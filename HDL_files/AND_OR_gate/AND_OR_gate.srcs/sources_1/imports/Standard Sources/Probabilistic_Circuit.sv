`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module AND_OR_gate (
    input logic clk,                            // Clock signal
    input logic reset_n,                        // Reset signal
    input signed [7:0] h [0:4],                 // Bias vector for 3 P-bits
    input logic signed [7:0] I_0,
    output logic m [0:4]                        // States of the 3 P-bits
);

    // Number of P-bits
    localparam num_Pbits = 5;
    
    // Weight parameters
    parameter signed J_00 = 8'sb00000000;
    parameter signed J_01 = 8'sb11110000;
    parameter signed J_02 = 8'sb00100000;
    parameter signed J_03 = 8'sb00000000;
    parameter signed J_04 = 8'sb00000000;
    parameter signed J_10 = 8'sb11110000;
    parameter signed J_11 = 8'sb00000000;
    parameter signed J_12 = 8'sb00100000;
    parameter signed J_13 = 8'sb00000000;
    parameter signed J_14 = 8'sb00000000;
    parameter signed J_20 = 8'sb00100000;
    parameter signed J_21 = 8'sb00100000;
    parameter signed J_22 = 8'sb00000000;
    parameter signed J_23 = 8'sb11100000;
    parameter signed J_24 = 8'sb00110000;
    parameter signed J_30 = 8'sb00000000;
    parameter signed J_31 = 8'sb00000000;
    parameter signed J_32 = 8'sb11100000;
    parameter signed J_33 = 8'sb00000000;
    parameter signed J_34 = 8'sb00110000;
    parameter signed J_40 = 8'sb00000000;
    parameter signed J_41 = 8'sb00000000;
    parameter signed J_42 = 8'sb00110000;
    parameter signed J_43 = 8'sb00110000;
    parameter signed J_44 = 8'sb00000000;
    
    // Weight matrix (3x3)
    logic signed [7:0] J [0:4][0:4] = '{{J_00, J_01, J_02, J_03, J_04},
                                        {J_10, J_11, J_12, J_13, J_14},
                                        {J_20, J_21, J_22, J_23, J_24},
                                        {J_30, J_31, J_32, J_33, J_34},
                                        {J_40, J_41, J_42, J_43, J_44}};      
    // Seeds
    parameter seed0 = 32'b10111011110101011111011001111111;
    parameter seed1 = 32'b01111000000011100010101011001111;
    parameter seed2 = 32'b10101011011000100010001111110011;
    parameter seed3 = 32'b01111001100010001011110001000110;
    parameter seed4 = 32'b11010101110001100001000011001010;
    logic [31:0] seed [0:4] = '{seed0,seed1,seed2,seed3,seed4};          // Seed values for 3 LFSRs    
    
    // Internal signals
    logic signed [7:0] I_i [0:num_Pbits-1];               // Weighted inputs for each P-bit
    logic signed [7:0] product_Jm [0:num_Pbits-1];       // Inner Product
    logic signed [7:0] result_Jm [0:num_Pbits-1];         // Result 
    logic signed [15:0] product_I0 [0:num_Pbits-1];       // Product of I0 and sum
    logic signed [7:0] addition_hi [0:num_Pbits-1];       // hi+sum(J_ij+m_j)
    logic signed [8:0] extended_addition [0:num_Pbits-1];; 
    
    // Sequencer with 3 clock cycle delay. 
    logic [1:0] clk_delay;
    logic [num_Pbits-1:0] active_P_bit;
    always @(posedge clk, negedge reset_n) begin  //seperate clocks for each pbit
        if (reset_n == 0) begin  //initial value 
            active_P_bit = 3'b00001;
            clk_delay = 2'b00;
        end else begin
            clk_delay += 1'b1;
            if (clk_delay == 2'b11) begin   // When clk_delay reaches 3
                active_P_bit = {active_P_bit[3:0], active_P_bit[4]};  //rotate operation
                clk_delay = 2'b00;  // Reset delay counter
            end
        end
    end
     
    // Weight update binary
    always @(posedge clk) begin
        integer i, j;
        for (i=0; i<num_Pbits; i=i+1) begin
            if (active_P_bit[i]) begin  // Only update active P-bit
                result_Jm[i] = 8'sb00000000;
//                product_Jm[i] = 8'sb00000000;
                for (j=0; j<num_Pbits; j=j+1) begin
                    product_Jm[i] = J[i][j] * m[j];                                 // Multiplication remaining inside Q[4][3] since m is 1'b     
                    result_Jm[i] = result_Jm[i] + product_Jm[i];                            // Truncate to 8-bit with sign preservation
                end
                
                extended_addition[i] = { {1{h[i][7]}}, h[i] }                          // Sign Extension
                                    + { {1{result_Jm[i][7]}}, result_Jm[i] };
                if (extended_addition[i] > 8'sb01111111) begin
                    addition_hi[i] = 8'sb01111111;
                end else if (extended_addition[i] < 8'sb10000000) begin
                    addition_hi[i] = 8'sb10000000;
                end else begin
                    addition_hi[i] = extended_addition[i][7:0];                            // Truncate to 8-bit with sign preservation
                end
                product_I0[i] = I_0 * addition_hi[i];                               // Multiplication up to Q[8][6]
                I_i[i] = product_I0[i] >>> 3;                                       // Shift down to Q[4][3]
            end
        end
    end

    
    // Instantiate 3 P-bits
    genvar i;
    generate
        for (i = 0; i < num_Pbits; i++) begin : P_bit_instances
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

