module adder(
input   [31:0] a, b,   // taking input a&b
output [31:0] y        // output y  
);
 assign y = a + b;
 endmodule