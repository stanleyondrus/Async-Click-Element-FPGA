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
--  Port ( );
end single_click;

architecture Behavioral of single_click is
signal WIDTH: natural := 4;
signal clk,rst : std_logic := '0'; 
signal delay_req : std_logic;
signal req_1_del, req_del_1, req_in : std_logic;
signal data_sig, data_res : std_logic_vector(3 downto 0);
signal input : std_logic := '0';
signal ack_o, ack_sig, ack_inv: std_logic;

component clock
    generic(
    period : time := 50 ns
    );
    port(
        stop : in  std_logic;
        clk  : out std_logic := '0'
    );
end component;

component clickity_clack is
  GENERIC ( DATA_WIDTH: NATURAL := 4;
          SEED: NATURAL := 4;
          REQ_INIT : STD_LOGIC := '0');
  Port (    rst : in std_logic;
            ack_i : in std_logic;
            req_i : in std_logic;
            data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
            ack_o: out std_logic;
            req_o: out std_logic;
            data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component;

component delay_element
    generic(
        size : natural  range 1 to 30 := 8 -- Delay  size
        );
        port (
            d : in   std_logic := '0'; -- Data  in
            z : out  std_logic := '0');
    end  component;
    
    

begin
    
    dut0 : clock
        port map(
        stop => rst,
        clk => clk
    );

    delay_elem_req : delay_element
        generic map(
                size => 8)
        port map(
            d => req_1_del,
            z => req_del_1
        );
        
    delay_elem_ack : delay_element
        generic map(
                size => 9)
        port map(
            d => ack_o,
            z => ack_sig
        );
        
    req_in <= not req_del_1;
    ack_inv <= not ack_sig;
    data_res <= data_sig + '1';
    
    stage1 : clickity_clack
        generic map(
            DATA_WIDTH => 4,
            SEED => 1,
            REQ_INIT => '1')
        port map(
            rst => rst,
            ack_i => ack_inv,
            req_i => req_in,
            data_i => data_res,
            ack_o => ack_o,
            req_o => req_1_del,
            data_o => data_sig
        );

    rst <= '1', '0' after 50 ns;

end Behavioral;
----
