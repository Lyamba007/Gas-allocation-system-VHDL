-- Control and diagnostic system 
-- Contains Diagnostic and Control devices
-- Shows system working process and can execute test mode

library IEEE;
use IEEE.STD_LOGIC_1164.all;											   

entity Workstation is 
	
	port(	
			clk,reset : in STD_LOGIC;
	 		--Ddia: in TestSequence;
	 		Y:out STD_LOGIC_VECTOR(1 to 14)
	     );
end Workstation;

architecture Workstation of Workstation is

	component GAS_FSM is 
		port(
				clk: in STD_LOGIC;
				reset: in STD_LOGIC;
				X: in STD_LOGIC_VECTOR (0 to 7);
				Y: out STD_LOGIC_VECTOR (1 to 14)
			);
	end component GAS_FSM;
	
	component GAS_Diagnostic_Device is 
		port(
				clk: in STD_LOGIC;
				reset: in STD_LOGIC;
				--D: in TestSequence;
				Yx: out STD_LOGIC_VECTOR (0 to 7)
			 );
	end component GAS_Diagnostic_Device; 
	
	signal Yx:STD_LOGIC_VECTOR(0 to 7);
begin
	
	UUT0:GAS_Diagnostic_Device
		port map(clk=>clk,reset=>reset,Yx=>Yx);

	UUT2:GAS_FSM
		port map(clk=>clk,reset=>reset,X=>Yx,Y=>Y);
	
end Workstation;
