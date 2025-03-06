`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2025 12:23:40
// Design Name: 
// Module Name: Multiplier_verilog
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplier_3x3(a, b, s);

input [2:0]a;
input [2:0]b;

output [5:0]s;


assign s = a*b;

endmodule