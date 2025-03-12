`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Linear Feedback Shift Register output unsigned 32bit s[0][32] random values in the range [0,1].
//  Taps at bit 32, 22, 2, and 1.
// THIS IS FOR BINARY OPERATIONS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module LFSR (clk, reset_n, LFSR_out, seed);

input [31:0] seed;
input clk;
input reset_n;
output logic [31:0] LFSR_out;

logic [32:1] r_LFSR;
logic feedback;
 

  // Create Feedback Polynomials.  Based on Application Note:
// http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
always @(*)
    begin
          feedback = r_LFSR[32] ^~ r_LFSR[22] ^~ r_LFSR[2] ^~ r_LFSR[1];
    end

always @(posedge clk, negedge reset_n)
    begin 
       if (reset_n == 0) 
            r_LFSR <= seed;
       else 
            r_LFSR <= {r_LFSR[32:1], feedback};
    end
    
assign LFSR_out = r_LFSR[32:1];
 
endmodule // LFSR