module mux2 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] d0,         // Input data 0
    input [WIDTH-1:0] d1,         // Input data 1
    input s,                       // Select signal
    output [WIDTH-1:0] y          // Output data
);
    assign y = s ? d1 : d0;       // Multiplexer logic
endmodule
