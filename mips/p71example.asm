# pre-example setup
main:
lui $s3, 0x1001
addi $s2, 1
addi $t0, 15
sw $t0, 32($s3)

# example
lw $t0, 32($s3)
add $t0, $s2, $t0
sw $t0, 48($s3)
# User data segment [10000000]..[10040000]
# [10000000]..[1001001f]  00000000
# [10010020]    0000000f  00000000  00000000  00000000    . . . . . . . . . . . . . . . . 
# [10010030]    00000010  00000000  00000000  00000000    . . . . . . . . . . . . . . . . 
# [10010040]..[1003ffff]  00000000

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall