`timescale 1ns / 1ps

module Multiplier_4x4(a, b, s);

input [3:0]a;
input [3:0]b;

output [7:0]s;


assign s = a*b;

endmodule