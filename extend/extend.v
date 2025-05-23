module extend(
    input  [31:7] a,
    input  [1:0]  immsrc,
    output reg [31:0] immext
);

    always @(*) begin
        case(immsrc)
            // I-type
            2'b00: immext = {{20{a[31]}}, a[31:20]};
            // S-type (stores)
            2'b01: immext = {{20{a[31]}}, a[31:25], a[11:7]};
            // B-type (branches)
            2'b10: immext = {{20{a[31]}}, a[7], a[30:25], a[11:8], 1'b0};
            // J-type (jal)
            2'b11: immext = {{12{a[31]}}, a[19:12], a[20], a[30:21], 1'b0};
            default: immext = 32'bx; // undefined
        endcase
    end
endmodule
