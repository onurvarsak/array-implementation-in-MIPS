.data
	A: .word 2, 4, 6, 8
.text
main:
	la $s0, A			# s0 = base adress of Array A			
	add $s1, $0, $0		# s1 = i	i = 0 + 0 		
	add $s2, $0, $0		# s2 = diff	diff = 0 + 0		
	addi $t0, $0, 3		# t0 = 3	temporary = 3		
for:
	slt $t1, $s1, $t0	# t1 = s1 < t0		if(i<3) t1 = 1	
	beq $t1, $0, done	# 	if(t1=0) go done
	sll $t2, $s1, 2		# t2 = i * 4
		
	add $t3, $s0, $t2	# t3 = base + i * 4
	lw $s3, 0($t3)		# s3 = A[i]
	lw $s4, 4($t3)		# s4 = A[i+1]
		
	sub $s2, $s4, $s3	# s2 = s4 - s3		diff = A[i+1] - A[i]
	slt $t4, $0, $s2	# t4 = 0 < s2		if(diff > 0) t4 = 1
	beq $t4, $0, else	# 	if(t4 = 0)  go else
	
	sll $t5, $s3, 2		# t5 = s3(A[i]) * 4 	
	add $s3, $s3, $t5	# s3 = s3 + t5
	j break	
else:
	add $t6, $s3, $s3	# t6 = 2 * s3
	sub $t6, $s3, $t6	# t6 = s3 - t6	if number is negatif do positive 
	sll $t7, $t6, 2		# t7 = t6 * 4
	add $s4, $t7, $t6	# t7 = t7 + s3
break:
	sw $s3, 0($t3)		# t3[i] = s3
	sw $s4, 4($t3)		# t3[i+1] = s4
	addi $s1, $s1, 1	# i = i + 1
	j for
done:
	