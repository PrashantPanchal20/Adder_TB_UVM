class random;

rand bit [3:0] a;
randc bit [3:0] b;

endclass

module randomization();

random rd;
initial begin
    rd = new();

    repeat (10) begin
      rd.randomize();
      $display("values are rand=%0d and randc=%0d",rd.a,rd.b);
      
    end
end

endmodule

// a ::  takes the random value on every randomization
// b ::  takes the random value on every randomization, 
//       but takes random value until every possible value has been assigned.
//       No will repeat the values again
