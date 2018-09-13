--------------------------------------------
-- Debouncer
--
-- Debounces signals from button presses, by making the system wait
-- 10ms between reading button presses.
--
-- Design based on "Debounce Logic Circuit (with VHDL example)"
-- by S. Larson, https://eewiki.net/pages/viewpage.action?pageId=4980758
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    Port ( clk : in  STD_LOGIC;
           signal_in : in  STD_LOGIC;
           signal_out : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
signal Input_to_Delay : STD_LOGIC;
signal Delay_to_Output : STD_LOGIC;
signal counter_out : STD_LOGIC;
signal counter_clear : STD_LOGIC;
signal counter_enable : STD_LOGIC;

begin
	Input_DFF:entity work.DFF PORT MAP(
		clk => clk,
		Enable => '1',
		Data_in => signal_in,
		Data_out => Input_to_Delay
	);
	
	Delay_DFF:entity work.DFF PORT MAP(
		clk => clk,
		Enable => '1',
		Data_in => Input_to_Delay,
		Data_out => Delay_to_Output
	);
	
	
	Output_DFF:entity work.DFF PORT MAP(
		clk => clk,
		Enable => counter_out,
		Data_in => Delay_to_Output,
		Data_out => signal_out
	);
	
	counter_clear <= ((Input_to_Delay xor Delay_to_output));
	counter_enable <= not counter_out;
	Inst_counter:entity work.counter PORT MAP(
		clk => clk,
		rst => counter_clear,
		Enable => counter_enable,
		Carry_out => counter_out
	);

end Behavioral;
