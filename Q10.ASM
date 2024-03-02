.MODEL SMALL
.STACK 32

.DATA 
    STARTROW   DB 12
    STARTCOL   DB 25
    ENDROW     DB 18
    ENDCOL     DB 54
    COLOUR     DB 1FH
    ASCIISTART DB 32
    ASCIIEND   DB 127
.CODE

MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

;SET TO VIDEO MODE
    MOV AH, 00h
    MOV AL, 03h
    INT 10h

;CLEAR SCREEN
    MOV AH, 06H
    MOV AL, 00h
    MOV BH, 01FH
    MOV CX, 0000H
    MOV DX, 184FH
    INT 10H
;SET CURSOR POSITION
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, 12
    MOV DL, 25
    INT 10H

;DISPLAY CHARACTER
            MOV AL,ASCIISTART
    REPEAT:     
                CMP AL,ASCIIEND
                JE  STOPDISPLAY

                MOV AH,03H
                MOV BH,00H
                INT 10H

                CMP DL,ENDCOL
                JNZ DISP

                ADD STARTROW,1
                MOV AH,02H
                MOV DH,STARTROW
                MOV DL,STARTCOL
                INT 10H


    DISP:       
                MOV DL,AL
                MOV AH,02H
                INT 21H
                INC AL
                JMP REPEAT

    STOPDISPLAY:
                MOV AX,4C00H
                INT 21H

MAIN ENDP
    END MAIN