library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        ALOAD           : in     vl_logic;
        C               : in     vl_logic;
        D               : in     vl_logic_vector(7 downto 0);
        Q               : out    vl_logic_vector(7 downto 0)
    );
end counter;
