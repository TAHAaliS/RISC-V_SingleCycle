module flopr #(parameter WIDTH = 32) (
    input clk,
    input reset,
    input [WIDTH-1:0] d,          // Input data to be stored
    output reg [WIDTH-1:0] q      // Output stored data
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;                // Reset output to 0
        else
            q <= d;                // Store input data on clock edge
    end
endmodule
