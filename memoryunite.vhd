library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity memory_unit is
    Generic ( MEM_SIZE : integer := 4096 );
    Port (
        clk : in STD_LOGIC; 
        we : in STD_LOGIC; 
        address : in STD_LOGIC_VECTOR(11 downto 0);
        data_in : in STD_LOGIC_VECTOR(15 downto 0); 
        data_out : out STD_LOGIC_VECTOR(15 downto 0) 
    );
end memory_unit;

architecture Behavioral of memory_unit is
    
    type memory_array is array (0 to MEM_SIZE-1) of STD_LOGIC_VECTOR(15 downto 0);
    signal RAM : memory_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
            
                RAM(to_integer(ieee.NUMERIC_STD.UNSIGNED(address))) <= data_in;
            end if;
            
            data_out <= RAM(to_integer(ieee.NUMERIC_STD.UNSIGNED(address)));
        end if;
    end process;
    
end Behavioral;
