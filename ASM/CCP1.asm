  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; CCP1.asm 
  ;;   A basic shell to initialize and run CCP1 interrupts 
  ;;  Inputs: none 
  ;;
  ;;  Outputs: none 
  ;;
  ;;  Side effects: 
  ;;    The CCP1_ISR executes once every 10 mS, and the 
  ;;    CCP1_Counter is incremented at a rate of 100 Hz 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LIST P=18F4520               ;directive to define processor
    #include <P18F4520.INC>       ;processor specific variable definitions
    CONFIG  OSC = INTIO67       ; internal clock @ 8MHz (1MHz with prescaler),
    CONFIG  WDT = OFF            ; watch dog timer OFF
    CONFIG  MCLRE = ON           ; MCLEAR (master clear)pin enabled
    CONFIG  PBADEN = OFF        ; PORTB pins digital (disable A/D for PORTB)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  Constants Section 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Standard constants for RSP 
TC_Port:             EQU     PORTA  ;; Port for Timing and Control Code 
TC_Dir:              EQU     TRISA  ;; Direction register for Timing and 
				    ;; Control Code 
E_Clk_Port:          EQU     PORTB  ;; Port for E-Clock 
E_Clk_Dir:           EQU     TRISB  ;; Direction register for E-Clock 
Data_Bus_Port:       EQU     PORTC  ;; Port for RSP Data Bus 
Data_Bus_Dir:        EQU     TRISC  ;; Direction register for RSP Data Bus 
PIC18_Top_Of_Data_Stack: EQU 0x5FF  ;; Initialization value for PIC18 Data Stack
		    
  ;; Special constants for CCP1.asm 
CountsPerInterrupt  EQU D'25000'  ;; Increment for CCP1  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  Variables Section 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    udata_acs  0x00 
T_C_Code:    RES     1  ;; Space for application
SI_Data:     RES     1  ;; Space for application
CCP1_Counter RES     2  ;; Counter for CCP1 interrupt 
security_code RES    1  ;; For the security Code
traffic_counter RES 1  ;; for the traffic light routine
RSPWrite_Data res 1
RSPRead_Data res 1
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  Macros Section 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Macro PUSHF, push a file register onto the data stack
  ;; Usage: PUSHF FileReg
  ;; Side Effect: [FileReg] moved onto stack, [FSR2]-1 -> [FSR2] 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUSHF: macro FileReg
  MOVFF FileReg, POSTDEC2
  endm
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Macro PULLF, pull data from the stack, and place a file register
  ;; Usage: PULLF FileReg
  ;; Side Effect: [FSR2]-1 -> [FSR2] and *[FSR2] written to [FileReg]
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PULLF: macro FileReg
  MOVFF PREINC2, FileReg
  endm
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Macro INCF16, Increment a 16 bit value, with the low byte at FileReg
  ;; Usage: INCF16 FileReg
  ;; Side Effect: (FileReg+1):FileReg  is incremented
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCF16: macro FileReg
  INFSNZ  FileReg,F
  INCF    FileReg+1,F
  endm
  ;*******************************************************************************		    
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  Program
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ORG 0x0000               ;; In the PIC18, there are 3 initial "Vectors"
  Goto  Main               ;; That is, places that the hardware jumps to. 
                           ;; Address 0x0000 is the target for a reset
  ORG 0x0008               ;; Address 0x0008 is the target for the 
  Goto  High_Priority_ISR  ;; High-priority interrupt 
  ORG 0x0018               ;; Address 0x0018 is the target for the 
  Goto  Low_Priority_ISR   ;; Low-priority interrupt 
Main:
  LFSR FSR2, PIC18_Top_Of_Data_Stack ;; Initialize the data stack 
  clrf security_code		     ;; Initialize security 
  clrf traffic_counter		     ;; Initialize traffic counter
  clrf    TC_Port                ; Clear T&C Port (PORTA)
  clrf    TC_Dir                 ; TC_Port_Dir (TRISA) all bits output
  clrf    E_Clk_Port             ; Clear E_Clk_Port (PORTB)
  setf    Data_Bus_Dir		 ; TRISC - INPUT
  movlw   b'11111110'            ; Make E_Clk_Port (PORTB.0) an output
  movwf   E_Clk_Dir              ; the rest of pins on PORTB are intput
 
  Call Init_CCP1_Interrupt           ;; Initialize the CCP1 interrupt 
Loop:                                
   NOP
  GOTO Loop     ;;  Go into an idle loop 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Init_CCP1_Interrupt   Initialize the CCP1 Interrupt 
  ;; Inputs:  None 
  ;; Outputs: None
  ;; Side effects:  Zero CCP1_Counter, 
  ;;    Set T1CON bits to activate Timer1
  ;;    Set T3Con bits for Timer3 (does not activate) 
  ;;    Set CCP1CON bits, to activate compare mode and interrupt 
  ;;    Set RCON:IPEN bit,  to active PIC18 mode interrupts (high/low priority)
  ;;    Set IPR1 bit,  to make CCP1 interrupt a high-priority interrupt
  ;;    Clear PIR1 bit,  to clear CCP1 interrupt flag 
  ;;    Set PIE1 bit,    to enable CCP1 interrupt 
  ;;    Set INTCON, GIEH to generally enable high-priority interrupts
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Init_CCP1_Interrupt:
  PUSHF  WREG           ;; WReg is used
  CLRF   TRISD          ;; Setup port D for pulses to visualize action on OScope
  CLRF   CCP1_Counter   ;; clear CCP1_Counter 
  CLRF   CCP1_Counter+1
  MOVLW  B'10000001'    ;; Setup    T1CON for Counting  
                        ;; RD16:    b7, latched 16-bit read
                        ;; T1CKPS1: b5, 1:2 prescaler (options, 1:1, 1:2, 1:4,
			;; 1:8)
                        ;; T1CKPS0: b4, 1:2 prescaler (options, 1:1, 1:2, 1:4,
			;; 1:8)
                        ;; T1SYNC_bar:  b2=0, T1 clock with synchronized with 
			;; internal phase clock
                        ;; TMR1ON:  b0, Turn timer 1 on 
  MOVWF  T1CON,
  MOVLW  B'10000000'    ;; Setup    T3Con for Counting, and CCP1 and CCP2 
			;; from Timer1
  MOVWF  T3CON,         ;; RD16L:   latched 16-bit read
  MOVLW  B'00001010'    ;; Setup    CCP1CON for compare mode 
  MOVWF  CCP1CON        ;; CCP1Mode = 1010,  Set CCP1IF bit (request interrupt)
  BSF    RCON,IPEN      ;; Active PIC18F High-priority / Low-priority mode
  BSF    IPR1,CCP1IP    ;; Make CCP1 a high-priority interrupt 
  BCF    PIR1,CCP1IF    ;; Clear the CCP1 Interrupt Flag (so that it 
			;; can be set to generate IRQ)
  BSF    PIE1,CCP1IE    ;; Enable the CCP1 interrupt 
  BSF    INTCON,GIEL    ;; Enable low-priority interrupts 
  BSF    INTCON,GIEH    ;; Enable high-priority interrupts and all interrupts
  PULLF  WREG 
  RETURN 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Interrupt Service Routine for the high priority interrupt
  ;;   The pattern in this high-level part of the interrupt service routine is: 
  ;;     Check the interrupt flag 
  ;;     If it is clear (not set), branch to the next check
  ;;       Otherwise (int. flag was set), service the interrupt request 
  ;;       Go back up to the top of the list, and start again. 
  ;;
  ;;   This pattern has the characteristic that High_Priority_ISR doesn't exit 
  ;;   until all interrupts in the list that are requesting service, 
  ;;   have been serviced. 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
High_Priority_ISR:
  BSF    PORTD,0x00
  BTFSS  PIR1,CCP1IF        ;; Test whether CCP1IF is set 
			    ;; (CCP1 interrupt requested)
  BRA    HP_ISR01           ;; If not set, go to next candidate 
  RCALL  CCP1_ISR           ;; Call the CCP1 ISR
  BRA    High_Priority_ISR  ;; Go to top, test all IRQs again 
HP_ISR01:
  BTFSS  PIR1,TMR1IF        ;; Test whether TMR1IF is set 
			    ;; (TMR1 interrupt requested)   
  BRA    HP_ISR02           ;; If not set, go to next candidate 
  RCALL  TMR1_ISR           ;; Call the TMR1 ISR
  BRA    High_Priority_ISR  ;; Go to top, test all IRQs again 
HP_ISR02:
  BCF     PORTD,0x00
  RETFIE  FAST              ;; Return from the interrupt, 
			    ;; FAST for high-priorty IRQ 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Interrupt Service Routine for the low-priority interrupt
  ;;  See description of programming patterh above
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Low_Priority_ISR:
  BSF    PORTD,0x01
  BTFSS  PIR2,CCP2IF        ;; Test whether CCP2IF is set 
			    ;; (CCP2 interrupt requested)
  BRA    LP_ISR01           ;; If not set, go to next candidate 
  RCALL  CCP2_ISR           ;; Call the CCP2 ISR
  BRA    High_Priority_ISR  ;; Go to top, test all IRQs again 
LP_ISR01:
  BTFSS  PIR2,TMR3IF        ;; Test whether TMR3IF is set 
			    ;; (TMR3 interrupt requested)   
  BRA    LP_ISR02           ;; If not set, go to next candidate 
  RCALL  TMR3_ISR           ;; Call the TMR3 ISR
  BRA    High_Priority_ISR  ;; Go to top, test all IRQs again 
LP_ISR02:
  BCF    PORTD,0x01
  RETFIE                    ;; Return from the interrupt, 
			    ;; No FAST for low-priority interrupt 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; CCP1_ISR  Service the needs of the CCP1 interrupt 
  ;; Inputs:  none
  ;; Outputs: none
  ;; Side effects:  Clear CCP1IF, to enable next CCP1 interrupt
  ;;    Increment CCP1_Counter
  ;;    Call User subroutine 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CCP1_ISR:
  BSF   PORTD,0x02
  PUSHF STATUS         ;; STATUS and WREG are changed in this routine
  PUSHF WREG 
  INCF16 CCP1_Counter  ;; Increment the interrupt counter, CCP1_Counter
  MOVLW  LOW CountsPerInterrupt  ;; Update CCPR1H:CCPR1L for the next interrupt
  ADDWF  CCPR1L,F                ;; CountsPerInterrupt in the future 
  MOVLW  HIGH CountsPerInterrupt ;; 
  ADDWFC CCPR1H,F                ;; 
  BCF  PIR1,CCP1IF		 ;; Clear the CCP1 Interrupt Flag 
				 ;; (so that the next IRQ can be generated)  
  Call  TrafficLight
  
  PULLF WREG           ;; Restore STATUS and WREG to previous values 
  PULLF STATUS 
  BCF   PORTD,0x02
  RETURN 
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;  Put STudent writes their MySubroutine (call)  Code Below.
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; TMR1_ISR  Service the needs of the CCPI interrupt 
  ;; Inputs:  none
  ;; Outputs: none
  ;; Side effects:   Clear TMR1IF, to setup for next TMR1 interrupt
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR1_ISR:
  BCF  PIR1,TMR1IF        
  RETURN 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; CCP2_ISR  Service the needs of the CCP2 interrupt 
  ;; Inputs:  none
  ;; Outputs: none
  ;; Side effects:   Clear CCP2IF, to setup for next CCP2 interrupt
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CCP2_ISR:
  BCF PIR2,CCP2IF  
  RETURN 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; TMR3_ISR  Service the needs of the CCPI interrupt 
  ;; Inputs:  none
  ;; Outputs: none
  ;; Side effects:  Clear TMR3IF, to setup for next TMR3 interrupt
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR3_ISR: 
  BCF  PIR2,TMR3IF 
  RETURN 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Init_SecuritySystem
  ;; Inputs:  none
  ;; Outputs: none
  ;; Side effects:  sets the code for the security system
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Init_SecuritySystem:
    MOVLW 0x00		    ;; the code of the security program
    MOVWF security_code	    ;; [W] -> security_code
  RETURN
;******************************************************************************
; SUBROUTINE: RSPRead                                   
;;   Inputs:  Reg W: Address of the RSP device to read ($0 .. $3)                                                         *
;;   Outputs:  Data Read from device -> variable
;;   Side Effects: None
;;
;*******************************************************************************
RSPRead:
    
    bcf	    E_Clk_Port,0	    ; Lower the Clock			    
    addlw   0x08		    ; Convert address apprpriate T&C code
    movwf   TC_Port		    ; RSP_TSF -> PORTA
    bsf	    E_Clk_Port,0	    ; Raise the clock
    movwf   RSPRead_Data	    ; Move value to variable
    bcf	    E_Clk_Port,0	    ; Lower the clock
    return 
    
;******************************************************************************
; SUBROUTINE: RSPWrite                                   
;;   Inputs:  Address of the RSP register to write (i.e. $0 or $1) 
;;	      
;;   Outputs: None
;;   Side Effects: Writes Data to a register
;;
;******************************************************************************
RSPWrite:
    PUSHF STATUS
    BCF E_Clk_Port,0			  ;; Lower the Clock
    ADDLW 0x08				  ;; Add 8
    SWAPF WREG				  ;; Convert TC code
    MOVWF TC_Port			  ;; RSP_TSF -> PORTA
    BSF	  E_Clk_Port,0			  ;; Raise the Clock
    MOVFF RSPWrite_Data, Data_Bus_Port    ;; Move data to PORT C
    CLRF Data_Bus_Dir			  ;; 0x00 -> [TRISC]
    BCF E_Clk_Port,0			  ;; Lower the Clock
    SETF Data_Bus_Dir			  ;; OxFF -> [TRISC]
    PULLF STATUS
    return 
;******************************************************************************
; SUBROUTINE: RSPExecute                                 
;;   Inputs:  Reg W: T&C code                                                     
;;   Outputs: None 
;;   Side Effects: Executes an instruction on the RSP 
;;
;******************************************************************************
RSPExecute: 
    PUSHF STATUS
    bcf E_Clk_Port,0 ;;should this be here?
    ;;load Port A onto [W] and execute
    movwf   TC_Port  ;;  
    bsf E_Clk_Port,0 ;; raise clock
    bcf E_Clk_Port,0 ;; lower clock 
    PULLF STATUS
    return
;******************************************************************************
; SUBROUTINE: TrafficLight                                 
;;   Inputs:  Reg W: T&C code                                                     
;;   Outputs: None 
;;   Side Effects: Executes an instruction on the RSP 
;;
;******************************************************************************   
TrafficLight:
    PUSHF STATUS
    PUSHF W
    INCF traffic_counter ;; Increment traffic counter
     
    MOVLW 0x27		     ;; move 40 W
    CPFSGT traffic_counter   ;; if counter > 40 skip the next line 
    BRA writefourteen
    
    MOVLW 0x3B		     ;; 60 -> [W]
    CPFSGT traffic_counter   ;; if counter > 60 skip the next line
    BRA writetwelve
    
    MOVLW 0x59		     ;; 90 -> [W]
    CPFSGT traffic_counter            ;; if counter > 90 don't write 41 to F
    BRA writefourtyone
    
    MOVLW 0x6D		     ;; 110 - [W]
    CPFSGT traffic_counter   ;; if counter > 110 dont write 21 to F
    BRA writetwentyone
   
    CPFSLT traffic_counter  ;; if counter < 110 don't clear it yet
    CLRF traffic_counter    ;; clear the counter
    goto gotoreturn	    ;; only reaching here if the count is over 110
    
    
    writefourteen:
	MOVLW 0x14
	MOVWF RSPWrite_Data
	goto gotoreturn
    writetwelve:
	MOVLW 0x12
	MOVWF RSPWrite_Data
	goto gotoreturn
    writefourtyone:
	MOVLW 0x41
	MOVWF RSPWrite_Data
	goto gotoreturn
    writetwentyone:
	MOVLW 0x21
	MOVWF RSPWrite_Data
	goto gotoreturn
    gotoreturn:
    ;; write the data to the F register
    MOVLW 0x00               ;; Reg F -> [W]
    call RSPWrite	     ;; call subroutine
    PULLF W
    PULLF STATUS
    return
     
  end 






