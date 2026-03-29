        AREA    WATER_CTRL, CODE, READONLY
        ENTRY
        EXPORT  __main

; GPIO Register Addresses
IO0PIN      EQU     0xE0028000
IO0SET      EQU     0xE0028004
IO0DIR      EQU     0xE0028008
IO0CLR      EQU     0xE002800C

LOW_TH      EQU     100
HIGH_TH     EQU     200

__main

        ; Set P0.10 as output, rest input
        LDR     R0, =IO0DIR
        MOV     R1, #0x00000400     ; (1 << 10)
        STR     R1, [R0]

LOOP
        ; Read input
        LDR     R0, =IO0PIN
        LDR     R1, [R0]

        ; Mask lower 8 bits
        AND     R1, R1, #0xFF

        ; If < LOW_TH ? LOW_LEVEL
        CMP     R1, #LOW_TH
        BLT     LOW_LEVEL

        ; If >= HIGH_TH ? HIGH_LEVEL
        CMP     R1, #HIGH_TH
        BGE     HIGH_LEVEL

        B       LOOP

LOW_LEVEL
        ; Pump ON
        LDR     R0, =IO0SET
        MOV     R1, #0x00000400
        STR     R1, [R0]
        B       LOOP

HIGH_LEVEL
        ; Pump OFF
        LDR     R0, =IO0CLR
        MOV     R1, #0x00000400
        STR     R1, [R0]
        B       LOOP

        END