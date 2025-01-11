library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
  Port (
    clock : in STD_LOGIC;                   -- سیگنال کلاک
    reset : in STD_LOGIC;                   -- سیگنال ریست
    opcode : in STD_LOGIC_VECTOR(3 downto 0); -- کد دستورالعمل
    ld_A : out STD_LOGIC;                   -- لود رجیستر A
    ld_B : out STD_LOGIC;                   -- لود رجیستر B
    alu_op : out STD_LOGIC_VECTOR(3 downto 0); -- عملیات ALU
    sel_mem : out STD_LOGIC;                -- انتخاب حافظه
    write_enable : out STD_LOGIC            -- فعال‌سازی نوشتن در حافظه
  );
end control_unit;


architecture behavioral of control_unit is
  -- تعریف حالات FSM
  type state_type is (RESET_STATE, FETCH, DECODE, EXECUTE, MEMORY_ACCESS, WRITEBACK);
  signal current_state, next_state : state_type;

begin
  -- فرآیند FSM
  process (clock, reset)
  begin
    if reset = '1' then
      current_state <= RESET_STATE;
    elsif rising_edge(clock) then
      current_state <= next_state;
    end if;
  end process;

  -- تعریف انتقال بین حالات
  process (current_state, opcode)
  begin
    -- تنظیم مقادیر پیش‌فرض
    ld_A <= '0';
    ld_B <= '0';
    alu_op <= (others => '0');
    sel_mem <= '0';
    write_enable <= '0';

    case current_state is
      when RESET_STATE =>
        -- حالت اولیه
        next_state <= FETCH;

      when FETCH =>
        -- واکشی دستورالعمل
        next_state <= DECODE;

      when DECODE =>
        -- رمزگشایی دستورالعمل
        if opcode = "0001" then  -- مثال: دستورالعمل ADD
          next_state <= EXECUTE;
        elsif opcode = "0010" then  -- مثال: دستورالعمل LOAD
          next_state <= MEMORY_ACCESS;
        else
          next_state <= RESET_STATE;  -- دستورالعمل نامعتبر
        end if;

      when EXECUTE =>
        -- اجرای عملیات ALU
        alu_op <= opcode;  -- تنظیم عملیات ALU
        ld_A <= '1';       -- لود نتیجه به رجیستر A
        next_state <= WRITEBACK;

      when MEMORY_ACCESS =>
        -- دسترسی به حافظه
        sel_mem <= '1';
        if opcode = "0010" then  -- LOAD
          ld_B <= '1';           -- داده را به رجیستر B لود کن
        elsif opcode = "0011" then  -- STORE
          write_enable <= '1';    -- نوشتن در حافظه فعال شود
        end if;
        next_state <= WRITEBACK;

      when WRITEBACK =>
        -- بازنویسی نتیجه به رجیستر
        next_state <= FETCH;

      when others =>
        -- حالت پیش‌فرض
        next_state <= RESET_STATE;
    end case;
  end process;

end behavioral;
