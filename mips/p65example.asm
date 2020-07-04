# pre-example setup
main:
# a = b + c
# d = a - e

# d = $s3
# a = $t0, b = $s0, c = $s1, e = $s2
addi $s0, $zero, 1
addi $s1, $zero, 2
addi $s2, $zero, 4

# example
add $t0, $s0, $s1 # $t0 = 1 + 2 = 3
sub $s3, $t0, $s2 # $s3 = 3 - 4 = -1, which is ffff ffff in twos complement

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall