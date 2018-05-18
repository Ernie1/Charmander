data segment

    ;-----------------------------------------
    ;ARRAY OF 50 INTEGERS.
    arr dw 28, 44, 22, 7, 42, -15, 35, 6, 43, 20
    ;-----------------------------------------

    

ends

code segment

    assume cs: code, ds: data

    start:

        ;INITIALIZE DATA SEGMENT.
        mov  ax, data
        mov  ds, ax

        ;CALL RECURSION(A, 0, A.LENGTH-1).
        mov bx, 0
        mov cx, 9
        call recursion
       

        ;FINISH PROGRAM.
        mov  ax, 4c00h
        int  21h

        ;-----------------------------------------
        ;RECURSION(A, p, r)
        ;    if p < r
        ;        q = RECURSION(A, p, r)
        ;        RECURSION(A, p, q-1)
        ;        RECURSION(A, q+1, r)

        recursion proc

            cmp bx, cx  ;if (left < right)
            jge ret1
             
            
            push cx
            push bx
            call quicksort  ;int pivot(ax) = quicksort(array, left, right);
            
            pop bx
            push ax
            mov cx, ax
            dec cx
            call recursion

            pop ax
            pop cx
            mov bx, ax
            inc bx
            call recursion

            ret1:
            ret

                   

        recursion endp

        ;-----------------------------------------
        ;QUICKSORT(A, p, r)
        ;    x = A[r]
        ;    i = p - 1
        ;    for j = p to r-1
        ;        if A[j] ≤ x
        ;            i = i + 1
        ;            exchange A[i] with A[j]
        ;    exchange A[i+1] with A[r]
        ;    return i+1

        quicksort proc

            ;p   q     r
;left pivot right
;bx  ax    cx

; mov bx, p
; mov cx, r

mov ax, bx; int pivot = left;
;q pivot

while1:
cmp bx, cx;     while (left < right)
jb while2
ret ;     return pivot;

while2:
cmp ax, cx  ;while (pivot < right)
jae while3

mov si, ax  ;if (array[pivot] <= array[right])
shl si, 1
mov dx, [ si ]
mov si, cx
shl si, 1
cmp dx, [ si ]
jg else2
dec cx   ;right--;
jmp while2

else2:
mov si, ax
shl si, 1
mov dx, [ si ] ;array_swap(array, pivot, right);
mov si, cx
shl si, 1
xchg dx, [ si ]
mov si, ax
shl si, 1
mov [ si ], dx 
mov ax, cx  ;pivot = right;
;break;

while3:
cmp bx, ax  ;while (left < pivot)
jge while1

mov si, bx  ;if (array[left] <= array[pivot])
shl si, 1
mov dx, [ si ]
mov si, ax
shl si, 1
cmp dx, [ si ]
jg else3
inc bx   ;left++;
jmp while3

else3:
mov si, bx ;array_swap(array, left, pivot);
shl si, 1
mov dx, [ si ]
mov si, ax
shl si, 1
xchg dx, [ si ]
mov si, bx
shl si, 1
mov [ si ], dx 
mov ax, bx  ;pivot = left;
jmp while1  ;break;

        quicksort endp
    
ends

    end start