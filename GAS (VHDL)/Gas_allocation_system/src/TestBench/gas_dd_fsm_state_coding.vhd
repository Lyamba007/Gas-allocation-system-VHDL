library gas_allocation_system;
use gas_allocation_system.heap_arr_pkg.all;
library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity gas_dd_fsm_listing_3_tb is
end gas_dd_fsm_listing_3_tb;

architecture TB_ARCHITECTURE of gas_dd_fsm_listing_3_tb is
	-- Component declaration of the tested unit
	component gas_dd_fsm_listing_3
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		D : in TestSequence;
		Yx : out STD_LOGIC_VECTOR(0 to 7) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal D : TestSequence;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Yx : STD_LOGIC_VECTOR(0 to 7);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : gas_dd_fsm_listing_3
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
		
		-- Each item of input array is 4-bits field
		-- Each 4-bits field means current state of test sequence
		D(1)<= "0001";
		D(2)<= "0010";
		D(3)<= "0011";
		D(4)<= "0100";
		D(5)<= "0101";
		D(6)<= "0110";
		
		-- It means the end of transitions 
		-- It returnes to initial state
		D(7)<= "0001";
		
		-- No matter what is in these items, because 
		-- current transition endings at D(7) = "0001"
		D(8)<= "0010";
		D(9)<= "0011";
		D(10)<= "0001";
		
		
		wait for 60 ns;
		
		reset <= '0';
		   wait;
	
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_gas_dd_fsm_listing_3 of gas_dd_fsm_listing_3_tb is
	for TB_ARCHITECTURE
		for UUT : gas_dd_fsm_listing_3
			use entity work.gas_dd_fsm_listing_3(arch);
		end for;
	end for;
end TESTBENCH_FOR_gas_dd_fsm_listing_3;

