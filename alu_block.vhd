library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_unit is
  Port (
    A : in STD_LOGIC_VECTOR(15 downto 0);
    B : in STD_LOGIC_VECTOR(15 downto 0);
    ALU_OP : in STD_LOGIC_VECTOR(2 downto 0);
    RESULT : out STD_LOGIC_VECTOR(15 downto 0);
    ZERO : out STD_LOGIC
  );
end ALU_unit;

architecture behavioral of ALU_unit is
    signal temp_result : STD_LOGIC_VECTOR(15 downto 0);
  begin
  
    process (A, B, ALU_OP)
    begin

      case ALU_OP is
        when "000" => temp_result <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));
        when "001" => temp_result <= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
        when "010" => temp_result <= A and B;
        when "011" => temp_result <= A or B;
        when "100" => temp_result <= A xor B;
        when "101" => temp_result <= not A;
        when "110" => temp_result <= STD_LOGIC_VECTOR(UNSIGNED(A) sll 1);
        when "111" => temp_result <= STD_LOGIC_VECTOR(UNSIGNED(A) srl 1);
        when others=> temp_result <= "0000000000000000";
      end case;
        RESULT <= temp_result;
    
      if temp_result = "0000000000000000" then
        ZERO <= '1';
      else
        ZERO <= '0';
      end if;
    end process;
  
  end behavioral;
  