.text
.global Rotate
                # ###  Rotate matrix by 90 degrees clockwise direction  ### #
Rotate:
                                                # rdi is the 8*8 matrix passed
        movq $0, %rcx                           # %rcx -> Stores the row index (i = 0)
        movq $0, %rdx                           # %rdx -> Stores the column index (j = 0)
        movq $8, %rbx                           # %rbx -> N = 8
          
.loop:
        # the below elements will be swapped in anti clockwise direction.
        # a[i][j]               -> %r9              
        # a[j][n-1-i]           -> %r10
        # a[n-1-i][n-1-j]       -> %r11
        # a[n-1-j][i]           -> %r12
        
        # ####  Setting %eax to a[i][j]

        movq %rcx, %r8                          # %r8 = i
        imul $8, %r8                            # %r8 = i * 8
        addq %rdx, %r8                          # %r8 = (i*8)+j
        leaq (%rdi, %r8, 2), %r9                # load the address of a[i][j] to %r9
        movw (%r9), %ax                         # %ax = a[i][j]

        # ####  Setting %r13 to a[j][n-1-j]

        movq %rdx, %r8                          # %r8 = j
        imul $8, %r8                            # %r8 = j * 8
        subq %rcx, %rbx                         # %rbx = N - i
        subq $1, %rbx                           # %rbx = N - i - 1
        addq %rbx, %r8                          # %r8 = (j*8)+(n-1-i)
        leaq (%rdi, %r8, 2), %r10               # load address of a[j][n-1-j] to %r10
        movw (%r10), %r13w                      # %r13w = a[j][n-1-j]
        movq $8, %rbx                           # resetting back %rbx to N = 8

        # ####  Setting %r14 to a[n-1-i][n-1-j]

        movq %rbx, %r8                          # %r8 = n
        subq $1, %r8                            # %r8 = n-1
        subq %rcx, %r8                          # %r8 = n-i-1
        imul $8, %r8                            # %r8 = (n-i-1)*8
        addq %rbx, %r8                          # %r8 = ((n-i-1)*8)+n
        subq $1, %r8                            # %r8 = ((n-i-1)*8)+n-1
        subq %rdx, %r8                          # %r8 = ((n-i-1)*8)+(n-1-j)
        leaq (%rdi, %r8, 2), %r11               # load address of a[n-1-i][n-1-j] to %r11
        movw (%r11), %r14w                      # %r14w = a[n-1-i][n-1-j]

        # ####  Setting %r15 to a[n-1-j][i]

        movq %rbx, %r8                          # %r8 = n
        subq $1, %r8                            # %r8 = n-1
        subq %rdx, %r8                          # %r8 = n-1-j
        imul $8, %r8                            # %r8 = (n-1-j)*8
        addq %rcx, %r8                          # %r8 = ((n-1-j)*8)+i
        leaq (%rdi, %r8, 2), %r12               # load address of a[n-1-j][i] to %r12
        movw (%r12), %r15w                      # %r15w = a[n-1-j][i]

# ## swap %rax <-> %r15
.swap1:
        movw %r15w, (%r9)
        movw %ax, (%r12)

# ## swap %rax <-> %r14
.swap2:
        movw %ax, (%r11)
        movw %r14w, (%r12)

# ## swap %rax <-> %r13
.swap3:
        movw %ax, (%r10)
        movw %r13w, (%r11)

        addq $1, %rdx                           # j = j + 1
        movq $7, %rsi
        subq %rcx, %rsi
        cmpq %rsi, %rdx                         # compare j and 8
        je .NextRow                             # if (j == 8) move to next row
        jmp .loop                               # else continue iterating through the row

.NextRow:
        
        incq %rcx                               # i = i + 1
        movq %rcx, %rdx                         # j = i
        cmpq $4, %rcx                           # compare i and n/2
        je .done                                # if (i == 4) then exit
        jmp .loop                               # else goto loop
.done:
        ret




        
        