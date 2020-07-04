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
