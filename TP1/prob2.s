.data

##### R1 START MODIFIQUE AQUI START #####

#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

vetor1: .word 1 2 3 4 #Primeiro vetor
vetor2: .word 1 1 1 1 #Segundo vetor

##### R1 END MODIFIQUE AQUI END #####
      
.text    

        add s0, zero, zero
        la a0, vetor1
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 2
        bne r0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor2
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 1
        bne r0,t0, FIM
        addi s0,s0,1


##### R2 START MODIFIQUE AQUI START #####

# Esse espaço é para você escrever o código dos procedimentos. 
# Por enquanto eles estão vazios

media:  # (a2(endeteço do vetor), a3(tamanho do vetor)) -> a0(valor médio)
        # Prologue
        addi	sp, sp, -40     # Alocação de memória 
        sw      ra, 0(sp)	# Armazeno endereço de retorno
        sw      t0, 8(sp)	# Armazeno valor de t0 para usar ele
        sw      t1, 16(sp)	# Armazeno valor de t1 para usar ele
        sw      t2, 24(sp)	# Armazeno valor de t2 para usar ele
        sw      t3, 32(sp)	# Armazeno valor de t3 para usar ele

        # Function
        add	t0, zero, a2    # Carrego endereço do vetor1 em t0 para iteração
        add	t1, zero, zero  # Inicialização t1 com 0
        addi 	t2, zero, 4     # Variável para conseguir endereço final em bytes
        mul	t2, t2, a3	# Tamanho em bytes do vetor
        add 	t2, t2, a2	# Endereço final do vetor

  loop1:
	lw	t3, 0(t0)	# Carrego valor do vetor em t2
	add	t1, t1, t3	# Acumulo soma dos valores do vetor
        addi    t0, t0, 4
        bne     t0, t2, loop1   # Confere se ja somou todos valores do vetor

        div     a0, t1, a3
    
        # Epilogue
        lw      ra, 0(sp)       # Carrego endereço de retorno
        lw      t0, 8(sp)       # Carrego antigo valor de t0
        lw      t1, 16(sp)      # Carrego antigo valor de t1    
        lw      t2, 24(sp)      # Carrego antigo valor de t2
        lw      t3, 32(sp)      # Carrego antigo valor de t3
        addi    sp, sp, 40      # Desalocação de memória
        ret
		
variancia: # (a2(endereço vetor1), a3(endereço vetor2), a4(tamanho dos vetores)) -> a0
        # Prologue
        addi    sp, sp, -80     # Alocação de memória 
        sw      ra, 0(sp)	# Armazeno endereço de retorno
        sw      a2, 8(sp)	# Armazeno valor de a2 para usar ele
        sw      a3, 16(sp)	# Armazeno valor de a3 para usar ele
        sw      t0, 24(sp)	# Armazeno valor de t0 para usar ele
        sw      t1, 32(sp)	# Armazeno valor de t1 para usar ele
        sw      t2, 40(sp)	# Armazeno valor de t2 para usar ele
        sw      t3, 48(sp)	# Armazeno valor de t3 para usar ele
        sw      t4, 56(sp)	# Armazeno valor de t4 para usar ele
        sw      t5, 64(sp)	# Armazeno valor de t5 para usar ele
        sw      t6, 72(sp)	# Armazeno valor de t6 para usar ele

        # Function
        add     t0, a2, zero    # Armazeno endereço vetor1 em t0
        add     t1, a3, zero    # Armazeno endereço vetor2 em t1
        add     t2, a4, zero    # Armazeno tamanho dos vetores em t2
        add     a3, t2, zero    # Passo tamanho do vetor no registrador de argumento a3
        jal     ra, media       # Realizo função média para vetor1
        add     t3, a0, zero    # Armazeno resultado da média em t3
        add     a2, t1, zero    # Passo endereço do vetor2 no registrador de argumento a2
        jal     ra, media       # Realizo função média para vetor2
        add     t4, a0, zero    # Armazeno resultado da média em t4
        add     t5, zero, zero  # Inicializo t5 em 0
        addi    sp, sp, -16     # Alocação de memória 
        sw      t0, 0(sp)       # Armazeno tamanho original dos vetores

  for1:
        sw      t5, 8(sp)       # Armazeno resultado da soma na memoria
        lw      t5, 0(t0)       # Carrego valor do vetor1 em t5
        sub     t5, t5, t3      # Subtraio a média do valor
        lw      t6, 0(t1)       # Carrego valor do vetor2 em t6
        sub     t6, t6, t4      # Subtraio a média do valor
        mul     t6, t6, t5      # Multiplico t5 e t6 e armazeno em t6
        lw      t5, 8(sp)       # Carrego soma passada da memória em t5
        add     t5, t5, t6      # Soma da multiplicação passada com a atual
        addi    t2, t2, -1      # Reduzo tamanho do vetor para iteração
        addi    t0, t0, 4       # Avanço no vetor1
        addi    t1, t1, 4       # Avanço no vetor2
        bne     t2, zero, for1  # Se tamanho do vetor = 0 sai do loop

        lw      t0, 0(sp)       # Carrego de volta antigo tamanho N do vetor
        addi     t0, t0, -1     # Subtraio 1 de N
        div     a0, t5, t0      # Divido resultado da soma por N - 1 e armazeno no registrador de retorno a0
        addi    sp, sp, 16      # Desalocação de memória 

        # Epilogue
        lw      ra, 0(sp)       # Carrego endereço de retorno
        lw      a2, 8(sp)	# Carrego antigo valor de a2
        lw      a3, 16(sp)	# Carrego antigo valor de a3
        lw      t0, 24(sp)	# Carrego antigo valor de t0
        lw      t1, 32(sp)	# Carrego antigo valor de t1
        lw      t2, 40(sp)	# Carrego antigo valor de t2
        lw      t3, 48(sp)	# Carrego antigo valor de t3
        lw      t4, 56(sp)	# Carrego antigo valor de t4
        lw      t5, 64(sp)	# Carrego antigo valor de t5
        lw      t6, 72(sp)	# Carrego antigo valor de t6
        addi    sp, sp, 80      # Desalocação de memória
        ret                    

##### R2 END MODIFIQUE AQUI END #####

FIM: addi t0, zero, s0