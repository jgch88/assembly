# pre-example setup
# jump to IndexOutOfBounds if $ s1 >= $t2 or $s1 is negative
main:
addi $s1, $zero, 0xffffffff
addi $t2, $zero, 0x00000002

# example
sltu $t0, $s1, $t2 # if s1 < t2, t0 = 1, happy path. 0 is the unhappy path.
# this bounds check shortcut works with sltu because
# if $s1 is negative, the unsigned check will treat it as a super large number, and will not set $t0 to 1
# if $s1 is bigger, it's the same check, and will also not set $t0 to 1
bne $t0, 1, IndexOutOfBounds # same as beq $t0, $zero, IndexOutOfBounds
# branch out if $t0 = 0 (unhappy path)
j Exit # not in example, but probably needed

IndexOutOfBounds:
addi $t3, $zero, 0xffffffff # to see simulator jump to this instruction

Exit:
# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall