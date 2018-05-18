## 指令系统
设一存储区中存放有10个带符号的单字节数，现要求分别求出其绝对值后存放到原单元中。

```
DATA    SEGMENT
        BLOCK   DB -10,15H,20H,-1,-23,46H,16H,-33,65H,88H
        DATA    ENDS
CODE    SEGMENT
        ASSUME DS:DATA, CS:CODE
START:  MOV     AX, DATA
        MOV     DS, AX
        MOV     SI, OFFSET  BLOCK
        MOV     CX, 10
AGAIN:  MOV     AL, [SI]
        TEST    AL, 80H     ;测试是否为正数
        JZ      NEXT
        NEG     AL          ;求负数的绝对值
        MOV     [SI], AL
NEXT:   INC     SI
        LOOP    AGAIN
        MOV     AH, 4CH     ;返回DOS
        INT     21H
CODE    ENDS
        END     START
```
![](sample_1.svg)

比较两个字符串 MESS1 和 MESS2 所含字符是否完全相同，若相同则显示‘MATCH’，若不同则显示‘NO MATCH’ 。

```
DATA     SEGMENT
MESS1    DB   'I AM A TEACHER.'
MESS2    DB   'I AM A TEACHAR.'
YES      DB   'MATCH', 0DH, 0AH, '$'
NO       DB   'NO MATCH', 0DH, 0AH, '$'
DATA     ENDS
CODE     SEGMENT
         ASSUME CS:CODE, DS:DATA
START:   MOV    AX, DATA
         MOV    DS, AX
BEGIN:   LEA    SI, MESS1
         LEA    DI, MESS2
         MOV    CX, MESS2- MESS1
         REPE   CMPSB
         JNE    DISPNO
         LEA    DX, YES
         MOV    AH, 9
         INT    21H
         MOV    AH, 4CH
         INT    21H
DISPNO:  LEA    DX, NO
         MOV    AH, 9
         INT    21H
         MOV    AH, 4CH
         INT    21H
CODE     ENDS
         END    START
```

![](sample_2.svg)

## 汇编语言编程
将一组有符号存储字节数据按从小到大的顺序排列。设数组变量为VAR，数组元素个数为 N。

```
    D       SEGMENT
  VAR       DB -1, -10, -100, 27H, 0AH, 47H
    N       EQU $-VAR
    D       ENDS
    C       SEGMENT
            ASSUME CS: C, DS:D
    B:      MOV AX, D
            MOV DS, AX
            MOV CX, N-1
            MOV DX, 1
   AG:      CALL SUBP
            INC DX
            LOOP AG
            MOV AH,4CH
            INT 21H
            SUBP PROC
            PUSH CX
            MOV CX, N
            SUB CX, DX
            MOV SI, 0
RECMP:      MOV AL, VAR[SI]
            CMP AL, VAR[SI+1]
            JLE NOCH
            XCHG AL, VAR[SI+1]
            XCHG AL, VAR[SI]
 NOCH:      INC SI
            LOOP RECMP
            POP CX
            RET
 SUBP       ENDP
    C       ENDS
            END B
```

![](sample_3.svg)

## 接口技术
利用 DOS 系统功能调用，从键盘输入一串字符，分别统计字母、数字和其他 字符的个数，并输出显示统计结果。

```
DATA       SEGMENT 
MAXSTRING  DB   100 
INACT      DB   DUP(0)   
STRING     DB   100 
DISMESS    DB   'PLEASE ENTER A STRING:',0AH,0DH,'$' 
DIGITAL    DB   'DIGITAL IS:','$' 
LETTER     DB   'LETTER IS:','$' 
OTHERCHAR  DB   'OTHER IS:','$' 
CRLF       DB   0AH,0DH,'$' 
DATA       ENDS 
CODE       SEGMENT 
           ASSUME CS:CODE,DS:DATA 
MAIN       PROC   FAR 
           MOV    AX,DATA 
           MOV    DS,AX 
           MOV    BL,0 
           MOV    BH,0 
           MOV    CH,0 
DISPSTRING MACRO 
           MOV    AH,9 
           INT    21H 
           ENDM 
DISPCHAR   MACRO 
           MOV    AH,2 
           INT    21H 
           ENDM 
           LEA    DX,DISMESS 
           DISPSTRING 
BEGIN:     LEA    DX,MAXSTRING 
           MOV    AH,0AH 
           INT    21H
           MOV    DL,INACT 
           MOV    DH,0
           INC    DX
           LEA    SI,STRING 
REPEAT:    DEC    DX
           JZ     ENDCHE 
           MOV    AL,[SI] 
           INC    SI 
           CMP    AL,'0' 
           JB     OTHER 
           CMP    AL,'9' 
           JA     NEXT1 
           INC    BL 
           JMP    REPEAT 
NEXT1:     OR     AL,20H 
           CMP    AL,'a' 
           JB     OTHER 
           CMP    AL,'z' 
           JA     OTHER 
           INC    BH 
           JMP    REPEAT 
OTHER:     INC    CH 
           JMP    REPEAT 
ENDCHE:    LEA    DX,DIGITAL 
           DISPSTRING 
           MOV    CL,BL 
           CALL   DISP 
           LEA    DX,LETTER 
           DISPSTRING 
           MOV    CL,BH 
           CALL   DISP 
           LEA    DX,OTHERCHAR 
           DISPSTRING 
           MOV    CL,CH 
           CALL   DISP 
           MOV    AH,4CH 
           INT    21H 
MAIN       ENDP 
DISP       PROC   NEAR 
           MOV    AL,CL 
           MOV    AH,0 
           MOV    CL,100 
           DIV    CL 
           MOV    CL,AH 
           MOV    DL,AL 
           ADD    DL,30H 
           DISPCHAR 
           MOV    AL,CL 
           MOV    AH,0 
           MOV    CL,10 
           DIV    CL 
           MOV    CL,AH 
           MOV    DL,AL 
           ADD    DL,30H 
           DISPCHAR 
           MOV    DL,CL 
           ADD    DL,30H 
           DISPCHAR 
           LEA    DX,CRLF 
           DISPSTRING 
           RET 
DISP       ENDP 
CODE       ENDS 
           END    MAIN
```

![](sample_4.svg)