.text
.global Hamming_dist

Hamming_dist:
        # first argument(A) is stored in " edi "
        # second argument(B) is stored in " esi "
        movl $0, %eax           # the return value of the hamming function
                                # is set to zero.
        cmpl %edi, %esi         # A == B
        je .done
.loop:
                # We loop as follows
                # while(A != B)
                # {
                #       p = A&1;
                #       q = B&1;
                #      ;if (p != q)
                #               count += 1;
                #       A = A/2;
                #       B = B/2;
                # }
        movl %edi, %ebx         # p = A, p is ebx
        movl %esi, %ecx         # q = B, q is ecx
        andl $1, %ebx           # p = p&1
        andl $1, %ecx           # q = q&1
        cmpl %ebx, %ecx         # compare p and q
        jne  .inc_count         # if not equal, then increment the hamming dist.
        shrl $1, %edi           # A = A/2
        shrl $1, %esi           # B = B/2
        cmpl %edi, %esi         # compare A and B
        je .done                # if equals then jump to done
        call .loop

.inc_count:
        addl $1, %eax

.done:
        ret

