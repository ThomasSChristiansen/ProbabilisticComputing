`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2025 12:00:46
// Design Name: 
// Module Name: clamper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: if clamp_EN is high, clamps the output P-bits to a desired state provided by clamp.
//              53 corresponds to the total number of P-bits and 8 to the number of output P-bits,
//              these values would have to be manually adjusted on a per system basis.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clamper(
    input logic signed [0:7]h[0:90],          //h from bias at floating operation
    input logic clamp[0:7],                   //desired clamped value of output P-bits
    input logic clamp_EN,
    
    output logic signed [0:7]h_clamped[0:90]  //clamped h bias vector
);

    integer i;
    
    always_comb begin
        h_clamped = h;  //move the h values to the output
        
        if (clamp_EN == 1'b1) begin
            for (i = 0; i < 8; i = i + 1) begin  //looping through the output P_bits 
            h_clamped[53 - 8 + i] = clamp[i] ? 8'b10000000 : 8'b01111111;  //replace the clamped values
            end
        end
    end
    
    
endmodule
