----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2018 05:57:57 PM
-- Design Name: 
-- Module Name: output_ring - Behavioral
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

ENTITY output_ring IS
    PORT (    init : IN STD_LOGIC;
          data : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
          test_in : IN STD_LOGIC;
          test_out : OUT STD_LOGIC;
          test_out_pin : OUT STD_LOGIC);
END output_ring;

ARCHITECTURE Behavioral OF output_ring IS

SIGNAL req_1_2, req_2_3, req_3_4, req_4_5, req_5_6, req_6_7, req_7_8, req_8_9, req_9_1 : STD_LOGIC;
SIGNAL ack_1_9, ack_9_8, ack_8_7, ack_7_6, ack_6_5, ack_5_4, ack_4_3, ack_3_2, ack_2_1 : STD_LOGIC;
SIGNAL data_1_2, data_2_3, data_3_4, data_4_5, data_5_6, data_6_7, data_7_8, data_8_9, data_9_1 : STD_LOGIC_VECTOR(4 DOWNTO 0); 
--signal init : std_logic;

    COMPONENT top_clack IS
    GENERIC ( DATA_WIDTH: NATURAL := 5;
          SEED: NATURAL := 0;
          REQ_INIT : STD_LOGIC := '0';
          DELAY: NATURAL := 80);
    Port (    init : IN STD_LOGIC;
          ack_i : IN STD_LOGIC;
          req_i : IN STD_LOGIC;
          data_i: IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
          ack_o: OUT STD_LOGIC;
          req_o: OUT STD_LOGIC;
          data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT clickity_clack IS
    GENERIC ( DATA_WIDTH: NATURAL := 5;
          SEED: NATURAL := 0;
          REQ_INIT : STD_LOGIC := '0');
    Port (    init : IN STD_LOGIC;
          ack_i : IN STD_LOGIC;
          req_i : IN STD_LOGIC;
          data_i: IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
          ack_o: OUT STD_LOGIC;
          req_o: OUT STD_LOGIC;
          data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
    END COMPONENT;

BEGIN
    test_out <= test_in;
    test_out_pin <= req_9_1;
    data <= data_9_1;
    
    stage1 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 1,
        REQ_INIT => '0',
        DELAY => 80)
    PORT MAP(
        init => init,
        ack_i => ack_2_1,
        req_i => req_9_1,
        data_i => data_9_1,
        ack_o => ack_1_9,
        req_o => req_1_2,
        data_o => data_1_2
    );
    
    stage2 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 2,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_3_2,
        req_i => req_1_2,
        data_i => data_1_2,
        ack_o => ack_2_1,
        req_o => req_2_3,
        data_o => data_2_3
    );
    
    stage3 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 3,
        REQ_INIT => '1')
    PORT MAP(
        init => init,
        ack_i => ack_4_3,
        req_i => req_2_3,
        data_i => data_2_3,
        ack_o => ack_3_2,
        req_o => req_3_4,
        data_o => data_3_4
    );
    
    
    stage4 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 0,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_5_4,
        req_i => req_3_4,
        data_i => data_3_4,
        ack_o => ack_4_3,
        req_o => req_4_5,
        data_o => data_4_5
    );
    
    stage5 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 0,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_6_5,
        req_i => req_4_5,
        data_i => data_4_5,
        ack_o => ack_5_4,
        req_o => req_5_6,
        data_o => data_5_6
    );
    
    stage6 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 6,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_7_6,
        req_i => req_5_6,
        data_i => data_5_6,
        ack_o => ack_6_5,
        req_o => req_6_7,
        data_o => data_6_7
    );
    
    stage7 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 7,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_8_7,
        req_i => req_6_7,
        data_i => data_6_7,
        ack_o => ack_7_6,
        req_o => req_7_8,
        data_o => data_7_8
    );
    
    stage8 : top_clack
    GENERIC MAP(
        DATA_WIDTH => 5,
        SEED => 11,
        REQ_INIT => '0')
    PORT MAP(
        init => init,
        ack_i => ack_9_8,
        req_i => req_7_8,
        data_i => data_7_8,
        ack_o => ack_8_7,
        req_o => req_8_9,
        data_o => data_8_9
    );
    
    stage9 : top_clack
        GENERIC MAP(
            DATA_WIDTH => 5,
            SEED => 8,
            REQ_INIT => '0')
        PORT MAP(
            init => init,
            ack_i => ack_1_9,
            req_i => req_8_9,
            data_i => data_8_9,
            ack_o => ack_9_8,
            req_o => req_9_1,
            data_o => data_9_1
        );
    
    -- init <= '0', '1' after 1600 ns;

END Behavioral;
