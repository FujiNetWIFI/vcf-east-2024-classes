 .OPT OBJ
 *=$5000
; ZERO PAGE TEMP VARS
TMP1      = $B0
TMP2      = $B1
TMP3      = $B2
TMP4      = $B3
PTR1      = $B4
PTR2      = $B6
PTR3      = $B8
PTR4      = $BA
; SYSTEM DEFINES
EOL       = $9B
OPEN      = $03
OWRIT     = $0B
PUTCHR    = $0B
IOCB2     = $20
;
ICCOM     = $0342
ICBAL     = $0344
ICBAH     = $0345
ICBLL     = $0348
ICBLH     = $0349
ICAX1     = $034A
ICAX2     = $034B
;
VCOUNT    = $D40B
CIOV      = $E456
;
OSCR
  LDX #IOCB2
  LDA #OPEN
  STA ICCOM,X
  LDA #SCRNAM & $FF
  STA ICBAL,X
  LDA #SCRNAM / $100
  STA ICBAH,X
  LDA #OWRIT
  STA ICAX1,X
  LDA #$00
  STA ICAX2,X
  JSR CIOV
  JSR WSCAN1
  JSR WSCAN1
  RTS
;
; PRSTR
;   A/X : Pointer to string, 0 or $9B terminated
PRSTR
  STA PTR1 		; save address
  STX PTR1+1

; work out the string length
  LDY #$00
L.0
  LDA (PTR1), Y
  BEQ FOUND.NIL
  CMP #EOL
  BEQ FOUND.EOL
  INY
  BNE L.0

; we didn't find a EOL or NIL in first 256 bytes, so error out.
  BEQ ZERO.LENGTH

FOUND.EOL
  INY             ; preserve the EOL char.
FOUND.NIL
  CPY #$00        ; check there was a string
  BEQ ZERO.LENGTH

  LDX #IOCB2      ; print to screen using PUTCHR
  LDA PTR1
  STA ICBAL,X
  LDA PTR1+1
  STA ICBAH,X
  LDA #PUTCHR
  STA ICCOM,X
  TYA             ; Y contains length
  STA ICBLL,X
  LDA #$00
  STA ICBLH,X
  JSR CIOV

ZERO.LENGTH
  RTS
;
; Wait for Scan Line 1
; so the display is showing fully before we continue
WSCAN1
  LDA VCOUNT
  BNE WSCAN1
WS1B
  LDA VCOUNT
  BEQ WS1B
  RTS

SCRNAM    .BYTE "E:",EOL 
