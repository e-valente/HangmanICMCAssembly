; Hello World - Escreve mensagem armazenada na memoria na tela



; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom						0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho						0100 0000
; 1280 roxo							0101 0000
; 1537 teal							0110 0000
; 1793 prata						0111 0000
; 2048 cinza						1000 0000
; 2304 vermelho						1001 0000
; 2561 lima							1010 0000
; 2816 amarelo						1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3839 branco						1111 0000



jmp main

logojogo : string ".:FORCA ICMC:."	; Poe "\0" automaticamente no final da string
str_putword : string "Digite a palavra desejada: "	; Poe "\0" automaticamente no final da string
str_input_char: string "Digite uma letra: "
str_clearscreen : string " "
myword: var #41
str_out: var #41




; ------ Programa Principal -----------

main:

	;tela inicial
	call InicioCapturaWord
	call LimpaTela
	
	
	;monta string de saída
	;conta nro. de caracteres
	loadn r0, #myword
	call CountCharsFromWord
	;monta a string de saida
	loadn r0, #str_out
	mov r1, r7    ;r1 agora tem o tamanho da string
	call MountStrOut
	
	;imprime logo (estático)
	;imprime string do logo
	loadn r1, #logojogo
	loadn r0, #50
	loadn r2, #3072
	call ImprimeString
	
	;desenha forca (estático)
	call DesenhaForca 
	

	
	;imprime string montada
	loadn r1, #str_out
	loadn r0, #1005
	loadn r2, #0
	call ImprimeString
	
	;string pra digitar 
	;o caractere (estático)
	loadn r1, #str_input_char
	loadn r0, #1120
	call ImprimeString
	
	
	;*********LOOP DO JOGO
	;call DesenhaHomem
	;obtem caractere
	;r1 ->posicao que será
	;impresso o caracter digitado
	;será armazenado em r7
	loadn r1, #1137
	call ObtemChar
	;********FIM do Loop do jogo
	
	
	halt
	
	
	

InicioCapturaWord:	
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  push r6
  push r7
  
  ;imprime string do logo
  loadn r1, #logojogo
  loadn r0, #50
  loadn r2, #3072
  call ImprimeString
  
  ;imprime string pra digitar palavra
  loadn r1, #str_putword
  loadn r0, #605
  loadn r2, #0
  call ImprimeString
  
  
  ;captura palavra do teclado
  loadn r1, #730
  loadn r4, #myword
  call InputWord
  
  
  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  
  rts
;********DESENHA O OBJETO FORCA ******************
DesenhaForca:
;r0 -> caractere
;r1->posicao da tela
;r2-> incremento na posica da tela
;r3->incremento loops
;r4 -> valor total em loops (limite de um loop)
;r7-> incremento para cor


  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  push r6
  push r7

  ;liga com a cabeca
  loadn r0, #'|'
  loadn r7, #256   ;cor marrom (256)
  loadn r1, #339   
  add r0, r0, r7   ;r0 terá a cor marrom
  outchar r0, r1
  
  ;galho principal da forca
  loadn r0, #'-'
  add r0, r0, r7   ;r0 terá a cor marrom
  loadn r1, #289
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
  inc r1
  outchar r0, r1
   inc r1
  outchar r0, r1
  
  ;tronco da forca
  loadn r0, #'|'
  add r0, r0, r7   ;r0 terá a cor marrom
  loadn r1, #329
  
  ;;loop 15 iteracoes
  loadn r3, #0
  loadn r4, #15
  loadn r2, #40
DesenhaForca_TroncoLoop:
  outchar r0, r1
  add r1, r1, r2
  inc r3
  cmp r4, r3
  jne DesenhaForca_TroncoLoop
 
  ;desenha gramado
  loadn r0, #'-'
  loadn r7, #512    ;cor verde (512)
  add r0, r0, r7   ;r0 terá a cor verde
  loadn r1, #920
  
  ;;loop 40 iteracoes
  loadn r4, #40
  loadn r2, #40
  loadn r3, #0
DesenhaForca_GramadoLoop:
  outchar r0, r1
  inc r1
  inc r3
  cmp r4, r3
  jne DesenhaForca_GramadoLoop

  
  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  
  
  
  rts



;********DESENHA HOMEM ******************
DesenhaHomem:  
;r0 -> caractere
;r1->posicao da tela
;r2-> incremento na posica da tela


    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    ;cabeca
    loadn r0, #'O'
    loadn r1, #379
    outchar r0, r1
    ;tronco1
    loadn r0, #'|'
    loadn r2, #40
    add r1, r1, r2
    outchar r0, r1
    ;braco esquerdo
    loadn r0, #'~'
    loadn r2, #38
    add r1, r1, r2
    outchar r0, r1
    loadn r0, #'/'
    inc r1
    outchar r0, r1
    ;tronco2
    loadn r0, #'|'
    inc r1
    outchar r0, r1
    ;braco direito
    loadn r0, #'~'
    inc r1
    outchar r0, r1
    inc r1
    loadn r0, #'/'
    outchar r0, r1
     ;tronco3
    loadn r0, #'|'
    loadn r1, #499
    outchar r0, r1
    ;tronco4
    loadn r2, #40
    add r1, r1, r2
    outchar r0, r1
    ;pé esquerdo
    push r1
    loadn r0, #'/'
    add r1, r1, r2
    dec r1
    outchar r0, r1
    add r1, r1, r2
    dec r1
     outchar r0, r1
    dec r1
    loadn r0, #'_'
    outchar r0, r1
    
    ;pé direito
     loadn r0, #'~'
     pop r1
    add r1, r1, r2
    inc r1
    outchar r0, r1
    add r1, r1, r2
    inc r1
    outchar r0, r1
    inc r1
    loadn r0, #'_'
    outchar r0, r1
    
    
  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
    
    rts
    
    
    
    
;************************IMPRIME STRING*********************************

ImprimeString:  ;r1->posicao inicial da string, r0-> posicao inicial da tela, r2-> constante para cor devolve r6 com ultima posicao impressa

  push r0 ;backup nos registradores
  push r1
  push r2
  push r3
  push r4
  
  ;copia cor para registrador r4
  mov r4, r2
  
  loadn r2, #'\0'  ;usado na comparacao
  
  
ImprimeString_Loop:

  loadi r3, r1      ; r3 <= conteudo da primeira posicao do vetor
  cmp r3, r2 ;compara conteudo de r3 e r2
  jeq ImprimeString_Sai  ;igual \0 => sai da rotina
  add r3, r3, r4         ;soma constante para cor
  outchar r3, r0	;imprime r3 na posicao r0
  inc r0		;incrementa a posicao da tela de 1
  inc r1		;incrementa a posicao da string de 1
  
  jmp ImprimeString_Loop
  
  
ImprimeString_Sai:


  mov r6, r0 ;grava a ultima posicao da tela em r6
  
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  
  rts    
	

	
;**********************LIMPA A TELA*************************************

LimpaTela:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem;   Obs: a mensagem sera' impressa ate' encontrar "/0"

	 push r0
	 push r1
	 push r2
	 push r3
	 push r4
	 push r5
	 push r6
	 push r7
	
	loadn r0, #0		; Posicao inicial
	loadn r1, #1200		;posicao final
	loadn r2, #str_clearscreen	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadi r3, r2	; r3 <- Conteudo da MEMORIA enderecada por r2

	
LimpaTela_Loop:	

	cmp r0, r1	;chegou ao fim da tela? posicao 1199, caso sim, sai
	jeq LimpaTela_Sai
	outchar r3, r0
	inc r0
	jmp LimpaTela_Loop
	
	
	
LimpaTela_Sai:	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

;**************OBTEM PALAVRA (STRING DIGITADA PELO USUARIO**************************

InputWord: ;r1->posicao da tela que será iniciada a impressao, r4->endereco da string (vazia),  devolve r6 com ultima posicao impressa

	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r2 na pilha para ser usado na subrotina
	push r3	; protege o r3 na pilha para ser usado na subrotina
	;loadn r1, #0 ;posicao na tela onde comecará a ser impressa a string
	loadn r2, #255 ;lixo
	loadn r3, #13  ;enters
	;loadn r4, #msg
	loadn r5, #'\0'
	mov r6, r4   ;backup do inicio da string
	

Loop_InputWord:
	inchar r0       ;pega caractere do teclado
	cmp r0, r2	;compara para nao ver se pega lixo do buffer do teclado
	jeq Loop_InputWord        ;se pegou lixo, tenta denovo
	cmp r0, r3	;compara se o usuario digitou enter
	jeq Exit_InputWord ;se digitou enter sai, senao:
	outchar r0, r1      ;imprime
	storei r4, r0     ;grava caractere na string str[r4] = r0
	inc r4		  ;incrementa posicao
	inc r1		  ;incrementa posicao na tela
	jmp Loop_InputWord
	
	
Exit_InputWord:
	storei r4, r5
	mov r6, r1  ;faz bk da ultima posicao da tela impressa
	pop r3	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r2
	pop r1
	pop r0
	rts

	
;********************CONTA CARACTERES DENTRO DE UMA PALABRA (STRING)****	
CountCharsFromWord:   ;r0->endereco da string, devolve qtd de caracteres em r7
   push r0
   push r1
   push r2
   
   
   loadi r1, r0    ;primeiro conteudo r1 = str[0]
   loadn r2, #'\0' ;comparar com o final
   loadn r3, #0    ;contador
   
CountCharsFromWord_Loop:
  cmp r1, r2
  inc r3
  inc r0           
  loadi r1, r0
  jne CountCharsFromWord_Loop
  
  dec r3       ;decrementamos, pois o \0 nao conta
  mov r7, r3

  pop r2
  pop r1
  pop r0
  rts
  
  
  
;*************MONTA STRING DE SAIDA (_ _ _ )
MountStrOut: ;r0->string r1->tamanho da string
  
  push r2
  push r3
  push r4
  push r5
  push r6
  push r7
  
  loadn r2, #'\0'
  loadn r3, #'_'
  loadn r4, #0   ;contador
  loadn r5, #' '
    
  
MountStrOut_Loop:
  storei r0, r3
  inc r0
  storei r0, r5
  inc r0
  inc r4
  cmp r4, r1
  jne MountStrOut_Loop
  
  storei r0, r2
  
  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  
  
  rts
  
  
;*************OBTEM CHAR ARMAZENA EM R7************8
ObtemChar: ;r1-> posicao inicial que será impressa o char digiado. Armazena resultado em r7
  
  push r2
  push r3
  push r4
  push r5
  push r6
  
;loadn r1, #0 ;posicao na tela onde comecará a ser impressa a string
	loadn r2, #255 ;lixo
	;loadn r3, #13  ;enters

	

Loop_ObtemChar:
	inchar r0       ;pega caractere do teclado
	cmp r0, r2	;compara para nao ver se pega lixo do buffer do teclado
	jeq Loop_ObtemChar        ;se pegou lixo, tenta denovo
	outchar r0, r1      ;imprime
	storei r7, r0     ;grava caractere na string str[r4] = r0

  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  
  
  rts  