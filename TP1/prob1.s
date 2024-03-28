.data

##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

vetor: .word 1 2 3 4 5 6 7 8 9 10


##### R1 END MODIFIQUE AQUI END #####

.text
        add s0, zero, zero #Quantidade de testes em que seu programa passou
        la a0, vetor
        addi a1, zero, 10
        addi a2, zero, 2
        jal ra, multiplos
        addi t0, zero, 5
        bne r0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor2
        addi a1, zero, 10
        addi a1, zero, 3
        jal ra, multiplos
        addi t0, zero, 3
        bne r0,t0, FIM
        addi s0,s0,1


##### R2 START MODIFIQUE AQUI START #####
multiplos: add  t0, a0  , zero  # Endereço do vetor em t0 para iteração
	   addi t5, zero, 4     # Carrega t5 com 4 para conseguir tamanho do vetor em bytes
      	   mul  t5, a1  , t5    # Carrego em t5 o tamanho total do vetor em bytes
           add  t5, a0  , t5    # Carrego endereço final do vetor em t5
loop:	   lw   t1, 0(t0) 	    # Carrega valor do vetor em t1	
           rem  t2, t1  , a2	# Carrega resto da divisão do número de t2 por a2
           bne  t2, zero, else	# If(resto == 0){...}else{...}
if:	   addi t3, t3  , 1     # Adiciona 1 em t3 para contagem dos múltiplos
else:	   addi t0, t0  , 4     # Desloca resgistrador do vetor para próximo elemento
   	   bne  t0, t5  , loop  # Confere se o vetor ja foi todo lido
##### R2 END MODIFIQUE AQUI END #####

FIM: addi t0, zero, a0