library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    generic(
        start           : integer := 0;
        fetch           : integer := 1;
        decode          : integer := 2;
        load            : integer := 8;
        store           : integer := 9;
        add             : integer := 10;
        sub             : integer := 11;
        Input           : integer := 12;
        jz              : integer := 13;
        jpos            : integer := 14;
        halt            : integer := 15
    );
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        Enter           : in     vl_logic;
        IR              : in     vl_logic_vector(7 downto 5);
        Aeq0            : in     vl_logic;
        Apos            : in     vl_logic;
        IRload          : out    vl_logic;
        JMPmux          : out    vl_logic;
        PCload          : out    vl_logic;
        Meminst         : out    vl_logic;
        MemWr           : out    vl_logic;
        Aload           : out    vl_logic;
        \Sub\           : out    vl_logic;
        \Halt\          : out    vl_logic;
        Asel            : out    vl_logic_vector(1 downto 0);
        state           : out    vl_logic_vector(3 downto 0);
        next_state      : out    vl_logic_vector(3 downto 0)
    );
end ControlUnit;
