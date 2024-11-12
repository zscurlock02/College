.data
.text

main:
	addi $1, $0, 10
	addiu $2, $0, 15
	andi $3, $0, 20
	lui $4, 0x1001
	xori $5, $0, 25
	ori $6, $0, 30
	slt $7, $0, $1
	slti $8, $3, 19
	sll $9, $1, 3
	srl $10, $2, 1
	sra $11, $3, 2
	sub $12, $2, $1
	subu $13, $2, $1
	add $14, $3, $3
	addu $15, $3, $4
	and $16, $5, $6
	sw $1, 0($4)
	nor $17, $2, $6
	xor $18, $3, $5
	or $19, $9, $10
	lw $20, 0($4)
	j jump

jump:
	jal jumpandlink
	beq $1, $2, exit
	bne $1, $2, exit

jumpandlink:
	jr $ra

exit:
	halt
