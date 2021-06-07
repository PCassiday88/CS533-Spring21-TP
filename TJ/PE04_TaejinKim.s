 # Rules for tower of Hanoi
 # Disks are transferred between pegs one at a time. At no time may a bigger disk be placed on top of a smaller one.            
            
            .data
input:      .asciiz "Enter number of disks: "
move_disk:  .asciiz "\nMove disk: "
from:       .asciiz " from rod: "
to:         .asciiz " to rod: "
finish:     .asciiz "\n\nPuzzle completed successfully.\n"
            .text
            .globl main

main:
            li $v0, 4 # print string 
            la $a0, input # address of string in memory
            syscall

            li $v0, 5   # read int
            syscall

            
            move $a0, $v0 # move to $a0
            li $a1, 1
            li $a2, 2
            li $a3, 3

            jal hanoi_puzzle # call honoi_puzzle

            li  $v0, 4 # print string
            la  $a0, finish
            syscall
            
            li $v0, 10 # exit program
            syscall

hanoi_puzzle:
            
            addi $sp, $sp, -20 # save them to stack
            sw $ra, 0($sp)
            sw $s0, 4($sp)
            sw $s1, 8($sp)
            sw $s2, 12($sp)
            sw $s3, 16($sp)
                        
            move $s0, $a0 # call the first recursion
            move $s1, $a1
            move $s2, $a2
            move $s3, $a3

            li $t1, 1
            beq $s0, $t1, output # if ($s0 == $t1) go to output

            addi $a0, $s0, -1 # first recursion call
            addi $a1, $s1, 0
            addi $a2, $s3, 0
            addi $a3, $s2, 0
            jal hanoi_puzzle

output:
           
            li $v0, 4  # print the first string
            la $a0, move_disk 
            syscall
          
            li $v0, 1 # print disk number
            add $a0, $s0, $zero
            syscall
            
            li $v0, 4 # print the second string
            la $a0, from
            syscall
            
            li $v0,  1 # print the first rod number
            add $a0, $s1, $zero
            syscall
           
            li $v0, 4  # print the third string
            la $a0, to
            syscall
            
            li $v0,  1 # print the second rod number
            add $a0, $s2, $zero
            syscall
            
            beq $s0, $t1, restore_return # if ($s0 == $t1) go to exit_hanoi

            addi $a0, $s0, -1 # Second recursion call
            addi $a1, $s3, 0
            addi $a2, $s2, 0
            addi $a3, $s1, 0
            jal hanoi_puzzle

restore_return:
            
            lw $ra, 0($sp) # restore registers from stack
            lw $s0, 4($sp)
            lw $s1, 8($sp)
            lw $s2, 12($sp)
            lw $s3, 16($sp)
            addi $sp, $sp, 20 # restore stack pointer

            jr $ra