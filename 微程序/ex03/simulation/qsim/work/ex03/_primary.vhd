library verilog;
use verilog.vl_types.all;
entity ex03 is
    port(
        altera_reserved_tms: in     vl_logic;
        altera_reserved_tck: in     vl_logic;
        altera_reserved_tdi: in     vl_logic;
        altera_reserved_tdo: out    vl_logic;
        P_UPCO          : out    vl_logic;
        P_RO            : out    vl_logic;
        P_RAMO          : out    vl_logic;
        PCO             : out    vl_logic_vector(15 downto 0);
        R2O             : out    vl_logic_vector(15 downto 0);
        R6O             : out    vl_logic_vector(15 downto 0);
        R7O             : out    vl_logic_vector(15 downto 0);
        G               : in     vl_logic;
        \OPEN\          : in     vl_logic;
        CLK_CONTINUOUS  : in     vl_logic;
        CLK_SINGLESTEP  : in     vl_logic
    );
end ex03;
