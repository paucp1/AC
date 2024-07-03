#suposem valor en registre %eax

movl %eax, %ecx
andl $15, %ecx
cmpl $0, %ecx
je m16