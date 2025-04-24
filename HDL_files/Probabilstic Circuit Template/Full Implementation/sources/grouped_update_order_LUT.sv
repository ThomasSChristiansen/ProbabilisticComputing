`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module grouped_update_order_LUT(group_EN, Pbit_EN);

input logic [0:2] group_EN;
output logic [0:6] Pbit_EN;

always_comb
begin 
case (group_EN)
  3'b000 : Pbit_EN = 7'b1010000;
  3'b001 : Pbit_EN = 7'b0101000;
  3'b010 : Pbit_EN = 7'b0000111;
endcase
end
endmodule
