            .data
newline:    .asciiz "\n"
             .text
            .globl main
main:
  li $s0, 2             #Initilaize with the smallest Prime
  li $s1, 100           #Counter for printing first 100 prime numbers
loop:
  addi $a0, $s0, 0      #Initialize the register with the number
  jal test_prime        #Call the sub program to check for the prime
  addi $s0, $s0, 1      # Increment to the next number for checking
  beqz $v0, loop        # if ($v0 == 0) then $s0 is not prime!
  addi $s1, $s1, -1     # If it reached at this point means the number is prime, reduce the counter
    syscall             # print the prime number
  #Print the new line
  li $v0, 4
  la $a0, newline
    syscall
  # if the counter is not reached to 0 loop again 
  bne $s1, $0, loop
  li $v0, 10            # exit the program
	syscall

# Function to test whether number is prime
test_prime:
	li $t0, 2           #Initialize the second to check for all numbers
    sra	$t2, $a0, 1     #A number is not divisible by more than its half, so we can iterate through half only and no need to iterate for all the numbers
test_loop:
  bgt $t0, $t2, exit_true #
  div $a0, $t0          #Divide the number from 2 to num/2
  mfhi $t1              #Get the Remainder of the division to $t1
  addi $t0, $t0, 1      #increment the number to check for next division
  bnez $t1, test_loop
  #Return 0, if the number is not prime, return 1 if the number is prime
  addi $v0, $zero, 0
  jr $ra                # return to the address where it was called
exit_true:
  addi $v0, $zero, 1
  jr $ra                # return to the address where it was called