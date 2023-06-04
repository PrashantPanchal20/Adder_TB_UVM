`include "agent.sv"
`include "scoreboard.sv"

class adder_env extends uvm_env;
     `uvm_component_utils(adder_env)

     adder_agent sa_agent;
     adder_scoreboard sa_sb;

     function new(string name, uvm_component parent);
          super.new(name, parent);
     endfunction: new

     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
          sa_agent= adder_agent::type_id::create("sa_agent",this);
          sa_sb   = adder_scoreboard::type_id::create("sa_sb",this);
     endfunction: build_phase

     function void connect_phase(uvm_phase phase);
     uvm_top.print_topology();
          super.connect_phase(phase);
          sa_agent.agent_ap.connect(sa_sb.sb_export);
     endfunction: connect_phase
endclass: adder_env
