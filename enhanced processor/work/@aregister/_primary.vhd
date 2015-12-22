library verilog;
use verilog.vl_types.all;
entity Aregister is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        Input           : in     vl_logic_vector(7 downto 0);
        Asel            : in     vl_logic_vector(1 downto 0);
        Aload           : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        Sub             : in     vl_logic;
        Aeq0            : out    vl_logic;
        Apos            : out    vl_logic;
        Output          : out    vl_logic_vector(7 downto 0);
        Q_A             : out    vl_logic_vector(7 downto 0);
        Q_addsub        : out    vl_logic_vector(7 downto 0);
        D_A             : out    vl_logic_vector(7 downto 0)
    );
end Aregister;
