-- alu.vhd : 8-bit ALU with zero (Z) and carry/borrow (C) flags
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_pkg.all;

entity alu is
  port ( a  : in  word_t;      -- operand A (usually Rd)
         b  : in  word_t;      -- operand B (Rs or immediate)
         op : in  alu_op_t;    -- which operation, see cpu_pkg
         y  : out word_t;      -- result
         z  : out std_logic;   -- '1' when result = 0
         c  : out std_logic ); -- carry (ADD) or borrow (SUB)
end alu;

architecture behavioral of alu is
begin
  process (a, b, op)
    variable r9  : unsigned(DATA_WIDTH downto 0);   -- 9 bits: bit 8 catches carry/borrow
    variable res : word_t;
    variable cy  : std_logic;
  begin
    cy := '0';                                      -- default: no carry
    case op is
      when ALU_ADD =>
        r9  := ('0' & unsigned(a)) + ('0' & unsigned(b));
        res := std_logic_vector(r9(DATA_WIDTH-1 downto 0));
        cy  := r9(DATA_WIDTH);                      -- '1' if result > 255
      when ALU_SUB =>
        r9  := ('0' & unsigned(a)) - ('0' & unsigned(b));
        res := std_logic_vector(r9(DATA_WIDTH-1 downto 0));
        cy  := r9(DATA_WIDTH);                      -- '1' if A < B (borrow)
      when ALU_AND  => res := a and b;
      when ALU_OR   => res := a or b;
      when ALU_XOR  => res := a xor b;
      when ALU_NOT  => res := not a;
      when ALU_PASS => res := b;
      when others   => res := (others => '0');
    end case;

    y <= res;
    c <= cy;
    if res = "00000000" then
      z <= '1';
    else
      z <= '0';
    end if;
  end process;
end behavioral;