library gas_allocation_system;
use gas_allocation_system.heap_arr_pkg.all;
library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity gas_diagnostic_device_tb is
end gas_diagnostic_device_tb;

architecture TB_ARCHITECTURE of gas_diagnostic_device_tb is
	-- Component declaration of the tested unit
	component gas_diagnostic_device
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		Yx : out STD_LOGIC_VECTOR(0 to 7) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Yx : STD_LOGIC_VECTOR(0 to 7);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : gas_diagnostic_device
		port map (
			clk => clk,
			reset => reset,
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
		
	wait for 60 ns;
		
		reset <= '0';
		   wait;
	
	end process;	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_gas_diagnostic_device of gas_diagnostic_device_tb is
	for TB_ARCHITECTURE
		for UUT : gas_diagnostic_device
			use entity work.gas_diagnostic_device(arch);
		end for;
	end for;
end TESTBENCH_FOR_gas_diagnostic_device;

