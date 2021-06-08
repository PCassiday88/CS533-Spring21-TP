.data
prompt: .asciiz "Enter the number of disk(s): "
msg1: .asciiz "\nMove disk "
msg2: .asciiz " from peg "
msg3: .asciiz " to peg "
 
.text
.globl main
main:
    li $v0,  4          # print string
    la $a0,  prompt
    syscall
    li $v0,  5          # read the number of disks
    syscall
 
    # parameters for the routine
    add $a0, $v0, $zero # move to $a0
    # Initialize the pegs
    li $a1, '1'
    li $a2, '2'
    li $a3, '3'
 
    jal tower_hanoi           # call tower_hanoi function
 
    li $v0, 10          # finally exit
    syscall
 
tower_hanoi:
 
    addi $sp, $sp, -20 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)
 
    add $s0, $a0, $zero
    add $s1, $a1, $zero
    add $s2, $a2, $zero
    add $s3, $a3, $zero
 
    addi $t1, $zero, 1
    beq $s0, $t1, output
    
    recur1:
 
        addi $a0, $s0, -1
        add $a1, $s1, $zero
        add $a2, $s3, $zero
        add $a3, $s2, $zero
        jal tower_hanoi
 
        j output
 
    recur2:
 
        addi $a0, $s0, -1
        add $a1, $s3, $zero
        add $a2, $s2, $zero
        add $a3, $s1, $zero
        jal tower_hanoi
 
    exit:
 
        lw   $ra, 0($sp)        # restore registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        lw   $s3, 16($sp)
 
        addi $sp, $sp, 20       # restore stack pointer
 
        jr $ra
 
    output:
        # Print the messages
        li $v0,  4             
        la $a0,  msg1
        syscall
        li $v0,  1              
        add $a0, $s0, $zero
        syscall
        li $v0,  4             
        la $a0,  msg2
        syscall
        li $v0,  11            
        add $a0, $s1, $zero
        syscall
        li $v0,  4              
        la $a0,  msg3
        syscall
        li $v0,  11             
        add $a0, $s2, $zero
        syscall
 
        beq $s0, $t1, exit
        j recur2