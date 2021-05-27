        .data
msg1:   .asciiz "Choose a number between 1-8: "
disk:   .asciiz "="
space:  .asciiz " "
endl:   .asciiz "\n"
        .text



checkInput: # This method will make sure the input was an int between 1 and 8
        li      $a1, 8
        ble     $a0, $zero, main
        bgt     $a0, $a1, main 
        move    $t9, $a0
        li      $t8, 8
        j       prepStack

prepStack:
        addi    $sp, $sp, -8
        sw      $ra, 0($sp)                    
        sw      $t9, 4($sp)
        move    $a0, $t9 
        j       printBegPeg

printBegPeg:
        li      $t0, 0 #tried a reg
        li      $t1, 0 #found a match
        # finds things that go here or not
        addi    $t0, 1
        # Need to increment $t1 at some point
        beq     $a0, $t1, weHaveAllDisplayed
        beq     $a0, $t0, printMidPeg

printMidPeg:
        li      $t0, 0
        # try to find things same way
        # Need to increment $t1 at some point
        beq     $a0, $t1, weHaveAllDisplayed
        beq     $a0, $t0, printEndPeg

printEndPeg:
        li      $t0, 0
        # try to find things same way
        # Need to increment $t1 at some point
        beq     $a0, $t1, weHaveAllDisplayed
        beq     $a0, $t0, getNextMove


main:
        # Load $s0-$s7 with the possible disk ints
        li      $s0, 11
        li      $s1, 12
        li      $s2, 13
        li      $s3, 14
        li      $s4, 15
        li      $s5, 16
        li      $s6, 17
        li      $s7, 18

        li      $v0, 4
        la      $a0, msg1
        syscall
        # Read the input
        li      $v0, 5
        syscall

        move    $a0, $v0
        jal     checkInput
        

exit:
        li      $v0, 10
        syscall

