; Hello World example

 .OPT OBJ
 *=$0600

START

 JSR OSCR			; open the editor screen

 LDA #S1 & $FF		; A/X point to string
 LDX #S1 / $100
 JSR PRSTR

; BRK is picked up by EASMD as a break point
 BRK


S1
 .BYTE "Hello, world!", $9B



 .INCLUDE #D2:SCREEN.ASM	; source code for screen routines
 .END
