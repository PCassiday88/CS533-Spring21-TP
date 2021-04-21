        .data
meg:    .asciiz "Please enter three numbers:\n"
meg1:   .asciiz "The sum of the largest two of three is "
        .text
        .globl main


main:
        li $v0, 4 # print string
        la $a0, meg # load address of string
        syscall # print string

        li $v0, 5 # read integer
        syscall # read integer from user
  
        move $t0, $v0 # copy the value of v0 into t0
        li $v0, 5 # read integer
        syscall # read integer from user

        move $t1, $v0 # copy the value of v0 into t1
        li $v0, 5 
        syscall # read integer from user

        move $t2, $v0 # copy the value of v0 into t2
        slt $t3, $t0, $t1 # $t3 = 1 if $t0 < $t1 (set on less than)
        beqz $t3, second # branch if $t0 >= $t1 (branch equal to zero)
  
  
        slt $t3, $t0, $t2
        beqz $t3, third # branch if $t0 >= $t2. So, $t2 <= $t0 < $t1

        add $s0, $t1, $t2 # s0 = $t1+$t2
        j end

     second:
        slt $t3, $t1, $t2
        beqz $t3, fourth # branch if $t1 >= $t2
  
        add $s0, $t0, $t2
        j end

     third:
        add $s0, $t0, $t1 # s0 = $t0+$t1
        j end

  
     fourth:
        add $s0, $t0, $t1 # $s0 = $t0+$t1

     end:

        li $v0, 4 # print string
        la $a0, meg1 
        syscall # string
  
        li $v0, 1
        move $a0, $s0 
        syscall

        li $v0, 10 # exit
        syscall