library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit_tb is
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is
    component alu_8bit
        Port (
            A         : in  STD_LOGIC_VECTOR (7 downto 0);
            B         : in  STD_LOGIC_VECTOR (7 downto 0);
            OP        : in  STD_LOGIC_VECTOR (3 downto 0);
            RESULT    : out STD_LOGIC_VECTOR (7 downto 0);
            CARRY_OUT : out STD_LOGIC
        );
    end component;

    signal A_tb         : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal B_tb         : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal OP_tb        : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal RESULT_tb    : STD_LOGIC_VECTOR (7 downto 0);
    signal CARRY_OUT_tb : STD_LOGIC;
begin
    UUT: alu_8bit port map (
        A => A_tb, B => B_tb, OP => OP_tb,
        RESULT => RESULT_tb, CARRY_OUT => CARRY_OUT_tb
    );

    stim_proc: process
    begin
        -- ADD: 0x25 + 0x17 = 0x3C
        A_tb <= x"25"; B_tb <= x"17"; OP_tb <= "0000";
        wait for 10 ns;
        assert RESULT_tb = x"3C" and CARRY_OUT_tb = '0'
            report "FAIL: ADD test" severity error;

        -- ADD with carry: 0xF0 + 0x30 = 0x20, carry 1
        A_tb <= x"F0"; B_tb <= x"30"; OP_tb <= "0000";
        wait for 10 ns;
        assert RESULT_tb = x"20" and CARRY_OUT_tb = '1'
            report "FAIL: ADD carry test" severity error;

        -- SUB: 0x35 - 0x12 = 0x23, no borrow
        A_tb <= x"35"; B_tb <= x"12"; OP_tb <= "0001";
        wait for 10 ns;
        assert RESULT_tb = x"23" and CARRY_OUT_tb = '1'
            report "FAIL: SUB test" severity error;

        -- SUB with borrow: 0x12 - 0x35 = 0xDD
        A_tb <= x"12"; B_tb <= x"35"; OP_tb <= "0001";
        wait for 10 ns;
        assert RESULT_tb = x"DD" and CARRY_OUT_tb = '0'
            report "FAIL: SUB borrow test" severity error;

        A_tb <= x"F0"; B_tb <= x"0F"; OP_tb <= "0010";
        wait for 10 ns;
        assert RESULT_tb = x"00" report "FAIL: AND test" severity error;

        A_tb <= x"F0"; B_tb <= x"0F"; OP_tb <= "0011";
        wait for 10 ns;
        assert RESULT_tb = x"FF" report "FAIL: OR test" severity error;

        A_tb <= x"AA"; B_tb <= x"0F"; OP_tb <= "0100";
        wait for 10 ns;
        assert RESULT_tb = x"A5" report "FAIL: XOR test" severity error;

        A_tb <= x"55"; B_tb <= x"00"; OP_tb <= "0101";
        wait for 10 ns;
        assert RESULT_tb = x"AA" report "FAIL: NOT test" severity error;

        A_tb <= x"F0"; B_tb <= x"0F"; OP_tb <= "0110";
        wait for 10 ns;
        assert RESULT_tb = x"FF" report "FAIL: NAND test" severity error;

        A_tb <= x"F0"; B_tb <= x"0F"; OP_tb <= "0111";
        wait for 10 ns;
        assert RESULT_tb = x"00" report "FAIL: NOR test" severity error;

        A_tb <= x"AA"; B_tb <= x"0F"; OP_tb <= "1000";
        wait for 10 ns;
        assert RESULT_tb = x"5A" report "FAIL: XNOR test" severity error;

        A_tb <= x"FF"; B_tb <= x"01"; OP_tb <= "1111";
        wait for 10 ns;
        assert RESULT_tb = x"00" and CARRY_OUT_tb = '0'
            report "FAIL: invalid operation test" severity error;

        report "PASS: alu_8bit testbench completed" severity note;
        wait;
    end process;
end Behavioral;
