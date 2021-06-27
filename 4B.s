.text               
.global search       
        # %rdi is the pointer to the char array --> First argument
        # %rsi is the pointer to the frq array --> Second argument
search:
        movl $0,  %ecx                  # Used for iterating through the char array (int i)
        movl $32, %edx                  # %edx stores the length of the array (N = 32)

.loop:
        leaq (%rdi,%rcx,1), %r12        # load the address of sen[0] into %r12
        movb (%r12), %r13b 
        cmpb $90, %r13b                 # Compare 65 and sen[%ecx]
        jle .test2                      # if (sen[i] >= 'A') then jump to test2
        
.traverse: 
        add $1,  %ecx                   # incrementing the iterating const (i.e i++)
        cmpl %edx, %ecx                 # compare i and N
        je .done                        # i == 32 goto done
        jmp .loop                       # else goto Loop
.test2:
        cmpb $65, %r13b                 # compares 90 and sen[%ecx] 
        jl .traverse                    # if (sen[i] <= 'Z') then inc the frq
        
.frq:
        
        subb $65, %r13b                 # subtract 65 from sen[i] and store the 
                                        # resulting value in sen[i]
        movzbq %r13b, %r13              # zero extend byte to quad word
        leaq (%rsi,%r13,2), %rbx        # load the address of frq[sen[i]] in %rbx
        addq $1, (%rbx)                 # frq[sen[i]] += 1
        jmp .traverse                   # continue iterating through the array

.done:
        ret

        