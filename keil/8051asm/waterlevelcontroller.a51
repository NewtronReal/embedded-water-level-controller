ORG 0000H

MAIN:
    MOV P1, #0FFH       ; Set Port1 as input
    MOV P2, #00H        ; Clear Port2 (output)

LOOP:
    MOV A, P1           ; Read water level (8-bit input)

    ; Check LOW condition (A < LOW_THRESHOLD)
    MOV R0, A
    CLR C
    MOV A, R0
    SUBB A, #100
    JC LOW_LEVEL        ; Jump if A < LOW_THRESHOLD

    ; Check HIGH condition (A >= HIGH_THRESHOLD)
    MOV A, R0
    CLR C
    SUBB A, #200
    JNC HIGH_LEVEL      ; Jump if A >= HIGH_THRESHOLD

    ; Otherwise MEDIUM level
MEDIUM_LEVEL:
    ; Do nothing (keep previous state)
    SJMP LOOP

LOW_LEVEL:
    SETB P2.0           ; Turn ON pump
    SJMP LOOP

HIGH_LEVEL:
    CLR P2.0            ; Turn OFF pump
    SJMP LOOP

END