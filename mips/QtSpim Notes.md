# QtSpim Notes

## Assembly files

- Extension .asm
- Need boilerplate file because simulator's "os" will enter via jal main, and expects an exit syscall (https://ecs-network.serv.pacific.edu/ecpe-170/tutorials/example1.asm/view):

```
# pre-example setup
main:

# example

# for qtspim simulator to exit
li $v0, 10
syscall
```

## QtSpim Simulator

### Loading .asm files

- File -> Reinitialize and load file

### Stepping through code

- Window -> Text Segment
- Toolbar -> "123" Icon: Single Step

### Restarting program

- Toolbar -> "Refresh" Icon: Clear Registers

### Viewing Memory

- Window -> Data Segment

### Machine Code

- In the Text Segment, you can see the [Program Counter] and machine code
- Similar to Page 80 Example

```
[00400038] 02484020  add $8, $18, $8          ; 10: add $t0, $s2, $t0
# machine code for instruction 00400038:
# 02484020 hex = 0000 0010 0100 1000 0100 0000 0010 0000
# organised into R format = 000000 10010 01000 01000 00000 100000 [op, rs, rt, rd, shamt, funct]
# opcode 000000, funct 100000 = add
# rd destination = 01000 = R8 = $t0
# rs, rt = first, second register source = 10010, 01000 = R18, R8 = $s2, $t0
# => add $t0, $s2, $t0
```

### Program Counter

- starts at 0x00400000

### Gotchas

- have been doing it wrong: addi $a0, 1 compiles even though it should be addi $a0, \$a0, 1. (Seems to have worked for $s0, $t0 etc because these are initialized to 0). See assembler's assembly output:

```
[00400030] 20840000  addi $4, $4, 0           ; 16: addi $a0, 0
[00400034] 20050001  addi $5, $0, 1           ; 17: addi $a1, $zero, 1
```

- addi $a0, 1 is shorthand for addi $a0, \$a0, 1
- when using argument registers e.g. \$a0, be extra careful because it's usually filled with junk from previous functions

### Style Guide

https://cs233.github.io/mipsstyle.html

- Label names should be all lower case with underscores separating words.
