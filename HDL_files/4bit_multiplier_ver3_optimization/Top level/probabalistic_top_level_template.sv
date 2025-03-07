`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	This is the standard source for a probabilistic circuit
//	For different behaviour input different
//	- num_Pbits based on size of network, line 11
//	- Name of mem files for h, J and seeds, starting line 27
//	- Range on output pbits, line 122
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module probabalistic_top_level_template #(
    parameter num_Pbits = 91  // Allows configuration
)(
    input logic clk,                            // Clock signal
    input logic reset_n,                        // Reset signal
    input logic clamp[0:7],                     // Bias vector for num_Pbits
    input clamp_EN,                             // Enable clamping
    output logic out [0:7]                      // States of the num_Pbits P-bits
);
    // Intermediate output storage
    logic m [0:num_Pbits-1];


    // Memory for compressed data
    logic signed [7:0] values [0:255];      // Nonzero values (RLE compressed)
    logic [7:0] run_lengths [0:255];        // RLE run lengths
    logic [7:0] col_indices [0:255];        // Column indices
    logic [7:0] row_ptr [0:num_Pbits];      // Row pointers (NOT delta encoded)
    logic signed [7:0] h [0:num_Pbits-1];   // Bias vector
    logic [31:0] seed [0:num_Pbits-1];      // Random seed array

    // Load values, run_lengths, col_indices, row_ptr, and h from .mem files
    initial begin
        $readmemb("values.mem", values);
        $readmemb("run_lengths.mem", run_lengths);
        $readmemb("col_indices.mem", col_indices);
        $readmemb("row_ptr.mem", row_ptr);
        $readmemb("h.mem", h);
        $readmemb("seed.mem", seed);
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
    logic signed [7:0] h_clamped [0:num_Pbits-1];         //clamped bias vector
    
    
    // Clamping
    clamper clamper (
    .h(h),
    .clamp(clamp),
    .clamp_EN(clamp_EN),
    .h_clamped(h_clamped)
    );
    
    // Sequencer with 3 clock cycle delay. 
    logic [0:3] group_EN;
    logic [0:num_Pbits-1] Pbit_EN;
    logic [1:0] clk_delay;
    always @(posedge clk, negedge reset_n) begin  //seperate clocks for each pbit
        if (reset_n == 0) begin  //initial value 
            group_EN = 0;
            clk_delay = 2'b00;
        end else begin
            clk_delay += 1'b1;
            if (clk_delay == 2'b11) begin   // When clk_delay reaches 3
                if (group_EN == 3'b100)
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
    always @(posedge clk) begin
        integer i, j, k;
        integer start_idx, end_idx;
        integer run_count, run_index;
        logic signed [7:0] temp_value;
        
        for (i = 0; i < num_Pbits; i = i + 1) begin
            if (Pbit_EN[i] == 1'b1) begin
                result_Jm[i] = 8'sb00000000; // Reset accumulation
                
                // Get row start and end indices
                start_idx = row_ptr[i];
                end_idx = row_ptr[i+1];

                k = start_idx;   // Start index for values[] traversal
                run_index = 0;   // Current RLE entry index
                run_count = 0;   // How many times we've used current value
                
                for (j = start_idx; j < end_idx; j = j + 1) begin 
                    // Fetch new value when needed
                    if (run_count == 0) begin
                        temp_value = values[run_index];
                        run_count = run_lengths[run_index];  // Load new run length
                        run_index = run_index + 1;
                    end

                    // Perform weight calculation
                    product_Jm[i] = temp_value * m[col_indices[k]];  
                    result_Jm[i] = result_Jm[i] + product_Jm[i];

                    // Update counters
                    run_count = run_count - 1;  // Decrement run length
                    k = k + 1;  // Move to next col_index
                end

                // Add bias vector and clamp
                extended_addition[i] = { {1{h[i][7]}}, h[i] } + { {1{result_Jm[i][7]}}, result_Jm[i] };
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
    assign out = m[83:90];
endmodule
