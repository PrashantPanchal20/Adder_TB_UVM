//sequence generater 
`include "transaction.sv"
`include "interface.sv"
`include "uvm_macros.svh"
 import uvm_pkg::*;
 

class add_sequencer extends uvm_sequencer#(adder_transaction);
     `uvm_component_utils(add_sequencer)
 
     function new(string name = "add_sequencer", uvm_component parent = null );
          super.new(name, parent);
     endfunction: new
     
     adder_transaction adr;
     // task body();
          // adder_transaction sa_tx;
 
          // repeat(15) begin
          //       sa_tx = adder_transaction::type_id::create("sa_tx");
          //       start_item(sa_tx);
          //       assert(sa_tx.randomize());
          //       finish_item(sa_tx);                          //its a part of sequence
          // end
     // endtask: body
     function void build_phase(uvm_phase phase);
               super.build_phase(phase);
               adr = adder_transaction::type_id::create("adr");
     endfunction
endclass: add_sequencer
