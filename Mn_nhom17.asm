#Data segment
		.data
#variable
input:		.space		60
filename:	.asciiz		"init15.bin"
#promt
prompt_print:	.asciiz		"Du lieu hien tai la: "
space:		.asciiz		" "
endl:		.asciiz		"\n"
#Code segment
		.text
#main function
		.globl	main
main:
#read_input

	#open file
	addi	$v0,	$zero,	13
	la	$a0,	filename
	addi	$a1,	$zero,	0
	addi	$a2,	$zero,	0
	syscall
	add	$s6,	$v0,	$zero
	# read file
	addi	$v0,	$zero,	14	
	add	$a0,	$s6,	$zero
	la	$a1,	input
	addi	$a2,	$zero,	60
	syscall	
	# close file
	addi	$v0,	$zero,	16	
	add	$a0,	$s6,	$zero
	syscall
    	
	jal	print
#process
	la	$t1, 	input
	la	$a1,	($t1)
	la	$a2,	60($t1)
	jal	mergeSort
#exit
	addi	$v0,	$zero,	10
	syscall
	
	
#print function
print:
	addi 	$t0,	$zero,	0
	addi 	$t6, 	$zero,	15
	la	$a0,	prompt_print
	addi	$v0,	$zero,	4
	syscall
	la	$t1,	input
begin_for:	
	lw	$a0,	($t1)
	addi 	$t1,	$t1,	4
	addi	$v0,	$zero,	1
	syscall
	la	$a0,	space
	addi	$v0,	$zero,	4
	syscall
	addi	$t0,	$t0,	1
	beq	$t0,	$t6, 	end_for
	j	begin_for
end_for:
	la	$a0,	endl
	addi	$v0,	$zero,	4
	syscall
	jr	$ra
	
	
	
#mergeSort function
#input
#$a1: address start
#$a2: address end
mergeSort:
	slt	$t0,	$a1,	$a2
	beq	$t0,	$zero,	end_mergeSort
	jal 	print	
end_mergeSort:
	jr	$ra
#input
#mergeFunction
	
