;******************************************************************************
;    Filename: ChipTestTemplate.asm                                           *
;    Date: 5/1/2018                                                           *
;    Author: DLM                                                              *
;    Company: UWM EE367                                                       *
;    Decription:  Template that sets up PORTA and PORTC pins for the chip     *
;                 test project (Spring 2018)                                  *
;		  MODIFY THIS BANNER WITH YOUR NAME AND PROJECT DESCRIPTION   *
;******************************************************************************
    LIST P=18F4520		;directive to define processor                *
    #include <P18F4520.INC>	;processor specific variable definitions      *
;******************************************************************************
;Configuration bits
    CONFIG  OSC = INTIO67		; Internal Clock @ 8MHz
    CONFIG  WDT = OFF			; Watch Dog Timer OFF
    CONFIG  MCLRE = OFF			; MCLEAR Pin Disabled
    CONFIG  PBADEN = OFF		; PORTB Pins Digital
    CONFIG  LVP = OFF                   ; Helps make PORTB,5 an output ??

;******************************************************************************
;Variable definitions
	udata_acs 0x000
Del_1   res     1                   ; Variable used in delay routine
Del_2   res     1                   ; Variable used in delay routine
; reserve space for your variables here
test_result0 res 1
test_result1 res 1
test_result2 res 1
test_result3 res 1
chip_id res 1

;******************************************************************************
;Reset vector
	ORG	0x0000

main:	; No interrupts, so main program can start here
    
	call	PortInit	; Initialize PORTS
	clrf test_result0	; clear variable
	clrf test_result1	; clear variable
	clrf test_result2	; clear variable
	clrf test_result3	; clear variable
	clrf chip_id


loop:				; main loop that runs forever
	clrf PORTA
	clrf test_result0	; clear variable
	clrf test_result1	; clear variable
	clrf test_result2	; clear variable
	clrf test_result3	; clear variable

				
	call    test_sequence	;; drive the possible inputs and grab the results 
	call    clear_and_test  ;; test the chip for validity	

	goto	loop		; run test forever forever

;******************************************************************************
; Port_Init initializes all of the PORTS for proper input and output functions
;
;	Inputs: None
;	Outputs: None
;	Side Effects: PORTA: A0-A3 are set as inputs (from the 4 gates)
;		      PORTA: A4-A7 are set as output (A4 & A5 drive gate inputs)
;		      PORTC: C0-C7 are set to output to drive LEDs
;
;******************************************************************************
PortInit:

	movlw	0x0F		; Remove A/D from port A pins
	movwf	ADCON1		; so they can be used as digital inputs
	movlw	b'00001111'	; set A0 - A3 input, A4 - A7 output 
	movwf	TRISA, ACCESS
	clrf	TRISC, ACCESS	; PORTC set all pins to output
	return

 
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
; SUBROUTINE: test_sequence                                      
;;   Inputs:  NONE                                                         *
;;   Outputs: test_result0-3    
;;   Side Effects: Test each possibility of inputs and stores the results in 
; 
;******************************************************************************

test_sequence:
    CLRF PORTA
    
    BCF PORTA, 4		;; input 00
    BCF PORTA, 5
    
    MOVFF PORTA, test_result0	;; save the first result
    
    BSF PORTA, 5		;; input 01
    BCF PORTA, 4		

    MOVFF PORTA, test_result1	;; save the second result
    
    BCF PORTA, 5		;; input 10
    BSF PORTA, 4
    
    MOVFF PORTA, test_result2	;; save the third result
    
    BSF PORTA, 5		;; input 11
    
    MOVFF PORTA, test_result3	;; save the last result
    
    
    CLRF PORTA
    return
    
    
    
    
;******************************************************************************
;; SUBROUTINE: set_and_test
;;   set  4 bits of all test_result variables and test for errors                                     
;;   Inputs:  test_result0-3                                                         *
;;   Outputs: test_result0-3 , does_chip_work   
;;   Side Effects: Test each possibility of inputs and stores the results in 
;;
;******************************************************************************

clear_and_test:
    
    MOVLW 0x0F				;; 0x0F -> [W]
    ANDWF test_result0, f		;; clear the top 4 bits of the test results
    ANDWF test_result1, f		;;
    ANDWF test_result2, f		;;
    ANDWF test_result3, f		;;

    ;; first make sure there is a chip
    ;; if all results are zero then there is no chip
    TSTFSZ test_result0			;;continue checking results if result0=0
    BRA beginning			;; else we have a non zero result => chip exists
    
    TSTFSZ test_result1			;;continue checking results if result1=0
    BRA beginning			;; else we have a non zero result => chip exists
    
    TSTFSZ test_result2			;;continue checking results if result2=0
    BRA beginning			;; else we have a non zero result => chip exists
    
    TSTFSZ test_result3			;;continue checking results if result3=0
    BRA beginning			;; else we have a non zero result => chip exists
    
    BRA no_chip				;; reaching here means we have zeros no matter what
 
beginning
    MOVLW 0xF0				;; 0xF0 -> [W]
    IORWF test_result0, f		;; set the top 4 bits of the test results
    IORWF test_result1, f		;;
    IORWF test_result2, f		;;
    IORWF test_result3, f		;;
    
    ;; test_resultx shoulld contain 0x00 or 0x01 or it is invalid
    ;; Test for 0x01 results first
    ;; Then test for 0x00    
    
    MOVLW 0xFF ;; all 1's
    CPFSEQ test_result0	    ;; testing for all ones
    MOVLW 0xF0		    ;; skipped if it is 0xFF otherwise change [W] to 
    CPFSEQ test_result0	    ;; valid if its equal otherwise
    BRA invalid_result
    
    
    MOVLW 0xFF ;; all 1's
    CPFSEQ test_result1	    ;; testing for all ones
    MOVLW 0xF0		    ;; skipped if it is 0xFF otherwise change [W] to 
    CPFSEQ test_result1	    ;; valid if its equal otherwise
    BRA invalid_result
    
    MOVLW 0xFF ;; all 1's
    CPFSEQ test_result2	    ;; testing for all ones
    MOVLW 0xF0		    ;; skipped if it is 0xFF otherwise change [W] to 
    CPFSEQ test_result2	    ;; valid if its equal otherwise
    BRA invalid_result
    
    MOVLW 0xFF ;; all 1's
    CPFSEQ test_result3	    ;; testing for all ones
    MOVLW 0xF0		    ;; skipped if it is 0xFF otherwise change [W] to 
    CPFSEQ test_result3	    ;; valid if its equal otherwise
    BRA invalid_result
 
    BRA valid_result
    
    ;; the 0 bit of PORTC is the red LED , 1 green.
invalid_result
	SETF PORTC
	call delay
	return
 
valid_result
	call    determine_chip	;; determine the chip type
	return 
	
no_chip
	SETF PORTC
	call delay
	return
;******************************************************************************
;; SUBROUTINE: determine chip                                     
;;   
;;   Inputs:  test_result0-1                                                       *
;;   Outputs: sets PORTC  
;;   Side Effects: outputs chip type onto the board uses the W register
;;
;****************************************************************************** 
;; we can determine the chip by iterating through the results and using 
;; deductive logic on the lower 4 bits
;; if first result is F then NAND (LS00)
;; else if second result is 0 then AND (LS08)
;; else if last result is 0 then XOR (LS86)
;; else is OR   (LS32)
;; All of the variables have verified bits before this subroutine is called
;; we can get away with checking the least significant bit of each reg
	
	

determine_chip: 
    
    MOVLW 0x0F				;; 0x0F -> [W]
    CLRF PORTC
    
    ANDWF test_result0, f		;; clear the top 4 bits of the test results
    ANDWF test_result1, f		;;
    ANDWF test_result2, f		;;
    ANDWF test_result3, f		;;
    
    
    BTFSC test_result0, 0		;; skip if first result is 0
    BRA nand_gate			;; its a nand gate
    
    BTFSS test_result1, 0		;; skip if second result is 1
    BRA and_gate			;; its an and gate
    
    BTFSS test_result3, 0		;; skip if the last result is a 1
    BRA xor_gate			;; its a xor gate
    
    BRA or_gate				;; its an or gate
    
    
    
nand_gate
    MOVLW 0x00
    MOVWF  PORTC
    CALL delay
    return
and_gate
    MOVLW 0x08
    MOVWF PORTC
    CALL delay
    return
xor_gate
    MOVLW 0x86
    MOVWF PORTC
    CALL delay
    return
or_gate
    MOVLW 0x32
    MOVWF PORTC
    CALL delay
    return
bad
    MOVLW 0xFF
    MOVWF PORTC
    CALL delay
    return
    
   end
    