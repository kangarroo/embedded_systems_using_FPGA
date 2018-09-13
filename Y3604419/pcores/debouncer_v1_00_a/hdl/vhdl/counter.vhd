------------------------------------------
-- Counter
-- This counts for about 10ms, rst clears the counter and the carry bit
-- Only outputs carry bit, to alert outside modules of overflow
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity counter is
	 Generic(
			  counter_size: INTEGER := 20);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           Carry_out : out  STD_LOGIC);
end counter;

architecture Behavioral of counter is
signal counter_val : UNSIGNED (counter_size downto 0);

begin

process(clk) is
begin
	if (rising_edge(clk)) then
	 if(rst = '1') then
		Carry_out <= '0';
		counter_val <= (others => '0');
    elsif(Enable = '1') then
		 if(counter_val(counter_size) = '0') then
			counter_val <= counter_val + 1;
		 else
			Carry_out <= '1';
		 end if;
	 end if;
	end if;
end process;
end Behavioral;

