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

entity clickity_clack is
  Port (    rst : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(2 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(2 downto 0));
end clickity_clack;

architecture Behavioral of clickity_clack is

signal ack_o_int : std_logic := '0';
signal and1 : std_logic;
signal and2 : std_logic;
signal or_out: std_logic := '0';
signal data_sig: std_logic_vector(2 downto 0) := (others => '0');

begin

and1 <= not(req_i) and ack_o_int and ack_i;
and2 <= not(ack_i) and not(ack_o_int) and req_i;
or_out <= and1 or and2;
req_o <= ack_o_int;
data_o <= data_sig;
ack_o <= ack_o_int;



clock_regs: process(or_out)
begin
    if rst = '1' then
        ack_o_int <= '0';
        data_sig <= (others => '0');
    else
        if rising_edge(or_out) then
            ack_o_int <= not ack_o_int;
            data_sig <= data_i;
        end if;
    end if;
end process;


end Behavioral;
