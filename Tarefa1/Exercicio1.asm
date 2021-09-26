ORG 00H				; diretiva para armazenar a próxima instrução no endereço 0
LJMP INICIO			; desvio incondicional do fluxo para a label INICIO

ORG 30H				; diretiva para armazenar a próxima instrução no endereço 30H
INICIO: MOV A, #00H		; começo da label início, move o literal 00H para o acumulador
V1:	MOV P0, A		; move o conteudo do acumulador para o registrador da porta 0
	INC A			; incrementa o valor do acumulador
	CJNE A, #0FFH, V1	; compara o valor do acumulador com 0FFH, desvia o fluxo para V1 se  				os valores forem diferentes se não segue o fluxo
	MOV P0, A		; move o conteudo do acumulador para P0
V2:	DJNZ ACC, V2		; decrementa o acumulador e desvia o fluxo para V2 se o conteudo do 					acumulador não for zero
	SJMP V1			; desvio incondicional para a label V1
	END			; encerra o programa