`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// If clamp_EN is high, clamps the output P-bits to a desired state provided by clamp.
// 53 corresponds to the total number of P-bits and 8 to the number of output P-bits,
// these values would have to be manually adjusted on a per system basis.
//////////////////////////////////////////////////////////////////////////////////

`include "global_params.svh"
module clamper (
    input logic signed [0:7] h [0:num_Pbits-1],          //h from bias at floating operation
    input logic clamp [0:7],                   //desired clamped value of output P-bits
    input logic clamp_EN,

    output logic signed [0:7] h_clamped [0:num_Pbits-1]  //clamped h bias vector
);

    integer i;

    always_comb begin
        h_clamped = h;  //move the h values to the output

        if (clamp_EN == 1'b1) begin
            for (i = 0; i < 8; i = i + 1) begin  //looping through the output P_bits 
            h_clamped[num_Pbits - 16 + i] = clamp[i] ? 8'b01111111 : 8'b10000000;  //replace the clamped values
            end
        end
    end


endmodule
