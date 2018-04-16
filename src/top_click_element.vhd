----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2018 11:02:06 AM
-- Design Name: 
-- Module Name: click_element - Behavioral
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

entity ring_click_element is
  Generic( stages:integer:=5);
  Port(  rst, ack_i, req_i : in std_logic;
         data_i: in std_logic_vector(2 downto 0);
         ack_o, req_o: out std_logic;
         data_o: out std_logic_vector(2 downto 0));
end ring_click_element;

architecture ring_behavioral of ring_click_element is

signal ack_out_sig, req_in_sig: std_logic_vector(stages downto 0);

type data_type is array(stages downto 0) of std_logic_vector(2 downto 0);
signal data_in_sig: data_type;

component clickity_clack is
  Port(    rst, ack_i, req_i: in std_logic;
           data_i: in std_logic_vector(2 downto 0);
           ack_o, req_o: out std_logic;
           data_o: out std_logic_vector(2 downto 0));
     end component;
     
begin

ring_gen:for i in 0 to stages-1 generate
    clickity_clack_i : clickity_clack
   port map(
           rst => rst,
           ack_i => ack_out_sig(i+1),
           req_i => req_in_sig(i),
           data_i => data_in_sig(i),
           ack_o => ack_out_sig(i),
           req_o => req_in_sig(i+1),
           data_o => data_in_sig(i+1)
    );
end generate;

--req_in_sig(0) <= not ack_out_sig(0);
--req_in_sig(stages) <= ack_out_sig(stages);
data_in_sig(0) <= data_in_sig(stages);

req_in_sig(0) <= req_in_sig(stages);
ack_out_sig(stages) <= ack_out_sig(0);

end ring_behavioral;