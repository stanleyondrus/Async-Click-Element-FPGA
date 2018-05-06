----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2018 05:18:37 PM
-- Design Name: 
-- Module Name: top_clack - Behavioral
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

entity top_clack is
  GENERIC ( DATA_WIDTH: NATURAL := 3;
          SEED: NATURAL := 0;
          REQ_INIT : STD_LOGIC := '0';
          DELAY: NATURAL := 10);
    Port (    init : in std_logic;
          ack_i : in std_logic;
          req_i : in std_logic;
          data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
          ack_o: out std_logic;
          req_o: out std_logic;
          data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end top_clack;

architecture Behavioral of top_clack is

component clickity_clack is
  GENERIC ( DATA_WIDTH: NATURAL := DATA_WIDTH;
          SEED: NATURAL := SEED;
          REQ_INIT : STD_LOGIC := REQ_INIT);
  Port (    init : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component;

component delay_test
    generic(
        size : natural := DELAY -- Delay  size
        );
        port (
            d : in   std_logic; -- Data  in
            z : out  std_logic);
    end  component;

SIGNAL req_del : STD_LOGIC;

attribute DONT_TOUCH : string;
attribute  DONT_TOUCH of  req_del : signal is "true";  
attribute  DONT_TOUCH of  delay_el : label is "true";  
attribute  DONT_TOUCH of  click_reg : label is "true";  

begin

delay_el : delay_test
        GENERIC MAP(
                size => DELAY)
        PORT MAP(
            d => req_del,
            z => req_o
        );
        
click_reg : clickity_clack
        GENERIC MAP(
            DATA_WIDTH => DATA_WIDTH,
            SEED => SEED,
            REQ_INIT => REQ_INIT)
        PORT MAP(
            init => init,
            ack_i => ack_i,
            req_i => req_i,
            data_i => data_i,
            ack_o => ack_o,
            req_o => req_del,
            data_o => data_o
        );

end Behavioral;
