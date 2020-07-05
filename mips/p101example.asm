# pre-example setup
# int fact (int n) {
#   if (n < 1) return (1);
#   else return (n * fact(n - 1));
# }
main:
addi $s0, $zero, 5 # doing some random stuff
addi $a0, $zero, 4 # initial value of n
jal fact # fact(4)
j fact_exit # so that jal fact doesn't link $ra to fact and invoke fact forever

# example
fact:
# there are two registers used in this procedure, argument n ($a0) and return address ($ra)
# so we need the stack pointer to store each of these two registers every time 
# the recursive closure is invoked. (return address has two cases: the base case and the recursive case)
# like in p98example, we push OLD values into the stack for preservation so we can override the
# registers in the current context. (argument n has all the cases for the recursion stack depth: from 1 ... n)
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)

# function body
slti $t0, $a0, 1 # test for n < 1. if n < 1, $t0 = 1 (base case)
beq $t0, $zero, L1 # branch to L1 on recursive case if $t0 = 0

# base case
addi $v0, $zero, 1
addi $sp, $sp, 8
jr $ra

# recursive case
L1:
addi $a0, $a0, -1 # if n >= 1, new argument is (n - 1)
jal fact # recurse

lw $a0, 0($sp) # base case's jr $ra will return back here since line above set jal address to this line. restore argument n
lw $ra, 4($sp) # restore return address
addi $sp, $sp, 8 # pop 2 items off stack pointer

# actual recursive logic
mul $v0, $a0, $v0 # return n * fact (n - 1)
jr $ra # return to caller

# escape recursive function
fact_exit:

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall

#### 
# At maximum depth of the recursion, can see n = 0, 1, 2, 3, 4. 
# $ra = 00400050, 00400050, 00400050, 00400050 (recursive cases), 00400018 (base case)
# User Stack [7ffff020]..[80000000]
# [7ffff020]    00000000  00400050  00000001  00400050    . . . . P . @ . . . . . P . @ . 
# [7ffff030]    00000002  00400050  00000003  00400050    . . . . P . @ . . . . . P . @ . 
# [7ffff040]    00000004  00400018  00000001  7ffff115    . . . . . . @ . . . . . . . . . 

# interestingly when stack pointer is added back, the contents are not cleared!