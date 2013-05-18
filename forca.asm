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
str_youlose: string "Voce perdeu!"
str_youwin: string "Voce ganhou!"
str_game_or_exit: string "Tecle (j) para jogar ou (s) para sair!"
str_clearscreen : string " "
myword: var #41
str_out: var #41




; ------ Programa Principal -----------

main:

	;tela inicial
	call LimpaTela
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
	;configura loop
	loadn r0, #0
	loadn r1, #7
	loadn r6, #0  ;controla desenho de tela

	Loop:
	;obtem caractere
	;r1 ->posicao que será
	;impresso o caracter digitado
	;será armazenado em r7
	push r0
	push r1
	push r6
	
	loadn r1, #1137
	call ObtemChar
	
	;compara
	;Implementar!!!!
	loadn r0, #myword
	loadn r1, #str_out
	mov r2, r7            ;r2 conterá o char do usuario
	call StrcmpStrFromCharTyped

	
	loadn r1, #str_out
	loadn r0, #1005
	loadn r2, #0
	call ImprimeString  ;devolve em r6 a ultima string impressa
	
	;VERIFICA GANHADOR ->IMplementar
	loadn r0, #str_out
	call VerificaGanhador  ;resultado em r6
	
	;**********GANHOU************
	loadn r5, #1
	push r7
	loadn r7, #2   ;diferente de 0 ou 1
	cmp r6, r5
	ceq Ganhou
	cmp r7, r5
	jeq JogarDenovo
	loadn r5, #0
	cmp r7, r5
	jeq Sair
	;************FIM GANHOU******
	
	
	pop r7
	loadn r3, #0
	pop r6
	cmp r7, r3
	ceq Controla_Desenho_Homem
	
	pop r1
	pop r0
	
	inc r0
	cmp r6, r1
	jne Loop
	;**********FIM do loop principal do jogo
	
	call Perdeu
	loadn r5, #1
	cmp r7, r5
	jeq JogarDenovo
	jmp Sair

JogarDenovo:
  jmp main
  
Sair:
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
DesenhaHomemEnforcado:  
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
    ;sangue
    loadn r0, #'}'
    loadn r2, #2304
    add r0, r0, r2
    loadn r1, #418
    outchar r0, r1
    inc r1
    inc r1
    outchar r0, r1
    loadn r1, #459
    outchar r0, r1
    
    loadn r1, #499
    dec r1
    outchar r0, r1
    inc r1
    inc r1
    outchar r0, r1
    
    
    
    loadn r1, #539
    outchar r0, r1
    loadn r1, #579
    dec r1
    outchar r0, r1
    inc r1
    inc r1
    outchar r0, r1
    
    ;tronco1
    loadn r1, #659	
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
    loadn r1, #779
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
    
    
;**********CONTROLA DESENHO HOMEM
Controla_Desenho_Homem:  ;escreva cada desenho em r6
  
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
   

 loadn r0, #0
 cmp r6, r0
 jeq Desenha1_Cabeca
 
 loadn r0, #1
 cmp r6, r0
 jeq Desenha2_TroncoSuperior
 
 loadn r0, #2
 cmp r6, r0
 jeq Desenha3_BracoDireito

 loadn r0, #3
 cmp r6, r0
 jeq Desenha4_BracoEsquerdo
 
 loadn r0, #4
 cmp r6, r0
 jeq Desenha5_TroncoInferior
 
 loadn r0, #5
 cmp r6, r0
 jeq Desenha6_PeEsquerdo
 
 loadn r0, #6
 cmp r6, r0
 jeq Desenha7_PeDireito
 
 
Desenha1_Cabeca:
  loadn r0, #'O'
  loadn r1, #379
  outchar r0, r1
  loadn r6, #1
  jmp Controla_Desenho_Homem_Exit
  
  
Desenha2_TroncoSuperior:

 loadn r0, #'|'
 loadn r1, #419
 outchar r0, r1
 loadn r6, #2
 jmp Controla_Desenho_Homem_Exit
 
 
Desenha3_BracoDireito:

 loadn r1, #460
 loadn r0, #'~'
 outchar r0, r1
 inc r1
 loadn r0, #'/'
 outchar r0, r1
 loadn r6, #3
 jmp Controla_Desenho_Homem_Exit 
 
 Desenha4_BracoEsquerdo:

 loadn r1, #457
 loadn r0, #'~'
 outchar r0, r1
 loadn r0, #'/'
 inc r1
 outchar r0, r1
 loadn r6, #4
 jmp Controla_Desenho_Homem_Exit 
 
 
 Desenha5_TroncoInferior:

 loadn r1, #459
 loadn r0, #'|'
 outchar r0, r1
 
 loadn r2, #40
 add r1, r1, r2
 outchar r0, r1
 
 add r1, r1, r2
 outchar r0, r1
 
 loadn r6, #5
 jmp Controla_Desenho_Homem_Exit 
 
 
 
Desenha6_PeEsquerdo:
;pé esquerdo
  loadn r1, #578
  loadn r0, #'/'
  outchar r0, r1
  loadn r2, #40
  add r1, r1, r2
  dec r1
  outchar r0, r1
  dec r1
  loadn r0, #'_'
  outchar r0, r1
 loadn r6, #6
 jmp Controla_Desenho_Homem_Exit 
  
 
Desenha7_PeDireito:
;pé esquerdo
  loadn r1, #580
  loadn r0, #'~'
  outchar r0, r1
  loadn r2, #40
  add r1, r1, r2
  inc r1
  outchar r0, r1
  inc r1
  loadn r0, #'_'
  outchar r0, r1
 loadn r6, #7
 jmp Controla_Desenho_Homem_Exit 
 
 
 
Controla_Desenho_Homem_Exit:

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

;**********************LIMPA A TELA Parte inferior*************************************

LimpaTelaParteInferior:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem;   Obs: a mensagem sera' impressa ate' encontrar "/0"

	 push r0
	 push r1
	 push r2
	 push r3
	 push r4
	 push r5
	 push r6
	 push r7
	
	loadn r0, #960		; Posicao inicial
	loadn r1, #1200		;posicao final
	loadn r2, #str_clearscreen	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadi r3, r2	; r3 <- Conteudo da MEMORIA enderecada por r2

	
LimpaTelaParteInferior_Loop:

	cmp r0, r1	;chegou ao fim da tela? posicao 1199, caso sim, sai
	jeq LimpaTela_Sai
	outchar r3, r0
	inc r0
	jmp LimpaTelaParteInferior_Loop
	
	
	
LimpaTelaParteInferior_Sai:	
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
	loadi r7, r7

  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
 
	
  
  rts  
  
  
  
;**********************STRCMP*************************
Strcmp:  ;faz strcmp-> r0->str1, r1->str2; Se r6 =0 sao diferentes, se r6 = 1 sao iguais

 ;empilha os registradores
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  
  loadn r3, #'\0' ;pra comparar
  
Strcmp_Loop:  
  
  loadi r5, r0    ;carrega conteudo de r0 (str1[0]) em r5
  loadi r4, r1    ;carrega conteudo de r1 (str2[0]) em r4
  inc r0	  ;incrementa conteudo de r0 (str1)
  inc r1          ;incrementa conteudo de r1 (str2)
  cmp r5, r3      ;compara com \0 pra ver se está no fim da str1
  jeq Strcmp_last_char ;se estiver no fim, verifica se str2 tb está no fim
  cmp r5, r4       ;compara o conteudo dos 2 caracteres atuais de str1 e str2
  jne Strcmp_not_equal ;se nao forem igual, seta resultado e sai da rotina
  jeq Strcmp_Loop       ;se os caracteres forem iguais, continua comparando
  
  
Strcmp_last_char:     ;compara se str2 está no fim (str1 já terminou!)
  cmp r4, r3          
  jeq Strcmp_equal    ;se str2 tb contem \0, as strings sao iguais
  
Strcmp_not_equal:
  loadn r6, #0       ;r6 recebe zero, dizendo que as strings sao diferentes
  jmp Strcmp_Final   ;vai para o final da rotina
  
Strcmp_equal:
  loadn r6, #1       ;r6 recebe zero, dizendo que as strings sao diferentes
  
Strcmp_Final:       ;desempilha e retorna. Nesse ponto str2 = str1

  ;desimpilha os registradores
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  
  rts  
  
  
StrcmpStrFromCharTyped:
;r0 palavra procurada
;r1 palavra que esta sendo montada
;r2 caractere

  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  push r6
  
  loadi r4, r0 ;conteudo do primeiro caracter da string procurada
  loadn r5, #'\0'
  loadn r7, #0  ;nao trocou
  
StrcmpStrFromCharTyped_Loop:

  cmp r4, r5
  jeq StrcmpStrFromCharTyped_Exit

  cmp r4, r2
  jeq StrcmpStrFromCharTyped_Write

  inc r1
  inc r1
  inc r0
  loadi r4, r0
  
  jmp StrcmpStrFromCharTyped_Loop
  
  
StrcmpStrFromCharTyped_Write:
  storei r1, r2
  loadn r7, #1
  
  inc r1
  inc r1
  inc r0
  loadi r4, r0
  jmp StrcmpStrFromCharTyped_Loop
  
StrcmpStrFromCharTyped_Exit:  
  
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
 
  rts
  
VerificaGanhador:  ;resultado em r6  
;r1 -> string a ser comparada (_ _ _ )

  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  
  loadn r1, #'\0'
  loadn r2, #0
  loadn r3, #'_'
  
VerificaGanhador_Loop:  
  loadi r4, r0
  cmp r4, r1  ;verifica fim da string
  jeq VerificaGanhador_Ganhou
  
  cmp r4, r3
  jeq VerificaGanhador_Perdeu
  
  inc r0
  jmp VerificaGanhador_Loop
  
  
  
VerificaGanhador_Perdeu:
  loadn r6, #0
  jmp VerificaGanhador_Exit
  
  
VerificaGanhador_Ganhou:
  loadn r6, #1
  
VerificaGanhador_Exit:
 
 
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0

  rts
  
;******************MSG GAHOU************  
Ganhou:  ;resultado rm r7 se vai jogar denovo ou nao
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  
  call LimpaTelaParteInferior
  loadn r1, #str_youwin
  loadn r0, #1010
  loadn r2, #0
  
  call ImprimeString
	
	loadn r1, #str_game_or_exit
	loadn r0, #1080
	loadn r2, #0
	call ImprimeString
	
	loadn r1, #1137
	call ObtemChar
	
	loadn r6, #'j'
	cmp r7, r6
	jeq Ganhou_JogarDenovo
	jmp Ganhou_SairDoJogo
	
 
 Ganhou_SairDoJogo:
 loadn r7, #0
 jmp Ganhou_Exit
 
 Ganhou_JogarDenovo:
 loadn r7, #1 
 
 Ganhou_Exit:
 
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0

  rts
  
  
  
;******************MSG GAHOU************  
Perdeu:  ;resultado rm r7 se vai jogar denovo ou nao
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  
 ;****AVISO QUE PERDEU
	call LimpaTela
	
	;imprime logo (estático)
	;imprime string do logo
	loadn r1, #logojogo
	loadn r0, #50
	loadn r2, #3072
	call ImprimeString
	
	call DesenhaForca
	call DesenhaHomemEnforcado
	;call LimpaTelaParteInferior
	loadn r1, #str_youlose 
	loadn r0, #1010
	loadn r2, #0
	call ImprimeString
	
	loadn r1, #str_game_or_exit
	loadn r0, #1080
	loadn r2, #0
	call ImprimeString
	
	loadn r1, #1137
	call ObtemChar
	
	loadn r6, #'j'
	cmp r7, r6
	jeq Perdeu_JogarDenovo
	jmp Perdeu_SairDoJogo
	
 
 Perdeu_SairDoJogo:
 loadn r7, #0
 jmp Perdeu_Exit
 
 Perdeu_JogarDenovo:
 loadn r7, #1 
 
 Perdeu_Exit:
 
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0

  rts  
