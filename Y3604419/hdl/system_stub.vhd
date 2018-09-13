-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    zio : inout std_logic;
    rzq : inout std_logic;
    mcbx_dram_we_n : out std_logic;
    mcbx_dram_udqs_n : inout std_logic;
    mcbx_dram_udqs : inout std_logic;
    mcbx_dram_udm : out std_logic;
    mcbx_dram_ras_n : out std_logic;
    mcbx_dram_odt : out std_logic;
    mcbx_dram_ldm : out std_logic;
    mcbx_dram_dqs_n : inout std_logic;
    mcbx_dram_dqs : inout std_logic;
    mcbx_dram_dq : inout std_logic_vector(15 downto 0);
    mcbx_dram_clk_n : out std_logic;
    mcbx_dram_clk : out std_logic;
    mcbx_dram_cke : out std_logic;
    mcbx_dram_cas_n : out std_logic;
    mcbx_dram_ba : out std_logic_vector(2 downto 0);
    mcbx_dram_addr : out std_logic_vector(12 downto 0);
    RS232_Uart_1_sout : out std_logic;
    RS232_Uart_1_sin : in std_logic;
    RESET : in std_logic;
    LEDs_8Bits_TRI_O : out std_logic_vector(7 downto 0);
    GCLK : in std_logic;
    DIP_Switches_8Bits_TRI_I : in std_logic_vector(7 downto 0);
    lcd_0_LCD_data_pin : out std_logic_vector(3 downto 0);
    lcd_0_LCD_RS_pin : out std_logic;
    lcd_0_LCD_RW_pin : out std_logic;
    lcd_0_LCD_E_pin : out std_logic;
    lcd_0_LCD_Enable_pin : out std_logic;
    debouncer_0_signal_in_pin : in std_logic;
    debouncer_1_signal_in_pin : in std_logic;
    debouncer_2_signal_in_pin : in std_logic;
    debouncer_3_signal_in_pin : in std_logic;
    debouncer_4_signal_in_pin : in std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      zio : inout std_logic;
      rzq : inout std_logic;
      mcbx_dram_we_n : out std_logic;
      mcbx_dram_udqs_n : inout std_logic;
      mcbx_dram_udqs : inout std_logic;
      mcbx_dram_udm : out std_logic;
      mcbx_dram_ras_n : out std_logic;
      mcbx_dram_odt : out std_logic;
      mcbx_dram_ldm : out std_logic;
      mcbx_dram_dqs_n : inout std_logic;
      mcbx_dram_dqs : inout std_logic;
      mcbx_dram_dq : inout std_logic_vector(15 downto 0);
      mcbx_dram_clk_n : out std_logic;
      mcbx_dram_clk : out std_logic;
      mcbx_dram_cke : out std_logic;
      mcbx_dram_cas_n : out std_logic;
      mcbx_dram_ba : out std_logic_vector(2 downto 0);
      mcbx_dram_addr : out std_logic_vector(12 downto 0);
      RS232_Uart_1_sout : out std_logic;
      RS232_Uart_1_sin : in std_logic;
      RESET : in std_logic;
      LEDs_8Bits_TRI_O : out std_logic_vector(7 downto 0);
      GCLK : in std_logic;
      DIP_Switches_8Bits_TRI_I : in std_logic_vector(7 downto 0);
      lcd_0_LCD_data_pin : out std_logic_vector(3 downto 0);
      lcd_0_LCD_RS_pin : out std_logic;
      lcd_0_LCD_RW_pin : out std_logic;
      lcd_0_LCD_E_pin : out std_logic;
      lcd_0_LCD_Enable_pin : out std_logic;
      debouncer_0_signal_in_pin : in std_logic;
      debouncer_1_signal_in_pin : in std_logic;
      debouncer_2_signal_in_pin : in std_logic;
      debouncer_3_signal_in_pin : in std_logic;
      debouncer_4_signal_in_pin : in std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      zio => zio,
      rzq => rzq,
      mcbx_dram_we_n => mcbx_dram_we_n,
      mcbx_dram_udqs_n => mcbx_dram_udqs_n,
      mcbx_dram_udqs => mcbx_dram_udqs,
      mcbx_dram_udm => mcbx_dram_udm,
      mcbx_dram_ras_n => mcbx_dram_ras_n,
      mcbx_dram_odt => mcbx_dram_odt,
      mcbx_dram_ldm => mcbx_dram_ldm,
      mcbx_dram_dqs_n => mcbx_dram_dqs_n,
      mcbx_dram_dqs => mcbx_dram_dqs,
      mcbx_dram_dq => mcbx_dram_dq,
      mcbx_dram_clk_n => mcbx_dram_clk_n,
      mcbx_dram_clk => mcbx_dram_clk,
      mcbx_dram_cke => mcbx_dram_cke,
      mcbx_dram_cas_n => mcbx_dram_cas_n,
      mcbx_dram_ba => mcbx_dram_ba,
      mcbx_dram_addr => mcbx_dram_addr,
      RS232_Uart_1_sout => RS232_Uart_1_sout,
      RS232_Uart_1_sin => RS232_Uart_1_sin,
      RESET => RESET,
      LEDs_8Bits_TRI_O => LEDs_8Bits_TRI_O,
      GCLK => GCLK,
      DIP_Switches_8Bits_TRI_I => DIP_Switches_8Bits_TRI_I,
      lcd_0_LCD_data_pin => lcd_0_LCD_data_pin,
      lcd_0_LCD_RS_pin => lcd_0_LCD_RS_pin,
      lcd_0_LCD_RW_pin => lcd_0_LCD_RW_pin,
      lcd_0_LCD_E_pin => lcd_0_LCD_E_pin,
      lcd_0_LCD_Enable_pin => lcd_0_LCD_Enable_pin,
      debouncer_0_signal_in_pin => debouncer_0_signal_in_pin,
      debouncer_1_signal_in_pin => debouncer_1_signal_in_pin,
      debouncer_2_signal_in_pin => debouncer_2_signal_in_pin,
      debouncer_3_signal_in_pin => debouncer_3_signal_in_pin,
      debouncer_4_signal_in_pin => debouncer_4_signal_in_pin
    );

end architecture STRUCTURE;

