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


module Multiplier_verilog(a, b, s);

input [0:3]a;
input [0:3]b;

output [0:3]s;


assign s = a*b;

endmodule