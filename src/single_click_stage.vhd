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
-- use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity single_click_stage is
  GENERIC (
          DATA_WIDTH: NATURAL := 4;
          SEED: NATURAL := 4;
          REQ_INIT : STD_LOGIC := '0');
  Port (    
            init : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end single_click_stage;

architecture Behavioral of single_click_stage is
attribute dont_touch : string;

CONSTANT WIDTH: natural := 4;
CONSTANT LENGTH: natural := 5;
signal req_to_click_delay, ack_to_click_delay : std_logic;
signal data_sig: std_logic_vector(3 downto 0);

attribute dont_touch of req_to_click_delay, ack_to_click_delay, data_sig : signal is "true"; 

component clickity_clack is
  GENERIC ( 
        DATA_WIDTH: NATURAL := WIDTH;
        SEED: NATURAL := SEED;
        REQ_INIT : STD_LOGIC := '0'
  );
  Port (    
        rst : in std_logic;
        ack_i : in std_logic;
        req_i : in std_logic;
        data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
        ack_o: out std_logic;
        req_o: out std_logic;
        data_o: out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
  end component;

component delay_component
    generic(
        length: natural:= LENGTH;
        size : natural  range 1 to 30
        );
        port (
            d : in   std_logic := '0';
            z : out  std_logic := '0'
        );
    end  component;

begin    
    delay_comp_req : delay_component
        generic map(
            length => LENGTH,
            size => 29
        )
        port map(
            d => req_i,
            z => req_to_click_delay
    );
        
    delay_comp_ack : delay_component
        generic map(
            length => LENGTH,
            size => 30)
        port map(
            d => ack_i,
            z => ack_to_click_delay
        );
        
    click : clickity_clack
        generic map(
            DATA_WIDTH => WIDTH,
            SEED => WIDTH,
            REQ_INIT => '1')
        port map(
            rst => init,
            ack_i => ack_to_click_delay,
            req_i => req_to_click_delay,
            data_i => data_i,
            ack_o => ack_o,
            req_o => req_o,
            data_o => data_sig
    );

    data_o <= data_sig  + '1';

end Behavioral;
