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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_delay is
--  Port ( );
end test_delay;

architecture Behavioral of test_delay is

signal clk,rst : std_logic := '0'; 
signal input, output: std_logic := '0';

component clock
    generic(
    period : time := 50 ns
    );
    port(
        stop : in  std_logic;
        clk  : out std_logic := '0'
    );
end component;

component delay_element
    generic(
        size : natural  range 1 to 30 := 10 -- Delay  size
        );
        port (
            d : in   std_logic := '0'; -- Data  in
            z : out  std_logic := '0');
    end  component;
    

begin

    dut1 : clock
        port map(
        stop => rst,
        clk => clk
    );

    dut0 : delay_element
        port map(
            d => input,
            z => output
        );

    rst <= '1', '0' after 50 ns;


data_logic: process(clk, rst)
begin
    if (rst = '1') then
        input <= '0';
    elsif rising_edge(clk) then
        input <= not input;
    end if;
end process;

end Behavioral;
----
