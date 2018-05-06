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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity click_element is
  GENERIC ( 
            DATA_WIDTH: NATURAL := 3;
            SEED: NATURAL := 0;
            REQ_INIT : STD_LOGIC := '0');
  Port (    
            init : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end click_element;

architecture Behavioral of click_element is

signal ack_o_int : std_logic := REQ_INIT;--'0';
signal and1 : std_logic;
signal and2 : std_logic;
signal or_out: std_logic := '0';
signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(SEED, DATA_WIDTH));
signal init_sig: std_logic := '1';
signal pseudo_clk : std_logic := '0';
attribute DONT_TOUCH : string;
attribute  DONT_TOUCH of  ack_o_int : signal is "true";  
attribute  DONT_TOUCH of  and1 : signal is "true";  
attribute  DONT_TOUCH of  and2 : signal is "true";  
attribute  DONT_TOUCH of  or_out : signal is "true";  
attribute  DONT_TOUCH of  data_sig : signal is "true";  
attribute  DONT_TOUCH of  init_sig : signal is "true";  
attribute  DONT_TOUCH of  pseudo_clk : signal is "true";  

begin

and1 <= not(req_i) and ack_o_int and ack_i;
and2 <= not(ack_i) and not(ack_o_int) and req_i;
or_out <= pseudo_clk;
req_o <= ack_o_int;
data_o <= data_sig;
ack_o <= ack_o_int;



clock_regs: process(or_out)
begin
    if rising_edge(or_out) then
            ack_o_int <= not ack_o_int;
            data_sig <= data_i;
    end if;
end process;

pseudo_clk <= and1 or and2 when init = '1' else '0';

end Behavioral;