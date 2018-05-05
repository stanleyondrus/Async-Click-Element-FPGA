----------------------------------------------------------------------------------
-- Delay element (2ns - 11ns)
-- used in delay_component
----------------------------------------------------------------------------------

library IEEE;
library  unisim;
use IEEE.STD_LOGIC_1164.ALL;
use  unisim.vcomponents.lut2;
use  unisim.vcomponents.lut1;

entity  delay_element is
    generic(
        size : natural range 1 to 30 := 30); -- number of LUTs    
    port (
        d : in std_logic; -- Data in
        z : out std_logic); -- Data out
end  delay_element;

architecture lut of delay_element  is
    component lut2
        generic (
            init : bit_vector  := X"4"
        );
        port (
            o  : out std_ulogic;
            i0 : in std_ulogic;
            i1 : in std_ulogic
        );
    end  component;
    
    -- Internal  signals.   
    signal s_connect : std_logic_vector(size downto  0);
    
    --   Synthesis attributes - we don't want the
    --   synthesizer to optimize the delay-chain.
    --------------------------------------------------
    attribute dont_touch : string;
    attribute dont_touch of  s_connect : signal  is "true";
    attribute rloc : string;

begin
    s_connect(0) <= d;
    
    -- Create  a riple-chain  of  luts (and  gates).  
    lut_chain : for  index  in 0 to (size -1)  generate
    
    signal o : std_logic;
    
    type  y_placement  is  array (integer  range 0 to 29) of  integer;
    
    constant  y_val : y_placement  := (0,1,0,1,0,1,0,1,2,3,2,3,2,3,2,3,4,5,4,5,4,5,4,5,6,7,6,7,6,7);
    
    attribute  rloc of  delay_lut : label  is "X0Y" & integer 'image(y_val(index) );
    
    begin
        delay_lut: lut2
            generic  map(
                init => "1010" -- AND truth-table
            )
            port  map(
                I1 => d,
                I0 => s_connect(index),
                O   => o
            );
        
        -- Simulate delay of 1 ns     
        s_connect(index +1) <= o after 1 ns;
        
   end generate lut_chain;
        
        -- Connect the output of delay element       
        z  <= s_connect(size -1);
end  lut;