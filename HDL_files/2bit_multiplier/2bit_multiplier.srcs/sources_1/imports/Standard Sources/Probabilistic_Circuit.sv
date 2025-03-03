`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	This is the standard source for a probabilistic circuit
//	For different behaviour input different
//	- num_Pbits
//	- Weights
//	- Seeds
//	- Sequencer size
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module probabilistic_circuit #(
    parameter num_Pbits = 14  // Allows configuration
)(
    input logic clk,                            // Clock signal
    input logic reset_n,                        // Reset signal
    input logic signed [7:0] I_0,               // Scaling factor
    input signed [7:0] h [0:num_Pbits-1],           // Bias vector for num_Pbits
    output logic m [0:num_Pbits-1],                  // States of the num_Pbits P-bits
    output logic [1:0] clk_delay
);
    // Bias vector
//    parameter h0 = 8'sb00000000;
//    parameter h1 = 8'sb00000000;
//    parameter h2 = 8'sb00000000;
//    parameter h3 = 8'sb00000000;
//    parameter h4 = 8'sb11001000;
//    parameter h5 = 8'sb11001000;
//    parameter h6 = 8'sb11001000;
//    parameter h7 = 8'sb11011000;
//    parameter h8 = 8'sb10000000;
//    parameter h9 = 8'sb10000000;
//    parameter h10 = 8'sb11010000;
//    parameter h11 = 8'sb11111000;
//    parameter h12 = 8'sb11111000;
//    parameter h13 = 8'sb11100000;
//    logic signed [7:0] h [0:13] = '{h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,10,h11,h12,h13};
    
    // Interconnection strengh
//    parameter I_0 = 8'sb00001000;
    
    // Weight parameters
    parameter J_0000 = 8'sb00000000;
    parameter J_0001 = 8'sb11110000;
    parameter J_0002 = 8'sb00000000;
    parameter J_0003 = 8'sb11110000;
    parameter J_0004 = 8'sb00100000;
    parameter J_0005 = 8'sb00000000;
    parameter J_0006 = 8'sb00000000;
    parameter J_0007 = 8'sb00000000;
    parameter J_0008 = 8'sb00000000;
    parameter J_0009 = 8'sb00000000;
    parameter J_0010 = 8'sb00100000;
    parameter J_0011 = 8'sb00000000;
    parameter J_0012 = 8'sb00000000;
    parameter J_0013 = 8'sb00000000;
    parameter J_0100 = 8'sb11110000;
    parameter J_0101 = 8'sb00000000;
    parameter J_0102 = 8'sb11110000;
    parameter J_0103 = 8'sb00000000;
    parameter J_0104 = 8'sb00000000;
    parameter J_0105 = 8'sb00100000;
    parameter J_0106 = 8'sb00000000;
    parameter J_0107 = 8'sb00000000;
    parameter J_0108 = 8'sb00000000;
    parameter J_0109 = 8'sb00000000;
    parameter J_0110 = 8'sb00100000;
    parameter J_0111 = 8'sb00000000;
    parameter J_0112 = 8'sb00000000;
    parameter J_0113 = 8'sb00000000;
    parameter J_0200 = 8'sb00000000;
    parameter J_0201 = 8'sb11110000;
    parameter J_0202 = 8'sb00000000;
    parameter J_0203 = 8'sb11110000;
    parameter J_0204 = 8'sb00000000;
    parameter J_0205 = 8'sb00100000;
    parameter J_0206 = 8'sb00100000;
    parameter J_0207 = 8'sb00000000;
    parameter J_0208 = 8'sb00000000;
    parameter J_0209 = 8'sb00000000;
    parameter J_0210 = 8'sb00000000;
    parameter J_0211 = 8'sb00000000;
    parameter J_0212 = 8'sb00000000;
    parameter J_0213 = 8'sb00000000;
    parameter J_0300 = 8'sb11110000;
    parameter J_0301 = 8'sb00000000;
    parameter J_0302 = 8'sb11110000;
    parameter J_0303 = 8'sb00000000;
    parameter J_0304 = 8'sb00100000;
    parameter J_0305 = 8'sb00000000;
    parameter J_0306 = 8'sb00100000;
    parameter J_0307 = 8'sb00000000;
    parameter J_0308 = 8'sb00000000;
    parameter J_0309 = 8'sb00000000;
    parameter J_0310 = 8'sb00000000;
    parameter J_0311 = 8'sb00000000;
    parameter J_0312 = 8'sb00000000;
    parameter J_0313 = 8'sb00000000;
    parameter J_0400 = 8'sb00100000;
    parameter J_0401 = 8'sb00000000;
    parameter J_0402 = 8'sb00000000;
    parameter J_0403 = 8'sb00100000;
    parameter J_0404 = 8'sb00000000;
    parameter J_0405 = 8'sb11110000;
    parameter J_0406 = 8'sb00000000;
    parameter J_0407 = 8'sb00100000;
    parameter J_0408 = 8'sb11110000;
    parameter J_0409 = 8'sb00000000;
    parameter J_0410 = 8'sb00000000;
    parameter J_0411 = 8'sb00010000;
    parameter J_0412 = 8'sb00000000;
    parameter J_0413 = 8'sb00000000;
    parameter J_0500 = 8'sb00000000;
    parameter J_0501 = 8'sb00100000;
    parameter J_0502 = 8'sb00100000;
    parameter J_0503 = 8'sb00000000;
    parameter J_0504 = 8'sb11110000;
    parameter J_0505 = 8'sb00000000;
    parameter J_0506 = 8'sb00000000;
    parameter J_0507 = 8'sb00100000;
    parameter J_0508 = 8'sb11110000;
    parameter J_0509 = 8'sb00000000;
    parameter J_0510 = 8'sb00000000;
    parameter J_0511 = 8'sb00010000;
    parameter J_0512 = 8'sb00000000;
    parameter J_0513 = 8'sb00000000;
    parameter J_0600 = 8'sb00000000;
    parameter J_0601 = 8'sb00000000;
    parameter J_0602 = 8'sb00100000;
    parameter J_0603 = 8'sb00100000;
    parameter J_0604 = 8'sb00000000;
    parameter J_0605 = 8'sb00000000;
    parameter J_0606 = 8'sb00000000;
    parameter J_0607 = 8'sb11110000;
    parameter J_0608 = 8'sb00000000;
    parameter J_0609 = 8'sb11110000;
    parameter J_0610 = 8'sb00000000;
    parameter J_0611 = 8'sb00000000;
    parameter J_0612 = 8'sb00010000;
    parameter J_0613 = 8'sb00100000;
    parameter J_0700 = 8'sb00000000;
    parameter J_0701 = 8'sb00000000;
    parameter J_0702 = 8'sb00000000;
    parameter J_0703 = 8'sb00000000;
    parameter J_0704 = 8'sb00100000;
    parameter J_0705 = 8'sb00100000;
    parameter J_0706 = 8'sb11110000;
    parameter J_0707 = 8'sb00000000;
    parameter J_0708 = 8'sb00100000;
    parameter J_0709 = 8'sb11110000;
    parameter J_0710 = 8'sb00000000;
    parameter J_0711 = 8'sb11100000;
    parameter J_0712 = 8'sb00010000;
    parameter J_0713 = 8'sb00100000;
    parameter J_0800 = 8'sb00000000;
    parameter J_0801 = 8'sb00000000;
    parameter J_0802 = 8'sb00000000;
    parameter J_0803 = 8'sb00000000;
    parameter J_0804 = 8'sb11110000;
    parameter J_0805 = 8'sb11110000;
    parameter J_0806 = 8'sb00000000;
    parameter J_0807 = 8'sb00100000;
    parameter J_0808 = 8'sb00000000;
    parameter J_0809 = 8'sb00000000;
    parameter J_0810 = 8'sb00000000;
    parameter J_0811 = 8'sb00010000;
    parameter J_0812 = 8'sb00000000;
    parameter J_0813 = 8'sb00000000;
    parameter J_0900 = 8'sb00000000;
    parameter J_0901 = 8'sb00000000;
    parameter J_0902 = 8'sb00000000;
    parameter J_0903 = 8'sb00000000;
    parameter J_0904 = 8'sb00000000;
    parameter J_0905 = 8'sb00000000;
    parameter J_0906 = 8'sb11110000;
    parameter J_0907 = 8'sb11110000;
    parameter J_0908 = 8'sb00000000;
    parameter J_0909 = 8'sb00000000;
    parameter J_0910 = 8'sb00000000;
    parameter J_0911 = 8'sb00000000;
    parameter J_0912 = 8'sb00010000;
    parameter J_0913 = 8'sb00100000;
    parameter J_1000 = 8'sb00100000;
    parameter J_1001 = 8'sb00100000;
    parameter J_1002 = 8'sb00000000;
    parameter J_1003 = 8'sb00000000;
    parameter J_1004 = 8'sb00000000;
    parameter J_1005 = 8'sb00000000;
    parameter J_1006 = 8'sb00000000;
    parameter J_1007 = 8'sb00000000;
    parameter J_1008 = 8'sb00000000;
    parameter J_1009 = 8'sb00000000;
    parameter J_1010 = 8'sb00000000;
    parameter J_1011 = 8'sb00000000;
    parameter J_1012 = 8'sb00000000;
    parameter J_1013 = 8'sb00000000;
    parameter J_1100 = 8'sb00000000;
    parameter J_1101 = 8'sb00000000;
    parameter J_1102 = 8'sb00000000;
    parameter J_1103 = 8'sb00000000;
    parameter J_1104 = 8'sb00010000;
    parameter J_1105 = 8'sb00010000;
    parameter J_1106 = 8'sb00000000;
    parameter J_1107 = 8'sb11100000;
    parameter J_1108 = 8'sb00010000;
    parameter J_1109 = 8'sb00000000;
    parameter J_1110 = 8'sb00000000;
    parameter J_1111 = 8'sb00000000;
    parameter J_1112 = 8'sb00000000;
    parameter J_1113 = 8'sb00000000;
    parameter J_1200 = 8'sb00000000;
    parameter J_1201 = 8'sb00000000;
    parameter J_1202 = 8'sb00000000;
    parameter J_1203 = 8'sb00000000;
    parameter J_1204 = 8'sb00000000;
    parameter J_1205 = 8'sb00000000;
    parameter J_1206 = 8'sb00010000;
    parameter J_1207 = 8'sb00010000;
    parameter J_1208 = 8'sb00000000;
    parameter J_1209 = 8'sb00010000;
    parameter J_1210 = 8'sb00000000;
    parameter J_1211 = 8'sb00000000;
    parameter J_1212 = 8'sb00000000;
    parameter J_1213 = 8'sb11100000;
    parameter J_1300 = 8'sb00000000;
    parameter J_1301 = 8'sb00000000;
    parameter J_1302 = 8'sb00000000;
    parameter J_1303 = 8'sb00000000;
    parameter J_1304 = 8'sb00000000;
    parameter J_1305 = 8'sb00000000;
    parameter J_1306 = 8'sb00100000;
    parameter J_1307 = 8'sb00100000;
    parameter J_1308 = 8'sb00000000;
    parameter J_1309 = 8'sb00100000;
    parameter J_1310 = 8'sb00000000;
    parameter J_1311 = 8'sb00000000;
    parameter J_1312 = 8'sb11100000;
    parameter J_1313 = 8'sb00000000;
    
    logic signed [7:0] J [0:13][0:13] = '{{J_0000, J_0001, J_0002, J_0003, J_0004, J_0005, J_0006, J_0007, J_0008, J_0009, J_0010, J_0011, J_0012, J_0013},
                                          {J_0100, J_0101, J_0102, J_0103, J_0104, J_0105, J_0106, J_0107, J_0108, J_0109, J_0110, J_0111, J_0112, J_0113},
                                          {J_0200, J_0201, J_0202, J_0203, J_0204, J_0205, J_0206, J_0207, J_0208, J_0209, J_0210, J_0211, J_0212, J_0213},
                                          {J_0300, J_0301, J_0302, J_0303, J_0304, J_0305, J_0306, J_0307, J_0308, J_0309, J_0310, J_0311, J_0312, J_0313},
                                          {J_0400, J_0401, J_0402, J_0403, J_0404, J_0405, J_0406, J_0407, J_0408, J_0409, J_0410, J_0411, J_0412, J_0413},
                                          {J_0500, J_0501, J_0502, J_0503, J_0504, J_0505, J_0506, J_0507, J_0508, J_0509, J_0510, J_0511, J_0512, J_0513},
                                          {J_0600, J_0601, J_0602, J_0603, J_0604, J_0605, J_0606, J_0607, J_0608, J_0609, J_0610, J_0611, J_0612, J_0613},
                                          {J_0700, J_0701, J_0702, J_0703, J_0704, J_0705, J_0706, J_0707, J_0708, J_0709, J_0710, J_0711, J_0712, J_0713},
                                          {J_0800, J_0801, J_0802, J_0803, J_0804, J_0805, J_0806, J_0807, J_0808, J_0809, J_0810, J_0811, J_0812, J_0813},
                                          {J_0900, J_0901, J_0902, J_0903, J_0904, J_0905, J_0906, J_0907, J_0908, J_0909, J_0910, J_0911, J_0912, J_0913},
                                          {J_1000, J_1001, J_1002, J_1003, J_1004, J_1005, J_1006, J_1007, J_1008, J_1009, J_1010, J_1011, J_1012, J_1013},
                                          {J_1100, J_1101, J_1102, J_1103, J_1104, J_1105, J_1106, J_1107, J_1108, J_1109, J_1110, J_1111, J_1112, J_1113},
                                          {J_1200, J_1201, J_1202, J_1203, J_1204, J_1205, J_1206, J_1207, J_1208, J_1209, J_1210, J_1211, J_1212, J_1213},
                                          {J_1300, J_1301, J_1302, J_1303, J_1304, J_1305, J_1306, J_1307, J_1308, J_1309, J_1310, J_1311, J_1312, J_1313}};
    
    parameter seed0 = 32'b10011101000100000101001111011100;
    parameter seed1 = 32'b01101110100110100110111010001110;
    parameter seed2 = 32'b10101010111111110101100101110110;
    parameter seed3 = 32'b10011111001000000010010110001001;
    parameter seed4 = 32'b01010000000010110010010111001100;
    parameter seed5 = 32'b11100000110010000011101101001010;
    parameter seed6 = 32'b00101010011000111011101000101001;
    parameter seed7 = 32'b01110011010111110011011011110110;
    parameter seed8 = 32'b01001100011100101110011110111100;
    parameter seed9 = 32'b01101011001010010100001110110100;
    parameter seed10 = 32'b01001011000100101000000100010101;
    parameter seed11 = 32'b10001101000011000000110000111001;
    parameter seed12 = 32'b00000010000101001000010000110100;
    parameter seed13 = 32'b01000101101011001110101110101100;
    logic [31:0] seed [0:13] = '{seed0, seed1, seed2, seed3, seed4, seed5, seed6, seed7, seed8, seed9, seed10, seed11, seed12, seed13};
    
    // Internal signals
    logic signed [7:0] I_i [0:num_Pbits-1];               // Weighted inputs for each P-bit
    logic signed [7:0] product_Jm [0:num_Pbits-1];       // Inner Product
    logic signed [7:0] result_Jm [0:num_Pbits-1];         // Result 
    logic signed [15:0] product_I0 [0:num_Pbits-1];       // Product of I0 and sum
    logic signed [7:0] addition_hi [0:num_Pbits-1];       // hi+sum(J_ij+m_j)
    logic signed [8:0] extended_addition [0:num_Pbits-1];; 
    
    // Sequencer with 3 clock cycle delay. 
    
    logic [0:3] group_EN;
    logic [0:num_Pbits-1] Pbit_EN;
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
     
     
    // Weight update binary
    always @(posedge clk) begin
        integer i, j;
        for (i=0; i<num_Pbits; i=i+1) begin
            if (Pbit_EN[i] == 1'b1) begin  // Only update active P-bit
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
                .enable(Pbit_EN[i]),           // Enable only the P-bit corresponding to the active_p_bit
                .reset_n(reset_n),
                .I_i(I_i[i]),                    // Pass pre-computed weighted input
                .seed(seed[i]),
                .m_i(m[i])                       // Output state of the P-bit
            );
        end
    endgenerate

endmodule

