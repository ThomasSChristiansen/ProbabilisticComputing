`timescale 1ns / 1ps

module Comparator ( GE, clk, Tanh_LUT_out, LFSR_out, s_out, clamp_en, clamp_value);

input GE; // global enable
input clk;
input clamp_en;
input clamp_value;

output reg s_out; 

input [31:0] Tanh_LUT_out;
input [31:0] LFSR_out;


always @ (posedge clk) begin
    if (GE == 1'b1) begin
        if (clamp_en) begin
            s_out <= clamp_value;  // Force the output to clamp_value
        end else begin
            s_out <= (Tanh_LUT_out > LFSR_out) ? 1'b1 : 1'b0;  // Normal behavior
        end
    end
end
endmodule 