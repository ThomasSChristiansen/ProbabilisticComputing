`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  P-bit module
//  This module controls the behaviour of a single P-bit using the LUT and LSFR.
//  Can handle binary and bipolar operation. 
//  For bipolar: Tanh_LUT_out and LFSR_out need to be signed. Uncomment the bipolar block. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module P_bit (
    input logic clk,                          // Clock signal
    input logic reset_n,                      // Reset signal
    input signed [7:0] I_i,                   // Weighted input for this P-bit
    input logic [31:0] seed,                  // Seed for random number generation
    input logic enable,                         
    output logic m_i                          // Output state of this P-bit
);

    // Internal signals
    logic [31:0] Tanh_LUT_out;                         // Output of the Tanh LUT
    logic [31:0] LFSR_out;                             // Output of the LFSR (random bit)

    // Instantiate the Tanh LUT
    Tanh_LUT tanh_lut_inst (
        .Tanh_LUT_in(I_i),                             // Weighted input
        .Tanh_LUT_out(Tanh_LUT_out)                    // Tanh LUT output
    );

    // Instantiate the LFSR
    LFSR lfsr_inst (
        .clk(clk),
        .reset_n(reset_n),
        .seed(seed),
        .LFSR_out(LFSR_out)                      
    );
    
//  Binary Operations block
    always @(posedge clk) begin
        if (enable == 1'b1) begin
            if (Tanh_LUT_out > LFSR_out) begin
                m_i <= 1'b1;
            end else if (Tanh_LUT_out < LFSR_out) begin
                m_i <= 1'b0;
            end else
                m_i <= 1'b0;
        end
    end
endmodule
