-- tb_alu.vhd : self-checking testbench for the ALU (11 tests)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_pkg.all;

entity tb_alu is
end tb_alu;

architecture sim of tb_alu is
  signal a, b, y : word_t := (others => '0');
  signal op      : alu_op_t := ALU_ADD;
  signal z, c    : std_logic;

  -- one row = one test: inputs and expected outputs
  type test_t is record
    a, b  : word_t;
    op    : alu_op_t;
    y     : word_t;     -- expected result
    z, c  : std_logic;  -- expected flags
  end record;
  type test_arr is array (natural range <>) of test_t;

  constant tests : test_arr := (
    --  A      B      op        Y      Z    C
    ( x"05", x"03", ALU_ADD,  x"08", '0', '0'),  --  0: 5 + 3 = 8
    ( x"C8", x"64", ALU_ADD,  x"2C", '0', '1'),  --  1: 200 + 100 = 300 -> 44, carry
    ( x"FF", x"01", ALU_ADD,  x"00", '1', '1'),  --  2: 255 + 1 = 0, zero and carry
    ( x"0A", x"03", ALU_SUB,  x"07", '0', '0'),  --  3: 10 - 3 = 7
    ( x"03", x"0A", ALU_SUB,  x"F9", '0', '1'),  --  4: 3 - 10 -> 249, borrow
    ( x"05", x"05", ALU_SUB,  x"00", '1', '0'),  --  5: 5 - 5 = 0, zero
    ( x"F0", x"3C", ALU_AND,  x"30", '0', '0'),  --  6: AND
    ( x"F0", x"0F", ALU_OR,   x"FF", '0', '0'),  --  7: OR
    ( x"AA", x"FF", ALU_XOR,  x"55", '0', '0'),  --  8: XOR
    ( x"0F", x"00", ALU_NOT,  x"F0", '0', '0'),  --  9: NOT A (B ignored)
    ( x"00", x"2A", ALU_PASS, x"2A", '0', '0')   -- 10: pass B through
  );
begin
  dut : entity work.alu port map (a => a, b => b, op => op, y => y, z => z, c => c);

  process
    variable errors : integer := 0;
  begin
    for i in tests'range loop
      a  <= tests(i).a;
      b  <= tests(i).b;
      op <= tests(i).op;
      wait for 10 ns;

      if y /= tests(i).y or z /= tests(i).z or c /= tests(i).c then
        report "Test " & integer'image(i) & " FAILED: y="
               & integer'image(to_integer(unsigned(y)))
               & " (expected " & integer'image(to_integer(unsigned(tests(i).y)))
               & "), z=" & std_logic'image(z) & ", c=" & std_logic'image(c)
               severity error;
        errors := errors + 1;
      end if;
    end loop;

    if errors = 0 then
      report "PASS: all " & integer'image(tests'length) & " ALU tests passed" severity note;
    else
      report "FAIL: " & integer'image(errors) & " of "
             & integer'image(tests'length) & " tests failed" severity error;
    end if;
    wait;
  end process;
end sim;