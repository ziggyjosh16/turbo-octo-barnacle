 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: DoWatch.asm							*
;; Author: Joshua Sharkey							*
;; Date: 4/12/2018								*
;; Description: This program is a sequence of instructions used to demonstrate	*
;;    the funtionality of the ALU						    
;;                                                      *
;;                                                                            *
;;   Side Effects: Program will Loop around                                                            *
;;                                                                            *
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include <P18F4520.INC>
;*******************************************************************************
;Configuration Word Setup
;*******************************************************************************

    CONFIG	OSC = INTIO67	; internal clock @ 8MHz (1MHz with prescaler)
						; for timing purposes 1 instruction cycle requires
						; 4 clock cycles ... or 4 microseconds
    CONFIG  LVP = OFF      ; Disable low voltage programming for debug
    CONFIG  WDT = OFF		; watch dog timer OFF
    CONFIG  MCLRE = OFF	; MCLEAR (master clear)pin enabled
    CONFIG  PBADEN = OFF	; PORTB pins digital (disable A/D for PORTB)

;*******************************************************************************
;;		CONSTANTS
;*******************************************************************************
TC_Port             equ     PORTA
TC_Dir              equ     TRISA
E_Clk_Port          equ     PORTB
E_Clk_Dir           equ     TRISB
Data_Bus_Port	    equ	    PORTC
Data_Bus_Dir	    equ	    TRISC
	   
;RSP components	    
RegF:		    equ	    0x00
RegG:		    equ	    0x01	
SI:		    equ	    0x02
ALU:		    equ	    0x03	

;T&C Codes RSP instructions		
RSP_TSF:	    equ	    0x8A
RSP_TFG:	    equ	    0x98
RSP_TGF:	    equ	    0x89
RSP_TSG:	    equ	    0x9A
RSP_ADDF:	    equ	    0x8B
RSP_ADDG:	    equ	    0x9B
	    
;stack
top_of_stack	    equ	    0x55
;*******************************************************************************		    
; Macro PUSHF, push a file register onto the data stack
; Usage: PushF FileReg
; Side Effect: [FileReg] moved onto stack, [FSR2]-1 -> [FSR2]
PUSHF: macro FileReg
 MOVFF FileReg, POSTDEC2
 endm
;*******************************************************************************
; Macro PULLF, push a file register onto the data stack
; Usage: PULL FileReg
; Side Effect: [FSR2]+1 -> [FSR2] and [[FSR2]] written to [FileReg]
PULLF: macro FileReg
 MOVFF PREINC2, FileReg
 endm
;*******************************************************************************
        udata_acs                       ; Define some variables
Del_1   res     1                   ; Variable used in delay routine
Del_2   res     1                   ; Variable used in delay routine
RSPWrite_Data res 1
RSPRead_Data res 1
Data_RegG: res 1
Data_SI: res 1
counter: res 2


 
;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    LFSR  FSR2, top_of_stack
    GOTO    main                   ; go to beginning of program

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
main:
    clrf    TC_Port                ; Clear T&C Port (PORTA)
    clrf    TC_Dir                 ; TC_Port_Dir (TRISA) all bits output
    clrf    E_Clk_Port             ; Clear E_Clk_Port (PORTB)
    setf    Data_Bus_Dir	   ; TRISC - INPUT
    movlw   b'11111110'            ; Make E_Clk_Port (PORTB.0) an output
    movwf   E_Clk_Dir              ; the rest of pins on PORTB are intput
    
    clrf Data_RegG		   ; clear variable
    clrf Data_SI		   ; clear variable
    clrf counter		   ; clear variable
    movlw 0x00			   ; move 0x00 -> [W]
    movf RSPWrite_Data		   ; move [W] -> variable
    movlw RegG			   ; Move RegG -> [W] 
    call RSPWrite		   ; call subroutine
loop:
    movlw 0x8A			   ; RSP_TSF Code
    call RSPExecute		   ; execute
    movlw 0x9B			   ; RSP_ADDG
    call RSPExecute		   ; execute
    call delay			   ; 1 second
    call delay			   ; 1 second
    movlw SI			   ; move SI address to [W]
    call RSPRead		   ; read value
    movff RSPRead_Data, Data_SI  ; move return value to Variable
    incf counter		   ; increment counter
    

    goto loop
    
 ;******************************************************************************
; SUBROUTINE: Delay                                      
;;   Inputs:  NONE                                                         *
;;   Outputs: NONE     
;;   Side Effects: CAUSES DELAY OF 1 SECOND
; 
; Clock frequency = 1 MHz
; Actual delay = 250000 cycles * 4us/cycle = 1s
; Error = 0 %
;
; Original code created with "on line" code generator @ piclist.com website
; http://www.piclist.com/techref/piclist/codegen/delay.htm
; Minor modifications required for PIC 18F series done by D. McClanahan
;******************************************************************************

delay
	movlw	0x4E
	movwf	Del_1
	movlw	0xC4
	movwf	Del_2
Delay_0
	decfsz	Del_1,f                 ; This nested loop 'burns' 249993
	goto	skip1                   ; instuction cycles with the constants
	decfsz	Del_2,f                 ; loaded above (Del_1=0x4E, Del_2=0xC4)
skip1
    goto	Delay_0

	nop                             ;3 additional instruction cycles
    nop
	nop

	return                          ;4 instruction cycles (includes call)

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
    BCF E_Clk_Port,0			  ;; Lower the Clock
    ADDLW 0x08				  ;; Add 8
    SWAPF W,W				  ;; Convert TC code
    MOVWF TC_Port			  ;; RSP_TSF -> PORTA
    BSF	  E_Clk_Port,0			  ;; Raise the Clock
    MOVFF RSPWrite_Data, Data_Bus_Port    ;; Move data to PORT C
    CLRF Data_Bus_Dir			  ;; 0x00 -> [TRISC]
    BCF E_Clk_Port,0			  ;; Lower the Clock
    SETF Data_Bus_Dir			  ;; OxFF -> [TRISC]
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
  
  
    end