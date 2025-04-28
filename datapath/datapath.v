module datapath (
    input        clk, reset,          // Clock and reset
    input  [1:0] ResultSrc,           // Selects result source
    input        PCSrc, ALUSrc,       // PC and ALU source control
    input        RegWrite,            // Register write enable
    input  [1:0] ImmSrc,              // Immediate type selector
    input  [2:0] ALUControl,          // ALU operation control
    output       Zero,                // ALU zero flag
    output [31:0] PC,                 // Program counter
    input  [31:0] Instr,              // Instruction input
    output [31:0] ALUResult, WriteData, // ALU result and data to write
    input  [31:0] ReadData            // Data read from memory
);

    // Internal signals
    wire [31:0] PCNext, PCPlus4, PCTarget;  // Next PC values
    wire [31:0] ImmExt;                     // Extended immediate value
    wire [31:0] SrcA, SrcB;                 // ALU input sources
    wire [31:0] Result;                     // Final result

    // PC update logic
    flopr #(32) pcreg (.clk(clk), .reset(reset), .d(PCNext), .q(PC));       // PC register
    adder       pcadd4 (.a(PC), .b(32'd4), .y(PCPlus4));                   // PC + 4
    adder       pcaddbranch (.a(PC), .b(ImmExt), .y(PCTarget));            // PC + branch offset
    mux2 #(32)  pcmux (.d0(PCPlus4), .d1(PCTarget), .s(PCSrc), .y(PCNext));// PC source mux

    // Register file logic
    regfile rf (
        .clk(clk), 
        .we(RegWrite), 
        .ra1(Instr[19:15]),  // Source register 1
        .ra2(Instr[24:20]),  // Source register 2
        .wa(Instr[11:7]),    // Destination register
        .wd(Result),         // Data to write
        .rd1(SrcA),          // Output source 1
        .rd2(WriteData)      // Output source 2
    );

    // Immediate extension
    extend ext (.a(Instr[31:7]), .immsrc(ImmSrc), .immext(ImmExt));  // Immediate value generator

    // ALU logic
    mux2 #(32) srcbmux (.d0(WriteData), .d1(ImmExt), .s(ALUSrc), .y(SrcB)); // Select ALU input B
    alu alu (.a(SrcA), .b(SrcB), .ALUControl(ALUControl), .y(ALUResult), .Zero(Zero)); // ALU operation

    // Result selection
    mux3 #(32) resultmux (.d0(ALUResult), .d1(ReadData), .d2(PCPlus4), .s(ResultSrc), .y(Result)); // Final result mux

endmodule

