library verilog;
use verilog.vl_types.all;
entity main is
    generic(
        S0              : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        S1              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        S2              : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        S3              : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        rst             : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        clk             : in     vl_logic;
        r               : in     vl_logic;
        a_tr            : in     vl_logic;
        b_tr            : in     vl_logic;
        a_ti_l          : out    vl_logic_vector(3 downto 0);
        a_ti_h          : out    vl_logic_vector(3 downto 0);
        b_ti_l          : out    vl_logic_vector(3 downto 0);
        b_ti_h          : out    vl_logic_vector(3 downto 0);
        a_l             : out    vl_logic;
        b_l             : out    vl_logic;
        c               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
end main;
