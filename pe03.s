        .data
msg:    .asciiz "The first 100 prime numbers are:\n"
resp:   .asciiz " number is: "
check:  .asciiz "The total of the first 100 prime numbers is: "
endl:   .asciiz "\n"
        .text

main: # 0 and 1 are not prime so initial values were set to 2 for beginning the program
        li      $t0, 0          #t0 maintains the count of prime numbers found
        li      $t1, 2          #t1 is the number being tested for primeness in procedure but it gets its value from s1
        li      $t2, 100        #t2 is the backstop that tells the program when to exit 
        li      $t3, 2          #Begins at 2 during the check prime procedure and increments till equal to t1
        li      $s1, 2          #Source of current integer to be tested for primeness. Value of t1 is copied from here
        li      $s2, 0          #For result validation, keeping a running total of the prime numbers to compare to online results

        li      $v0, 4          #Display the opening message
        la      $a0, msg
        syscall       

check_prime:       
        div     $t1, $t3            #Receives the int under test and begins the div by 2                       
        mfhi    $t4                 #Gains the remainder and holds that value in t4
        beq     $t3, $t1, counter   #If t3==t1 then it is prime and go to counter procedure                 
        beq     $t4, $zero, L1      #If t3<t1 check if t4==0 (is not prime if true and goes to L1)
        addi    $t3, 1              #If t4 != zero, increment t3 and begin procedure again until t3==t1
        j       check_prime                
        
counter: #Enter this procedure when a number has been determined to be prime
        addi    $t0, 1              #Increment the counter
        
        li      $v0, 1              #Print the current count of prime numbers
        move    $a0, $t0
        syscall

        li      $v0, 4              #Print the response string
        la      $a0, resp
        syscall

        li      $v0, 1              #Print the current value of s1 (which has been determined to be prime)
        move    $a0, $s1
        syscall

        li      $v0, 4              #print a new line
        la      $a0, endl
        syscall

        add     $s2, $s2, $s1       #Keep total sum of the prime numbers

L1:     
        beq     $t0, $t2, exit      #If counter equals backstop, exit the program
        addi    $s1, 1              #Otherwise, increment s1
        move    $t1, $s1            #Move value of s1 into t1
        li      $t3, 2              #Set t3 back to 2
        j       check_prime         #Begin a new prime check with the next int being tested
                                    # and t3 set back at 2

exit:
        li      $v0, 4              #Display closing message
        la      $a0, check
        syscall

        li      $v0, 1              #Print total sum of first 100 prime numbers for result validation
        move    $a0, $s2
        syscall

        li      $v0, 10             #Exit the program
        syscall
        

        #add sum of all results


