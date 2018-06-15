-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Gas_allocation_system
-- Author      : Lyamba007
-- Company     : NURE
--
-------------------------------------------------------------------------------
--
-- File        : I:\DISK D\HDL_designs\Diploma\Gas_allocation_system\compile\GAS_graph.vhd
-- Generated   : 06/15/18 17:58:40
-- From        : I:\DISK D\HDL_designs\Diploma\Gas_allocation_system\src\GAS_graph.asf
-- By          : FSM2VHDL ver. 5.0.7.2
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity GAS_graph is 
	port (
		clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (0 to 7);
		Y: out STD_LOGIC_VECTOR (1 to 14));
end GAS_graph;

architecture GAS_graph_arch of GAS_graph is

-- SYMBOLIC ENCODED state machine: Sreg0
type Sreg0_type is (
    A1, A2, A3, A4, A5, A6, A7, A8, A9
);
signal Sreg0, NextState_Sreg0: Sreg0_type;

-- attribute enum_encoding of Sreg0_type: type is ... -- enum_encoding attribute is not supported for symbolic encoding

attribute fsm_extract: string;
attribute fsm_extract of Sreg0: signal is "yes";

attribute fsm_fftype: string;
attribute fsm_fftype of Sreg0: signal is "d";

attribute fsm_style: string;
attribute fsm_style of Sreg0: signal is "bram";

attribute safe_implementation: string;
attribute safe_implementation of Sreg0: signal is "no";

-- Declarations of pre-registered internal signals
signal int_Y, next_Y: STD_LOGIC_VECTOR (1 to 14);

begin


----------------------------------------------------------------------
-- Machine: Sreg0
----------------------------------------------------------------------
------------------------------------
-- Next State Logic (combinatorial)
------------------------------------
Sreg0_NextState: process (X, Sreg0)
begin
	NextState_Sreg0 <= Sreg0;
	-- Set default values for outputs and signals
	-- ...
	case Sreg0 is
		when A1 =>
			if X(0)/Y(1) then	
				NextState_Sreg0 <= A2;
			elsif ~X(0)/- then	
				NextState_Sreg0 <= A1;
			end if;
		when A2 =>
			if 1/Y(2) then	
				NextState_Sreg0 <= A3;
			end if;
		when A3 =>
			if X(1)/Y(3) then	
				NextState_Sreg0 <= A4;
			elsif ~X(1)/Y(8) then	
				NextState_Sreg0 <= A1;
			end if;
		when A4 =>
			if X(2)/Y(4) then	
				NextState_Sreg0 <= A5;
			elsif ~X(2)/Y(9) then	
				NextState_Sreg0 <= A1;
			end if;
		when A5 =>
			if X(3)/Y(5) then	
				NextState_Sreg0 <= A6;
			elsif ~X(3)/Y(12) then	
				NextState_Sreg0 <= A5;
			end if;
		when A6 =>
			if X(4)/Y(6) then	
				NextState_Sreg0 <= A7;
			elsif ~X(4)/Y(10) then	
				NextState_Sreg0 <= A1;
			end if;
		when A7 =>
			if ~X(5)/Y(13) then	
				NextState_Sreg0 <= A9;
			elsif X(5)/Y(7) then	
				NextState_Sreg0 <= A8;
			end if;
		when A8 =>
			if X(6)/- then	
				NextState_Sreg0 <= A1;
			elsif ~X(6)/Y(11) then	
				NextState_Sreg0 <= A1;
			end if;
		when A9 =>
			if X(7)/Y(7) then	
				NextState_Sreg0 <= A8;
			elsif ~X(7)/Y(14) then	
				NextState_Sreg0 <= A1;
			end if;
--vhdl_cover_off
		when others =>
			null;
--vhdl_cover_on
	end case;
end process;

------------------------------------
-- Current State Logic (sequential)
------------------------------------
Sreg0_CurrentState: process (clk)
begin
	if rising_edge(clk) then
		Sreg0 <= NextState_Sreg0;
	end if;
end process;

end GAS_graph_arch;
