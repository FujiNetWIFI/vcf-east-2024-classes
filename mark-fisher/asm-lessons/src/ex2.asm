 .OPT OBJ
 *=$0600
 LDX #$00
START
 LDA D1,X
 STA D2,X
 INX
 CPX #5
 BNE START
 BRK
D1
 .BYTE 1,2,3,4,5
D2
 .BYTE 0,0,0,0,0
 .END
