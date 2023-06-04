`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

`include "uvm_macros.svh"
 import uvm_pkg::*;

class adder_agent extends uvm_agent;
     `uvm_component_utils(adder_agent)
 
     // Analysis ports to connect the monitors to the scoreboard
     uvm_analysis_port#(adder_transaction) agent_ap;
     // add_sequencer#(adder_transaction) sa_seqr;
     add_sequencer sa_seqr;
     adder_driver sa_drvr;
     add_monitor sa_mon;
     virtual intf vif;

     function new(string name = "adder_agent", uvm_component parent = null);
          super.new(name, parent);
          agent_ap = new("agent_ap", this);

     endfunction: new
 
     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
 
          sa_seqr = add_sequencer::type_id::create("sa_seqr",this);
          sa_drvr = adder_driver::type_id::create("sa_drvr",this);
          sa_mon  = add_monitor::type_id::create("sa_mon",this);
     endfunction: build_phase
 
     function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
          sa_drvr.seq_item_port.connect(sa_seqr.seq_item_export);
          sa_mon.mon_ap.connect(agent_ap);
     endfunction: connect_phase
endclass: adder_agent
