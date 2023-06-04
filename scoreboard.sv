// `include "transaction.sv"

class adder_scoreboard extends uvm_scoreboard;
     `uvm_component_utils(adder_scoreboard)
 
     uvm_analysis_port #(adder_transaction) sb_export;
 
     // uvm_tlm_analysis_fifo #(adder_transaction) fifo;
 
     // adder_transaction transaction;
     adder_transaction txn;
 
     function new(string name, uvm_component parent);
          super.new(name, parent);
          txn    = new("txn");
     endfunction: new
 
     function void build_phase(uvm_phase phase);
          super.build_phase(phase);
          sb_export  = new("sb_export", this);
     endfunction: build_phase
 
     // function void connect_phase(uvm_phase phase);
     // endfunction: connect_phase

     virtual function void write(txn);
          $display("SCB:: Transaction Pkt recived");
          txn.print();
          endfunction : write
 
     task run_phase(uvm_phase phase);
          //forever 
          begin
               $display("Inside task run");
               // fifo.get(transaction);
               compare();
          end
     endtask: run_phase
 
     function void compare();
          if(txn) begin
               `uvm_info("compare", {"Test: OK!"}, UVM_LOW);
               `uvm_info("base_seq",$sformatf("a=%0b and b=%0b and out = %0b",txn.a,txn.b,txn.out),UVM_LOW);

        //   end else begin
        //        `uvm_info("compare", {"Test: Fail!"}, UVM_LOW);
          end
     endfunction
endclass: adder_scoreboard
