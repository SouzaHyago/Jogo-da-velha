;Nomes:
;Hyago Dos Santos Souza 
;Karen Nanamy Kamo 
;Sarah Meicy Machado Barbosa 

;********************************************************
;                         TEXTOS
;********************************************************
Tabuleiro : string "___  ___  ___"
mensagem : string "BEM-VINDOS JOGADORES!"
instrucoes : string "Use os numeros para marcar uma posicao!"

vezJogUm: string "* Vez do jogador 1! *"
vezJogDois: string "* Vez do jogador 2! *"

clear: string "                                  "
resultadoVelha: string "DEU VELHA x-x!"
resultadoP1: string "VITORIA DO JOGADOR 1!"
resultadoP2: string "VITORIA DO JOGADOR 2!"
jogueDenovo: string "APERTE ENTER PARA JOGAR DENOVO"

;********************************************************
;                       VARIÁVEIS
;********************************************************
jogada : var #1       ; se for ímpar, vez do jogador um. se for par, vez do jogador 2
vezJogador : var #1   ;guarda 1 ou 2 para ver de quem é a vez
; as seguintes variaveis indicam se a posicao esta ocupada
pos1 : var #1
pos2 : var #1
pos3 : var #1
pos4 : var #1
pos5 : var #1
pos6 : var #1
pos7 : var #1
pos8 : var #1
pos9 : var #1

;********************************************************
;                         MAIN
;********************************************************
restart:
    ;inicializando
    loadn r4, #1       
    store jogada, r4         ;inicializa a variável da jogada com 1 para o jogador 1 começar a partida

    ;limpando tabuleiro;
    loadn r1, #1014
    call limparLinha

    loadn r1, #894
    call limparLinha

    loadn r1, #774
    call limparLinha

    ;limpando mensagens da partida anterior
    loadn r1, #1400
    call limparLinha
    loadn r1, #1440
    call limparLinha

    ;inserindo o valor 0 nas variáveis para deletar as jogadas
    loadn r4, #0
    store pos1, r4
    store pos2, r4
    store pos3, r4
    store pos4, r4
    store pos5, r4
    store pos6, r4
    store pos7, r4
    store pos8, r4
    store pos9, r4

    jmp main 

main:
    ;printa a mensagem de boas vindas
    loadn r0, #mensagem
    loadn r1, #49
    loadn r4, #3328
    call printString

    ;printa a mensagem com as instruções
    loadn r0, #instrucoes
    loadn r1, #120
    loadn r4, #256
    call printString


    ;print do tabuleiro
    loadn r0, #Tabuleiro
    loadn r1, #813
    loadn r4, #3328
    call printString

    loadn r0, #Tabuleiro
    loadn r1, #933
    loadn r4, #3328
    call printString

    loadn r0, #Tabuleiro
    loadn r1, #1053
    loadn r4, #3328
    call printString


mainLoop:
    ;vendo de quem eh a jogada
    loadn r0, #2            ;auxiliar
    load r5, jogada         ;r5 recebe o numero da jogada
    mod r2, r5, r0          ;r2 recebe resto da divisão jogada/2
    loadn r0, #1            ;auxiliar
    cmp r0, r2              ;if(resto == 1)
    jeq printPlayerUm       ;eh a vez do jogador 1
    jmp printPlayerDois     ;else, eh a vez do jogador 2
    
    
    printPlayerUm:
        ;imprime na tela de quem eh a vez, no caso, jogador 1
        push r3
        loadn r3, #1
        store vezJogador, r3
        pop r3

        loadn r0, #vezJogUm
        loadn r1, #249
        loadn r4, #2048
        call printString
        ;r0 guarda o char que sera marcado no tabuleiro
        loadn r0, #'X'
        jmp lerTeclado


    printPlayerDois:
        ;imprime na tela de quem eh a vez, no caso, jogador 2
        push r3
        loadn r3, #2
        store vezJogador, r3
        pop r3

        loadn r0, #vezJogDois
        loadn r1, #249
        loadn r4, #2048
        call printString
        ;r0 guarda o char que sera marcado no tabuleiro
        loadn r0, #'O'


    lerTeclado:
        ;le teclado
        inchar r7           

        ;verificar qual tecla númerica foi apertada
        ;switch (r7) case:
        loadn r2, #'1'
        cmp r2, r7
        jeq pressUm

        loadn r2, #'2'
        cmp r2, r7
        jeq pressDois

        loadn r2, #'3'
        cmp r2, r7
        jeq pressTres

        loadn r2, #'4'
        cmp r2, r7
        jeq pressQuatro

        loadn r2, #'5'
        cmp r2, r7
        jeq pressCinco

        loadn r2, #'6'
        cmp r2, r7
        jeq pressSeis

        loadn r2, #'7'      
        cmp r2, r7 
        jeq pressSete  

        loadn r2, #'8'      
        cmp r2, r7 
        jeq pressOito  

        loadn r2, #'9'      
        cmp r2, r7 
        jeq pressNove


    call delay
    jmp mainLoop
halt

fimPartida:
    ; imprime resultado da partida
    loadn r1, #1400
    loadn r4, #256
    call printString

    call startAgain

    loopFimPartida:
        call delay
        inchar r7           ;le teclado
        loadn r0, #13       ;código para a tecla enter
        cmp r0, r7
        jne loopFimPartida
    jmp restart

;funcao que printa a mensagem para jogar de novo
startAgain:
    push r0
    push r1
    push r4

    loadn r0, #jogueDenovo
    loadn r1, #1440
    loadn r4, #256
    call printString

    pop r4
    pop r1
    pop r0

rts


;funcao que limpa a linha dado uma posicao na tela
limparLinha:
    push r0
    push r4

    loadn r0, #clear
    loadn r4, #0
    call printString

    pop r4
    pop r0

rts


pressUm:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos1
    cmp r1, r6
    jne mainLoop            ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #1014         ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos1
    jmp marcarJg2Pos1

    marcarJg1Pos1:
        store pos1, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos1:
        store pos1, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressDois:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos2
    cmp r1, r6
    jne mainLoop             ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #1019          ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos2
    jmp marcarJg2Pos2

    marcarJg1Pos2:
        store pos2, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos2:
        store pos2, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressTres:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos3
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #1024          ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos3
    jmp marcarJg2Pos3

    marcarJg1Pos3:
        store pos3, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos3:
        store pos3, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressQuatro:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos4
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #894           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos4
    jmp marcarJg2Pos4

    marcarJg1Pos4:
        store pos4, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos4:
        store pos4, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressCinco:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos5
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #899           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos5
    jmp marcarJg2Pos5

    marcarJg1Pos5:
        store pos5, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos5:
        store pos5, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressSeis:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos6
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #904           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos6
    jmp marcarJg2Pos6

    marcarJg1Pos6:
        store pos6, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos6:
        store pos6, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressSete:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos7
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #774           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos7
    jmp marcarJg2Pos7

    marcarJg1Pos7:
        store pos7, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos7:
        store pos7, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressOito:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos8
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #779           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos8
    jmp marcarJg2Pos8

    marcarJg1Pos8:
        store pos8, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos8:
        store pos8, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

pressNove:
    ;verificando se a pos esta vazia
    loadn r6, #0
    load r1, pos9
    cmp r1, r6
    jne mainLoop ;posicao já foi preenchida, retorna

    ;verificando qual jogador fez a jogada
    push r2
    push r3
    push r4

    load r2, vezJogador
    loadn r3, #1
    loadn r4, #2
    cmp r2, r3
    loadn r1, #784           ;guarda a posicao a ser marcada no tabuleiro
    jeq marcarJg1Pos9
    jmp marcarJg2Pos9

    marcarJg1Pos9:
        store pos9, r3
        pop r4
        pop r3
        pop r2
        jmp fazerJogada 

    marcarJg2Pos9:
        store pos9, r4
        pop r4
        pop r3
        pop r2
        jmp fazerJogada

fazerJogada: 
       outchar r0, r1       ;marca X ou O no tabuleiro
       inc r5               ;incrementa o numero da jogada
       store jogada, r5


       jmp checarVitoria

checarVitoria:
    ;sucesso se pos7 == pos8 == pos9 (todas diferentes de 0)
    checarVitoriaLinhaSup:
    ;verifica se a linha esta incompleta
    load r0, pos7
    loadn r1, #0
    cmp r0, r1                  ;se pos7 == 0, linha superior incompleta
    jeq checarVitoriaLinhaMeio
    ; se pos7 != 0
    load r1, pos8
    cmp r0, r1                 ;(pos7 == pos8) ?
    jne checarVitoriaLinhaMeio ;false, linha superior não uniforeme 
    ;true, compara pos7 == pos 9
    load r1, pos9
    cmp r0, r1
    jeq checarVitoriaTrue


    ; sucesso se pos4 == pos5 == pos6 (todas diferentes de 0)
    checarVitoriaLinhaMeio:
    ;verifica se a linha esta incompleta
    load r0, pos4
    loadn r1, #0
    cmp r0, r1                  ;se pos4 == 0, linha do meio incompleta
    jeq checarVitoriaLinhaInf
    ; compara as demais posicoes da linha
    load r1, pos5
    cmp r0, r1
    jne checarVitoriaLinhaInf
    load r1, pos6
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaLinhaInf:
    ;verifica se a linha esta incompleta
    load r0, pos1
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaColunaUm
    ; compara as demais posicoes da linha
    load r1, pos2
    cmp r0, r1
    jne checarVitoriaColunaUm
    load r1, pos3
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaColunaUm:
    ; verifica se a coluna esta incompleta
    load r0, pos7
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaColunaDois
    ; compara as demais posicoes da coluna
    load r1, pos4
    cmp r0, r1
    jne checarVitoriaColunaDois
    load r1, pos1
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaColunaDois:
    ; verifica se a coluna esta incompleta
    load r0, pos8
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaColunaTres
    ; compara as demais posicoes da coluna
    load r1, pos5
    cmp r0, r1
    jne checarVitoriaColunaTres
    load r1, pos2
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaColunaTres:
    ; verifica se a coluna esta incompleta
    load r0, pos9
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaDiagUm
    ; compara as demais posicoes da coluna
    load r1, pos6
    cmp r0, r1
    jne checarVitoriaDiagUm
    load r1, pos3
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaDiagUm:
    ; verifica se a diagonal esta incompleta
    load r0, pos7
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaDiagDois
    ; compara as demais posicoes da diagonal
    load r1, pos5
    cmp r0, r1
    jne checarVitoriaDiagDois
    load r1, pos3
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaDiagDois:
    ; verifica se a diagonal esta incompleta
    load r0, pos9
    loadn r1, #0
    cmp r0, r1
    jeq checarVitoriaFalse
    ; compara as demais posicoes da diagonal
    load r1, pos5
    cmp r0, r1
    jne checarVitoriaFalse
    load r1, pos1
    cmp r0, r1
    jeq checarVitoriaTrue

    checarVitoriaFalse:
    ;verificando se deu velha
    loadn r0, #9
    cmp r5, r0              ;r5 contem o numero da jogada
    jgr deuVelha            ;se foram feitas mais de 9 jogadas sem vitória, deu velha

    jmp mainLoop

    ;executado caso alguem tenha ganhado
    ;descobre quem ganhou e imprime mensagem de sucesso
    checarVitoriaTrue:


        loadn r1, #1
        cmp r0, r1      ;r0 guarda o conteudo de uma pos da linha/ coluna completa
        ;se posX == 1, p1 ganhou
        jeq winP1
        ;else
        jmp winP2

deuVelha:
    ; carrega resultado velha como resultado da partida
    loadn r0, #resultadoVelha
    jmp fimPartida

winP1:  
    ;função que coloca resultado como vitoria do p1
    loadn r0, #resultadoP1
    jmp fimPartida

winP2:
    ;função que coloca resultado como vitoria do p2
    loadn r0, #resultadoP2
    jmp fimPartida

;funcao que printa uma string
printString: 
	push r0 	            ;endereça a string
	push r1 	            ;guarda a posição na tela onde a string começará a ser escrita
	push r2	                ;auxiliar
	push r3	                ;variável auxiliar 
	push r4	                ;guarda a cor da string


	loadi r2, r0 		    ;r2 <- r0
	loopPrintString:
		add r2, r4, r2      ;isso é o que "colore" o texto
		outchar r2, r1      ;printa o char contido em r2 na posição contida no r1
		
		inc r1 		        ;avança uma posição na tela
		inc r0 		        ;avança um char da string
		loadi r2, r0	
		
		loadn r3, #'\0'		;atribui critério de parada ao r3 (chegar no fim da string)
		cmp r2, r3			;verifica se o char em r2 = \0
		jne loopPrintString	;se NÃO for igual, continua do loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

rts 
 

delay:			
	push r0                 ;conserva os valores dos registradores
	push r1
	
	loadn r1, #100          ;a
    delay_volta2:			;quebrou o contador acima em duas partes (dois loops de decremento)
	    loadn r0, #200	    ;b
    delay_volta: 
        dec r0			    ; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
        jnz delay_volta	
        dec r1
        jnz delay_volta2
	
	pop r1
	pop r0
	

rts
