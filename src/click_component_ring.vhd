----------------------------------------------------------------------------------
-- Click component ring
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity click_component_ring is
    generic (
          SIZE: natural := 3;                           -- Number of Click components in the ring
          DATA_WIDTH: natural := 4;                     -- for Click element
          SEED: natural := 3;                           -- for Click element
          REQ_INIT : std_logic := '0';
          DELAY_REQ_LENGTH : integer := 5;
          DELAY_SIZE : natural range 1 to 30 := 30
    );
    port (    
          init : IN std_logic);
          --data : out std_logic_vector(4 downto 0); --commented out for now
          --test_in : in std_logic;
          --test_out : out std_logic;
          --test_out_pin : out std_logic);
end click_component_ring;

architecture behavioral of click_component_ring is

component click_component is
  generic (
          DATA_WIDTH: natural := DATA_WIDTH;
          SEED: natural := SEED;
          REQ_INIT : std_logic := REQ_INIT;
          DELAY_REQ_LENGTH : integer := DELAY_REQ_LENGTH;
          DELAY_SIZE : natural range 1 to 30 := DELAY_SIZE);
  port (    
          init : in std_logic;
          ack_i : in std_logic;
          req_i : in std_logic;
          data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
          ack_o: out std_logic;
          req_o: out std_logic;
          data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component;

signal ack_sig: std_logic_vector(SIZE downto 0);
signal req_sig: std_logic_vector(SIZE downto 0);
type data_type is array(SIZE downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0); 
--signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(SEED, DATA_WIDTH));
signal data_sig: data_type;

attribute dont_touch : string;
attribute dont_touch of ack_sig, req_sig, data_sig : signal is "true";
attribute dont_touch of click_component : component is "yes";

begin    
    click_comp_gen : for i in 0 to (SIZE-1) generate
       click_i: click_component port map(
              init => init,
              ack_i => ack_sig(i+1), 
              req_i => req_sig(i), 
              data_i => data_sig(i), 
              ack_o => ack_sig(i), 
              req_o => req_sig(i+1), 
              data_o => data_sig(i+1)); 
    end generate;
    
    ack_sig(SIZE) <= ack_sig(0);  
    req_sig(0) <= req_sig(SIZE); 
    data_sig(0) <= data_sig(SIZE); 
             
end behavioral;
