.text
	.align 4
	.globl procesar
	.type	procesar, @function
	.data
	.align 16
	uno:     .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	cero:    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	
procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl %ebx
    pushl %esi
    pushl %edi
    
# Aqui has de introducir el codigo
	movl 8(%ebp), %eax #@mata
	movl 12(%ebp), %ecx #@matb
	movl 16(%ebp), %edx #n

	imul %edx, %edx #n*n
	addl %eax, %edx #@mata[n*n]
	
for:
    movl %eax, %ebx
	andl $15, %ebx
	cmpl $0, %ebx
	jne fora
	movl %ecx, %ebx
	andl $15, %ebx
	cmpl $0, %ebx
	jne fora

forb: cmpl %edx, %eax
	jge fifor
	movdqu (uno), %xmm1 #mueve todo 1s a xmm1
	movdqu (%eax), %xmm0  
	pand %xmm0, %xmm1  #and bit a bit 
	movdqu %xmm1, (%ecx)
	movdqu (cero), %xmm0
	pcmpgtb %xmm0, %xmm1  # pone a 1s el xmm1 si es >0, sino pone todo a 0s
	movdqu %xmm1, (%ecx)
	addl $16, %eax  
	addl $16, %ecx
	jmp for
	
fora: cmpl %edx, %eax
	jge fifor
	movdqa (uno), %xmm1 #mueve todo 1s a xmm1
	movdqa (%eax), %xmm0  
	pand %xmm0, %xmm1  #and bit a bit 
	movdqa %xmm1, (%ecx)
	movdqa (cero), %xmm0
	pcmpgtb %xmm0, %xmm1  # pone a 1s el xmm1 si es >0, sino pone todo a 0s
	movdqa %xmm1, (%ecx)
	addl $16, %eax  
	addl $16, %ecx
	jmp for

# El final de la rutina ya esta programado

fifor:	
    emms	# Instruccion necesaria si os equivocais y usais MMX
    popl %edi
    popl %esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret