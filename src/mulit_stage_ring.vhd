----------------------------------------------------------------------------------
-- Click chain
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity multi_stage_ring is
    generic (
          SIZE: natural := 100;                           -- Number of Click elements in the ring
          DATA_WIDTH: natural := 4                     -- for Click element
          );   
    port (    
          --init : in std_logic := '0';
          JA1, JA2, JA3, JA4, JA7: out std_logic);
end multi_stage_ring;

architecture behavioral of multi_stage_ring is

component click_element is
  generic (
          DATA_WIDTH: natural := DATA_WIDTH;
          SEED: natural;
          REQ_INIT : std_logic);
  port (    
          init : in std_logic;
          ack_i : in std_logic;
          req_i : in std_logic;
          data_i: in std_logic_vector(DATA_WIDTH-1 downto 0);
          ack_o: out std_logic;
          req_o: out std_logic;
          data_o: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component;

signal ack_sig: std_logic_vector(SIZE downto 0);
signal ack_2_1, req_1_2, ack_inv, req_inv : std_logic;
signal data_1_2, data_inc : std_logic_vector(DATA_WIDTH-1 downto 0);
signal req_sig: std_logic_vector(SIZE downto 0);
signal init : std_logic;
type data_type is array(SIZE downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0); 

signal data_sig: data_type;

attribute dont_touch : string;
attribute dont_touch of ack_sig, req_sig, data_sig, ack_inv, req_inv: signal is "true";
attribute dont_touch of click_element : component is "true";

begin  
    click_comp_gen : for i in 0 to (SIZE-1) generate
    begin
       click_i: click_element 
       generic map(
              SEED => 0,
              REQ_INIT => '1' )
    port map(
              init => init,
              ack_i => ack_sig(i+1), 
              req_i => req_sig(i), 
              data_i => data_sig(i), 
              ack_o => ack_sig(i), 
              req_o => req_sig(i+1), 
              data_o => data_sig(i+1)); 
    end generate;
    
    stage1 : click_element
    GENERIC MAP(
        SEED => 5,
        REQ_INIT => '1')
    PORT MAP(
        init => init,
        ack_i => ack_inv,
        req_i => req_sig(SIZE),
        data_i => data_sig(SIZE),
        ack_o => ack_sig(SIZE),
        req_o => req_inv,--req_sig(0),
        data_o => data_sig(0)
    );
    
   --data_sig(0) <= data_inc + 1;
   req_sig(0) <= not req_inv;  
   ack_inv <= not ack_sig(0);

   JA1 <= data_sig(SIZE)(0);
   JA2 <= data_sig(SIZE)(1);
   JA3 <= data_sig(SIZE)(2);
   JA4 <= ack_sig(SIZE);
   JA7 <= req_sig(0);
              
  init <= '0', '1' after 40 ns;
      
end behavioral;
