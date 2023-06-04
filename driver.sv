
// `include "interface.sv"
`include "uvm_macros.svh"
 import uvm_pkg::*;

class adder_driver extends uvm_driver#(adder_transaction);
     `uvm_component_utils(adder_driver)
 
     //Interface declaration
      virtual intf vif;
 
     function new(string name, uvm_component parent);
          super.new(name, parent);
     endfunction: new
 
     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
     void'(uvm_resource_db#(virtual intf)::read_by_name(.scope("*"), .name("interface"), .val(vif)));
     endfunction: build_phase
 
     task run_phase(uvm_phase phase);
          //Our code here
          fork
          drive();
          join
     endtask: run_phase

    virtual task drive();
    
    adder_transaction sa_tx;
    integer counter = 0, state = 0;
    vif.a = 1'b0;
    vif.b = 1'b0;
    vif.en_i = 1'b0;
 
    forever begin
        if(counter==0) begin
            //Gets a transaction from the sequencer and
            //stores it in the variable 'sa_tx'
            seq_item_port.get_next_item(sa_tx);
        end
 
        @(posedge vif.clk)
        begin
            if(counter==0) begin
                vif.en_i = 1'b1;
                state = 1;
            end
 
            if(counter==1) begin
                vif.en_i = 1'b0;
            end   
 
            case(state)
                1: begin
                    vif.a = sa_tx.a;
                    vif.b = sa_tx.b;
 
                    // sa_tx.a = sa_tx.a &lt;&lt; 1;
                    // sa_tx.b = sa_tx.b &lt;&lt; 1;
 
                    counter = counter + 1;
                    if(counter==2) state = 2;
                end
 
                2: begin
                    vif.a = 1'b0;
                    vif.b = 1'b0;
                    counter = counter + 1;
 
                    if(counter==6) begin
                        counter = 0;
                        state = 0;
 
                        //Informs the sequencer that the
                        //current operation with
                        //the transaction was finished
                        seq_item_port.item_done();
                    end
                end
            endcase
        end
    end
endtask: drive
endclass: adder_driver
