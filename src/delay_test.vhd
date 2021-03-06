----------------------------------------------------------------------------------
-- Delay test
-- length:1 / size:30 / 10ns delay
-- length:10 / size:30 / 100ns delay
-- length:100 / size:30 / 1us delay
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;

entity delay_test is
 generic(
       length : integer := 10; -- number of delay_elements
       size : natural range 1 to 30 := 30); -- number of LUTs per delay_element      
    port (
        SW0 : in std_logic;
        LED0, LED1, JA1, JA4: out std_logic);
end delay_test;

architecture behavioral of delay_test is
    signal in_sig, out_sig: std_logic; 
        
   component delay_component
      generic(
               length : integer; -- number of delay_elements
               size : natural range 1 to 30); -- number of LUTs per delay_element      
             port (
               d : in   std_logic := '0'; -- Data in
               z : out  std_logic := '0'); -- Data out
    end component;

begin

delay_gen : delay_component
    generic map(
            length => length, -- number of delay_elements
            size => size) -- number of LUTs per delay_element        
        port map(
            d => in_sig, -- Data  in
            z => out_sig); -- Data out
            
   in_sig <= SW0;
   LED0 <= SW0;
   LED1 <= out_sig;
   JA1 <= SW0;
   JA4 <= out_sig;

end behavioral;