# Microprocessor 8bit with VHDL
Project realization for Digital Electronic Design with VHDL (1FA326) in Uppsala University.
![architecture](images/architecture.png)

## Submodules

- Control Unit (CU)
- Arithmetic Logic Unit (ALU)
- Program Counter (PC)
- Address Register
- Loop Counter

## Operations

All operations are performed in two clock cycles:

1. **FETCH:** The microprocessor loads an instruction from the memory location pointed by the Program Counter (PC). The instruction is stored in the Instruction Register (INSTR_REG), and then decoded by the Instruction Decoder.

2. **EXECUTE:** The Control Unit (CU) submits command execution to submodules with control signals.

## Instruction Set Architecture (ISA)

The instruction set supports the following operations:

- Memory-related operations (loading and storing of internal registers)
- Jump operations and address modifications
- Arithmetic and logic operations

### Instructions
| Instruction | Description | Operation |
| ----------- | ----------- | --------- |
| LD_ADDR1    | Loads address register 1 | ADR1 <= MEM(PC+1) |
| LD_ADDR2    | Loads address register 2 | ADR2 <= MEM(PC+1) |
| LD_ACC      | Loads accumulator | ACC <= MEM(ADR1) |
| LD_TEMP     | Loads temporary register | TEMP <= MEM(ADR2) |
| LD_JUMPREG  | Loads JUMP-register | JUMP_REG <= MEM(PC + 1) |
| ST_ACC1     | Store accumulator | MEM(ADR1) <= ACC |
| ST_ACC2     | Store accumulator | MEM(ADR2) <= ACC |
| JPF         | Unconditional jump forward | PC <= PC + JUMP_REG |
| JPB         | Unconditional jump back | PC <= PC - JUMP_REG |
| JPF_G       | Conditional jump forward if GT | PC <= PC + JUMP_REG if GT |
| JPF_Z       | Conditional jump forward if Z | PC <= PC + JUMP_REG if Z |
| CMP         | Compare | (GT, Z) <= ACC - TEMP |
| ADD         | Addition | ACC <= ACC + TEMP |
| SUB         | Subtraction | ACC <= ACC - TEMP |

### Instruction format
Single byte instruction
| OP code | function | mnemonic |
| - | - | - |
| 0000 | 0001 | CMP |
| 0000 | 0010 | ADD |
| 0000 | 0011 | SUB |
| 0001 | 0000 | JPF | 
| 0001 | 0001 | JPB | 
| 0001 | 0010 | JPF_G |
| 0001 | 0011 | JPF_Z |
| 1000 | 0001 | ST_ACC1 |
| 1000 | 0010 | ST_ACC1 |
| 1010 | 0000 | LD_ACC |
| 1010 | 0001 | LD_TEMP |

Two bytes instruction
| OP code | function | address | mnemonic |
|-|-| - | - |
| 1010 | 1000 | xxxxxxxx | LD_JUMPREG |
| 1010 | 1001 | xxxxxxxx | LD_ADDR1 |
| 1010 | 1010 | xxxxxxxx | LD_ADDR2 |

![time_diagram](images/time_diagram.png)

# Test Programs
`A=B+C`
How it would be "compiled"
```asm
LD_ADD_OP; load the address of B
x"F0"; chosen address
LD_ADDR2_OP; load the address of C
x"F1";
LD_ACC_OP; move B to ACC
LD_TEMP_OP;  move C to TEMP
LD_ADDR1_OP; load the address of A
x"F2";
ADD_OP; add B and C
ST_ACC1_OP; store the result in A
```

`IF A>=0 THEN B=C`
```asm
LD_ADDR1_OP;  load the address of A (0x00)
x"F0";  address of A (0x01)
LD_ADDR2_OP;  load the address of 0 variable (0x02)
x"F1";  address of 0 variable (0x03)
LD_JUMPREG_OP;  (0x04)
x"0E";  address of B = C (0x05)
LD_ACC_OP;  move A to ACC (0x06)
LD_TEMP_OP;  move 0 to TEMP (0x07)
CMP_OP;  compare A and 0 		(0x08)
JPF_G_OP;  if A > 0 then jump to 	(0x09)
JPF_Z_OP;  if A == 0 then jump to 	(0x0A)
; -- else operations
LD_JUMPREG_OP;  (0x0B)
x"14";  else jump to 0x14	(0x0C)
JPF_OP;  jump to 0x14	(0x0D)
; -- if operations (here we load B and C)
LD_ADDR1_OP;  load the address of C (0x0E)
x"F3";  address of C (0x0F)
LD_ADDR2_OP;  load the address of B (0x10)
x"F2";  address of B (0x11)
LD_ACC_OP;  move C to ACC (0x12)
ST_ACC2_OP;  store C in B (0x13)
```

# List of signals
| Signal    | Meaning           | Units involved                  |
| --------- | ----------------- | ------------------------------- |
| FETCH     | Fetch signal      | Control bus -> CU (INSTR_REG)          |
| STAT_UPD  | Status update     | Control bus -> CU(STATUS) |
| ACC_OE    | Accumulator output enable | CU -> Control bus -> Accumulator(ACC_BUF) |
| ACC_INC   | Accumulator increment   | CU -> Control bus -> Accumulator(ACC) |
| ACC_LD    | Accumulator load        | CU -> Control bus -> Accumulator(ACC) |
| CMP       | Compare operation       | CU -> Control bus -> Accumulator(ALU) |
| SUB       | Subtraction operation   | CU -> Control bus -> Accumulator(ALU) |
| TEMP_LD   | Temporary register load | CU -> Control bus -> Accumulator(TMP_REG) |
| PC_OE     | Program counter output enable | CU -> Control bus -> ProgramCounter(PC_BUF) |
| PC_INC    | Program counter increment | CU -> Control bus -> ProgramCounter(PC) |
| PC_LD     | Program counter load | CU -> Control bus -> ProgramCounter(PC) |
| JPF       | Jump forward        | CU -> Control bus -> ProgramCounter(ALU) |
| JPB       | Jump backward       | CU -> Control bus -> ProgramCounter(ALU) |
| JUMP_LD   | Jump load address   | CU -> Control bus -> ProgramCounter(JUMP_REG) |
| ADDR1_OE  | Address 1 output enable | CU -> Control bus -> Register1(ADDR1_BUF) |
| ADDR1_INC | Address 1 increment     | CU -> Control bus -> Register1(ADDR1) |
| ADDR1_LD  | Address 1 load          | CU -> Control bus -> Register1(ADDR1)  |
| ADDR2_OE  | Address 2 output enable | CU -> Control bus -> Register2(ADDR2_BUF)  |
| ADDR2_INC | Address 2 increment     | CU -> Control bus -> Register2(ADDR2)  |
| ADDR2_LD  | Address 2 load          | CU -> Control bus -> Register2(ADDR2)  |

### Execution on the FPGA
Videos of the execution on the DE1-SoC FPGA board.
- [Add Program](https://drive.google.com/file/d/1Jgky0CRWGgtvu1gbJoBRLZBz2IVZI-pI/view?usp=sharing)
- [Branch Program](https://drive.google.com/file/d/12SLZNjsHIX3QHUZwtROI03yDijUwk06g/view?usp=sharing)