module scpf(
    input clk,
    input clk1,
    input reset,
    output [31:0] WriteData,
    output [31:0] DataAdr,
    output MemWrite
);

    wire [31:0] PC;
    wire [31:0] Instr;
    wire [31:0] ReadData;

    // Instantiate single-cycle processor and memories
    singlcycleP s (.clk(clk), .reset(reset), .PC(PC), .Instr(Instr), .MemWrite(MemWrite), .ALUResult(DataAdr), .WriteData(WriteData), .ReadData(ReadData));

    imem2 IM (.a(PC), .clk(clk1), .rd(Instr));

    datam DM (.clk(clk), .a(DataAdr), .wd(WriteData), .we(MemWrite), .rd(ReadData));

endmodule
