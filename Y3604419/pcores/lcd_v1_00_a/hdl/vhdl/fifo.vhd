----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:27 02/20/2013 
-- Design Name: 
-- Module Name:    fifo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fifo is
	Generic ( DATA_WIDTH    : integer := 32; -- 32 bits wide
				 ADDRESS_WIDTH : integer := 8); -- 256 entries
	Port ( data_in : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
			 data_out : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
			 write_req : in  STD_LOGIC;
			 write_ack : out  STD_LOGIC;
			 read_req : out  STD_LOGIC;
			 read_ack : in  STD_LOGIC;
			 clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC);
end fifo;

architecture Arch of fifo is
	type READ_STATE_TYPE is ( R_READY, R_WAIT );
	type WRITE_STATE_TYPE is ( W_READY, W_WAIT );
	type memory_type is array (0 to ((2**ADDRESS_WIDTH)-1)) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal memory : memory_type;
	signal read_ptr : unsigned(ADDRESS_WIDTH-1 downto 0);
	signal write_ptr : unsigned(ADDRESS_WIDTH-1 downto 0);
	signal read_state : READ_STATE_TYPE;
	signal write_state : WRITE_STATE_TYPE;	 
begin
	Process (clk, rst) is
		variable full : bit;
		variable empty : bit;
	begin
		if rst = '1' then
			read_state <= R_READY;
			write_state <= W_READY;
			read_ptr <= (others => '0');
			write_ptr <= (others => '0');
		elsif rising_edge(clk) then
			full := '0';
			empty := '0';
			write_ack <= '0';
			read_req <= '0';
			if read_ptr = write_ptr then
				empty := '1';
			elsif read_ptr = (write_ptr + 1) then
				full := '1';
			end if;
			case write_state is
				when W_READY =>
					if write_req = '1' and full = '0' then
						memory(to_integer(write_ptr)) <= data_in;
						write_ack <= '1';
						write_ptr <= write_ptr + 1;
						write_state <= W_WAIT;
					end if;
				when W_WAIT =>
					write_state <= W_READY;
			end case;
			case read_state is
				when R_READY =>
					if empty = '0' then
						read_req <= '1';
						if read_ack = '1' then
							read_req <= '0';
							read_ptr <= read_ptr + 1;
							read_state <= R_WAIT;
						end if;
					end if;
				when R_WAIT =>
					if read_ack = '0' then
						read_state <= R_READY;
					end if;
			end case;
		end if;
	end Process;
	data_out <= memory(to_integer(read_ptr));
end Arch;

