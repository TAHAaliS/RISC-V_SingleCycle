module controller(
    input  [6:0] op,         // Opcode from instruction
    input  [2:0] funct3,     // funct3 field for ALU operation
    input        funct7b5,   // MSB of funct7 for subtraction
    input        Zero,       // ALU zero flag
    output [1:0] ResultSrc,  // Selects result source
    output       MemWrite,   // Enables memory write
    output       PCSrc,      // Controls PC update (branch/jump)
    output       ALUSrc,     // Selects ALU second operand
    output       RegWrite,   // Enables register write
    output       Jump,       // Jump control signal
    output [1:0] ImmSrc,     // Immediate type selector
    output [2:0] ALUControl  // ALU operation control
);

    wire [1:0] ALUOp;        // ALU operation type
    wire       Branch;       // Branch control signal

    // Main decoder: generates control signals based on opcode
    maindec md(
        .op(op), 
        .ResultSrc(ResultSrc), 
        .MemWrite(MemWrite), 
        .Branch(Branch),
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .Jump(Jump), 
        .ImmSrc(ImmSrc), 
        .ALUOp(ALUOp)
    );

    // ALU decoder: determines ALU operation based on funct3, funct7, and ALUOp
    aludec ad(
        .opb5(op[5]), 
        .funct3(funct3), 
        .funct7b5(funct7b5), 
        .ALUOp(ALUOp), 
        .ALUControl(ALUControl)
    );

    // PCSrc: selects PC update source (branch/jump logic)
    assign PCSrc = (Branch & Zero) | Jump;

endmodule

