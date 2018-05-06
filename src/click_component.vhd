----------------------------------------------------------------------------------
-- Click Component
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.std_logic_unsigned.all;

entity click_component is
  generic (
          DATA_WIDTH: NATURAL := 4;
          SEED: NATURAL := 3;
          REQ_INIT : STD_LOGIC := '0';
          DELAY_REQ_LENGTH : integer := 5;
          DELAY_ACK_LENGTH : integer := 6;
          DELAY_SIZE : natural range 1 to 30 := 30);
  port (    
            init : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end click_component;

architecture behavioral of click_component is

signal req_to_click_delay, ack_to_click_delay : std_logic;
signal data_sig: std_logic_vector(3 downto 0);

attribute dont_touch : string;
attribute dont_touch of req_to_click_delay, ack_to_click_delay, data_sig : signal is "true";

component clickity_clack is
  generic ( 
        DATA_WIDTH: NATURAL := DATA_WIDTH;
        SEED: NATURAL := SEED;
        REQ_INIT : STD_LOGIC := REQ_INIT);
  port (    
        rst : in std_logic;
        ack_i : in std_logic;
        req_i : in std_logic;
        data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
        ack_o: out std_logic;
        req_o: out std_logic;
        data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
  end component;

component delay_component
    generic(
        length: natural;
        size : natural  range 1 to 30);
        port (
            d : in   std_logic := '0';
            z : out  std_logic := '0');
    end  component;
    
--attribute dont_touch of clickity_clack : component is "yes";
--attribute dont_touch of delay_component : component is "yes";

begin    
    delay_comp_req : delay_component
        generic map(
            length => DELAY_REQ_LENGTH,
            size => DELAY_SIZE)
        port map(
            d => req_i,
            z => req_to_click_delay);
        
    delay_comp_ack : delay_component
        generic map(
            length => DELAY_ACK_LENGTH,
            size => DELAY_SIZE)
        port map(
            d => ack_i,
            z => ack_to_click_delay);
        
    click : clickity_clack
        generic map(
            DATA_WIDTH => DATA_WIDTH,
            SEED => SEED,
            REQ_INIT => REQ_INIT)
        port map(
            rst => init,
            ack_i => ack_to_click_delay,
            req_i => req_to_click_delay,
            data_i => data_i,
            ack_o => ack_o,
            req_o => req_o,
            data_o => data_sig);

    data_o <= data_sig  + '1';

end Behavioral;