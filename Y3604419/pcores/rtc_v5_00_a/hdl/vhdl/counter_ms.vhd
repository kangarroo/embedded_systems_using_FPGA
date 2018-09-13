----------------------------------------------------
-- Counter
-- This is the generic counter used for the Hours, Minutes and Seconds
-- The counter "Rolls over" at 60 seconds/ Minutes, however the rollover
-- User can also set time using the load line.
-- for the hours in set in the Top Level
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clk : in STD_LOGIC; --100MHz Clock
			  counter_increment : in  STD_LOGIC; --1 Hz Clock
			  load_flag : in STD_LOGIC;
           load : in  STD_LOGIC_VECTOR (5 downto 0);
           clear : in  STD_LOGIC;
           counter_carry : out  STD_LOGIC;
           counter_val : out  STD_LOGIC_VECTOR (5 downto 0));
end counter;

architecture Behavioral of counter is

signal counter_6bit : UNSIGNED(5 downto 0);

begin
process(counter_increment,clk)
 begin
	 if rising_edge(counter_increment) then
		if(counter_6bit < "111011") then
			counter_6bit <= counter_6bit + 1;
			counter_carry <= '0';
		else
			counter_carry <= '1';
		end if;
	 end if;
	 
	 if rising_edge(clk) then
		if (clear ='1') then
			counter_6bit <= (others => '0');
			counter_carry <= '0';
		elsif (load_flag = '1') then
			counter_6bit <= unsigned(load);
			counter_carry <= '0';
		end if;
	 end if;
	 

 end process ;
 
 counter_val <= std_logic_vector(counter_6bit);
end Behavioral;

