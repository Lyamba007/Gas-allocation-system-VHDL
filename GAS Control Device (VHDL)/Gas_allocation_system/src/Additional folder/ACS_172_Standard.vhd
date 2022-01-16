library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Package for creating array of integers (redo to array of strings???)
PACKAGE heap_arr_pkg IS
    type TestSequence is array (0 to 5) of std_logic_vector (2 downto 0);
END; 

-- Use package for creating array of integers (redo to array of strings???)
USE work.heap_arr_pkg.all; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ACS_172_Standard is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		D: in TestSequence;
		Yx1: out STD_LOGIC;
		Yx2: out STD_LOGIC);
end ACS_172_Standard;

architecture arch of ACS_172_Standard is
	
	
signal State, NextState: std_logic_vector(2 downto 0);
signal A0: std_logic_vector(2 downto 0):= "000";
signal A1: std_logic_vector(2 downto 0):= "001";
signal A2: std_logic_vector(2 downto 0):= "010";
signal A3: std_logic_vector(2 downto 0):= "011";
signal A4: std_logic_vector(2 downto 0):= "100";
signal A5: std_logic_vector(2 downto 0):= "101";

	
begin
	
	State_CurrentState: process (clk,reset)
	begin 
		
		if rising_edge(clk) then
			if reset='1' then	
				State <= A1;
			else
				State <= NextState;
			end if;
		end if;
	end process;	
	
	State_NextState: process (State, NextState)
	begin  
		
		case State is
			
			when "000" =>
				NextState <= A1;
			
			when "001" =>
				if(D(2) = "010") then
					NextState <= A2;
				elsif(D(2) = "011") then
					NextState <= A3;
				elsif(D(2) = "100") then
					NextState <= A4;
				end if;
			
			when "010" =>
			
				if(D(3) = "011") then		
					NextState <= A3;
				elsif(D(3) = "100") then
					NextState <= A4;	 
				end if;
				
			when "011" => 
				if(D(4) = "101") then
					NextState <= A5;
				else
					NextState <= A0;
				end if;	  
				
			-- duplicate code from "011" !!!	
			when "100" =>  
				if(D(4) = "101") then
					NextState <= A5;
				else
					NextState <= A0;
				end if;	 	
			
			when "101" =>
				NextState <= A0;
			
			when others => null;
		end case; 	 
		
	end process;
	
	Yx1<= '1' when (State = A1 and D(2) = "010") or ((State = A3 or State = A4) and D(4) = "101") else '0';
	Yx2<= '1' when (State = A1 and D(2) = "100") or (State = A2 and D(3) = "100") else '0';
	
end arch;
