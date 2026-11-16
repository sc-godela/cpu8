-- tb_basic_gates.vhd : checks all gates against their truth tables
library ieee;
use ieee.std_logic_1164.all;

entity tb_basic_gates is
end tb_basic_gates;

architecture sim of tb_basic_gates is
  signal a, b : std_logic := '0';
  signal y_and, y_or, y_xor, y_not : std_logic;
begin
  u_and : entity work.and2 port map (a => a, b => b, y => y_and);
  u_or  : entity work.or2  port map (a => a, b => b, y => y_or);
  u_xor : entity work.xor2 port map (a => a, b => b, y => y_xor);
  u_not : entity work.not1 port map (a => a, y => y_not);

  process
    -- inputs ab = 00, 01, 10, 11 and the expected output for each
    type in_array is array (0 to 3) of std_logic_vector(1 downto 0);
    constant inputs  : in_array := ("00", "01", "10", "11");
    constant exp_and : std_logic_vector(0 to 3) := "0001";
    constant exp_or  : std_logic_vector(0 to 3) := "0111";
    constant exp_xor : std_logic_vector(0 to 3) := "0110";
    constant exp_not : std_logic_vector(0 to 3) := "1100";
    variable errors  : integer := 0;
  begin
    for i in 0 to 3 loop
      a <= inputs(i)(1);
      b <= inputs(i)(0);
      wait for 10 ns;

      if y_and /= exp_and(i) then
        report "AND failed at test " & integer'image(i) severity error;
        errors := errors + 1;
      end if;
      if y_or /= exp_or(i) then
        report "OR failed at test " & integer'image(i) severity error;
        errors := errors + 1;
      end if;
      if y_xor /= exp_xor(i) then
        report "XOR failed at test " & integer'image(i) severity error;
        errors := errors + 1;
      end if;
      if y_not /= exp_not(i) then
        report "NOT failed at test " & integer'image(i) severity error;
        errors := errors + 1;
      end if;
    end loop;

    if errors = 0 then
      report "PASS: all gate tests passed" severity note;
    else
      report "FAIL: " & integer'image(errors) & " errors" severity error;
    end if;
    wait;  -- stop the process
  end process;
end sim;