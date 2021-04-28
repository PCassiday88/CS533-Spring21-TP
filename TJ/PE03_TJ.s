        .data
space:  .asciiz " , "
        .text
        .globl main

main:
        li $s0, 11 # the smallest prime number is 2 but program starts at 11 
        li $s1, 100 # print 100 prime numbers from 11
        li $s2, 0 # counts prime numbers

loop:
        addi $a0, $s0, 0
        jal test_prime # jump and link

        addi $s0, $s0, 1 # $s0=$s0+1
        beqz $v0, loop # # $v0 == 0 is $s0 is not prime number.
        addi $s2, $s2, 1 # increment
        addi $s3, $v0, 0
        
        li $v0, 1
        addi $a0, $s0, -1
        syscall 
  
        li $v0, 4 # print space with comma
        la $a0, space
        syscall
  
        bne $s1, $s2, loop # if ($s1 != $s2) go to loop
        
        beq $s1, $s2, quit # if ($s1 == $s2) go to quit

test_prime:
	    li $t0, 2

loop_2:
        beq $t0, $a0, true # ($t0 == $a0) 
        div $a0, $t0 # $a0/$t0
        mfhi $t1 # $t1 = hi remainder
        addi $t0, $t0, 1 #$t0 = $t0+1
        bnez $t1, loop_2 # if $t1 != 0 go to loop_2
        addi $v0, $zero, 0
        jr $ra

true:
        addi $v0, $zero, 1
        jr $ra

quit:
        li	$v0, 10 # program exit
	    syscall