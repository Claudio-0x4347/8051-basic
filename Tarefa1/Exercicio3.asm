	ORG 00H				; diretiva para armazenar a próxima instrução no endereço 0
	LJMP INICIO			; desvio incondicional para a label INICIO
	
	ORG 30H				; diretiva para armazenar a próxima intrução no endereço 30H
INICIO: MOV SP, #2FH			; move o literal 2F para o apontador de pilha(SP)
	MOV DPTR, #TABELA		; move o endereço da TABELA para o registrador de 							16bits(DPTR)
	
V1:	MOV R7, #00H			; move o literal 0 para o registrador 7
V2:	MOV A, R7			; move o conteudo do registrador 7 para o acumulador
	MOVC A, @A+DPTR			; move o conteudo do endereço apontado por A+DPTR para o 						acumulador
	MOV P2,A			; move o conteudo do acumulador para porta 2(P2)
	LCALL ATRASO			; chama a subrotina ATRASO
	INC R7				; incrementa o valor do registrador 7
	CJNE R7,#08H, V2		; compara o valor do registrador 7 com o literal 04H, desvia 					o fluxo para V2 se forem diferentes, continua o fluxo se 						forem iguais
	SJMP V1				; desvio incondicional para V1

ATRASO:	MOV R0,#100			; move o literal 100 para o registrador 0
V3:	MOV R1, #200			; move o literal 200 para o registrador 1
	DJNZ R1, $			; decrementa o valor do registrador 1, desvia o fluxo para 						permanecer decrementando até zerar o conteudo do registrador
	DJNZ R0, V3			; decrementa o valor do registrador 0, desvia o fluxo para 						V3 se o valor do registrador não for zero
	RET				; retorno da subrotina de ATRASO

TABELA:	DB 01H, 03H, 02H, 06H
	DB 04H, 0CH, 08H, 09H		; cria uma tabela no final do programa na memória ROM
	END				; encerra o programa