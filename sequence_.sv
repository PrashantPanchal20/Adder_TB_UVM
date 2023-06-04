
// `include "transaction.sv"
`include "uvm_macros.svh"
 import uvm_pkg::*;

class base_seq extends uvm_sequence#(adder_transaction);
  `uvm_object_utils(base_seq)
  adder_transaction req;

  function new (string name = "base_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
    `uvm_do(req);
    
    `uvm_info("base_seq",$sformatf("INSIDE SEQUENCE :: a=%0b and b=%0b and out = %0b",req.a,req.b,req.out),UVM_LOW);
    $monitor("a = %0b b = %0b out = %0b",req.a,req.b,req.out);
  endtask
endclass
