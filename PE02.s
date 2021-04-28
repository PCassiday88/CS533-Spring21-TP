# PE02: Assembly LanguagePE02: Assembly Language
# Write and test an adding machine program that repeatedly reads in integers and adds them into a running sum. 
# The program should stop when it gets an input that is 0, printing out the sum at that point.
# Submit your screen shot of output and source code to BB (submission) link.  Due on 02/02 11:30PM.

        .data
prompt: .asciiz "Enter an integer or 0 to stop\n"    #String for user input prompt to input integer or 0 to escape
respon: .asciiz "Your current total is: "            #String for displaying the user's current total of all previous inputs
final:  .asciiz "Your final total was: "
endl:   .asciiz "\n"                                 #Declaring/defining endl
        .text

main:
        li      $t1, 0                  #On program start this register will be initialized to zero
                                        #It will contain the running total sum of all previous integer
                                        #inputs 
user_input:
        li      $v0, 4                  #Prep to display string
        la	    $a0, prompt             #Load address of prompt to $a0
        syscall                         #Do it  

        li      $v0, 5                  #Read int
        syscall                         #Read the int the user input which is in $v0
        move    $t0, $v0                #Copy value of $v0 to $t0

        beq     $t0, $zero, exit        #branch to exit if t0 == 0

        add      $t1, $t1, $t0          #Add into $t1 the sum of $t1 and $t0

        li      $v0, 4                  #Provide the response string
        la      $a0, respon
        syscall

        li      $v0, 1                  #Display the current total
        move    $a0, $t1
        syscall

        li      $v0, 4                  #Print a new line for asthetics
        la      $a0, endl
        syscall

        j       user_input              #Begin the flow again until user inputs 0

exit:
        li      $v0, 4                  #Display the final total string
        la      $a0, final
        syscall

        li      $v0, 1                  #Provide the user with the cumulative total
        move    $a0, $t1 
        syscall

        li      $v0, 10                 #Exit the program
        syscall
