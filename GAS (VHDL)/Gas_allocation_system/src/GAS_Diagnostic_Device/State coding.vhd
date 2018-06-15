--The diagnostic device that generates a set of conditions for the operation of the control device
--a set of conditions (8-bit register X) is a check of the sequence of transitions
--on which the control automaton must pass to check for correctness	working	
	
-- The feature of device is concrete state that can not be changed 
-- (this code can optimized using ROM)

library IEEE;
use IEEE.std_logic_1164.all;
--Package for creating array of states
--Each state is signal of std_logic_vector 
--(state is an item of array) 
PACKAGE heap_arr_pkg IS
	type TestSequence is array (1 to 10) of std_logic_vector (1 to 4);
END; 


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Use package for creating array of states (array of std_logic_vector)
USE work.heap_arr_pkg.all;

entity GAS_DD_Listing3 is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		D: in TestSequence;
		Yx: out STD_LOGIC_VECTOR (0 to 7));
end GAS_DD_Listing3;

architecture arch of GAS_DD_Listing3 is
	
	signal State, NextState: std_logic_vector(3 downto 0);
	
	constant A1: std_logic_vector(3 downto 0):= "0001";
	constant A2: std_logic_vector(3 downto 0):= "0010";
	constant A3: std_logic_vector(3 downto 0):= "0011";
	constant A4: std_logic_vector(3 downto 0):= "0100";
	constant A5: std_logic_vector(3 downto 0):= "0101";
	constant A6: std_logic_vector(3 downto 0):= "0110";
	constant A7: std_logic_vector(3 downto 0):= "0111";
	constant A8: std_logic_vector(3 downto 0):= "1000";
	constant A9: std_logic_vector(3 downto 0):= "1001";
	
	-- Signal for copying input sequence from external memory			
	signal DD: TestSequence;
	
begin
	
	State_CurrentState: process (clk,reset)
	begin 
		if rising_edge(clk) then
			
			if reset='1' then
				-- Copying input sequence from external memory
				DD <= D;
				State <= A1;		   		  
				
			else
				State <= NextState;
				
			end if;	  
		end if;
	end process;	
	
	-- Sensitivity list must include control signals
	-- (State for case enumeration and input register
	-- for transit condition)
	State_NextState: process (State, DD)
	begin  
		
		Yx<= (others=>'0');
		
		case State is
			
			when "0001" =>
				if(DD(2) = "0010") then
					NextState <= A2;
					Yx(0) <= '1';
				else
					NextState <= A1;	
				end if;	
			
			when "0010" =>
				NextState <= A3;
			
			when "0011" =>
				if(DD(4) = "0100") then
					NextState <= A4;
					Yx(1) <= '1';
				else
					NextState <= A1;
				end if;	
			
			when "0100" =>
				if(DD(5) = "0101") then
					NextState <= A5;
					Yx(2) <= '1';
				else
					NextState <= A1;
				end if;			  
			
			when "0101" =>
				if(DD(6) = "0110") then
					NextState <= A6;
					Yx(3) <= '1';
				elsif (DD(6) = "0101") then	
					NextState <= A5;
				else
					NextState <= A1;
				end if;
			
			when "0110" =>
				if(DD(7) = "0111") then
					NextState <= A7;
					Yx(4) <= '1';
				else 
					NextState <= A1;
				end if;	 
				
			-- WARNING! we can transit from A7 only to A8 or A9
			when "0111" =>
				if(DD(8) = "1000") then
					NextState <= A8;
					Yx(5) <= '1';
				elsif (DD(8) = "1001") then
					NextState <= A9;
				else
					NextState <= A1;
				end if;	
				
				--WARNING! problem with a multiple transition from A8 to A1
				--when "1000" =>
				--if(D(9) = "0001") then
			
			when "1001" =>
				if(DD(9) = "1000") then
					NextState <= A8;
					Yx(7) <= '1';
				else
					NextState <= A1;
				end if;	
				
			-- No null for synthesis machine template!!!
			when others => NextState <= A1;
		end case; 	 
		
	end process;	
end arch;
