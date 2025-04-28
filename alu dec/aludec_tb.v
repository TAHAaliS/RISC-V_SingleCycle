module tb_aludec;

    // Inputs
    reg opb5;
    reg [2:0] funct3;
    reg funct7b5;
    reg [1:0] ALUOp;

    // Outputs
    wire [2:0] ALUControl;

    // Instantiate the ALU Control module
    aludec uut (
        .opb5(opb5),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    // Test procedure
    initial begin
        // Display outputs
        $monitor("Time = %0d | opb5 = %b, funct3 = %b, funct7b5 = %b, ALUOp = %b -> ALUControl = %b",
                  $time, opb5, funct3, funct7b5, ALUOp, ALUControl);

        // Test case 1: ALUOp = 00 (addition)
        opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b00;
        #10;
        
        // Test case 2: ALUOp = 01 (subtraction)
        opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b01;
        #10;

        // Test case 3: ALUOp = 10 (R-type add/sub, funct3 = 000)
        opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b10;
        #10;
        
        // Test case 4: ALUOp = 10 (R-type add/sub, funct3 = 000 with subtraction)
        opb5 = 1; funct3 = 3'b000; funct7b5 = 1; ALUOp = 2'b10;
        #10;

        // Test case 5: ALUOp = 10 (R-type slt)
        opb5 = 0; funct3 = 3'b010; funct7b5 = 0; ALUOp = 2'b10;
        #10;
        
        // Test case 6: ALUOp = 10 (R-type or)
        opb5 = 0; funct3 = 3'b110; funct7b5 = 0; ALUOp = 2'b10;
        #10;

        // Test case 7: ALUOp = 10 (R-type and)
        opb5 = 0; funct3 = 3'b111; funct7b5 = 0; ALUOp = 2'b10;
        #10;

        // Test case 8: Invalid ALUOp and funct3
        opb5 = 0; funct3 = 3'b001; funct7b5 = 0; ALUOp = 2'b10;
        #10;

        // End simulation
        $finish;
    end
endmodule
