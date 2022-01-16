-- Finite state machine that generate output signals for
-- control object to execute data operations

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity GAS_FSM is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (0 to 7);
		Y: out STD_LOGIC_VECTOR (1 to 14));
end GAS_FSM;

architecture GAS_FSM_arch of GAS_FSM is
	
	
	constant A1: std_logic_vector(3 downto 0):= "0001";
	constant A2: std_logic_vector(3 downto 0):= "0010";
	constant A3: std_logic_vector(3 downto 0):= "0011";
	constant A4: std_logic_vector(3 downto 0):= "0100";
	constant A5: std_logic_vector(3 downto 0):= "0101";
	constant A6: std_logic_vector(3 downto 0):= "0110";
	constant A7: std_logic_vector(3 downto 0):= "0111";
	constant A8: std_logic_vector(3 downto 0):= "1000";
	constant A9: std_logic_vector(3 downto 0):= "1001";
	
	signal State, NextState: std_logic_vector (3 downto 0);
	
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
	
	
	State_NextState: process (X, State, NextState)
	begin  
		Y<= (others=>'0');	
		
		case State is						   
			
			-- X(0) is a bit that is marked on algorithm graph as Z
			when "0001" =>
				if (X(0)='1') then	
					NextState <= A2;
					Y(1) <= '1';
				elsif (X(0) = '0') then
					NextState <= A1;
				else	
					NextState <= A1;
			end if;	
			
			when "0010" =>
				NextState <= A3;
				Y(2) <= '1';
				
			when "0011" =>
				if (X(1)='1') then	
					NextState <= A4;
					Y(3) <= '1';
				elsif (X(1) = '0') then	
					NextState <= A1;
					Y(8) <= '1';
				else
					NextState <= A1;
			end if;	
			
			when "0100" =>
				if (X(2)='1') then	
					NextState <= A5;
					Y(4) <= '1';
				elsif (X(2) = '0') then	
					NextState <= A1;
					Y(9) <= '1';
				else
					NextState <= A1;
			end if;	
			
			when "0101" =>
				if (X(3)='1') then	
					NextState <= A6;
					Y(5) <= '1';
				elsif (X(3)='0') then	
					NextState <= A5;
					Y(12) <= '1';
				else
					NextState <= A1;
			end if;	
			
			when "0110" =>
				if (X(4)='1') then	
					NextState <= A7;
					Y(6) <= '1';
				elsif (X(4) = '0') then
					NextState <= A1;
					Y(10) <= '1';
				else
					NextState <= A1;
			end if;	  
			
			when "0111" =>
				if (X(5)='1') then	
					NextState <= A8;
					Y(7) <= '1';
				elsif (X(5)='0') then	
					NextState <= A9;
					Y(13) <= '1';  
				else 
					NextState <= A1;
			end if;	  
			
			when "1000" =>
				if (X(6)='0') then	
					NextState <= A1;
					Y(11) <= '1';	
				elsif (X(6) = '1') then
					NextState <= A1;
				else
					NextState <= A1;
			end if;	 
			
			when "1001" =>
				if (X(7)='1') then	
					NextState <= A8;
					Y(7) <= '1';
				elsif (X(7) = '1') then	
					NextState <= A1;
					Y(14) <= '1';
				else
					NextState <= A1;	
				end if;
			
			-- No null for synthesis!!!
			when others => NextState <= A1;
			
		end case;
	end process;
	
end GAS_FSM_arch;
