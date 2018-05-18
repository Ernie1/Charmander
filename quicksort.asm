data segment

    ;-----------------------------------------
    ;ARRAY OF 50 INTEGERS.
    arr dw 28, 44, 22, 7, 42, -15, 35, 6, 43, 20
    ;-----------------------------------------

    i   dw  ? 
    j   dw  ?
    p   dw  0                           ;START OF THE ARRAY, EQUALS TO 0.
    r   dw  9                          ;END OF THE ARRAY, EQUALS TO A.LENGTH - 1.
    q   dw  ?
    x   dw  ?

ends

code segment

    assume cs: code, ds: data

    start:

        ;INITIALIZE DATA SEGMENT.
        mov  ax, data
        mov  ds, ax

        ;CALL QUICKSORT(A, 0, A.LENGTH-1).
        call quicksort

        ;WAIT FOR ANY KEY.
        mov  ah, 7
        int  21h

        ;FINISH PROGRAM.
        mov  ax, 4c00h
        int  21h

        ;-----------------------------------------
        ;QUICKSORT(A, p, r)
        ;    if p < r
        ;        q = QUICKSORT(A, p, r)
        ;        QUICKSORT(A, p, q-1)
        ;        QUICKSORT(A, q+1, r)

        quicksort proc

            ;COMPARE P WITH R.
            mov  ax, p 
            cmp  ax, r                  ;COMPARE P WITH R
            jge  bigger1                ;IF P ≥ R, SORT IS DONE.

            ;CALL PARTITION(A, P, R).
            call partition

            ;GET Q = PARTITION(A, P, R).
            mov  q, ax

            ;PUSH Q+1, R INTO STACK FOR LATER USAGE.
            inc  ax
            push ax
            push r

            ;CALL QUICKSORT(A, P, Q-1).
            mov  ax, q
            mov  r, ax
            dec  r
            call quicksort

            ;CALL QUICKSORT(A, Q+1, R).
            pop  r
            pop  p 
            call quicksort 

            ;WHEN SORT IS DONE.
            bigger1:
                ret

        quicksort endp

        ;-----------------------------------------
        ;PARTITION(A, p, r)
        ;    x = A[r]
        ;    i = p - 1
        ;    for j = p to r-1
        ;        if A[j] ≤ x
        ;            i = i + 1
        ;            exchange A[i] with A[j]
        ;    exchange A[i+1] with A[r]
        ;    return i+1

        partition proc

            ;p   q     r
;low pivot high
;bx  ax    cx

mov bx, p
mov cx, r

;mov q, ax; int pivot = low;
;q pivot

while1:
cmp bx, cx;     while (low < hight)
jl while2
ret ;     return pivot;

while2:
cmp ax, cx  ;while (pivot < hight)
jge while3

mov si, ax  ;if (array[pivot] <= array[hight])
shl si, 1
mov dx, [ si ]
mov si, cx
shl si, 1
cmp dx, [ si ]
jg else2
dec cx   ;hight--;
jmp while2

else2:
mov si, ax
shl si, 1
mov dx, [ si ] ;array_swap(array, pivot, hight);
mov si, cx
shl si, 1
xchg dx, [ si ]
mov si, ax
shl si, 1
mov [ si ], dx 
mov ax, cx  ;pivot = hight;
;break;

while3:
cmp bx, ax  ;while (low < pivot)
jge while1

mov si, bx  ;if (array[low] <= array[pivot])
shl si, 1
mov dx, [ si ]
mov si, ax
shl si, 1
cmp dx, [ si ]
jg else3
inc bx   ;low++;
jmp while3

else3:
mov si, bx ;array_swap(array, low, pivot);
shl si, 1
mov dx, [ si ]
mov si, ax
shl si, 1
xchg dx, [ si ]
mov si, bx
shl si, 1
mov [ si ], dx 
mov ax, bx  ;pivot = low;
jmp while1  ;break;

        partition endp
    
ends

    end start