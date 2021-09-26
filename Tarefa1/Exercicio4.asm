	ORG 00H				; diretiva para armzenar a próxima instrução no endereço 0
	LJMP START			; desvio incondicional para label START
	
	ORG 30H				; diretiva para armazenar a próxima intrução no endereço 30H
START:	MOV A,#0			; move o literal 0 para o acumulador
V1:	MOV P1, A			; move o conteudo do acumulador para a porta 1
	LCALL ATRASO			; chama a subrotina ATRASO
	RL A				; rotaciona os bits do acumulador para a esquerda sem o 						carry
	ORL A, #01			; efetua a operação or entre o conteudo do acumlador com o 						literal 01(seta o último bit)
	CJNE A, #11111111B, V1		; compara o valor do acumulador com o literal 0x11111111, 						desvia o fluxo para V1 se não forem iguais

V2:	MOV P1, A			; move o conteudo do acumulador para a porta 1
	RR A				; rotaciona os bits do acumulador para a direita sem o carry
	ANL A,#01111111B		; efetua a operação and entre o conteudo do acumulador e o 						literal 0x01111111(mascara)
	LCALL ATRASO			; chama a subrotina ATRASO
	CJNE A,#0, V2			; compara o valor do acumulador com o literal 0, desvia o 						fluxo para V2 se não forem iguais
	SJMP V1				; desvio incondicional para V1

ATRASO:	MOV R0, #200			; move o literal 200 para o registrador 0
V3:	MOV R1, #200			; move o litral 200 para o registrador 1
	DJNZ R1, $			; decrementa o registrador 1 e verifica se é igual a zero, 						caso diferente desvia para a mesma instrução
	DJNZ R0, V3			; decrementa o registrador 0 e verifica se é igual a zero, 						caso diferente desvia para V3
	RET				; retorna da subrotina de atraso

	END				; encerra o programa