        .data
string1:.asciiz     "Enter an integer:"
string2:.asciiz     "Sum of all integers is: "
        .text

main:
    li $s0,0    #Initialize register with 0 as the sum
    loop:
        li $v0,4            #print string
        la $a0,string1
        syscall

        li $v0,5            #Take user input
        syscall
        beq $v0,$0,finish     #if the entered number is 0 then call function done(finish and display the sum)
        #else condition
        add $s0,$s0,$v0     #sum = sum + input
        j  loop             #Loop to read the next number

    finish:
        li  $v0,4           #print string
        la  $a0,string2
        syscall

        li $v0,1            #print the final sum
        move    $a0,$s0
        syscall

        li $v0, 10          #system code to exit
        syscall