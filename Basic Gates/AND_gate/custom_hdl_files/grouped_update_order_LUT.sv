`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module grouped_update_order_LUT(group_EN, Pbit_EN);

input logic [0:2] group_EN;
output logic [0:2] Pbit_EN;

always_comb
begin 
case (group_EN)
  3'b000 : Pbit_EN = 3'b100;
  3'b001 : Pbit_EN = 3'b010;
  3'b010 : Pbit_EN = 3'b001;
endcase
end
endmodule
