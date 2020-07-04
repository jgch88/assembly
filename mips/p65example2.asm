# pre-example setup
main:
addi $s1, 1
addi $s2, 2
addi $s3, 3
addi $s4, 4

# example
add $t0, $s1, $s2 # t0 = g + h
add $t1, $s3, $s4 # t1 = i + j
sub $s0, $t0, $t1 # f = (g + h) - (i + j) = (1 + 2) - (3 + 4) = -4 = ffff fffc   // -4 -> 0100 -> 0011 -> 1100 -> c

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall