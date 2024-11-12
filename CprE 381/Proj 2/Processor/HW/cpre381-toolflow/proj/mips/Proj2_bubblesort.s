.data
array:  .word 5, 2, 9, 1, 5, 6   # Array to be sorted
size:   .word 6                # Number of elements in the array

.text
main:
    # Load the base address of the array
    lui $1, 0x1001
    ori $t0, $1, 0
    
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
    

inner_loop:
    # Calculate the offset for the current element
    sll $t3, $t2, 2   # Multiply the inner loop counter by 4 (element size)

    
    # Calculate the address of the current and next elements
    add $t4, $a0, $t3   # Address of the current element
    add $t5, $t4, $t8   # Address of the next element

    # Load the current and next elements from memory
    lw $t6, 0($t4)
    lw $t7, 0($t5)

    # Compare the current and next elements
    slt $1, $t7, $t6
    beq $1, $0, no_swap

    # Swap the elements
    sw $t6, 0($t5)
    sw $t7, 0($t4)

    # Set the flag to indicate that a swap was made
    addiu $t9, $0, 1

no_swap:
    # Increment the inner loop counter
    addi $t2, $t2, 1

    # Check if the inner loop is finished
    bne $t2, $t1, inner_loop

    # If no swaps were made in this pass, the array is sorted
    beq $t9, $zero, done

    # Reset the inner loop counter for the next pass
    addiu $t2, $0, 0

    # Continue with the next pass of the outer loop
    j outer_loop

done:
    # Exit the program
    halt
