.data
	msg: .asciiz "This is the first program!"


.text 
main:
	li $v0, 4
	la $a0, msg
	syscall

	li $v0, 10
	syscall
	
main2:
	slt $t1, $s0, $s1 
	beq $t1, $zero, endLoop
	
	
	endLoop:
	
	
	
	

