        .OPT OBJ
        *=$0600
        LDX #$FF
        STX $2FC
;
;
LOOP
        LDA $D40B
        STA $D40A
        STA $D01A
        LDX $2FC
        CPX #$FF
        BNE QUIT
        BEQ LOOP
QUIT
        BRK
