library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;   

PACKAGE heap_arr_pkg IS
   type coeff_ram_address is array (1 to 2) of character; 
   type coeff_array is array (1 to 10) of string(1 to 2);
END; 

USE work.heap_arr_pkg.all; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity example is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		D: in coeff_array;
		Yx: out STD_LOGIC_VECTOR (0 to 7));
end example;

architecture arch of example is
	  begin
	end;