library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_in_1 is
	port(
		x1:in STD_LOGIC_VECTOR(0 to 7); 
		x2:in STD_LOGIC_VECTOR(0 to 7);
		adr:in STD_LOGIC;
		Y:out STD_LOGIC_VECTOR(0 to 7)
		);
end MUX_2_in_1;

architecture arch of MUX_2_in_1 is
begin
	
	Y <= x1 when (adr = '0') else x2;
	
end arch;
