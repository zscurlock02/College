.data
.text
.globl main
main:
    lui $sp, 0x1001
    # Calling function1 with argument 5
    li $a0, 5
    jal function1
    # Exit the program
    halt

function1:
    # Save the return address on the stack
    subi $sp, $sp, 4
    sw $ra, 0($sp)
    # Function 1: Add 10 to the argument and check for equality
    addi $t0, $a0, 10
    beq $t0, 15, function2
    bne $t0, 15, function3

function2:
    # Function 2: Add 20 to the argument and jump to function3
    addi $t0, $a0, 20
    j function3

function3:
    # Save the return address on the stack
    subi $sp, $sp, 4
    sw $ra, 0($sp)
    # Function 3: Subtract 5 from the argument and call function4
    addi $t0, $a0, -5
    jal function4
    # Restore the return address from the stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    # Return to the caller
    jr $ra

function4:
    # Save the return address on the stack
    subi $sp, $sp, 4
    sw $ra, 0($sp)
    # Function 4: Multiply the argument by 2 and call function5
    add $t0, $a0, $a0
    jal function5
    # Restore the return address from the stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    # Return to the caller
    jr $ra

function5:
    # Function 5: Subtract 1 from the argument
    addi $t0, $a0, -1
    jr $ra

