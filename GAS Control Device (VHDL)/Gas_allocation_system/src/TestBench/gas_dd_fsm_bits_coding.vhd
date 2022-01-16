library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity gas_dd_fsm_tb is
end gas_dd_fsm_tb;

architecture TB_ARCHITECTURE of gas_dd_fsm_tb is
	-- Component declaration of the tested unit
	component gas_dd_fsm
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(1 to 9);
		Yx : out STD_LOGIC_VECTOR(0 to 7) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal D : STD_LOGIC_VECTOR(1 to 9);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Yx : STD_LOGIC_VECTOR(0 to 7);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : gas_dd_fsm
		port map (
			clk => clk,
			reset => reset,
			D => D,
			Yx => Yx
		);

	clk_process: process
		
	begin
		
		clk <= '0';
		
		wait for 50 ns;
		
		clk<='1';
		
		wait for 50 ns;
		
		wait for 0 ns;
		
	end process;
	
	some_process:process
		
	begin  
		reset<='1';
		
		-- Each bit of input array characterizes not crash transition ('1') between state
		-- and crash transition ('0')
		D<="101111000";
	
    	wait for 60 ns;
		
		reset <= '0';
		
        wait for 300 ns;

		reset<='1';
		
        D <="111111000";

		wait for 150 ns;
		
		reset <= '0';
		
        wait for 300 ns;
      
    
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_gas_dd_fsm of gas_dd_fsm_tb is
	for TB_ARCHITECTURE
		for UUT : gas_dd_fsm
			use entity work.gas_dd_fsm(arch);
		end for;
	end for;
end TESTBENCH_FOR_gas_dd_fsm;

