library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_unit is
  Port (
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    ld : in STD_LOGIC;                          
    inr : in STD_LOGIC;                         
    clr : in STD_LOGIC;                       
    data_in : in STD_LOGIC_VECTOR(15 downto 0);
    data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end register_unit;

architecture behavioral of register_unit is
  signal reg_data : STD_LOGIC_VECTOR(15 downto 0);
begin
  process (clock, reset)
  begin
    if reset = '1' then
      reg_data <= (others => '0');
    elsif rising_edge(clock) then
      if clr = '1' then
        reg_data <= (others => '0');
      elsif ld = '1' then
        reg_data <= data_in;
      elsif inr = '1' then
        reg_data <= reg_data + 1;
      end if;
    end if;
  end process;

  data_out <= reg_data;
end behavioral;
