module alu (
    input [31:0] a,                // First operand
    input [31:0] b,                // Second operand
    input [2:0] ALUControl,        // Control signal to select operation
    output reg [31:0] y,   // Result of the operation
    output reg Zero                // Zero flag
);
    always @(*) begin
        case (ALUControl)
            3'b000: y = a + b;           // Addition
            3'b001: y = a - b;           // Subtraction
            3'b010: y = a & b;           // AND
            3'b011: y = a | b;           // OR
            3'b100: y = a ^ b;           // XOR
            3'b101: y = (a < b) ? 32'b1 : 32'b0; // Set Less Than
            default: y = 32'b0;           // Default case
        endcase
        
        // Set Zero flag
        Zero = (y == 32'b0) ? 1'b1 : 1'b0;
    end
endmodule
