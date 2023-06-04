`include "uvm_macros.svh"
 import uvm_pkg::*;


class add_monitor extends uvm_monitor;

    `uvm_component_utils(add_monitor)

    uvm_analysis_port#(adder_transaction) mon_ap;
    virtual intf vif;
    adder_transaction txn;

    function new(string name, uvm_component parent);
        super.new(name,parent);
        mon_ap = new("mon_ap", this);
        txn = new();
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        void'(uvm_resource_db#(virtual intf)::read_by_name (.scope("ifs"), .name("interface"), .val(vif)));
        
        // mon_ap = uvm_config_db#(virtual intf)::get("mon_ap","interface",this);
        // if(!uvm_config_db#(virtual vif) :: get(.scope("ifs"), .name("interface"), .val(vif)))
        //   `uvm_fatal(get_type_name(), "Not set at top level");

    endfunction

    task run_phase(uvm_phase phase);

        fork

        collect_txn();

        join

    endtask

    task collect_txn();

        forever@(posedge vif.clk) begin


        txn = adder_transaction::type_id::create("txn", this);  

            txn.a = vif.a;   

            txn.b = vif.b;

            txn.out = vif.out;

        mon_ap.write(txn);
        $display("inside monitor run -------------------===========================");
        end

    endtask 

endclass : add_monitor
