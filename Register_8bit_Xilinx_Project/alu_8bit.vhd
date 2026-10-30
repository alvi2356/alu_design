library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8-bit combinational ALU
-- OP codes:
-- 0000 ADD, 0001 SUB, 0010 AND, 0011 OR, 0100 XOR,
-- 0101 NOT A, 0110 NAND, 0111 NOR, 1000 XNOR
entity alu_8bit is
    Port (
        A         : in  STD_LOGIC_VECTOR (7 downto 0);
        B         : in  STD_LOGIC_VECTOR (7 downto 0);
        OP        : in  STD_LOGIC_VECTOR (3 downto 0);
        RESULT    : out STD_LOGIC_VECTOR (7 downto 0);
        CARRY_OUT : out STD_LOGIC
    );
end alu_8bit;

architecture Behavioral of alu_8bit is
begin
    process (A, B, OP)
        variable temp : unsigned (8 downto 0);
    begin
        RESULT <= (others => '0');
        CARRY_OUT <= '0';
        temp := (others => '0');

        case OP is
            when "0000" =>                 -- Addition
                temp := ('0' & unsigned(A)) + ('0' & unsigned(B));
                RESULT <= std_logic_vector(temp(7 downto 0));
                CARRY_OUT <= temp(8);

            when "0001" =>                 -- Subtraction; carry=1 means no borrow
                RESULT <= std_logic_vector(unsigned(A) - unsigned(B));
                if unsigned(A) >= unsigned(B) then
                    CARRY_OUT <= '1';
                else
                    CARRY_OUT <= '0';
                end if;

            when "0010" => RESULT <= A and B;
            when "0011" => RESULT <= A or B;
            when "0100" => RESULT <= A xor B;
            when "0101" => RESULT <= not A;
            when "0110" => RESULT <= A nand B;
            when "0111" => RESULT <= A nor B;
            when "1000" => RESULT <= A xnor B;
            when others =>
                RESULT <= (others => '0');
                CARRY_OUT <= '0';
        end case;
    end process;
end Behavioral;
