.data
userprompt1: .asciiz "\nEnter the first integer: "
userprompt2: .asciiz "\nEnter the second integer: "
userprompt3: .asciiz "\nEnter the third integer: " 
seperator: .asciiz "\n----------------\n "
result: .asciiz "\nThe result is: "
.text

main:

    #t0-to hold first integer
    #t1-to hold second integer
    #t2-to hold thrid integer

    # Read the first number
    li $v0, 4 #syscall to print string
    la $a0, userprompt1  #address of string to print
    syscall

    li $v0, 5 #syscall to read an integer
    syscall
    move $t0, $v0  #move the number to read into $t0

    #Read the second number
    li $v0, 4
    la $a0, userprompt2
    syscall

    li $v0,5        
    syscall
    move $t1,$v0    #move the number to read into $t1

    #Read the third integer
    li $v0,4
    la $a0,userprompt3
    syscall
    li $v0,5
    syscall
    move $t2,$v0    #move the number to read into $t1


    # Now t0,t1 and t2 have the numbers and need to compare which one are greater to each other
    # Compare each values and sort so that t0 and t1 will have the largest value
    # based on this table branching can be done https://chortle.ccsu.edu/assemblytutorial/Chapter-24/ass24_4.html
    ble $t2,$t0,swap1   #branch to swap1 if t2<=t0
    #else condition
    add $t0,$t0,$t2     #Add between t0 and t2 and save it in t0
    sub $t2,$t0,$t2     #At this step t2 will have the value that were in t0
    sub $t0,$t0,$t2     #At this step t0 will have the value that were in t2

swap1:
    ble $t2,$t1,swap2   #branch to swap1 if t2<=t1,if this condition is met then t0 and t1 will have the greatest value,we just need to sum
    #else condition
    add $t1,$t1,$t2     #add between t1 and t2 and save it in t1
    sub $t2,$t1,$t2     #at this step t2 will have the value that was in t1
    sub $t1,$t1,$t2     #at this step t1 will have value that was in t2

#at this time t0 and t1 have the largest numbers so just simply add them and print
swap2:
    la $a0,result   #priint the string for result
    li $v0,4
    syscall 

    add $t0,$t0,$t1 #Add t0 and t1 and let the result be in t0
    li $v0,1
    move $a0,$t0    #print the result
    syscall

    la $a0,seperator   #print the seperator to have a neat output
    li $v0,4
    syscall 

    li $v0,10   #Exit
    syscall
