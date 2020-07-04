# pre-example setup
# while (save[i] == k) {
#   i += 1;
# }
main:
lui $s6, 0x1001 # save
addi $s3, $zero, 1 # i, must be at least 1, otherwise sll which is multiplication will do nothing and not execute the i += 1 part
addi $s5, $zero, 0 # k
addi $t0, $zero, 5
sw $t0, 20($s6) # save[5] = 5, to prevent it from being an infinite loop. 
# try out the infinite loop to see the exception!

# example
Loop:
  sll $t1, $s3, 2
  add $t1, $t1, $s6
  lw $t0, 0($t1)
  bne $t0, $s5, Exit
  addi $s3, $s3, 1
  j Loop

Exit:


# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall