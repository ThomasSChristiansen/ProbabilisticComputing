`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module grouped_update_order_LUT(group_EN, Pbit_EN);

input logic [0:3] group_EN;
output logic [0:13] Pbit_EN;

always_comb
begin 
case (group_EN)
3'b000 : Pbit_EN = 14'b10100001000000;
3'b001 : Pbit_EN = 14'b01001010000000;
3'b010 : Pbit_EN = 14'b00010100011000;
3'b011 : Pbit_EN = 14'b00000000100010;
3'b100 : Pbit_EN = 14'b00000000000101;
endcase
end
endmodule