# Write and test a recursive program for solving the classic mathematical recreation, the Towers of Hanoi puzzle. 
#(This will require the use of stack frames to support recursion.) The puzzle consists of three pegs (1, 2, and 3) and n disks 
#(the number n can vary; typical values might be in the range from 1 to 8). Disk 1 is smaller than disk 2, 
#which is in turn smaller than disk 3, and so forth, with disk n being the largest. 
#Initially, all the disks are on peg 1, starting with disk n on the bottom, disk n − 1 on top of that, and so forth, up to disk 1 on the top. 
#The goal is to move all the disks to peg 2. You may only move one disk at a time, that is, 
#the top disk from any of the three pegs onto the top of either of the other two pegs. Moreover, 
#there is a constraint: You must not place a larger disk on top of a smaller disk.

# Must take int input for n (number of disks)
# Must recursively set each disk less than the one before it
# Must have 3 pegs and all disks start on peg 1 in order of top (smallest aka disk 1) to bottom (largest aka disk n) 


        .data
msg1:   .asciiz "Choose a number between 1-8 "
peg:    .asciiz "||\n"
disk:   .asciiz "="
base:   .asciiz "X"
star:   .asciiz "*"
tip:    .asciiz "^\n"
endl:   .asciiz "\n"
        .text 


showAllDisks:
# Display multiple pegs from largest to smallest
#        addi    $sp, $sp, -8                    # Saving t9 and ra
#        sw      $t9, 4($sp)
#        sw      $ra, 0($sp)
#        ble     $a0, $zero, exit
#        move    $t9, $a0        # $t9 has the int given as param
        li      $t0, 1          # Has the number of markers in disk                        
        move    $t1, $t9        # Has the number of disks left to add
        li      $t2, 1          # Used to increment markers before moving to next disk
        j       showDisk


showDisk:
        beq     $t0, $zero, whiteSpace 
        li      $v0, 4
        la      $a0, disk
        syscall
        addi    $t0, -1
        j       showDisk
#Decrement $t1 to move to the next disk and set $t0 to that value
nextDisk:
        beq     $t1, $t0, restoreStack
        addi    $t1, -1
        addi    $t2, 1
        move    $t0, $t2 
        #Display a new line
        li      $v0, 4
        la      $a0, endl
        syscall
        j       showDisk

whiteSpace:
        beq     $t9, $t2, nextPeg
        sub     $t3, $t9, $t2
        j       innerWhiteSpace

    innerWhiteSpace:
            beq     $t3, $zero, pegSep
            li      $v0, 4
            la      $a0, star
            syscall
            addi    $t3, -1
            j       innerWhiteSpace
                pegSep:
                li      $v0, 4
                la      $a0, star 
                syscall
                li      $v0, 4
                la      $a0, star 
                syscall
                j       nextDisk

nextPeg:
        li      $v0, 4
        la      $a0, star 
        syscall
        li      $v0, 4
        la      $a0, star 
        syscall
        j       restoreStack
        

restoreStack:
        lw      $t9, 4($sp)
        lw      $ra, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra 


main:
        # Load $s0-$s7 with the possible disk ints
        li      $s0, 1
        li      $s1, 2
        li      $s2, 3
        li      $s3, 4
        li      $s4, 5
        li      $s5, 6
        li      $s6, 7
        li      $s7, 8

        li      $v0, 4
        la      $a0, msg1
        syscall
        # Read the input
        li      $v0, 5
        syscall

        move    $a0, $v0
        jal     checkInput
        
        # move    $a0, $t9 
        # jal     showAllDisks

checkInput: # This method will make sure the input was an int between 1 and 8
        addi    $sp, $sp, -8                    # Saving t9 and ra
        sw      $t9, 4($sp)
        sw      $ra, 0($sp)
        ble     $a0, $zero, main
        bgt     $a0, $s7, main
        move    $t9, $a0
        j       showAllDisks



        # li      $t4, 3
        # mult    $t4, $a0
        # mflo    $t4  
        # addi    $t4, 4
        

exit:
        li      $v0, 10
        syscall


