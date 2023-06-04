`include "uvm_macros.svh" 
 import uvm_pkg::*;
`include "env.sv"
`include "sequence_.sv"
// `include "sequencer.sv"


class adder_test extends uvm_test;
     `uvm_component_utils(adder_test)
 
     adder_env sa_env;
     base_seq sa_seq;
 
     function new(string name, uvm_component parent);
          super.new(name, parent);
     endfunction: new
 
     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
          sa_env = adder_env::type_id::create("sa_env",this);
     endfunction: build_phase
 
     task run_phase(uvm_phase phase);
 
          phase.raise_objection(.obj(this));

          sa_seq = base_seq::type_id::create("sa_seq",this);
          
          repeat(1) begin 
               #5; sa_seq.start(sa_env.sa_agent.sa_seqr);
               end
          
          phase.drop_objection(.obj(this));
     endtask: run_phase
endclass: adder_test
