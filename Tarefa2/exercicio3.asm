ORG 00H
SJMP SETUP

ORG 03H
LJMP ONDA_400

ORG 13H
LJMP ONDA_800

; =========== SUBROTINA PARA CONFIGURAR OS PERIFERICOS =============
ORG 30H
SETUP: 		CLR P1.0	; INICIALIZA O PINO DA ONDA
		MOV R7, #00H	; INICIALIZA O REGISTRADO DO PARÂMETRO DE ONDA
		MOV IE, #85H	; EA = 1, EX1 = 1, EX0 = 1
		MOV TCON, #05H	; IT1 = 1 IT0 = 1 INTERRUPÇÕES POR TRANSIÇÃO
		MOV TMOD, #01H	; TIMER 0 MODO 1 (M10=0 M00=1)

MAIN:		JNB PSW.1, $	; SEGURA O FLUXO ATÉ A DEFINIÇÃO DA ONDA (BIT 1 PSW)
ONDA:		CPL P1.0	; INVERTE O ESTADO DA ONDA
		LCALL DELAY
		SJMP ONDA


; =========== SUBROTINA DE GERAÇÃO DA ONDA QUADRADA ================
ONDA_400:	MOV R7, #3	; 3 CICLOS DE CONTAGEM PARA MEIA ONDA 200 MS
		SETB PSW.1
		RETI

ONDA_800:	MOV R7, #6	; 6 CICLOS DE CONTAGEM PARA MEIA ONDA 400 MS
		SETB PSW.1
		RETI

; =========== SUBROTINA DE ATRASO ==================================
DELAY:		MOV A, R7		; R7 É DEFINIDO QUANDO INVOCADO AS INTERRUPÇÕES
		SETB TR0		; DISPARA CONTAGEM
RECARGA:	MOV TH0, #0FH		; RECARRREGA O TIMER
		MOV TL0, #0FFH
		JNB TF0, $		; DT= 66,6666666664 MS
		CLR TF0
		DJNZ A, RECARGA
		CLR TR0
		RET
END