`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	This is the standard source for a probabilistic circuit
//	For different behaviour input different
//	- num_Pbits based on size of network, line 11
//	- Name of mem files for h, J and seeds, starting line 27
//	- Range on output pbits, line 122
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "global_params.svh"
module probabalistic_top_level_template(
    input logic clk,                            // Clock signal
    input logic reset_n,                        // Reset signal
    input logic clamp [0:7],                     // Bias vector for num_Pbits
    input clamp_EN,                             // Enable clamping
    output logic [0:num_Out-1] out,                      // States of the num_Pbits P-bits
    output logic [1:0] clk_delay
);
    // Intermediate output storage
    logic [0:num_Pbits-1] m;


    // Memory for compressed data
    logic signed [7:0] values [0:463];      // Nonzero values 
    logic [7:0] col_indices [0:463];        // Column indices
    logic [15:0] row_ptr [0:num_Pbits];      // Row pointers 
    logic signed [7:0] h [0:num_Pbits-1];   // Bias vector
    logic [31:0] seed [0:num_Pbits-1];      // Random seed array

    // Load values, col_indices, row_ptr, and h from .mem files
    initial begin
        $readmemb("4bIntFac_v7_values.mem", values);
        $readmemb("4bIntFac_v7_col_indices.mem", col_indices);
        $readmemb("4bIntFac_v7_row_ptr.mem", row_ptr);
        $readmemb("4bIntFac_v7_h.mem", h);
        $readmemb("4bIntFac_v7_seeds.mem", seed);
    end
    
    // Interconnection strengh
    parameter I_0 = 8'sb00001000;  //I_0 = 1
    
    // Internal signals
    logic signed [7:0] I_i [0:num_Pbits-1];               // Weighted inputs for each P-bit
    logic signed [7:0] product_Jm [0:num_Pbits-1];        // Inner Product
    logic signed [7:0] result_Jm [0:num_Pbits-1];         // Result 
    logic signed [15:0] product_I0 [0:num_Pbits-1];       // Product of I0 and sum
    logic signed [7:0] addition_hi [0:num_Pbits-1];       // hi+sum(J_ij+m_j)
    logic signed [8:0] extended_addition [0:num_Pbits-1];
    logic signed [8:0] extended_result_Jm [0:num_Pbits-1]; 
    logic signed [7:0] h_clamped [0:num_Pbits-1];         //clamped bias vector
    
    
    // Clamping
    clamper clamper (
    .h(h),
    .clamp(clamp),
    .clamp_EN(clamp_EN),
    .h_clamped(h_clamped)
    );
    
    // Sequencer with 3 clock cycle delay. 
    logic [0:2] group_EN;
    logic [0:num_Pbits-1] Pbit_EN;
//    logic [1:0] clk_delay;
    always @(posedge clk, negedge reset_n) begin  //seperate clocks for each pbit
        if (reset_n == 0) begin  //initial value 
            group_EN = 0;
            clk_delay = 2'b00;
        end else begin
            clk_delay <= (clk_delay + 1) & 2'b11;
            if (clk_delay == 2'b11) begin   // When clk_delay reaches 3
                if (group_EN == 3'b011)
                    group_EN <= 3'b000;  // Reset after reaching 100
                else
                    group_EN <= group_EN + 1;
                clk_delay <= 2'b00;
            end
        end
    end

    // Instantiate the grouped_update_order_LUT
    grouped_update_order_LUT grouped_update_order_LUT_inst (
        .group_EN(group_EN),                       
        .Pbit_EN(Pbit_EN)
    );  
     
    // Weight update
    // Sparse Matrix Multiplication
    always @(posedge clk) begin
        integer i, k, index;
        integer start_idx, end_idx;
    
        for (i = 0; i < num_Pbits; i = i + 1) begin
            if (Pbit_EN[i] == 1'b1) begin
                // Reset accumulator (extended to 9 bits for proper sign representation)
                extended_result_Jm[i] = 9'sb000000000;
                start_idx = row_ptr[i];
                end_idx = row_ptr[i+1];
                // Iterate over all columns
                for (k = 0; k < num_Pbits; k = k + 1) begin
                    index = start_idx + k;
                    if (index < end_idx) begin
                        // Use the stored column index directly
                        // 'j' is the index of the p-bit whose state is multiplied
                        // Note: m is indexed with constant bounds NUM_PBITS.
                        // The product is sign-extended to 9 bits for accumulation.
                        product_Jm[i] = values[index] * m[col_indices[index]];
                        extended_result_Jm[i] = extended_result_Jm[i] +
                            {{1{product_Jm[i][7]}}, product_Jm[i]};
                    end
                end
                if (extended_result_Jm[i] > 8'sb01111111) begin
                    result_Jm[i] = 8'sb01111111;
                end else if (extended_result_Jm[i] < 8'sb10000000) begin
                    result_Jm[i] = 8'sb10000000;
                end else begin
                    result_Jm[i] = extended_result_Jm[i][7:0];
                end
                
                // Bias addition and clamping
                extended_addition[i] = { {1{h_clamped[i][7]}}, h_clamped[i] } + { {1{result_Jm[i][7]}}, result_Jm[i] };
                if (extended_addition[i] > 8'sb01111111) begin
                    addition_hi[i] = 8'sb01111111;
                end else if (extended_addition[i] < 8'sb10000000) begin
                    addition_hi[i] = 8'sb10000000;
                end else begin
                    addition_hi[i] = extended_addition[i][7:0];
                end
        
                // Multiply by I_0 and shift for Q4.3 fixed-point scaling
                product_I0[i] = I_0 * addition_hi[i];
                I_i[i] = product_I0[i] >>> 3;
            end
        end
    end

    // Instantiate P-bits
    genvar i;
    generate
        for (i = 0; i < num_Pbits; i++) begin : P_bit_instances
            P_bit p_bit_inst (
                .clk(clk),
                .enable(Pbit_EN[i]),           // Enable only the P-bit corresponding to the active_p_bit
                .reset_n(reset_n),
                .I_i(I_i[i]),                    // Pass pre-computed weighted input
                .seed(seed[i]),
                .m_i(m[i])                       // Output state of the P-bit
            );
        end
    endgenerate
    assign out = m[83:num_Pbits-1];
endmodule
