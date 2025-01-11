library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_level is
  Port (
    clock : in STD_LOGIC;                 -- سیگنال کلاک
    reset : in STD_LOGIC;                 -- سیگنال ریست
    data_in : in STD_LOGIC_VECTOR(15 downto 0); -- داده ورودی خارجی
    data_out : out STD_LOGIC_VECTOR(15 downto 0); -- داده خروجی نهایی
    zero_flag : out STD_LOGIC              -- وضعیت صفر ALU
  );
end top_level;

architecture structural of top_level is

  -- سیگنال‌های داخلی
 
  signal reg_A, reg_B, reg_out : STD_LOGIC_VECTOR(15 downto 0); -- سیگنال رجیسترها
  signal alu_result : STD_LOGIC_VECTOR(15 downto 0);           -- خروجی ALU
  signal alu_zero : STD_LOGIC;                                 -- وضعیت صفر ALU
  signal alu_op : STD_LOGIC_VECTOR(3 downto 0);                -- کد عملیات ALU
  signal mem_out : STD_LOGIC_VECTOR(15 downto 0);              -- خروجی حافظه
 
  signal sel_reg, sel_mem, ld_A, ld_B : STD_LOGIC;             -- سیگنال‌های کنترلی

begin

  -- **واحد رجیستر A**
  reg_A_unit: entity work.register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_A,
      inr => '0',
      clr => '0',
      data_in => data_in,
      data_out => reg_A
    );

  -- **واحد رجیستر B**
  reg_B_unit: entity work.register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_B,
      inr => '0',
      clr => '0',
      data_in => data_in,
      data_out => reg_B
    );

  -- **واحد ALU**
  alu_instance: entity work.ALU_unit
    Port map (
      A => reg_A,
      B => reg_B,
      ALU_OP => alu_op,
      RESULT => alu_result,
      ZERO => alu_zero
    );

  -- **واحد حافظه**
  mem_unit: entity work.memory_unit
    Port map (
      clk => clock,
      reset => reset,
      address => reg_B,   -- آدرس حافظه از رجیستر B
      we => sel_mem,
      data_in => reg_A,   -- داده ورودی حافظه از رجیستر A
      data_out => mem_out -- داده خروجی حافظه
    );

  -- **انتخاب داده خروجی**
  process (sel_reg, alu_result, mem_out)
  begin
    if sel_reg = '1' then
      data_out <= alu_result; -- خروجی ALU
    else
      data_out <= mem_out; -- خروجی حافظه
    end if;
  end process;

  -- **اتصال سیگنال‌های کنترلی**
  zero_flag <= alu_zero; -- اتصال وضعیت صفر ALU به خروجی

  -- **واحد کنترل**
--   control_unit: entity work.control_unit
--     Port map (
--       clock => clock,
--       reset => reset,
--       alu_op => alu_op,
--       sel_reg => sel_reg,
--       sel_mem => sel_mem,
--       ld_A => ld_A,
--       ld_B => ld_B
--     );

    control_unit : entity work.control_unit
        Port map (
          clock => clock,                 -- سیگنال کلاک
          reset => reset,                   -- سیگنال ریست
          opcode => alu_op,                -- کد دستورالعمل
          ld_A => ld_A,                   -- لود رجیستر A
          ld_B => ld_B,                 -- لود رجیستر B
          alu_op => alu_op,                   -- عملیات ALU
          sel_mem  => sel_mem,               -- انتخاب حافظه
          sel_reg  => sel_reg,                   --انتخاب ریجستر   
        --   write_enable             -- فعال‌سازی نوشتن در حافظه
        );
end structural;
