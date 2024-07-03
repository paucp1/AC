 .text
	.align 4
	.globl Asignar
	.type Asignar,@function
Asignar:
	pushl %ebp
        	movl %esp, %ebp

	movl 8(%ebp), %eax		#eax = @v
	imul $12, 24(%ebp), %ecx		#ecx = 12*pos
	movl 12(%ebp), %edx		#edx = X.c
	movl %edx, (%eax, %ecx)		#v[pos].c = X.c

	movl 16(%ebp), %edx		#edx = X.k
	movl %edx, 4(%eax, %ecx)		#v[pos].k = X.k

	movl 20(%ebp), %edx		#edx = X.m
	movl %edx, 8(%eax, %ecx)		#v[pos].m = X.m

	movl %ebp, %esp
	popl %esp
	ret
