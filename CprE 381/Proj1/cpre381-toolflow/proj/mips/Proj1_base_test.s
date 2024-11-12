.data
array: .word 0, 1, 2, 3

.text

main:
	addi $s0, $zero, 100
	addiu $s1, $zero, 110
	add $s2, $s0, $s1
	addu $s3, $s0, $s1
	and $s2, $s0, $s1
	andi $s2, $s0, 100
	lui $t0, 0x1001
	la $t0, array
	lw $t1, 0($t0)
	nor $s2, $s0, $s1
	xor $s2, $s0, $s1
	xori $s2, $s0, 100
	or $s2, $s0, $s1
	ori $s2, $s0, 100
	slt $s2, $s0, $s1
	slti $s2, $s0, 10
	sll $s2, $s0, 2
	srl $s2, $s0, 2
	sra $s2, $s0, 2
	sw $s2, 4($t0)
	sub $s2, $s0, $s1
	subu $s2, $s0, $s1
	beq $s0, $s1, branch
	bne $s0, $s1, branch
	
branch:
	j jump
	
	
jump:
	jal jumpandlink
	j exit
	
jumpandlink:
	jr $ra
	
exit:
	halt
