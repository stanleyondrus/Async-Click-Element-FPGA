----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2018 11:08:36 PM
-- Design Name: 
-- Module Name: delay_test
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

entity delay_test is
    PORT (
        SW0 : IN STD_LOGIC;
        LED0, LED1, JA1, JA4: OUT STD_LOGIC);
end delay_test;

architecture Behavioral of delay_test is
constant STAGES : integer := 5;
signal delay_sig: std_logic_vector(STAGES downto 0);

component delay_element
    generic(
        size : natural  range 1 to 30 := 10 -- Delay  size
        );
        port (
            d : in   std_logic := '0'; -- Data  in
            z : out  std_logic := '0');
    end  component;

attribute keep : string;
attribute  keep of  delay_sig : signal is "true";  

begin

delay_gen:for i in 0 to (STAGES-1) generate
   delay_i : delay_element
   generic map(
               size => 20)
   port map(
           d => delay_sig(i),
           z => delay_sig(i+1)
    );
end generate;

   delay_sig(0) <= SW0;
   LED0 <= SW0;
   LED1 <= delay_sig(STAGES-1);
   JA1 <= SW0;
   JA4 <= delay_sig(STAGES-1);
  
end Behavioral;