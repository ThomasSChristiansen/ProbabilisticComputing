`timescale 1ns / 1ps

module Comparator ( GE, clk, Tanh_LUT_out, LFSR_out, m);

input GE;                           // global enable
input clk;                          // Clock
output logic m;                   // System output
input [31:0] Tanh_LUT_out;          // Hyper tangent LUT output
input [31:0] LFSR_out;              // LFSR output

// Compare hyper tangent LUT with the current LFSR output.
// 1 if Tanh_LUT_out is larger than LFSR_out and 0 sotherwise.

always @ (posedge clk) begin
    if (GE == 1'b1) begin
        m <= (Tanh_LUT_out > LFSR_out) ? 1'b1 : 1'b0; 
    end
end
endmodule