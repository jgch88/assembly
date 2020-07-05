# pre-example setup
# load 0000 0000 0011 1101 0000 1001 0000 0000 into register $s0
main:

# example
lui $s0, 61 # 61 decimal = 0000 0000 0011 1101 binary
# since immediates are only 16 bit, they are loaded into the top half of the word (16 bits), the bottom half are 0s
ori $s0, $s0, 2304 # 2304 decimal = 0000 1001 0000 0000 binary, merge into bottom half
# logical OR with bottom half's 0s will copy the other half of the immediate into the bottom 

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall

####
# R16 [s0] = 3d0900 -> 1111010000100100000000