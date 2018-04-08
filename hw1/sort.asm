##############  sort ######################################################################################
# 这是一个简单的mips汇编语言编写的排序程序，从键盘输入10个无符号字数并从大到小进行排序，排序结果在屏幕上显示出来。
# 程序具有简单的错误处理功能。
##########  2018  ###########################################################################################

#------------代码 segment-------------------#

.text
.globl main

error:                               # 错误处理，若输入整数不再指定范围内，从新输入
    li      $v0,   4                 # 打印字符串，输出
    la      $a0,   errormsg          # 取字符串errormsg首地址->$a0
    syscall                          # 系统调用
    j get                            # 转重新输入

swap:
	sll     $t1,   $a1,   2
	add     $t1,   $t1,   $a0
	lw      $t0,   0($t1)
	lw      $t2,   4($t1)
	sw      $t2,   0($t1)
	sw      $t0,   4($t1)
	jr      $ra

sort:
	addi    $sp,   $sp,   -20        # 进栈
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
    li      $v0,   4                 # 打印字符串，输出
    la      $a0,   str1
    syscall
	move    $s0,   $zero             # 循环计数
	addi    $s1,   $zero, 10
	la      $s2,   v                 # $s2 v

get:
    li      $v0,   5                 # 接收键盘输入一整数，接收到的数据存放在$v0中
    syscall
    bltz    $v0,   error             # 如果输入的整数$v0<0，则转error出错处理
	sll     $t0,   $s0,   2
	addu    $t0,   $t0,   $s2
	sw      $v0,   0($t0)
    addi    $s0,   $s0,   1
	blt     $s0,   $s1,   get
	move    $a0,   $s2
	move    $a1,   $s1
	jal sort
	li      $v0,   4                 # 打印字符串，输出
    la      $a0,   str2
    syscall
	move    $s0,   $zero

loop3:
	sll     $t0,   $s0,   2
	addu    $t0,   $t0,   $s2
	li      $v0,   1                 # 打印整数，输出
    lw      $a0,   0($t0)
    syscall
	li      $v0,   4                 # 打印字符串，输出
    la      $a0,   nspace
	syscall
	addi    $s0,   $s0,   1
	blt     $s0,   $s1,   loop3
	li      $v0,   4                 # 打印字符串，输出
    la      $a0,   nline
	syscall
	li $v0, 10 # 退出，返回系统
    syscall

#-------------------数据 segment--------------------#       

.data
   v:
       .space 40
   str1:
       .asciiz "请输入10个无符号数字，每个数后加回车:\n"
   str2:
       .asciiz "排序结果:\n"
   errormsg:
       .asciiz "请输入无符号数\n" # 字符串定义，.asciiz类型定义字符串，最后以"00"字符作为终止符结束
   nline:  
       .asciiz "\n"
   nspace:
	   .asciiz " "

###----end of file     