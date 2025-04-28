module imem2(
input [31:0]a,
input clk,
output [31:0] rd
);

    im2_bb inst0(.address ({a[9:2],2'b00}),.clock ( clk ),.q (rd[7:0]));
    im2_bb inst1(.address ({a[9:2],2'b01}),.clock ( clk ),.q (rd[15:8]));
    im2_bb inst2(.address ({a[9:2],2'b10}),.clock ( clk ),.q (rd[23:16]));
    im2_bb inst3(.address ({a[9:2],2'b11}),.clock ( clk ),.q (rd[31:24]));

 endmodule