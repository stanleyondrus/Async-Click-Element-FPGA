----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2018 11:08:36 PM
-- Design Name: 
-- Module Name: test_delay - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_delay is
--  Port ( );
end test_delay;

architecture Behavioral of test_delay is
signal WIDTH: natural := 4;
signal clk,rst : std_logic := '0'; 
signal delay_req1_in, delay_req2_in: std_logic;
signal delay_req1_out, delay_req2_out: std_logic;
signal req1_2, req2_3, req3_1, ack1_3, ack2_1, ack3_2 : std_logic;
signal data1_2, data2_3, data3_1 : std_logic_vector(3 downto 0);
signal req1_o_d, req2_o_d, req3_o_d, req2_i_d, req3_i_d, req1_i_d : std_logic;
signal input : std_logic := '0';
signal ack1_3_inv, ack3_i_env : std_logic;

component clock
    generic(
    period : time := 50 ns
    );
    port(
        stop : in  std_logic;
        clk  : out std_logic := '0'
    );
end component;

component clickity_clack is
  GENERIC ( DATA_WIDTH: NATURAL := 4;
          SEED: NATURAL := 4;
          REQ_INIT : STD_LOGIC := '0');
  Port (    rst : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component;

component delay_element
    generic(
        size : natural  range 1 to 30 := 10 -- Delay  size
        );
        port (
            d : in   std_logic := '0'; -- Data  in
            z : out  std_logic := '0');
    end  component;
    

begin
    
    dut0 : clock
        port map(
        stop => rst,
        clk => clk
    );

    dut1 : delay_element
        port map(
            d => req1_o_d,
            z => req2_i_d
        );
        
    dut2 : delay_element
        port map(
            d => req2_o_d,
            z => req3_i_d
        );
        
    dut3 : delay_element
        port map(
            d => req3_o_d,
            z => req1_i_d
        );
        
    --env_inv : delay_element
    --    port map(
    --        d => ack1_3_inv,
    --        z => req1_i_d
    --    );
        
    --ack1_3_inv <= not ack1_3; 
    
    --env_out : delay_element
    --    port map(
    --        d => req3_o_d,
    --        z => ack3_i_env
    --    );
        
    stage1 : clickity_clack
        generic map(
            DATA_WIDTH => 4,
            SEED => 5,
            REQ_INIT => '1')
        port map(
            rst => rst,
            ack_i => ack2_1,
            req_i => req1_i_d,--req3_1
            data_i => data3_1,
            ack_o => ack1_3,
            req_o => req1_o_d,--req1_2,
            data_o => data1_2
        );

    stage2 : clickity_clack
        generic map(
                DATA_WIDTH => 4,
                SEED => 4,
                REQ_INIT => '0')
        port map(
            rst => rst,
            ack_i => ack3_2,
            req_i => req2_i_d,
            data_i => data1_2,
            ack_o => ack2_1,
            req_o => req2_o_d,
            data_o => data2_3
        );
        
    stage3 : clickity_clack
        generic map(
            DATA_WIDTH => 4,
            SEED => 3,
            REQ_INIT => '1')
        port map(
            rst => rst,
            ack_i => ack1_3,
            req_i => req3_i_d,--req2_3,
            data_i => data2_3,
            ack_o => ack3_2,
            req_o => req3_o_d,--req3_1,
            data_o => data3_1
        );

    rst <= '1', '0' after 50 ns;

data_logic: process(clk, rst)
begin
    if (rst = '1') then
        
    elsif rising_edge(clk) then
        input <= not input;
    end if;
end process;

end Behavioral;
----
