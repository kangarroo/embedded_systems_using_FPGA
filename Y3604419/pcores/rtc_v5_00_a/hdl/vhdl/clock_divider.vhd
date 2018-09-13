-----------------------------------------------------------
-- Clock Divider
-- This hardware converts the 100MHz clock to a 1Hz Clock
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           clk_1Hz : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

signal counter : INTEGER := 1;
signal clk_out : STD_LOGIC := '0';

begin
 process(clk)
 begin
	if(rising_edge(clk)) then
		if(rst = '1') then
			counter <= 1;
			clk_out <= '0';
		elsif(counter = 50000000) then
			counter <= 1;
			clk_out <= not clk_out;
		else
			counter <= counter + 1; 
		end if;
	end if;
 end process;
 
  clk_1Hz <= clk_out;
end Behavioral;

