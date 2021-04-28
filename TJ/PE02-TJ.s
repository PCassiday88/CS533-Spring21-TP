        .data
meg:    .asciiz "Please input integer.\n"
meg1:   .asciiz "Total sum of integers is "
        .text
        .globl main

    main:
        li $s0, 0 #$s0 (saved values representing final computed results)

    loop:
        li $v0, 4 # print string
        la $a0, meg # load address of string
        syscall # print string

        li $v0, 5 # read integer
        syscall 

        beqz $v0, end # branch on zero
        add $s0, $s0, $v0 # s0 = s0+v0
        j loop

    end:
        li $v0, 4 # print string
        la $a0, meg1 # load address of string
        syscall # print string

        li $v0, 1
        move $a0, $s0 #copy the value of $s0 into a0
        syscall

        li $v0, 10 # end
        syscall