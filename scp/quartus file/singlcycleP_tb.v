`timescale 1ns / 1ps

module singlcycleP_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] Instr;
    reg [31:0] ReadData;

    // Outputs
    wire [31:0] PC;
    wire MemWrite;
    wire [31:0] ALUResult;
    wire [31:0] WriteData;

    // Instantiate the Unit Under Test (UUT)
    singlcycleP uut (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .MemWrite(MemWrite),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        Instr = 32'b0;
        ReadData = 32'b0;

        // Wait for global reset
        #20;
        reset = 0;

        // Test 1: Provide an instruction (sample instruction and ReadData for testing)
        Instr = 32'h00000033; // Example R-type instruction
        ReadData = 32'h12345678;
        #10;

        // Test 2: Another instruction
        Instr = 32'h00000013; // Example I-type instruction
        #10;

        // Add more tests as needed

        // Finish simulation after some time
        #50;
        $stop;
    end
endmodule
