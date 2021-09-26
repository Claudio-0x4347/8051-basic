	ORG 00H				; diretiva para armazenar a próxima instrução no endereço 0
	LJMP START			; desvio incondicional para a label START

	ORG 30H				; diretiva para armazenar a próxima instrução no endereço 30
START:	MOV A, #80H			; move o literal 80 para o acumulador
V1:	MOV P1, A			; move o conteudo do acumulador para a porta 1
	LCALL ATRASO			; chama a subrotina de ATRASO
	RR A				; rotaciona para direita o conteúdo do acumulador
	ORL A, #80H			; efetua a operação or com o literal 80H(seta o nibble 							superior)
	CJNE A, #0FFH, V1		; compara o conteudo do acumulador com o literal FFH, caso 						diferente desvia o fluxo para V1

V2:	MOV P1, A			; move o conteudo do acumulador para P1
	RL A				; rotaciona para esquerda o conteudo do acumulador
	ANL A, #11111110B		; efetua a operação and entre o acumulador e o literal 							0x11111110
	LCALL ATRASO			; chama a subrotina de ATRASO
	CJNE A, #0, V2			; compara o conteudo do acumulador com o literal 0, caso 						diferente desvia o fluxo para V2
	SJMP V1				; desvio incondicional do fluxo para V1

ATRASO:	MOV R0, #200			; move o literal 200 para o registrador 0
V3:	MOV R1, #200			; move o literal 200 para o registrador 1
	DJNZ R1, $			; decrementa o conteudo do registrador 1, se não for zero 						desvia o fluxo para a mesma instrução
	DJNZ R0, V3			; decrementa o conteudo do registrador 0, se não for zero 						desvia o fluxo para V3
	RET				; retorna da subrotina de ATRASO

	END				; encerra o programa