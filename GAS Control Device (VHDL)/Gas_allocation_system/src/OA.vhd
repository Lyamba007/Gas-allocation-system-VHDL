library ieee;
use ieee.std_logic_1164.all;

entity OA is
	port(
		clk:in STD_LOGIC;
		reset:in STD_LOGIC;
		Y:in STD_LOGIC_VECTOR(0 to 13);
		Xc:out STD_LOGIC_VECTOR(0 to 7)
		);
end OA;

architecture arch of OA is
begin
	
	Xc<="00000000";
	
end arch;
