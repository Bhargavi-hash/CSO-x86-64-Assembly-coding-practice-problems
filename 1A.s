.data
        # Here is the list of 32 short ints (16 bits)
        # Declaring an array
        .align 2
        List:
            .word 6, 8, 1, 2, 7, 3, 4, 5
        len:
            .word 8
.text
.global main                 # Bubble Sort Implementation #
main:
        movq List@GOTPCREL(%rip), %rbx              # %rbx stores pointer to the List
        movq len@GOTPCREL(%rip), %r10               # %r10 = N = length of List
        subq $1, %r10                               # N = N - 1
        movq $0, %rcx                               # %rcx -> Used to iterate (i=0)
        movq $0, %rdx                               # %rdx = Swap_count

.loop:
        leaq (%rbx, %rcx, 2), %rax                  # load address of List[i] to %rax
        movw (%rax), %r12w                          # %r12 = List[i]
        cmpq %rcx, %r10                             # compare i and N
        je .check_swap_count                        # if(i==N) goto check swap funct
        incq %rcx                                   # i = i + 1
        leaq (%rbx, %rcx, 2), %r11                  # load address of List[i+1] to %r11
        movw (%r11), %r13w                          # %r13 = List[i+1]
        cmpw %r12w, %r13w                           # compare List[i] & List[i+1]
        jl .swap                                    # if(List[i+1]<List[i]) then swap
        jmp .loop                                   # Continue iterating

.check_swap_count:
        cmpq $0, %rdx                               # compare 0 and swap count
        je .done                                    # if(swap_count == 0)=>List is sorted
                                                    # exit from the sorting process
        jmp .set                                    # else goto set funct

.swap:
        # Swaping List[i] and List[i+1]
        movw %r13w, (%rax)                           
        movw %r12w, (%r11)    
        addq $1, %rdx                               # Incrementing the swap_count 
        jmp .loop                                   # Go back to loop   

.set:
        movq $0, %rcx                               # resetting i to 0
        movq $0, %rdx                               # resetting swap_count to 0
        jmp .loop                                   # Start iterating through the List again

.done:
        ret






