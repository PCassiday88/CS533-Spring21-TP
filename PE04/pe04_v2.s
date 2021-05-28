        .data
msg1:   .asciiz "Choose a number between 1-8: "
moved:  .asciiz "\nMoved disk number "
from:   .asciiz " from peg labeled "
to:     .asciiz " to peg "
        .text


hanoi_tower:
        addi    $sp, $sp, -20           # Make room on the stack to store the pegs, ra, and the value of n
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        sw      $s3, 16($sp)

        # Save the input (n), and the three peg labels in regs s0-s3
        move    $s0, $a0        # Here is where $s0 is decremented so that the condition on line 24 will eventually be true
        move    $s1, $a1 
        move    $s2, $a2 
        move    $s3, $a3 

        li      $t1, 1
        beq     $s0, $t1, output 

        outerLoop:
            addi    $a0, $s0, -1        # Into a0 store n-1
            move    $a1, $s1 
            move    $a2, $s3 
            move    $a3, $s2 
            jal     hanoi_tower         # Must decrement value of $s0 for next iteration 
            j      output 

        innerLoop:
            addi    $a0, $s0, -1 
            move    $a1, $s3 
            move    $a2, $s2 
            move    $a3, $s1 
            jal     hanoi_tower

        exitTower: # We restore the stack with every change to the world (i.e. when we move a disk from one peg to the other and output it)
            lw      $ra, 0($sp)
            lw      $s0, 4($sp)
            lw      $s1, 8($sp) 
            lw      $s2, 12($sp)
            lw      $s3, 16($sp) 
            addi    $sp, $sp, 20
            jr      $ra         # Brings us to line 32

        output:
            
            li      $v0, 4
            la      $a0, moved
            syscall

            li      $v0, 1
            move    $a0, $s0 
            syscall

            li      $v0, 4
            la      $a0, from 
            syscall

            li      $v0, 11
            move    $a0, $s1 
            syscall

            li      $v0, 4
            la      $a0, to 
            syscall

            li      $v0, 11
            move    $a0, $s2 
            syscall

            beq     $s0, $t1, exitTower
            j       innerLoop           # Hits this line when $s0 = 3

main:
        li      $v0, 4          # Print user message to enter an int between 1 and 8 
        la      $a0, msg1
        syscall
        # Read the input
        li      $v0, 5
        syscall

        move    $a0, $v0

        # This block confirms that the integer input was between 1-8 or restart main
        # I did not know how to first confirm that the input was an integer so I 
        # took an ineffecient route and checked for equality for the 8 accepted inputs
        # If none of the conditions are met, the program jumps back to the start of main
        # li      $t9, 1
        # beq     $a0, $t9, continue 
        # li      $t9, 2
        # beq     $a0, $t9, continue 
        # li      $t9, 3
        # beq     $a0, $t9, continue 
        # li      $t9, 4
        # beq     $a0, $t9, continue 
        # li      $t9, 5
        # beq     $a0, $t9, continue 
        # li      $t9, 6
        # beq     $a0, $t9, continue 
        # li      $t9, 7
        # beq     $a0, $t9, continue 
        # li      $t9, 8
        # beq     $a0, $t9, continue 
        # j       main 

# lines 93-109 were not needed and invalid entries were tested  
        li      $t9, 8
        ble     $a0, $zero, main
        bgt     $a0, $t9, main 

 #       continue:
        # Name the pegs
        li      $a1, 'A'
        li      $a2, 'B'
        li      $a3, 'C'

        #Call hanoi function
        jal     hanoi_tower
        

exit:
        li      $v0, 10
        syscall

