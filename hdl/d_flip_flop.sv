//=========================================================================
// D Flip Flop
//=========================================================================

module d_flip_flop (
  input   logic   i_D,
  output  logic   o_Q,
  output  logic   o_Qn,

  input   logic   i_clk,
  input   logic   i_rst
);

  always_ff @(posedge i_clk) begin
    if(i_rst) begin
      o_Q   <= 0;
      o_Qn  <= 1;
    end else begin
      o_Q   <= i_D;
      o_Qn  <= ~i_D;
    end
  end
    
endmodule