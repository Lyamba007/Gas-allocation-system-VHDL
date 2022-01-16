--The diagnostic device that generates a set of conditions for the operation of the control device
--a set of conditions (8-bit register X) is a check of the sequence of transitions
--on which the control automaton must pass to check for correctness	working	
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Package for creating array of integers (redo to array of strings???)
PACKAGE heap_arr_pkgs IS
	type TestSequence is array (5 downto 0) of std_logic_vector (2 downto 0);
END; 

-- Use package for creating array of integers (redo to array of strings???)
USE work.heap_arr_pkgs.all; 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity ACS_172 is 	
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		D: in TestSequence;
		Yx1: out STD_LOGIC;
		Yx2: out STD_LOGIC);
	
end ACS_172;
architecture ACS of ACS_172 is

	
	signal State,NextState:std_logic_vector(2 downto 0);
	signal DD: TestSequence;
	
	
begin 
	
	State_CurrentState: process (clk,reset, DD)
	begin 
		
		if rising_edge(clk) then
		 
		 		if (reset='1' or NextState = "000") then
					
					State <= D(5); NextState <= D(4);
					DD <= D;
					
				else
				
				  State <= DD(4); NextState <= DD(3);	
				  DD <= DD(4 downto 0)&"000";
				  
				end if;
		end if;
	end process;	
	
	State_process: process (State,NextState,reset)
	begin
		
		Yx1 <= '0';
		Yx2 <= '0';
		case State is		
			
			when "001" => 
				if(NextState = "010") then
					Yx1 <= '1';	
				elsif(NextState = "011") then
					Yx2 <= '0';
				elsif(NextState = "100") then
					Yx2 <= '1';		
				end if;
			
			when "010" =>			   
				if(NextState = "011") then
					Yx2 <= '0';
				elsif (NextState = "100") then
					Yx2 <= '1';
				end if;
			
			when "011" =>
				if(NextState = "101") then
					Yx1 <= '1';	
				end if;	  
				
			when "100" =>  
				if(NextState = "101") then
					Yx1 <= '1';
				end if;			
			
			when others => null;
		end case; 
		
	end process;

end ACS;
		

