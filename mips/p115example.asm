# pre-example setup
main:

# example
Loop:
sll $t1, $s3, 2
add $t1, $t1, $s6
lw $t0, 0($t1)
bne $t0, $s5, Exit
addi $s3, $s3, 1
j Loop

Exit:

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall

####
# [00400024] 00134880  sll $9, $19, 2           ; 6: sll $t1, $s3, 2   -> 000000 00000 10011 01001 00010 000000 -> 0, 0,19, 9, 2, 0
# [00400028] 01364820  add $9, $9, $22          ; 7: add $t1, $t1, $s6 -> 000000 01001 10110 01001 00000 100000 -> 0, 9,22, 9, 0,32
# [0040002c] 8d280000  lw $8, 0($9)             ; 8: lw $t0, 0($t1)    -> 100011 01001 01000 0000000000000000   ->35, 9, 8, 0
# [00400030] 15150003  bne $8, $21, 12 [Exit-0x00400030]               -> 000101 01000 10101 0000000000000011   -> 5, 8,21, 3 (Exit address = [0040003c], so [Exit-0x00400030] = 12, which is 3 instructions ahead. Simulator seems to be different from book)
# [00400034] 22730001  addi $19, $19, 1         ; 10: addi $s3, $s3, 1 -> 001000 10011 10011 0000000000000001   -> 8,19,19, 1, 
# [00400038] 08100009  j 0x00400024 [Loop]      ; 11: j Loop           -> 000010 00000100000000000000001001     -> 2, 100009 (hex address, not dec number) which is first instruction's address [00400024] / 4
