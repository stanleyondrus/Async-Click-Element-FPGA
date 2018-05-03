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
-- use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity single_click is
    PORT (    rst : IN STD_LOGIC;
      data : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      test_in : IN STD_LOGIC;
      test_out : OUT STD_LOGIC;
      test_out_pin : OUT STD_LOGIC;
      test_out_del : OUT STD_LOGIC);
end single_click;

architecture Behavioral of single_click is
signal WIDTH: natural := 4;
signal delay_req : std_logic;
signal req_sig, req_inv : std_logic;
signal data_sig, data_res : std_logic_vector(4 downto 0);
signal input : std_logic := '0';
signal ack_o, ack_sig, ack_sig_1, ack_sig_2, ack_sig_3, ack_sig_4, ack_inv: std_logic;



component delay_element
    generic(
        size : natural  range 1 to 30 := 11 -- Delay  size
        );
        port (
            d : in   std_logic := '0'; -- Data  in
            z : out  std_logic := '0');
    end  component;

begin
    test_out <= test_in;
    test_out_pin <= test_in;
    test_out_del <= ack_sig_4;
    data <= "10101";
       
    delay_elem_ack : delay_element
        generic map(
                size => 25)
        port map(
            d => test_in,
            z => ack_sig
        );
        
    delay_elem_ack1 : delay_element
        generic map(
                size => 20)
        port map(
            d => ack_sig,
            z => ack_sig_1
        );
        
    delay_elem_ack2 : delay_element
        generic map(
                size => 20)
        port map(
            d => ack_sig_1,
            z => ack_sig_2
        );
        
    delay_elem_ack3 : delay_element
        generic map(
                size => 20)
        port map(
            d => ack_sig_2,
            z => ack_sig_3
        );
        
    delay_elem_ack4 : delay_element
        generic map(
                size => 20)
        port map(
            d => ack_sig_3,
            z => ack_sig_4
        );

   -- rst <= '1', '0' after 120 ns;

end Behavioral;
----
