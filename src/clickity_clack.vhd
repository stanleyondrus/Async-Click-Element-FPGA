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
  generic ( DATA_WIDTH: NATURAL := 3;
            SEED: NATURAL := 0;
            REQ_INIT : STD_LOGIC := '0');
  port (    rst : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end clickity_clack;

architecture Behavioral of clickity_clack is

signal ack_o_int : std_logic := REQ_INIT;--'0';
signal and1 : std_logic;
signal and2 : std_logic;
signal or_out: std_logic := '0';
signal data_sig: std_logic_vector(DATA_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(SEED, DATA_WIDTH));
signal req_sig: std_logic := REQ_INIT;

begin

and1 <= not(req_i) and ack_o_int and ack_i;
and2 <= not(ack_i) and not(ack_o_int) and req_i;
or_out <= and1 or and2;
req_o <= ack_o_int;
--req_sig;
--req_sig <= ack_o_int;
data_o <= data_sig;
ack_o <= ack_o_int;

process(or_out, rst)
begin
    if rst = '1' then
        ack_o_int <= '0';
        data_sig <= (others => '0');
  --  elsif falling_edge(rst) then
    --    ack_o_int <= REQ_INIT;
      --  data_sig <= std_logic_vector(to_unsigned(SEED, DATA_WIDTH));
    elsif rising_edge(or_out) then
       ack_o_int <= not ack_o_int;
       data_sig <= data_i;
    end if;
end process;

end Behavioral;