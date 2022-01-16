library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ACS_172_FSM is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		X1,X2: in STD_LOGIC;
		Y:out STD_LOGIC_VECTOR (1 to 5)
		);
		
end ACS_172_FSM;

architecture arch of ACS_172_FSM is
	
	
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
		
		Y <= "00000";
		
		case State is
			
			when "000" =>
					NextState <= A1;
					Y(1) <= '1';
			
			when "001" =>
				if(X1 = '1') then
					NextState <= A2;
					Y(2) <= '1'; 
					
				elsif(X1 = '0' and X2 = '0') then
					NextState <= A3;
					Y(3) <= '1'; 
					
				else
					NextState <= A4;
					Y(4) <= '1';
				end if;
			
			when "010" =>
				if(X2 = '0') then		
					NextState <= A3;
					Y(3)<= '1';
				else
					NextState <= A4;
					Y(4) <= '1';
				end if;
				
			when "011" => 
				if(X1 = '1') then
					NextState <= A5;
					Y(5) <= '1';
				else
					NextState <= A0;
				end if;	  
				
			-- duplicate code from "011" !!!	
			when "100" =>  
				if(X1 = '1') then
					NextState <= A5;
					Y(5) <= '1';
				else
					NextState <= A0;
				end if;	 	
			
			when "101" =>
				NextState <= A0;
			
			when others => null;
		end case; 	 
		
	end process;
		
end arch;
