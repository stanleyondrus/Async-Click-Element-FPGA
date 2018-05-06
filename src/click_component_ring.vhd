----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2018 11:02:06 AM
-- Design Name: 
-- Module Name: clickity_clack - Behavioral
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
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity click_component_ring is
    generic (
          SIZE: natural := 3;                           -- Number of Click components in the ring
          DATA_WIDTH: natural := 4;                     -- for Click element                
          DELAY_REQ_LENGTH : integer := 5;
          DELAY_SIZE : natural range 1 to 30 := 30
    );
    port (    
          init : IN STD_LOGIC);
          --data : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); --commented out for now
          --test_in : IN STD_LOGIC;
          --test_out : OUT STD_LOGIC;
          --test_out_pin : OUT STD_LOGIC);
end click_component_ring;

architecture Behavioral of click_component_ring is

component click_component is
  generic (
          DATA_WIDTH: NATURAL := DATA_WIDTH;
          SEED: NATURAL;
          REQ_INIT : STD_LOGIC;
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
attribute dont_touch of ack_sig, req_sig, data_sig: signal is "true";
attribute dont_touch of click_component : component is "yes";

begin  
    click_comp_gen : for i in 0 to (SIZE-1) generate
        type seed_type is array (natural range 0 to SIZE-1) of natural;
        constant REQ_INIT : std_logic_vector(2 downto 0) := "100";  
        constant  SEED_VALUE : seed_type  := (0,0,0);
     begin
       click_i: click_component 
        generic map(
              SEED => SEED_VALUE(i),
              REQ_INIT => REQ_INIT(i))
       port map(
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
             
end Behavioral;
