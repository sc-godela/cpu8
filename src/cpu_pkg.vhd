-- cpu_pkg.vhd : shared constants and types for the 8-bit CPU
library ieee;
use ieee.std_logic_1164.all;

package cpu_pkg is

  -- widths
  constant DATA_WIDTH  : integer := 8;
  constant INSTR_WIDTH : integer := 16;
  constant ADDR_WIDTH  : integer := 8;

  -- common types  (N-1 downto 0 = N bits, e.g. 7 downto 0 = 8 bits)
  subtype word_t    is std_logic_vector(DATA_WIDTH-1 downto 0);   -- 8-bit data
  subtype instr_t   is std_logic_vector(INSTR_WIDTH-1 downto 0);  -- 16-bit instruction
  subtype addr_t    is std_logic_vector(ADDR_WIDTH-1 downto 0);   -- 8-bit address
  subtype opcode_t  is std_logic_vector(3 downto 0);              -- instr(15:12)
  subtype reg_sel_t is std_logic_vector(1 downto 0);              -- selects R0..R3

  -- opcodes (instr(15:12))
  constant OP_NOP   : opcode_t := "0000";  -- do nothing
  constant OP_LOAD  : opcode_t := "0001";  -- Rd <- RAM[addr]
  constant OP_STORE : opcode_t := "0010";  -- RAM[addr] <- Rd
  constant OP_LDI   : opcode_t := "0011";  -- Rd <- imm (load immediate)
  constant OP_ADD   : opcode_t := "0100";  -- Rd <- Rd + Rs
  constant OP_SUB   : opcode_t := "0101";  -- Rd <- Rd - Rs
  constant OP_AND   : opcode_t := "0110";  -- Rd <- Rd and Rs
  constant OP_OR    : opcode_t := "0111";  -- Rd <- Rd or Rs
  constant OP_XOR   : opcode_t := "1000";  -- Rd <- Rd xor Rs
  constant OP_NOT   : opcode_t := "1001";  -- Rd <- not Rd
  constant OP_JMP   : opcode_t := "1010";  -- PC <- addr (always jump)
  constant OP_JZ    : opcode_t := "1011";  -- if Z = 1 then PC <- addr
  constant OP_HALT  : opcode_t := "1111";  -- stop the CPU

  -- ALU operation select (used by the ALU in step 2)
  subtype alu_op_t is std_logic_vector(2 downto 0);
  constant ALU_ADD  : alu_op_t := "000";  -- Y = A + B   (sets C on carry)
  constant ALU_SUB  : alu_op_t := "001";  -- Y = A - B   (sets C on borrow)
  constant ALU_AND  : alu_op_t := "010";  -- Y = A and B
  constant ALU_OR   : alu_op_t := "011";  -- Y = A or B
  constant ALU_XOR  : alu_op_t := "100";  -- Y = A xor B
  constant ALU_NOT  : alu_op_t := "101";  -- Y = not A
  constant ALU_PASS : alu_op_t := "110";  -- Y = B unchanged (used for LDI/LOAD)

end package cpu_pkg;