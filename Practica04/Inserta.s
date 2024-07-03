 .text
	.align 4
	.globl Insertar
	.type Insertar,@function
Insertar:
        pushl %ebp
        movl %esp, %ebp
        subl $12, %esp
        pushl %ebx
        pushl %esi
        
        movl $0, %ebx;
        movl $-1, %ecx
        
dowhile:imul $12, %ebx, %edx		#12i
        addl 8(%ebp), %edx		#@v + 12 i
        movl 4(%edx), %edx		#%edx = v[i].k
        
        cmpl 16(%ebp), %edx		
        jle else1			#Salta al else si X.k >= v[i].k
        
        movl %ebx, %ecx		#lug = i
        jmp enddowhile
else1:
        incl %ebx			#++i		
        
	imul $12, %ebx, %edx	#12i
        addl 8(%ebp), %edx		#@v + 12 i
        cmpl $0x80000000, 4(%edx)	#v[i].k
        jne dowhile
        
enddowhile: 
	imul $12, %ebx, %edx	#12i
        addl 8(%ebp), %edx		#@v + 12 i
        cmpl $0x80000000, 4(%edx)	#v[i].k
        jne else2
        
        movl %ebx, %ecx		#lug = i
        jmp endelse2
        
else2:	imul $12, %ebx, %edx		#12i
        addl 8(%ebp), %edx		#@v + 12 i
        cmpl $0x80000000, 4(%edx)	#v[i].k
        je endelse2
        
        incl %ebx
        jmp else2
        
endelse2:
	movl %ebx, %eax		# j = i
	
for:	cmpl %eax, %ecx		
	jg endfor			#Salta si lug > j
	
	imul $12, %eax, %edx		#12j
        addl 8(%ebp), %edx		#@v + 12j = &v[j].c
        movl (%edx), %esi		#esi = v[j].c
        movl %esi, 12(%edx)		#v[j+1].c = v[j].c
        
        movl 4(%edx), %esi		#v[j].k
        movl %esi, 16(%edx)		#v[j+1].k = v[j].k
        
        movl 8(%edx), %esi		#v[j].m
        movl %esi, 20(%edx)		#v[j+1].m = v[j].m
        
        decl %eax			#--j
        jmp for
        
endfor: pushl %ecx
	pushl 12(%ebp)
	pushl 8(%ebp)
	
	call Asignar
	
	movl %ebx, %eax
	incl %eax
	
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
	
    
        
        
        
        
	
	


        
        
        
        
        
    	
