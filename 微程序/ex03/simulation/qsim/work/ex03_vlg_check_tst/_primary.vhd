library verilog;
use verilog.vl_types.all;
entity ex03_vlg_check_tst is
    port(
        PCO             : in     vl_logic_vector(15 downto 0);
        P_RAMO          : in     vl_logic;
        P_RO            : in     vl_logic;
        P_UPCO          : in     vl_logic;
        R2O             : in     vl_logic_vector(15 downto 0);
        R6O             : in     vl_logic_vector(15 downto 0);
        R7O             : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end ex03_vlg_check_tst;
