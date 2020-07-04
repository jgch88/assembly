# pre-example setup
# http://web.cs.iastate.edu/~cs321/pa1.html
main:
lui $s3, 0x1001 # load upper part of $s3 with address 0x1001, $s3 = 0x10010000
# in the Data window in QtSpim, User data segment addresses are from [10000000]..[10040000]
addi $t0, 15
sw $t0, 8($s3) # store value f at 0x10010008
# User data segment [10000000]..[10040000]
# [10000000]..[10010007]  00000000
# [10010008]    0000000f  00000000                        . . . . . . . . 
# [10010010]..[1003ffff]  00000000
addi $s2, 1 # h = 1

# example
lw $t0, 8($s3) # load word from 0x10010008
add $s1, $s2, $t0 # g = h + A[8], 1 + f = 10

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall