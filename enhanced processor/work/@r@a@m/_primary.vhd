library verilog;
use verilog.vl_types.all;
entity RAM is
    port(
        data_in         : in     vl_logic_vector(7 downto 0);
        addr            : in     vl_logic_vector(4 downto 0);
        we              : in     vl_logic;
        clk             : in     vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end RAM;
