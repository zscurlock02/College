.data
array:  .word 5, 2, 9, 1, 5, 6   # Array to be sorted
size:   .word 6                # Number of elements in the array

.text
main:
    # Load the base address of the array
    lui $1, 0x1001
    nop
    nop
    nop
    ori $t0, $1, 0
    
    nop
    nop
    nop
    add $a0, $t0, $zero  # Load the base address of the array

    # Load the size of the array
    lw $t1, 0x18($1)

    # Initialize variables         
    addiu $t8, $0, 4	# Element size (4 bytes)
    addiu $t9, $0, 1	# Set a flag to 1 (1 means no swaps have been made)       

outer_loop:
    # Reset the inner loop counter
    addiu $t2, $0, 0
    addiu $t9, $0, 0	# Reset the flag
    nop     

inner_loop:
    # Calculate the offset for the current element
    sll $t3, $t2, 2   # Multiply the inner loop counter by 4 (element size)
    nop
    nop
    nop
    
    # Calculate the address of the current and next elements
    add $t4, $a0, $t3   # Address of the current element
    nop
    nop
    nop
    add $t5, $t4, $t8   # Address of the next element

    # Load the current and next elements from memory
    lw $t6, 0($t4)
    nop
    nop
    lw $t7, 0($t5)
    nop
    nop
    nop

    # Compare the current and next elements
    slt $1, $t7, $t6
    nop
    nop
    nop
    beq $1, $0, no_swap
    nop

    # Swap the elements
    sw $t6, 0($t5)
    sw $t7, 0($t4)

    # Set the flag to indicate that a swap was made
    addiu $t9, $0, 1

no_swap:
    # Increment the inner loop counter
    addi $t2, $t2, 1
    nop
    nop
    nop

    # Check if the inner loop is finished
    bne $t2, $t1, inner_loop
    nop

    # If no swaps were made in this pass, the array is sorted
    beq $t9, $zero, done
    nop

    # Reset the inner loop counter for the next pass
    addiu $t2, $0, 0

    # Continue with the next pass of the outer loop
    j outer_loop
    nop

done:
    # Exit the program
    halt
