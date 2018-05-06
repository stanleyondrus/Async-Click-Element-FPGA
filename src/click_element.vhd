----------------------------------------------------------------------------------
-- Click element
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity click_element is
  generic ( 
            DATA_WIDTH: natural := 3;
            SEED: natural := 0;
            REQ_INIT : std_logic := '0');
  port (    
            init : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end click_element;

architecture behavioral of click_element is

signal ack_o_int : std_logic := REQ_INIT;--'0';
signal and1 : std_logic;
signal and2 : std_logic;
signal or_out: std_logic := '0';
signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(SEED, DATA_WIDTH));
signal init_sig: std_logic := '1';
signal pseudo_clk : std_logic := '0';
attribute dont_touch : string;
attribute dont_touch of  ack_o_int : signal is "true";  
attribute dont_touch of  and1 : signal is "true";  
attribute dont_touch of  and2 : signal is "true";  
attribute dont_touch of  or_out : signal is "true";  
attribute dont_touch of  data_sig : signal is "true";  
attribute dont_touch of  init_sig : signal is "true";  
attribute dont_touch of  pseudo_clk : signal is "true";  

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

end behavioral;
