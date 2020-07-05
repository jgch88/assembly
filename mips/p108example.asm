# pre-example setup
# copy string y into string x
# assume base address of x and y are in $a0 and $a1
# void strcpy (char x[], char y[])
# {
#   int i;

#   i = 0;
#   while ((x[i] = y[i]) != '\0')
#   i += 1;
# }
main:
# setup x = "" @ 0x10010000
lui $a0, 0x1001
# setup y = "ABCDE" @ 0x10020000
lui $a1, 0x1002
add $t0, $zero, 65 # add 'A' into $a1's first byte
sb $t0, 0($a1)
add $t0, $zero, 66 # add 'B' into $a1's second byte
sb $t0, 1($a1)
add $t0, $zero, 67 # add 'C' into $a1's third byte
sb $t0, 2($a1)
add $t0, $zero, 68 # add 'D' into $a1's fourth byte
sb $t0, 3($a1)
add $t0, $zero, 69 # add 'E' into $a1's fifth byte
sb $t0, 4($a1)
add $t0, $zero, $zero # add '\0' into $a1's sixth byte
sb $t0, 5($a1)
addi $s0, $zero, 6 # some random value in $s0 that main might have been using

jal strcpy # invoke strcpy(x, y)
j strcpy_exit

# example
strcpy:
addi $sp, $sp, -4 # adjust stack for 1 item
sw $s0, 0($sp) # save $s0 because we're going to overwrite it in our procedure

add $s0, $zero, $zero # initialize i = 0

L1:
add $t1, $s0, $a1 # address of y[i] in $t1
lbu $t2, 0($t1) # $t2 = y[i] (load byte unsigned, each ascii character uses 1 byte)
add $t3, $s0, $a0 # address of x[i] in $t3
sb $t2, 0($t3) # x[i] = y[i]

beq $t2, $zero, L2 # if y[i] == 0 i.e. end of string's \0, go to L2
addi $s0, $s0, 1 # increment i by 1 and not 4, since $s0 is a byte offset and not a word offset
j L1 # continue loop

L2:
lw $s0, 0($sp) # cleanup and restore original $s0 outside function closure
addi $sp, $sp, 4 # reset stack pointer
jr $ra # return

strcpy_exit: # escape function

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall

####
# Observe the little endianness of the bytes in each word
# e.g. 44434241 is DCBA addressed from right to left, bytes 3,2,1,0 within the word
# User data segment [10000000]..[10040000]
# [10000000]..[1000ffff]  00000000
# [10010000]    44434241  00000045  00000000  00000000    A B C D E . . . . . . . . . . . 
# [10010010]..[1001ffff]  00000000
# [10020000]    44434241  00000045  00000000  00000000    A B C D E . . . . . . . . . . . 
# [10020010]..[1003ffff]  00000000