#Data segment
		.data
#variable
input:		.space		60
aux:		.space		60
filename:		.asciiz		"INT15.bin"
#promt
prompt_print:	.asciiz		"Du lieu hien tai la: "
space:		.asciiz		" "
endl:		.asciiz		"\n"
promt_error:	.asciiz		"Khong the mo file"
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
	slt	$t0,	$v0,	$zero
	bne	$t0,	$zero,	error
	add	$s6,	$v0,	$zero
	# read file
	addi	$v0,	$zero,	14	
	add	$a0,	$s6,	$zero
	la	$a1,	input
	addi	$a2,	$zero,	600
	syscall	
	# close file
	addi	$v0,	$zero,	16	
	add	$a0,	$s6,	$zero
	syscall
    	
	jal	print
#process
	la	$t1, 	input
	addi	$a1,	$t1,	0
	addi	$a2,	$t1,	56
	addi 	$a3,	$t1,	32
	jal	mergeSort
#exit
	addi	$v0,	$zero,	10
	syscall
#error
error:
	la	$a0,	promt_error
	addi	$v0,	$zero,	4
	syscall
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
mergeSort:
#a0 = address input, a1 = address left, a2 = address right
	#if	a1 >= a2	return
	slt	$t0,	$a1,	$a2
	beq	$t0,	$zero,	end_mergeSort
	#mid = (left + right)/2
	sub	$t0,	$a2,	$a1
	sra	$t0,	$t0,	3
	sll	$t0,	$t0,	2
	add	$a3,	$a1,	$t0
	
	#call mergeSort(left, mid)
	    #store paramenter
	addi    $sp,	$sp,	-16
	sw	$a1, 	0($sp)
	sw	$a2, 	4($sp)		
	sw	$a3, 	8($sp)
	sw	$ra, 	12($sp)
	    #call function
	add	$a2,	$zero,	$a3
	jal	mergeSort
	    #load paramenter
	lw	$a1, 	0($sp)
	lw	$a2, 	4($sp)
	lw	$a3, 	8($sp)
	lw	$ra, 	12($sp)
	addi	$sp, 	$sp, 	16
	#call mergeSort(mid + 1, right)
	    ##store paramenter
	addi    $sp,	$sp,	-16
	sw	$a1, 	0($sp)
	sw	$a2, 	4($sp)		
	sw	$a3, 	8($sp)
	sw	$ra, 	12($sp)
	    #call function
	add	$a1,	$zero,	$a3
	addi	$a1,	$a1,	4
	jal	mergeSort
	     #load paramenter
	lw	$a1, 	0($sp)
	lw	$a2, 	4($sp)
	lw	$a3, 	8($sp)
	lw	$ra, 	12($sp)
	addi	$sp, 	$sp, 	16
	#call merge	
	#store paramenter
	addi    $sp,	$sp,	-16
	sw	$a1, 	0($sp)
	sw	$a2, 	4($sp)		
	sw	$a3, 	8($sp)
	sw	$ra, 	12($sp)
	    #call function
	addi	$a3,	$a3,	4
	jal	merge
	    #load paramenter
	    #load paramenter
	lw	$a1, 	0($sp)
	lw	$a2, 	4($sp)
	lw	$a3, 	8($sp)
	lw	$ra, 	12($sp)
	addi	$sp, 	$sp, 	16
end_mergeSort:
	jr	$ra
#mergeFunction
merge:
    #a1 = address left, a2 = address right, a3 = address mid
	# store paramenter
	addi    $sp,	$sp,	-4
	sw	$a1, 	0($sp)
	#t0 = aux
	la	$t0, 	aux
	# while (left < mid && mid <= right) so sanh
	# t4 = mid cux
	add	$t4, 	$zero,	$a3
while1:
    # condition
	slt	$t1, 	$a1, 	$t4
	beqz	$t1,	endWhile1
	slt	$t1, 	$a2, 	$a3
	bnez	$t1, 	endWhile1 
    # body while	
        #t1 = *left, t2 = *mid, 
    	lw	$t1, 	0($a1)
    	lw	$t2, 	0($a3)
        # if (t1 < t2) *aux = t1 else *aux = t2
        	slt	$t3, 	$t1, 	$t2
        	beqz	$t3, 	elseIf	
        # then
        	sw	$t1, 	0($t0)
        	addi	$a1,	$a1, 	4
        	j	endIf
        # else
elseIf:
		sw	$t2, 	0($t0)
		addi	$a3, 	$a3, 	4
        # endif
endIf:
	addi	$t0, 	$t0, 	4
	j	while1
    # endWhile
endWhile1:	
# 	while (right) chua duyet
whileRight:
	slt	$t1, 	$a2, 	$a3
	bnez	$t1, 	endWhileRight
    # body while	
	lw	$t1,	0($a3)
	sw	$t1, 	0($t0)
	addi	$a3, 	$a3, 	4
	addi	$t0, 	$t0, 	4
	j 	whileRight
    #endwhileRight
endWhileRight:
#	while (left) chua duyet het	
whileLeft:
	slt	$t1, 	$a1, 	$t4
	beqz	$t1, 	endWhileLeft
    # body while	
	lw	$t1, 	0($a1)
	sw	$t1, 	0($t0)
	addi	$a1, 	$a1, 	4
	addi	$t0, 	$t0, 	4
	j 	whileLeft
    #endwhileRight
endWhileLeft:
    # copy from aux to input
    	lw	$t1, 	0($sp)
	la	$t0, 	aux
    # while left <= right
whileCopy:
	slt	$t2, 	$a2, 	$t1
	bnez	$t2, 	endWhileCopy
bodyWhileCopy:
	lw	$t2, 	0($t0)
	sw	$t2, 	0($t1)
	addi	$t0, 	$t0, 	4
	addi	$t1, 	$t1, 	4
	j	whileCopy
endWhileCopy:
	
endMerge:
	lw	$a1, 	0($sp)
	addi	$sp, 	$sp, 	4
	addi    $sp,	$sp,	-4
	sw	$ra, 	0($sp)
	jal	print
	lw	$ra, 	0($sp)
	addi	$sp, 	$sp, 	4
	jr	$ra
	
