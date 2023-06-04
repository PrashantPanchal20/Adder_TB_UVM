// Code your design here
module adder(clk,a,b,en_i,out,en_o);
  input a,b,clk,en_i;
  output reg out, en_o;

  always @(posedge clk) begin
    if (en_i) begin
      assign out = a ^ b;
      assign en_o = a & b;
      end
    else 
      out = 0; 
  end
endmodule
