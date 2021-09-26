LAMP 	EQU P2.7		; diretiva para um Alias do bit 7 do pino 2 como LAMP
	ORG 00H			; diretiva para armazenar a próxima instrução no endereço 0
	LJMP SETUP		; desvio incondicional do fluxo para label SETUP

	ORG 23H			; diretiva para armazenar a próxima instrução no endereço 23H 						(Interrupção serial)
LAMP:	SETB LAMP		; seta o bit LAMP (liga a lampada)
	LCALL ATRASO		; chama subrotina ATRASO
	CLR LAMP		; limpa o bit LAMP (desliga a lampada)
	CLR RI			; reseta o bit de receção
	RETI			; retorna da interrupção

	ORG 30H			; diretiva par armazenar a próximma instrução no endereço 30H
SETUP:	MOV P2, 0		; limpa o port 2 com o litral 0
	MOV TMOD, #00100000B	; coloca o timer 1 em modo 2 (recarga automática)
	MOV TH1, #0FDH		; valor de regarca para taxa de transmissão de 9600
	MOV IE, #90H		; habilita a interrupção serial
	MOV SCON, #01010000B	; coloca a serial no modo 1 e habilita recepção(REN=1)
	SETB TR1		; dispara o timer 1
	SJMP $			; loop infinito para espera de interrupções

ATRASO:	MOV R0, #100		; move o literal 100 para o registrador 0
V1:	MOV R1, #200		; move o literal 200 para o registrador 1
V2:	MOV R2, #200		; move o literal 200 para o registrador 2
	DJNZ R2, $		; decrementa o conteudo do registrador 2, se diferente de zero 						desvia o fluxo para a mesma instrução
	DJNZ R1, V2		; decrementa o conteudo do registrador 1, se diferente de zero 						desvia o fluxo para a label V2
	DJNZ R0, V1		; decrementa o conteudo do registrador 0, se diferente de zero 						desvia o fluxo para a label V1
	RET			; retorno da subrotina de atraso
	
	END			; encerra o programa