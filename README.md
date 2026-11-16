# cpu8 — an 8-bit CPU in VHDL

A simple 8-bit CPU designed from scratch in VHDL, built bottom-up: each block is written and tested on its own before being connected into the full processor. Simulated in Vivado (XSim); code is VHDL-93 compatible.

## Architecture

- 8-bit data path, 4 general-purpose registers (R0–R3)
- Harvard memory: 256 × 16-bit program ROM, 256 × 8-bit data RAM
- Flags: Z (zero), C (carry/borrow)
- 16-bit instruction format:

```
 15    12 11  10 9    8 7              0
+--------+------+------+----------------+
| opcode |  Rd  |  Rs  | address / imm  |
+--------+------+------+----------------+
```

## Instruction set

| Opcode | Mnemonic | Meaning |
|---|---|---|
| 0000 | NOP | do nothing |
| 0001 | LOAD Rd, addr | Rd <- RAM[addr] |
| 0010 | STORE Rd, addr | RAM[addr] <- Rd |
| 0011 | LDI Rd, imm | Rd <- imm |
| 0100 | ADD Rd, Rs | Rd <- Rd + Rs |
| 0101 | SUB Rd, Rs | Rd <- Rd - Rs |
| 0110 | AND Rd, Rs | Rd <- Rd and Rs |
| 0111 | OR Rd, Rs | Rd <- Rd or Rs |
| 1000 | XOR Rd, Rs | Rd <- Rd xor Rs |
| 1001 | NOT Rd | Rd <- not Rd |
| 1010 | JMP addr | PC <- addr |
| 1011 | JZ addr | if Z = 1, PC <- addr |
| 1111 | HALT | stop |

## Folder structure

```
cpu8/
├── src/       VHDL design files
├── sim/       testbenches
├── docs/      notes and build plan
└── vivado/    Vivado project (not tracked by Git)
```

## Progress

| Step | Block | Status |
|---|---|---|
| 0 | basic_gates + testbench | Done, tests pass |
| 1 | cpu_pkg (constants, types) | In progress |
| 2 | ALU + testbench | |
| 3 | Register file | |
| 4 | Program counter | |
| 5 | Instruction register | |
| 6 | Program ROM | |
| 7 | Data RAM | |
| 8 | Control unit (FSM) | |
| 9 | CPU top level (integration) | |

## How to simulate

1. Open Vivado and create an RTL project inside `cpu8/vivado/` (no board needed).
2. Add the files in `src/` as design sources and `sim/` as simulation sources, **without** copying them into the project.
3. Set the testbench you want as top under Simulation Sources.
4. Run **Behavioral Simulation** and check the Tcl Console for `PASS`.

## Reference

Harris & Harris, *Digital Design and Computer Architecture*, 2nd ed. (Morgan Kaufmann).
