-- basic_gates.vhd : simple 2-input gates and an inverter
library ieee;
use ieee.std_logic_1164.all;

entity and2 is
  port ( a, b : in std_logic; y : out std_logic );
end and2;
architecture rtl of and2 is
begin
  y <= a and b;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
entity or2 is
  port ( a, b : in std_logic; y : out std_logic );
end or2;
architecture rtl of or2 is
begin
  y <= a or b;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
entity xor2 is
  port ( a, b : in std_logic; y : out std_logic );
end xor2;
architecture rtl of xor2 is
begin
  y <= a xor b;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
entity not1 is
  port ( a : in std_logic; y : out std_logic );
end not1;
architecture rtl of not1 is
begin
  y <= not a;
end rtl;