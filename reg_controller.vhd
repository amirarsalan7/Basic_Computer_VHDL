library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_controller is
  Port (
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    sel : in STD_LOGIC_VECTOR(2 downto 0); -- انتخاب ثبات
    ld : in STD_LOGIC;
    inr : in STD_LOGIC;
    clr : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR(15 downto 0);
    data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end register_controller;

architecture structural of register_controller is
  -- سیگنال‌های داخلی برای فعال‌سازی بارگذاری، افزایش مقدار و پاک کردن
  signal ld_ar, ld_pc, ld_dr, ld_ac, ld_ir, ld_tr : STD_LOGIC;
  signal inr_ar, inr_pc, inr_dr, inr_ac, inr_ir, inr_tr : STD_LOGIC;
  signal clr_ar, clr_pc, clr_dr, clr_ac, clr_ir, clr_tr : STD_LOGIC;

  -- سیگنال‌های داخلی برای داده‌ها
  signal ar_data, pc_data, dr_data, ac_data : STD_LOGIC_VECTOR(15 downto 0);
  signal ir_data, tr_data : STD_LOGIC_VECTOR(15 downto 0);

  -- تعریف کامپوننت ثبات
  component register_unit
    Port (
      clock : in STD_LOGIC;
      reset : in STD_LOGIC;
      ld : in STD_LOGIC;
      inr : in STD_LOGIC;
      clr : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR(15 downto 0);
      data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;

begin
  -- اختصاص سیگنال‌های داخلی براساس مقدار sel
  process (sel, ld, inr, clr)
  begin
    -- پیش‌فرض: همه سیگنال‌ها صفر
    ld_ar  <= '0'; ld_pc  <= '0'; ld_dr  <= '0'; ld_ac  <= '0'; ld_ir  <= '0'; ld_tr  <= '0';
    inr_ar <= '0'; inr_pc <= '0'; inr_dr <= '0'; inr_ac <= '0'; inr_ir <= '0'; inr_tr <= '0';
    clr_ar <= '0'; clr_pc <= '0'; clr_dr <= '0'; clr_ac <= '0'; clr_ir <= '0'; clr_tr <= '0';

    -- فعال‌سازی سیگنال‌ها براساس sel
    case sel is
      when "000" => ld_ar <= ld; inr_ar <= inr; clr_ar <= clr;
      when "001" => ld_pc <= ld; inr_pc <= inr; clr_pc <= clr;
      when "010" => ld_dr <= ld; inr_dr <= inr; clr_dr <= clr;
      when "011" => ld_ac <= ld; inr_ac <= inr; clr_ac <= clr;
      when "100" => ld_ir <= ld; inr_ir <= inr; clr_ir <= clr;
      when "101" => ld_tr <= ld; inr_tr <= inr; clr_tr <= clr;
      when others =>
        -- بدون تغییر
        null;
    end case;
  end process;

  -- نمونه‌سازی ثبات AR
  AR: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_ar,
      inr => inr_ar,
      clr => clr_ar,
      data_in => data_in,
      data_out => ar_data
    );

  -- نمونه‌سازی ثبات PC
  PC: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_pc,
      inr => inr_pc,
      clr => clr_pc,
      data_in => data_in,
      data_out => pc_data
    );

  -- نمونه‌سازی ثبات DR
  DR: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_dr,
      inr => inr_dr,
      clr => clr_dr,
      data_in => data_in,
      data_out => dr_data
    );

  -- نمونه‌سازی ثبات AC
  AC: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_ac,
      inr => inr_ac,
      clr => clr_ac,
      data_in => data_in,
      data_out => ac_data
    );

  -- نمونه‌سازی ثبات IR
  IR: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_ir,
      inr => inr_ir,
      clr => clr_ir,
      data_in => data_in,
      data_out => ir_data
    );

  -- نمونه‌سازی ثبات TR
  TR: register_unit
    Port map (
      clock => clock,
      reset => reset,
      ld => ld_tr,
      inr => inr_tr,
      clr => clr_tr,
      data_in => data_in,
      data_out => tr_data
    );

  -- انتخاب خروجی
  process (sel, ar_data, pc_data, dr_data, ac_data, ir_data, tr_data)
  begin
    case sel is
      when "000" => data_out <= ar_data;
      when "001" => data_out <= pc_data;
      when "010" => data_out <= dr_data;
      when "011" => data_out <= ac_data;
      when "100" => data_out <= ir_data;
      when "101" => data_out <= tr_data;
      when others => data_out <= (others => '0');
    end case;
  end process;

end structural;
