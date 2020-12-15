
####################################
#Trabalho feito por:
#Julia martins reis
#Pedro Henrique Morais
#####################################


.data

saida: .asciiz "Saida:" 
multi: .asciiz "+"
n: .asciiz "\n"
igual: .asciiz "="

dados: .float 1.0000
taxaerro: .float 1.400
peso1: .float 0.800000
peso2: .float 0.000001
aprendisado: .float 0.005


.text	
MAIN: 
	
	addi $s1,$zero, 15	
	addi $s2,$zero, 10
	
	lwc1 $f0, dados
	lwc1 $f1, peso1
	lwc1 $f2, peso2
	lwc1 $f3, taxaerro
	lwc1 $f4, aprendisado

	
	mul.s $f5, $f0, $f0
	li $t0,1                        # int i = 1
#TREINO
for:	slt $t1, $t0, $s1
	beq $t1, $zero fim
	move $v0,$t0                    # dados = i;            
        mtc1 $v0,$f20  
        cvt.s.w $f20,$f20
        mov.s  $f0,$f20   	
	add.s $f5, $f0, $f0		# saidaEsperada = dados * dados;
	add.s $f11, $f1, $f2,		# peso1 + peso2
	mul.s $f22, $f11, $f0		#(peso1 + peso2) * dados
	sub.s $f3, $f5, $f22		# taxaErro = saidaEsperada - (pesoA + pesoB) * dados
	mul.s $f23, $f4,$f0		#taxaAprendizado * dados;
	mul.s $f24, $f3,$f23		# taxaErro * taxaAprendizado * dados;
	add.s $f1, $f1, $f24		# peso1 = peso1 + taxaErro * taxaAprendizado * dados;
	add.s $f2, $f2, $f24		# peso2 += taxaErro * taxaAprendizado * dados;
	sub.s $f25, $f1, $f2		# saidaEsperada - peso1
	sub.s $f3, $f2, $f25		# taxaErro = saidaEsperada - peso1 - peso2;
	move  $v0,$t0                 	# i++
        addiu $v0,$v0,1
        move  $t0,$v0
	j for
	
# Resultados
	fim:	li  $t2,1               		 # int i = 1
	for2:	slt $t3, $t2, $s2
		beq $t3, $zero fim2
		move $v0,$t2                      	 # dados = i;            
        	mtc1 $v0,$f19  
        	cvt.s.w $f19,$f19
        	mov.s $f0,$f19   			
		mul.s $f15, $f0, $f1 			#dados * pesoA 
		mul.s $f16, $f0, $f2			# dados * pesoB;
		add.s $f6, $f15, $f16			# resultado = dados * pesoA + dados * pesoB;
			

		li $v0, 4
		la $a0, n
		syscall 
	
		li $v0, 4
		la $a0, saida
		syscall
			
		li $v0, 2
		mov.s $f12, $f0
		syscall
 			
		li $v0, 4
		la $a0, multi
		syscall 

		li $v0, 2
		mov.s $f12, $f0
		syscall
 		
		li $v0, 4
		la $a0, igual
		syscall 

		li $v0, 2
		mov.s $f12, $f6
		syscall	
		
		move  $v1,$t2                 	# i++
      	 	addiu $v1,$v1,1
     		move  $t2,$v1
			
		j for2
		fim2: jr $ra
