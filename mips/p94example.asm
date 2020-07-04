# pre-example setup
main:
addi $s0 0xffffffff
addi $s1 0x00000001

# example
slt $t0, $s0, $s1 # $t0 = 1
sltu $t0, $s0, $s1 # $t0 = 0

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall