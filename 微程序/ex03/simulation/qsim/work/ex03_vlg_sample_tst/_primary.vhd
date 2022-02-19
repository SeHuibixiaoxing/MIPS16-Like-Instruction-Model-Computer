library verilog;
use verilog.vl_types.all;
entity ex03_vlg_sample_tst is
    port(
        CLK_CONTINUOUS  : in     vl_logic;
        CLK_SINGLESTEP  : in     vl_logic;
        G               : in     vl_logic;
        \OPEN\          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end ex03_vlg_sample_tst;
