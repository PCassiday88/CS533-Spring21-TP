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
base:   .asciiz "_"
star:   .asciiz "*"
tip:    .asciiz "^\n"
endl:   .asciiz "\n"
        .text 


checkInput: # This method will make sure the input was an int between 1 and 8
        ble     $a0, $zero, main
        bgt     $a0, $s7, main 
        move    $t9, $a0
        li      $t8, 30
        j       prepStack

prepStack:
        # li      $t4, -4
        # mult    $t9, $t4 
        # mflo    $t3
        # move    $t4, $t3
        # addi    $t4, -8 

#        add     $sp, $sp, $t4
        addi    $sp, $sp, -40
        sw      $ra, 0($sp)                    
        sw      $t9, 4($sp)
        j       storeDisks
    storeDisks:
            sw      $s0, 8($sp) 
            sw      $s1, 12($sp) 
            sw      $s2, 16($sp) 
            sw      $s3, 20($sp) 
            sw      $s4, 24($sp) 
            sw      $s5, 28($sp) 
            sw      $s6, 32($sp) 
            sw      $s7, 36($sp) 
            j       showAllDisks


showAllDisks:
# Display multiple pegs from largest to smallest
        li      $t0, 1          # Has the number of markers in disk                        
        li      $t1, 2          # Has the number of disks left to add
        li      $t2, 3          # Used to increment markers before moving to next disk
 #       j       showDisk1
        move    $a1, $t9
        j       determineStack1

# determineStackS0:
#         li      $t7, 10
#         div     $s0, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s0, $t5
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack1:
#         div     $s1, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s1, $t5
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack2:
#         div     $s2, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s2, $t5
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack3:
#         div     $s3, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s3, $t5
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack4:
#         div     $s4, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s4, $t5
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack5:
#         div     $s5, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s5, $t5 
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack6:
#         div     $s6, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s6, $t5 
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         addi    $a1, -1
#         beq     $a1, $zero, determineOrder
# determineStack7:
#         div     $s1, $t7 
#         mfhi    $t6
#         mflo    $t5
#         move    $s7, $t5 
#         beq     $t6, $t0, peg1
#         beq     $t6, $t1, peg2
#         beq     $t6, $t2, peg3
#         j       determineWinner

# peg1:



#showDisk1:
#         beq     $t0, $zero, whiteSpace 
#         li      $v0, 4
#         la      $a0, disk
#         syscall
#         addi    $t0, -1
#         j       showDisk
# #Decrement $t1 to move to the next disk and set $t0 to that value
# nextDisk:
#         beq     $t1, $t0, restoreStack
#         addi    $t1, -1
#         addi    $t2, 1
#         move    $t0, $t2 
#         #Display a new line
#         li      $v0, 4
#         la      $a0, endl
#         syscall
#         j       showDisk

# whiteSpace:
#         beq     $t9, $t2, nextPeg
#         sub     $t3, $t8, $t2
#         j       innerWhiteSpace

#     innerWhiteSpace:
#             beq     $t3, $zero, nextDisk
#             li      $v0, 4
#             la      $a0, star
#             syscall
#             addi    $t3, -1
#             j       innerWhiteSpace

# nextPeg:
#         sub     $t3, $t8, $t2
#         j       residualWhiteSpace

#         residualWhiteSpace:
#             beq     $t3, $zero, continue
#             li      $v0, 4
#             la      $a0, star
#             syscall
#             addi    $t3, -1
#             j       residualWhiteSpace
#         continue:
#             li      $v0, 4
#             la      $a0, endl
#             syscall
#             j       printBase
    
#         printBase:
#                 beq     $t8, $zero, restoreStack
#                 li      $v0, 4
#                 la      $a0, base
#                 syscall
#                 addi    $t8, -1
#                 j       printBase 
        

restoreStack:
        li      $v0, 4
        la      $a0, endl
        syscall

        lw      $t9, 4($sp)
        lw      $ra, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra 


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


