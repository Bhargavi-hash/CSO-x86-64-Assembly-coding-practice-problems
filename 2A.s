.data
        # Here is the list of 32 short ints (16 bits).
        # Declaring an array
        .align 2
        List:
            .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
        KEY:
            .word 20
.text
.global main
main:
        movq $-1, %rax                            # returns position where the KEY is found
        movq $32, %rcx                             # Stores the length of the List ( N = 8 )
        movq $0, %rdx                             # Used to iterate through the List
        movq List@GOTPCREL(%rip), %rbx            # %rbx stores the pointer to the "List"
        movq KEY@GOTPCREL(%rip), %r10             # %r10 = &KEY
        movq (%r10), %r10                         # %r10 = KEY
                # ###    Sequential Search    ### #

                        # We loop as follows:
                        # while ( i != 8 )
                        # {
                        #    ;if(List[i] == KEY)
                        #         return i;
                        #     i = i + 1;
                        # }
.loop:
        leaq (%rbx, %rdx, 2), %r12                # Loading the address of %rbx into %r12
        cmpw %r10w, (%r12)                        # Compare KEY and value in memory %r12 
        je .found                                 # Jump to found
        addq $1, %rdx                             # i = i + 1
        cmpq %rcx, %rdx                           # Compare i and N
        je .done                                  # if (i == N) goto done
        call .loop                                # go back to loop again
.found:
        movq %rdx, %rax 
        jmp .done
.done:
        ret

