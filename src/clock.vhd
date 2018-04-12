----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/08/2018 09:41:12 AM
-- Design Name: 
-- Module Name: clock - Behavioral
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

entity clock is
    generic(
        period : time := 50 ns
    );
    port(
        stop : in  std_logic;
        clk  : out std_logic := '0'
    );
end clock;

architecture behaviour of clock is
begin
    process
    begin
        if (not stop = '1') then
            clk <= '1', '0' after period / 2;
            wait for period;
        else
            wait;
        end if;
    end process;
end behaviour;

