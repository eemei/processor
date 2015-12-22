library verilog;
use verilog.vl_types.all;
entity IRregiester is
    port(
        clock           : in     vl_logic;
        Reset           : in     vl_logic;
        Q_ram           : in     vl_logic_vector(7 downto 0);
        IRload          : in     vl_logic;
        JMPmux          : in     vl_logic;
        PCload          : in     vl_logic;
        Meminst         : in     vl_logic;
        Asel            : in     vl_logic_vector(1 downto 0);
        IR              : out    vl_logic_vector(2 downto 0);
        Q_IR            : out    vl_logic_vector(7 downto 0);
        D_PC            : out    vl_logic_vector(4 downto 0);
        Q_Incr          : out    vl_logic_vector(4 downto 0);
        Q_PC            : out    vl_logic_vector(4 downto 0);
        Q_Meminst       : out    vl_logic_vector(4 downto 0);
        Q_IRmux         : out    vl_logic_vector(4 downto 0)
    );
end IRregiester;
