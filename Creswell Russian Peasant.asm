# Carmen Creswell
# My First MIPS program
# Description: 
# This program uses MIPS to implement the Russian
# Peasant multiplication algortithm 

.data
prompt1: .asciiz "Please input the first integer: "
prompt2: .asciiz "Please input the second integer: "
result: .asciiz "Result: "
 
.text
#ask for the first integer
li $v0, 4
la $a0, prompt1
syscall
 
li $v0, 5
syscall
move $t1, $v0 #store the first number in $t1

#ask for the second integer 
li $v0, 4
la $a0, prompt2
syscall
 
li $v0, 5
syscall
move $t2, $v0 #store the second number in $t2

#this code is here to catch if the first line should be added
#directly into the total, it only happens once, so it's outside the loop
andi $t0, $t2, 1 # get least significant bit of t2 and put it in t0
bnez $t0, then #if t2 is odd

#multiply 
start:
	sll $t3, $t1, 1 #multiply the first number by 2
	srl $t4, $t2, 1	#divide the second number by 2
	
	move $t1, $t3  #put the multiplied number back into $t1
	move $t2, $t4  #put the divided number back into $t2
	
	andi $t0, $t2, 1 # get least significant bit of new t2 and put it in t0
	bnez $t0, then #if t2 is odd
	j start
then:
	add $t5, $t5, $t1 #add the number to the total
	beq $t2, 1, else #when t2 equals 1, end the loop
	j start
else:
	#display the result 
	li $v0,4
	la $a0,result
	syscall
 
	li $v0,1
	move $a0,$t5 
	syscall
 
	li $v0,10 #terminate the program
	syscall