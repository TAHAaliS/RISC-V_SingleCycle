module regfile (
    input clk,                       // Clock signal
    input we,                  // Write enable signal
    input [4:0] ra1,          // Address of the first register to read
    input [4:0] ra2,          // Address of the second register to read
    input [4:0] wa,          // Address of the register to write to
    input [31:0] wd,         // Data to write
    output [31:0] rd1,        // Data read from the first register
    output [31:0] rd2         // Data read from the second register
);
    reg [31:0] regFile [0:31];      // Register file with 32 registers

    // Read logic
    assign rd1 = (ra1 == 5'b0) ? regFile[ra1] : 32'b0; // Read from regFile or 0 for address 0
    assign rd2 = (ra2 == 5'b0) ? regFile[ra2] : 32'b0; // Read from regFile or 0 for address 0

    // Write logic
    always @(posedge clk) begin
        if (we && (wa != 5'b0)) // Prevent writing to register 0
            regFile[wa] <= wd; // Write data to specified register
    end
endmodule
