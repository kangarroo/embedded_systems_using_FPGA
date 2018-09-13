library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver_8Bit is
    Generic (
        CLK_MHZ : NATURAL
    );
    Port (
        clk : in STD_LOGIC;
		  rst : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR (7 downto 0);
        RS_in : in STD_LOGIC;
        load : in STD_LOGIC;
        ack : out STD_LOGIC;
        LCD_data : out STD_LOGIC_VECTOR (3 downto 0);
        LCD_RS : out STD_LOGIC;
        LCD_RW : out STD_LOGIC;
        LCD_E : out STD_LOGIC;
        LCD_Enable : out STD_LOGIC
    );
end Driver_8Bit;

architecture Arch of Driver_8Bit is
    type STATE_TYPE is ( INIT, INIT_WAIT_1, INIT1, INIT1_WAIT, INIT2, INIT2_WAIT, INIT3, INIT_WAIT_2,
        IDLE, MSB, MSB_WAIT, LSB, LSB_WAIT, WAIT_FOR_LCD, SIGNAL_ACK );
    signal state : STATE_TYPE := INIT;
    subtype STATE_TIMER_TYPE is INTEGER range 0 to (CLK_MHZ*50*1000); -- 50ms max wait
    shared variable state_timer : STATE_TIMER_TYPE := 0;
    signal driver_ack : STD_LOGIC := '0';
    signal driver_load : STD_LOGIC := '0';
    signal data_reg : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
    signal data_nibble : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    signal RS_reg : STD_LOGIC := '0';
begin
    -- State machine
    STATE_PROC: process (clk, load, state) is
    begin
        if rst = '1' then
		      state <= INIT;
				state_timer := 0;
				data_reg <= (others=>'0');
				RS_reg <= '0';
        elsif rising_edge(clk) then
            if state_timer /= 0 then
                state_timer := state_timer - 1;
            end if;
            case state is
                when INIT =>
                    if state_timer = 0 then
                        state_timer := CLK_MHZ * 50 * 1000; -- 50ms initial delay
                        state <= INIT_WAIT_1;
                    end if;
                when INIT_WAIT_1 =>
                    if state_timer = 0 then
                        state <= INIT1;
                    end if;
                when INIT1 =>
                    if driver_ack = '1' then
                        state <= INIT1_WAIT;
                    end if;
                when INIT1_WAIT =>
                    if driver_ack = '0' then
                        state <= INIT2;
                    end if;
                when INIT2 =>
                    if driver_ack = '1' then
                        state <= INIT2_WAIT;
                    end if;
                when INIT2_WAIT =>
                    if driver_ack = '0' then
                        state <= INIT3;
                    end if;
                when INIT3 =>
                    if driver_ack = '1' then
                        state_timer := CLK_MHZ * 15 * 1000; -- 15ms delay after initialisation
                        state <= INIT_WAIT_2;
                    end if;
                when INIT_WAIT_2 =>
                    if state_timer = 0 then
                        state <= IDLE;
                    end if;
                when IDLE =>
                    if driver_ack = '0' and load = '1' then
                        data_reg <= data_in;
                        RS_reg <= RS_in;
                        state <= MSB;
                    end if;
                when MSB =>
                    if driver_ack = '1' then
                        state <= MSB_WAIT;
                    end if;
                when MSB_WAIT =>
                    if driver_ack = '0' then
                        state <= LSB;
                    end if;
                when LSB =>
                    if driver_ack = '1' then
                        state <= LSB_WAIT;
                    end if;
                when LSB_WAIT =>
                    if driver_ack = '0' then
                        if RS_reg = '1' then
                            state_timer := CLK_MHZ * 45; -- Write operations take 43us
                        elsif data_reg (7 downto 2) = "000000" then
                            state_timer := CLK_MHZ * 2000; -- Clear or Home operations take 1.53ms in theory
                        else
                            state_timer := CLK_MHZ * 40; -- Config operations take 39us
                        end if;
                        state <= WAIT_FOR_LCD;
                    end if;
                when WAIT_FOR_LCD =>
                    if state_timer = 0 then
                        state <= SIGNAL_ACK;
                    end if;
                when SIGNAL_ACK =>
                    state <= IDLE;
            end case;
        end if;
    end process STATE_PROC;

    with state select
        ack <= '1' when SIGNAL_ACK,
            '0' when others;
    with state select
        driver_load <= '1' when MSB | LSB | INIT1 | INIT2 | INIT3,
            '0' when others;
    with state select
        data_nibble <= data_reg (7 downto 4) when MSB | MSB_WAIT,
            data_reg (3 downto 0) when LSB | LSB_WAIT,
            "0010" when INIT1 | INIT1_WAIT | INIT2 | INIT2_WAIT | INIT3,
            (others=>'0') when others;
				
    LCD_Enable <= '1';

    driver: entity work.Driver_4Bit(Arch)
        generic map (
            CLK_MHZ => CLK_MHZ
        )
        port map (
            clk => clk,
				rst => rst,
            data_in => data_nibble,
            load => driver_load,
            RS_in => RS_reg,
            ack => driver_ack,
            LCD_data => LCD_data,
            LCD_RS => LCD_RS,
            LCD_RW => LCD_RW,
            LCD_E => LCD_E
        );
end Arch;
