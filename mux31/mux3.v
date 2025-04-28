module mux3 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] d0,         // Input data 0
    input [WIDTH-1:0] d1,         // Input data 1
    input [WIDTH-1:0] d2,         // Input data 2
    input [1:0] s,                // 2-bit select signal
    output [WIDTH-1:0] y          // Output data
);
    assign y = s[1] ? d2 : (s[0] ? d1 : d0); // Multiplexer logic
endmodule
