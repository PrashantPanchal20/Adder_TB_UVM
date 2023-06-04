`include "uvm_macros.svh"
 import uvm_pkg::*;
`include "test.sv"
// `include "interface.sv"
`include "dut.v"

module top;

intf vif();

adder design_module(vif.clk, vif.a, vif.b, vif.en_i, vif.out, vif.en_o);

initial begin
    //database register ->> configuration block
    uvm_resource_db#(virtual intf)::set(.scope("*"),.name("interface"), .val(vif));

    run_test("adder_test");
end
initial begin
    vif.clk = 0;
end

always #5 vif.clk = ~vif.clk;

endmodule

//https://colorlesscube.com/uvm-guide-for-beginners/chapter-3-top-block/
