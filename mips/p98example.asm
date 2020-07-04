# pre-example setup
# int leaf_example (int g, int h, int i, int j) {
#   int f;
#   f = (g + h) - (i + j);
#   return f;
# }
main:
# example

# some random previous code using $t1, $t0, $s0, context outside the function call
addi $t0, $zero, 4
addi $t1, $zero, 5
addi $s0, $zero, 6

# loading arguments for function call
addi $a0, $zero, 0
addi $a1, $zero, 1
addi $a2, $zero, 2
addi $a3, $zero, 3

# call function
jal leaf_example # stores PC+4 in $ra, so that function can return to next line via j $ra

# use return value
add $s1, $s0, $v0 # 6 + ((0 + 1) - (2 + 3)) = 2

# end program
j Exit

# now leaf_example also wants to use these registers
# it has to store them in the stack memory so that when control
# returns back from the function closure, the context $t1, $t0, $s0 are preserved
leaf_example:
addi $sp, $sp, -12
sw $t1, 8($sp)
sw $t0, 4($sp)
sw $s0, 0($sp)
# $sp went from 7ffff048 to 7ffff03c. old context is now stored in (stack) memory 7ffff044, 7ffff040, 7ffff03c
# User Stack [7ffff03c]..[80000000]
# [7ffff03c]    00000006                                  . . . . 
# [7ffff040]    00000004  00000005  00000001  7ffff116    . . . . . . . . . . . . . . . .  

add $t0, $a0, $a1
add $t1, $a2, $a3
sub $s0, $t0, $t1

add $v0, $s0, $zero

lw $s0, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
addi $sp, $sp, 12

jr $ra

Exit:
# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall