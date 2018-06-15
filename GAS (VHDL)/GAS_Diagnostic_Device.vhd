--The diagnostic device that generates a set of conditions for the operation of the control device
--a set of conditions (8-bit register X) is a check of the sequence of transitions
--on which the control automaton must pass to check for correctness	working	

library IEEE;
use IEEE.std_logic_1164.all;

--Package for creating array of states
--Each state is signal of std_logic_vector 
PACKAGE heap_arr_pkg IS
	type TestSequence is array (1 to 10) of std_logic_vector (1 to 4);
	-- Describe sequence that ROM keeps
	-- For example it's only one sequence
	constant c_Test_sequence: TestSequence := ("0001","0010","0011","0100","0101","0110","0111","1001","1000","0001");
END; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 

-- Use package for creating array of states (array of std_logic_vector)
USE work.heap_arr_pkg.all; 

entity GAS_Diagnostic_Device is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		-- No input for reading from ROM
		--D: in TestSequence;
		Yx: out STD_LOGIC_VECTOR (0 to 7));
end GAS_Diagnostic_Device;

architecture arch of GAS_Diagnostic_Device is

	-- If waveform has 'U' in starting point 
	--(when reset is 1 and before rising edge)
	-- State and NextState can be initialized there
	signal State: std_logic_vector(1 to 4); 
	signal NextState: std_logic_vector(1 to 4);
	
	--Signal for copying test sequence (reading constant)
	signal DD : TestSequence;
	
	
begin
	--Process for initialization and switching DD array
	State_CurrentState: process (clk,reset,DD)
	begin
		if rising_edge(clk) then
			
			--ATTENTION! Reset (reset) must load 
			--only first sequence in ROM every time
			if (reset='1') then
			
				--Copying the first sequence from ROM to signal
				DD <= c_Test_sequence;
			
			-- Synchronize process must not working with signals
			-- that operated in other process (State, NextState)
			-- so NextState has a role DD(2)   
			-- Array item needs to be checked if it initial state or not 
			elsif(DD(2) = "0001") then
				
				--Copying from ROM to signal
				--ATTENTION!If we using all sequences there must be shifting
				--an array of all sequences (another sequence except first)
				DD <= c_Test_sequence;	
				
			else
				DD <= DD(2 to 10)&"0001";	
			end if;
			
			--Initiation State and NextState after shifting
			State <= DD(1); NextState <= DD(2);
		end if;
	end process;											    
	
	State_NextState: process (State, NextState)
	begin  
		
		Yx<= (others=>'0');
		
		case State is
			
			when "0001" =>
				if(NextState = "0010") then
					Yx(0) <= '1';
				end if;
			
			when "0011" => 
				if(NextState = "0100") then
					Yx(1) <= '1';	
				end if;	 
			
			when "0100" => 
				if(NextState = "0101") then
					Yx(2) <= '1';
				end if;	
			
			when "0101" =>
				if(NextState = "0110") then
					Yx(3) <= '1';	
				end if;
			
			when "0110" =>
				if(NextState = "0111") then
					Yx(4) <= '1';
				end if;	 

			when "0111" =>
				if(NextState = "1000") then
					Yx(5) <= '1';
				end if;	
				
				--WARNING! problem with a multiple transition from A8 to A1
				--when "1000" =>
				--	if(NextState = "0001") then
				
			
			when "1001" =>
				if(NextState = "1000") then
					Yx(7) <= '1';						
				end if;
				
			-- In this case null is synthesized
			-- BUT, desirable, use another operator
			-- or operation for avoiding non-synthesize
			when others => null;
		end case; 	 
		
	end process;	
end arch;
