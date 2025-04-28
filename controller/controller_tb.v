module tb_controller;

    // Inputs
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7b5;
    reg Zero;

    // Outputs
    wire [1:0] ResultSrc;
    wire MemWrite;
    wire PCSrc;
    wire ALUSrc;
    wire RegWrite;
    wire Jump;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    // Instantiate the controller module
    controller uut (
        .op(op),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .Zero(Zero),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)
    );

    // Test procedure
    initial begin
        // Display outputs
        $monitor("Time = %0d | op = %b, funct3 = %b, funct7b5 = %b, Zero = %b | ResultSrc = %b, MemWrite = %b, PCSrc = %b, ALUSrc = %b, RegWrite = %b, Jump = %b, ImmSrc = %b, ALUControl = %b",
                  $time, op, funct3, funct7b5, Zero, ResultSrc, MemWrite, PCSrc, ALUSrc, RegWrite, Jump, ImmSrc, ALUControl);

        // Test case 1: R-type instruction (funct3 = 000, funct7b5 = 0, op = 0000011)
        op = 7'b0000011; funct3 = 3'b000; funct7b5 = 0; Zero = 0;
        #10;

        // Test case 2: I-type instruction (funct3 = 000, funct7b5 = 0, op = 0010011)
        op = 7'b0010011; funct3 = 3'b000; funct7b5 = 0; Zero = 0;
        #10;

        // Test case 3: Branch instruction (Branch = 1, Zero = 1)
        op = 7'b1100011; funct3 = 3'b000; funct7b5 = 0; Zero = 1; 
        #10;

        // Test case 4: Jump instruction (Jump = 1)
        op = 7'b1101111; funct3 = 3'b000; funct7b5 = 0; Zero = 0;
        #10;

        // Test case 5: Memory write instruction (MemWrite = 1)
        op = 7'b0100011; funct3 = 3'b000; funct7b5 = 0; Zero = 0;
        #10;

        // Test case 6: ALU operation with Zero = 1 (ALUSrc = 1)
        op = 7'b0110011; funct3 = 3'b000; funct7b5 = 0; Zero = 1;
        #10;

        // Test case 7: ALU operation with Zero = 0 (ALUSrc = 0)
        op = 7'b0110011; funct3 = 3'b000; funct7b5 = 0; Zero = 0;
        #10;

        // Test case 8: I-type instruction with different funct3
        op = 7'b0000011; funct3 = 3'b100; funct7b5 = 0; Zero = 0;
        #10;

        // End simulation
        $finish;
    end
endmodule

