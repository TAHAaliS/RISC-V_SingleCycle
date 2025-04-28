 module datam(
    input wire clk,
    input wire [31:0] a,
    input wire [31:0] wd,
    input wire we,
    output wire [31:0] rd
);

 dm dm0(.address ({a[9:2],2'b00}),.clock (clk),.data(wd[7:0]),.wren (we),.q(rd[7:0]));
 dm dm1(.address ({a[9:2],2'b01}),.clock (clk),.data(wd[15:8]),.wren (we),.q(rd[15:8]));
 dm dm2(.address ({a[9:2],2'b10}),.clock (clk),.data(wd[23:16]),.wren (we),.q(rd[23:16]));
 dm dm3(.address ({a[9:2],2'b11}),.clock (clk),.data(wd[31:24]),.wren (we),.q(rd[31:24]));

endmodule