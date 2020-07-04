# pre-example setup
main:
addi $s1, 1
addi $s2, 2
addi $s3, 3
addi $s4, 4 # change $s4 to observe bne branching behaviour

# example
bne $s3, $s4, Else 
# [00400034] 16740003  bne $19, $20, 12 [Else-0x00400034]    # 12 is the PC address offset, 3 x 4
# 16740003 -> 000101 10011 10100 0000000000000011 (I format) -> 5, 19, 20, 3 
# Else offset is 3 instructions down
add $s0, $s1, $s2
j Exit

Else:
sub $s0, $s1, $s2

Exit:

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall