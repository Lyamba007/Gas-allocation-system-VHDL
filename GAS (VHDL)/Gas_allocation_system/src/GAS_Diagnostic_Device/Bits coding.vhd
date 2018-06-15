--The diagnostic device that generates a set of conditions for the operation of the control device
--a set of conditions (8-bit register X) is a check of the sequence of transitions
--on which the control automaton must pass to check for correctness	working	

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity GAS_DD_FSM is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		D: in STD_LOGIC_VECTOR (1 to 9);
		Yx: out STD_LOGIC_VECTOR (0 to 7));
end GAS_DD_FSM;

architecture arch of GAS_DD_FSM is
	
	signal State, NextState: std_logic_vector(3 downto 0);
	
	-- Not good set signals because they always 
	-- must be initialized!!!
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
	signal DD: std_logic_vector (1 to 9);
	
begin
	
	State_CurrentState: process (clk,reset)
	begin 
				
		if rising_edge(clk) then 
			
			if reset='1' then

				-- Copying input sequence from external memory
				DD <= D;	
				State <= A1;
			else State <= NextState;
			end if;	
		end if;
	end process;											    
	
	-- Sensitivity list must include control signals
	-- (State for case enumeration and input register
	-- for transit condition)
	State_NextState: process (State,DD)
	begin  
		
		Yx<= (others=>'0');
		
		case State is

			when "0001" =>
				if(DD(2) = '1') then
					NextState <= A2;
					Yx(0) <= '1';
				elsif (DD(2) = '0') then
					NextState <= A1;
				else	  
					NextState <= A1;
				end if;	
			 
			when "0010" =>
					NextState <= A3;
				
			when "0011" =>
				if(DD(4) = '1') then
					NextState <= A4;
					Yx(1) <= '1';
				elsif(DD(4) = '0') then
					NextState <= A1;
				else
					NextState <= A1;
				end if;	
					
			when "0100" =>
				if(DD(5) = '1') then
					NextState <= A5;
					Yx(2) <= '1';
				elsif (DD(5) = '0') then
					NextState <= A1;
				else
					NextState <= A1;
				end if;			  
				
			when "0101" =>
				if(DD(6) = '1') then
					NextState <= A6;
					Yx(3) <= '1';
				elsif (DD(6) = '0') then
					NextState <= A5;
				else
					NextState <= A1;
				end if;
			
			when "0110" =>
				if(DD(7) = '1') then
					NextState <= A7;
					Yx(4) <= '1';
				elsif (DD(7) = '0') then
					NextState <= A1;
				else	
					NextState <= A1;
				end if;	 
				
			-- WARNING! we can transit from A7 only to A8 or A9
			when "0111" =>
				if(DD(8) = '1') then
					NextState <= A8;
					Yx(5) <= '1';
				elsif (DD(8) = '0') then
					NextState <= A9;
				else
					NextState <= A1;
				end if;	
				
				--WARNING! problem with a multiple transition from A8 to A1
					--when "1000" =>
					--if(D(9) = "0001") then

			when "1001" =>
				if(DD(9) = '1') then
					NextState <= A8;
					Yx(7) <= '1';
				elsif(DD(9) = '0') then
					NextState <= A1;
				else
					NextState <= A1;
				end if;
			 
			-- No null for synthesis machine template!!!	
			when others => NextState <= A1;
		end case; 	 
		
	end process;
	
end arch;
