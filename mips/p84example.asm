# pre-example setup
main:
lui $t1, 0x1001 # A
addi $s2, 1 # h
addi $t0, 15 # value
sw $t0, 1200($t1)

# example
lw $t0, 1200($t1)
add $t0, $s2, $t0
sw $t0, 1200($t1)
# [00400034] 8d2804b0  lw $8, 1200($9)          ; 9: lw $t0, 1200($t1) 
# 8d2804b0 -> 100011 01001 01000 0000010010110000 -> 35, 9, 8, 1200
# [00400038] 02484020  add $8, $18, $8          ; 10: add $t0, $s2, $t0 
# [0040003c] ad2804b0  sw $8, 1200($9)          ; 11: sw $t0, 1200($t1) 

# boilerplate for qtspim simulator to exit
li $v0, 10 
syscall