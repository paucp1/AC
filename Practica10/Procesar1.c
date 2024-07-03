
    pushl %ebp
    movl %esp, %ebp
    subl 8, %esp
    pushl %ebx

    movl 8(%ebp), %eax #@mata
    movl 12(%ebp), %ecx #@matb
    movl 16(%ebp), %edx #n

    imul %edx, %edx #n*n
    addl %eax, %edx #@mata[n*n]

 for:
    cmpl %edx, %eax #mata[i*n+j] < mata[n*n]
    jge end 
    movb (%eax), %bh 
    andb $1, %bh #mata[i*n+j]&1
    cmpb $0, %bh #mata[i*n+j]&1 > 0
    jle else
if: 
    movb $255, (%ecx) #matb[i*n+j] = 255
    jmp incr
else: 
    movb $0, (%ecx) #matb[i*n+j] = 0
incr: 
    incl %eax #++@mata
    incl %ecx #++@matb 
    jmp for
end: 
    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret


