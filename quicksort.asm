DATA        SEGMENT
;int array[] = {28, 44, 22, 7, 42, -15, 35, 6, 43, 20};
ARR         DW     28, 44, 22, 7, 42, -15, 35, 6, 43, 20
DATA        ENDS

CODE        SEGMENT
            ASSUME CS: CODE, DS: DATA

START:      MOV    AX, DATA
            MOV    DS, AX

            ;recursion(array, 0, 9);
            MOV    BX, 0
            MOV    CX, 9
            CALL   RECURSION
            
            ;terminated
            MOV    AX, 4C00H
            INT    21H

;recursion(int array[], int left, int right)
;AX pivot, BX left, CX right
RECURSION   PROC

            ;if (left < right)
            CMP    BX, CX
            JGE    RET1
             
            ;int pivot = quicksort(array, left, right);
            PUSH   CX
            PUSH   BX
            CALL   QUICKSORT
            
            ;recursion(array, left, pivot - 1);
            POP    BX
            PUSH   AX
            MOV    CX, AX
            DEC    CX
            CALL   RECURSION

            ;recursion(array, pivot + 1, right);
            POP    AX
            POP    CX
            MOV    BX, AX
            INC    BX
            CALL   RECURSION

RET1:       RET
RECURSION   ENDP

;int quicksort(int array[], int left, int right)
;AX pivot, BX left, CX right
QUICKSORT   PROC

            ;int pivot = left;
            MOV    AX, BX

;while (right > left)
WHILE1:     CMP    BX, CX
            JB     WHILE2

            ;return pivot
            RET

;while (right > pivot)
WHILE2:     CMP    AX, CX
            JAE    WHILE3

            ;if (array[right] >= array[pivot])
            MOV    SI, AX
            SHL    SI, 1
            MOV    DX, [ SI ]
            MOV    SI, CX
            SHL    SI, 1
            CMP    DX, [ SI ]
            JG     ELSE2

            ;--right;
            DEC    CX
            JMP    WHILE2

;else
ELSE2:      ;swap(array, pivot, right);
            MOV    SI, AX
            SHL    SI, 1
            MOV    DX, [ SI ]
            MOV    SI, CX
            SHL    SI, 1
            XCHG   DX, [ SI ]
            MOV    SI, AX
            SHL    SI, 1
            MOV    [ SI ], DX

            ;pivot = right
            MOV    AX, CX
            
            ;break

;while (left < pivot)
WHILE3:     CMP    BX, AX
            JGE    WHILE1

            ;if (array[left] <= array[pivot])
            MOV    SI, BX
            SHL    SI, 1
            MOV    DX, [ SI ]
            MOV    SI, AX
            SHL    SI, 1
            CMP    DX, [ SI ]
            JG     ELSE3

            ;++left
            INC    BX
            JMP    WHILE3

;else
ELSE3:      ;swap(array, left, pivot)
            MOV    SI, BX
            SHL    SI, 1
            MOV    DX, [ SI ]
            MOV    SI, AX
            SHL    SI, 1
            XCHG   DX, [ SI ]
            MOV    SI, BX
            SHL    SI, 1
            MOV    [ SI ], DX 

            ;pivot = left
            MOV    AX, BX

            ;break
            JMP    WHILE1

QUICKSORT ENDP
    
CODE        ENDS
            
            END    START