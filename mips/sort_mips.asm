##############  sort ######################################################################################
# ����һ���򵥵�mips������Ա�д��������򣬴Ӽ�������10���޷����������Ӵ�С������������������Ļ����ʾ������
# ������м򵥵Ĵ������ܡ�
##########  2018  ###########################################################################################

#------------���� segment-------------------#

.text
.globl main

error:                               # ��������������������ָ����Χ�ڣ���������
    li      $v0,   4                 # ��ӡ�ַ��������
    la      $a0,   errormsg          # ȡ�ַ���errormsg�׵�ַ->$a0
    syscall                          # ϵͳ����
    j get                            # ת��������

swap:
	sll     $t1,   $a1,   2
	add     $t1,   $t1,   $a0
	lw      $t0,   0($t1)
	lw      $t2,   4($t1)
	sw      $t2,   0($t1)
	sw      $t0,   4($t1)
	jr      $ra

sort:
	addi    $sp,   $sp,   -20        # ��ջ
	sw      $ra,   16($sp)
	sw      $s0,   12($sp)
	sw      $s1,   8($sp)
	sw      $s2,   4($sp)
	sw      $s3,   0($sp)
	move    $s0,   $a0               # $s0 v[]
	move    $s1,   $a1               # $s1 n
	move    $s2,   $zero             # $s2 i
	
loop1:
	ble     $s1,   $s2,   exit1
	add     $s3,   $s2,   -1         # $s3 j

loop2:
	slt     $t0,   $s3,   $zero
	bne     $t0,   $zero, exit2
	sll     $t0,   $s3,   2
	add     $t0,   $t0,   $s0
	lw      $t1,   0($t0)            # $t1 v[j]
	lw      $t2,   4($t0)            # $t2 v[j+1]
	ble     $t2,   $t1,   exit2
	move    $a0,   $s0
	move    $a1,   $s3
	jal swap
	addi    $s3,   $s3,   -1
	j loop2

exit2:
	addi    $s2,   $s2,   1
	j loop1

exit1:
	lw      $s3,   0($sp)            # start to pop
	lw      $s2,   4($sp)
	lw      $s1,   8($sp)
	lw      $s0,   12($sp)
	lw      $ra,   16($sp)
	addi    $sp,   $sp,   20
	jr $ra

main:
    li      $v0,   4                 # ��ӡ�ַ��������
    la      $a0,   str1
    syscall
	move    $s0,   $zero             # ѭ������
	addi    $s1,   $zero, 10
	la      $s2,   v                 # $s2 v

get:
    li      $v0,   5                 # ���ռ�������һ���������յ������ݴ����$v0��
    syscall
    bltz    $v0,   error             # ������������$v0<0����תerror������
	sll     $t0,   $s0,   2
	addu    $t0,   $t0,   $s2
	sw      $v0,   0($t0)
    addi    $s0,   $s0,   1
	blt     $s0,   $s1,   get
	move    $a0,   $s2
	move    $a1,   $s1
	jal sort
	li      $v0,   4                 # ��ӡ�ַ��������
    la      $a0,   str2
    syscall
	move    $s0,   $zero

loop3:
	sll     $t0,   $s0,   2
	addu    $t0,   $t0,   $s2
	li      $v0,   1                 # ��ӡ���������
    lw      $a0,   0($t0)
    syscall
	li      $v0,   4                 # ��ӡ�ַ��������
    la      $a0,   nspace
	syscall
	addi    $s0,   $s0,   1
	blt     $s0,   $s1,   loop3
	li      $v0,   4                 # ��ӡ�ַ��������
    la      $a0,   nline
	syscall
	li $v0, 10 # �˳�������ϵͳ
    syscall

#-------------------���� segment--------------------#       

.data
   v:
       .space 40
   str1:
       .asciiz "������10���޷������֣�ÿ������ӻس�:\n"
   str2:
       .asciiz "������:\n"
   errormsg:
       .asciiz "�������޷�����\n" # �ַ������壬.asciiz���Ͷ����ַ����������"00"�ַ���Ϊ��ֹ������
   nline:  
       .asciiz "\n"
   nspace:
	   .asciiz " "

###----end of file     