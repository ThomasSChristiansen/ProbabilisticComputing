`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  3 P-bit AND gate module
//  This module computes the weight I_i for each instantiated P-bit. 
//  The weight update has the inputs of the weight matrix J
//  and bias vector h representated in fixed point s[4][3]. 
//  The computation includes multiplication - meaning we go to s[8][6] and back while loosing some precision.
//  The computation include overflow detection/correction for specific parts such as the addition part. 
//  
//  Ex: h=15.875 result_Jm=8 then addition_hi=23.875 (outside s[4][3] range of 15.875 - wraps aound)
//      If overflow is not accounted for this would equal -8 instead of the correct value clamped to max.     
//
//  A Sequencer is also implemented with each P-bit being active for 3 clock cycles 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module P_bit_AND (
    input logic clk,                            // Clock signal
    output logic clk_out,
    input logic reset_n,                        // Reset signal
    output logic m [0:2],                        // States of the 3 P-bits
    output logic [2:0] active_P_bit
);

    // Binary operation
    
    // Weight matrix (3x3)
    parameter J_00 = 8'sb00000000;  parameter J_01 = 8'sb11110000;  parameter J_02 = 8'sb00100000;
    parameter J_10 = 8'sb11110000;  parameter J_11 = 8'sb00000000;  parameter J_12 = 8'sb00100000;
    parameter J_20 = 8'sb00100000;  parameter J_21 = 8'sb00100000;  parameter J_22 = 8'sb00000000;
    logic signed [7:0] J [0:2][0:2] = '{{J_00,J_01,J_02},
                                        {J_10,J_11,J_12},
                                        {J_20,J_21,J_22}};        
    // Bias vector
    parameter h0 = 8'sb01111111;            // Høj
    parameter h1 = 8'sb01111111;            // Høj
    parameter h2 = 8'sb11010000;            // -6
    logic signed [7:0] h [0:2] = '{h0,h1,h2};
    
    // Interconnection strengh
    parameter I_0 = 8'sb00001000;
    
    // Seeds
    parameter seed0 = 32'b11011010111000011110101101111000;     // Default seed for first P-bit
    parameter seed1 = 32'b10101101010010101011001100011110;     // Default seed for second P-bit
    parameter seed2 = 32'b11010001101101010011111010010001;     // Default seed for third P-bit
    logic [31:0] seed [0:2] = '{seed0,seed1,seed2};          // Seed values for 3 LFSRs    
    
    // Internal signals
    logic signed [7:0] I_i [0:2];               // Weighted inputs for each P-bit
    logic signed [15:0] product_Jm [0:2];       // Inner Product
    logic signed [7:0] result_Jm [0:2];         // Result 
    logic signed [15:0] product_I0 [0:2];       // Product of I0 and sum
    logic signed [7:0] addition_hi [0:2];       // hi+sum(J_ij+m_j)

    
    always @(posedge active_P_bit[0]) begin
        if (reset_n == 0)
            clk_out = 0;
        else
            clk_out += 1;
        end
        
    // Sequencer with 3 clock cycle delay. 
    logic [1:0] clk_delay;
//    logic [2:0] active_P_bit;
    always @(posedge clk, negedge reset_n) begin  //seperate clocks for each pbit
        if (reset_n == 0) begin  //initial value 
            active_P_bit = 3'b001;
            clk_delay = 2'b00;
        end else begin
            clk_delay += 1'b1;
            if (clk_delay == 2'b11) begin   // When clk_delay reaches 3
                active_P_bit = {active_P_bit[1:0], active_P_bit[2]};  //rotate operation
                clk_delay = 2'b00;  // Reset delay counter
            end
        end
    end
     
    // Weight update binary
    always @(posedge clk) begin
        integer i, j;
        for (i=0; i<3; i=i+1) begin
            if (active_P_bit[i]) begin  // Only update active P-bit
                result_Jm[i] = 8'sb00000000;
                for (j=0; j<3; j=j+1) begin
                    product_Jm[i] = J[i][j] * m[j];
                    result_Jm[i] = result_Jm[i] + (product_Jm[i]);
                end
                
                // Detect Overflow Before Addition
                if ((h[i] > 0) && (result_Jm[i] > 8'sb01111111 - h[i])) begin
                    addition_hi[i] = 8'sb01111111; // Clamp to Max
                end else if ((h[i] < 0) && (result_Jm[i] < 8'sb10000000 - h[i])) begin
                    addition_hi[i] = 8'sb10000000; // Clamp to Min
                end else begin
                    addition_hi[i] = h[i] + result_Jm[i];  // Safe Addition
                end
                
                product_I0[i] = I_0 * addition_hi[i];
                I_i[i] = product_I0[i] >>> 3;  // Shift down to s[4][3]
            end
        end
    end

    
    // Instantiate 3 P-bits
    genvar i;
    generate
        for (i = 0; i < 3; i++) begin : P_bit_instances
            P_bit p_bit_inst (
                .clk(clk),
                .enable(active_P_bit[i]),           // Enable only the P-bit corresponding to the active_p_bit
                .reset_n(reset_n),
                .I_i(I_i[i]),                    // Pass pre-computed weighted input
                .seed(seed[i]),
                .m_i(m[i])                       // Output state of the P-bit
            );
        end
    endgenerate

endmodule

