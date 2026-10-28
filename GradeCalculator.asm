.data
header: .asciiz "============== Grade Calculator ============== "
midterm1: .asciiz "\nEnter Midterm 1 Test Score:\t"
midterm2: .asciiz "\nEnter Midterm 2 Test Score:\t"
finalExam: .asciiz "\nEnter Final Exam Score:\t\t"
newLine: .asciiz "\n"
avg: .asciiz "\nAverge is: "
grade: .asciiz "\nLetter Grade is: "
endHeader: .asciiz "\n=============================================="
.text

main:
	li $v0, 4
	la $a0, header
	syscall
	
	la $a0, midterm1
	syscall
	li $v0, 5
	syscall
	add $s0, $v0, $0	# Gets user's FIRST midterm score and store's it into $s0
	
	li $v0, 4
	la $a0, midterm2
	syscall
	li $v0, 5
	syscall
	add $s1, $v0, $0	# Gets user's SECOND midterm score and store's it into $s1
	
	li $v0, 4
	la $a0, finalExam
	syscall
	li $v0, 5
	syscall
	add $s2, $v0, $0	# Gets user's Final exam score and store's it into $s2
	
	add $a1,$s0, $0
	add $a2,$s1, $0
	add $a3,$s2, $0
	jal calculateAvg	# Jumps to calculateAvg subroutine
	add $t0, $v1, $0	# Stores average score into $t0
	
	li $v0, 4
	la $a0, newLine
	syscall
	li $v0, 4
	la $a0, avg
	syscall
	li $v0, 1
	add $a0, $t0, $0	# Prints out the score
	syscall

	add $a1, $t0, $0
	jal calculateGrade	# Jumps to calculateGrade subroutine
	add $t0, $v0, $0
	
	li $v0, 4
	la $a0, grade
	syscall
	
	li $v0, 11
	add $a0, $t0, $0	# Prints out the grade
	syscall
	
	li $v0, 4
	la $a0, endHeader
	syscall
	
li $v0, 10
syscall

calculateAvg: 	add $t0, $a1, $0
		add $t1, $a2, $0
		add $t2, $a3, $0
		
		li $t4, 3	# helps with calculating average
		
		add $t5, $t0, $t1
		add $t5, $t5, $t2
		div $t5, $t5, $t4
		mflo $t6		# gets the quotient of the average score 
		
		add $v1, $t6, $0
		jr $ra

calculateGrade:	add $t0, $a1, $0
		
		bge $t0, 90, gradeA
		bge $t0, 80, gradeB
		bge $t0, 70, gradeC
		bge $t0, 60, gradeD
		j gradeF
		
gradeA:	li $v0, 65
	jr $ra
	
gradeB:	li $v0, 66
	jr $ra


gradeC:	li $v0, 67
	jr $ra


gradeD:	li $v0, 68
	jr $ra


gradeF:	li $v0, 70
	jr $ra
