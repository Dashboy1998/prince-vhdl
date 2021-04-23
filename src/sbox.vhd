library ieee;
use ieee.std_logic_1164.all;

-- Substitution box of PRINCE
entity sbox is
    port(data_in:  in std_logic_vector(3 downto 0);
         data_out: out std_logic_vector(3 downto 0)
    );
end sbox;

architecture behavioral of sbox is
    begin
        process(data_in)
        begin
            case data_in is
                when x"0" => data_out <= x"B";
                when x"1" => data_out <= x"F";
                when x"2" => data_out <= x"3";
                when x"3" => data_out <= x"2";
                when x"4" => data_out <= x"A";
                when x"5" => data_out <= x"C";
                when x"6" => data_out <= x"9";
                when x"7" => data_out <= x"1";
                when x"8" => data_out <= x"6";
                when x"9" => data_out <= x"7";
                when x"A" => data_out <= x"8";
                when x"B" => data_out <= x"0";
                when x"C" => data_out <= x"E";
                when x"D" => data_out <= x"5";
                when x"E" => data_out <= x"D";
                when x"F" => data_out <= x"4";
                when others => null; -- GHDL complains without this statement
            end case;
        end process;
    end behavioral;

architecture dataflow of sbox is
    begin
        with data_in select data_out <=
        x"B" when x"0",
        x"F" when x"1",
        x"3" when x"2",
        x"2" when x"3",
        x"A" when x"4",
        x"C" when x"5",
        x"9" when x"6",
        x"1" when x"7",
        x"6" when x"8",
        x"7" when x"9",
        x"8" when x"A",
        x"0" when x"B",
        x"E" when x"C",
        x"5" when x"D",
        x"D" when x"E",
        x"4" when x"F",
        x"X" when others; -- Prevents latches
    end architecture dataflow;

architecture structural of sbox is
    alias A is data_in(3);
    alias B is data_in(2);
    alias C is data_in(1);
    alias D is data_in(0);
    signal nA, nB, nC, nD: std_logic;
    begin 
        nA <= not A;
        nB <= not B;
        nC <= not C;
        nD <= not D;
        
        data_out(3) <= (nA and nC) or (B and nD) or (A and C and nD);
        data_out(2) <= (nC and D) or (A and nC) or (A and B);
        data_out(1) <= (nA and nB) or (nB and nC) or (nC and nD);
        data_out(0) <= (nA and nB and nC) or (nA and nB and nD) or (nA and B and C) or (B and C and nD) or (A and nC and D);
        
end architecture structural;
