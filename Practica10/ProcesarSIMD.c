    pushl %ebp
    movl %esp, %ebp
    subl 8, %esp

    movl 8(%ebp), %eax #@mata
    movl 12(%ebp), %ecx #@matb
    movl 16(%ebp), %edx #n

    imul %edx, %edx #n*n
    addl %eax, %edx #@mata[n*n]

 for:
    cmpl %edx, %eax #mata[i*n+j] < mata[n*n]
    jge end 
    movdqu (%eax), %xmm0 #xmm0 = mata[i*n+j]
    movdqu (uno), %xmm1 #xmm1 = 1
    pand %xmm0, %xmm1 #mata[i*n+j]&1
    movdqu %xmm1, (%ecx) #xmm1 = mata[i*n+j]&1
    movdqu (cero), %%xmm0
    pcmpgtb %xmm0, %xmm1 #si mata[i*n+j]&1 > 0, xmm1 tot a 1s (255), sino xmm1 tot a 0s
    movdqu %xmm1, (%ecx) #matb[i*n+j] = xmm1
    addl $16, %eax
    addl $16, %ecx
    jmp for

end: 
    movl %ebp, %esp
    popl %ebp
    ret