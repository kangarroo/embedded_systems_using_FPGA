------------------------------------------
-- D Type Flip Flop
-- This modules stores a signal for 1 clock cycle
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
    Port ( clk : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           Data_in : in  STD_LOGIC;
           Data_out : out  STD_LOGIC);
end DFF;

architecture Behavioral of DFF is

begin

process(clk)
begin
	if(rising_edge(clk)) then
		if(Enable = '1') then
			Data_out <= Data_in;
		elsif(Enable = '0') then
			Data_out <= '0';
		end if;
	end if;
end process;

end Behavioral;

