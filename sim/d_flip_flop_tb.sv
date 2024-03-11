`include "../hdl/d_flip_flop.sv"

module d_flip_flop_tb;
logic D;
logic Q;
logic Qn;
logic clk;
logic rst;

logic [1:0] D_test_vals = {1'b1, 1'b0};

logic D_prev;

// rand bit D_rand;

// instantiate DUT
d_flip_flop dut
(
    .i_D(D),
    .o_Q(Q),
    .o_Qn(Qn),
  
    .i_clk(clk),
    .i_rst(rst)
);

// generate clock
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("d_flip_flop_tb.vcd");
    $dumpvars(0, d_flip_flop_tb);
end

    initial begin
        #1 rst <= 1'bx; clk <= 1'bx; D <= 1'bx;
        #(CLK_PERIOD*3) rst <= 0;

        // reset FIFO
        #(CLK_PERIOD*3) rst <= 1; clk <= 0; D <= 0;
        repeat(3) @(posedge clk);
        rst <= 0;
        // output should be 0 after reset
        assert (Q == 1'b0);
        assert (Qn == 1'b1);
        for (int i = 0; i < 15; i++) begin
            D_prev <= D;
            D <= $urandom_range(1);
            @(posedge clk);
            assert (Q == D_prev);
        end
        // D <= $urandom_range(1);

        @(posedge clk);
        repeat(2) @(posedge clk);
        $finish(2);
    end
    
    // Icarus Verilog does not support concurrent assertions :(
    // assert property (!(Q && Qn));

endmodule