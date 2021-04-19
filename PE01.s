        .data
prompt: .asciiz "Enter an integer: "
respon: .asciiz "The sum of your two highest integers is: "
endl:   .asciiz "\n"
        .text

main:
#Lines 8-30 allow the user to input three ints and those values are saved in $ts0, $s1, and $s2
        li      $v0, 4                  #Prep to display string
        la	    $a0, prompt             #Load address of prompt to $a0
        syscall                         #Do it 
        
        li      $v0, 5                  #Read int
        syscall                         #Read the int the user input which is in $v0
        move    $s0, $v0                #Copy value of $v0 to $t0

        li      $v0, 4                  #Prep to display string
        la	    $a0, prompt             #Load address of prompt to $a0
        syscall                         #Do it 
        
        li      $v0, 5                  #Read int
        syscall                         #Read the int the user input which is in $v0
        move    $s1, $v0                #Copy value of $v0 to $t1

        li      $v0, 4                  #Prep to display string
        la	    $a0, prompt             #Load address of prompt to $a0
        syscall                         #Do it 
        
        li      $v0, 5                  #Read int
        syscall                         #Read the int the user input which is in $v0
        move    $s2, $v0                #Copy value of $v0 to $t2

#Now we must determine which of the three integers is the lowest and add the other two
#No tie breaking criteria was given in the instructions

        slt     $t3, $s0, $s1           #If the sum of t3 and t4 (stored as t3) is 2 s0 is smallest
        slt     $t4, $s0, $s2           #If t3 is 0 then either s0 is largest or atleast 2/3 larger ints equal
        add     $t3, $t3, $t4           #If t3 = 1 than s0 is in the middle

        addi    $t5, $t3, -2            #If t3=2 goto L1 because this will make equal to zero which means s0 is smallest
        beq     $t5, $zero, L1          #If this condition is true, add s1 and s2 else continue

        addi    $t5, $t3, -1            #If t3=1 go to L2 to find out if s0 will be added with s1 or s2
        beq     $t5, $zero, L2

        beq     $t3, $zero, L2          #If t3=0 then s0 is either the largest or it and one other are 
                                        # equal but both larger than the 3rd int
                                        
L1:     add     $s3, $s1, $s2
        j       exit

L2:     slt     $t4, $s1, $s2           #We know s0 is in the middle so now we just need to know the other int
        beq     $t4, $zero, else        #If true s1 > s2 so add s1 and s0
        j       L3                      #Add s2 and s0
else:   add     $s3, $s1, $s0
        j       exit
                                          
L3:     add     $s3, $s2, $s0           #If t3=0 or s1 < s2 (add s2, s0 because we know s0 >= s1&s2
        j       exit                    # and that s1 < s2)

#Now that we have the sum in $s3 we can display that amount
exit:   li      $v0, 4                  #Prep to print a String
        la      $a0, endl               #Load the address of endl String into $a0
        syscall                         #Do it

        li      $v0, 4                  #Print string
        la	    $a0, respon             #Load address to respon String into $a0
        syscall                         #Do it

        li      $v0, 1                  #Prepare to print an int
        move    $a0, $s3                #Copy the int value in $s3 to $a0
        syscall                         #Print contents of $a0 as a string

        li      $v0, 10
        syscall