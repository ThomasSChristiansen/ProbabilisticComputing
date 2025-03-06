module four_bit_mult_tb;
    // Num P-bits
    localparam num_Pbits = 53;
    
    // Inputs
    logic clk;
    logic reset_n;
//    logic signed [7:0] h [0:num_Pbits-1];                     // Bias vector for 3 P-bits
    logic signed [7:0] I_0;
     
    // Outputs
    logic mult_out [0:num_Pbits-1];                            // States of the 3 P-bits
    logic [1:0] clk_delay;
    
    real bias [0:num_Pbits-1];
    // Instantiate the 3_P_bit_AND
    probabilistic_circuit uut (
        .clk(clk),
        .reset_n(reset_n),
        .m(mult_out),
        .clk_delay(clk_delay)
    );
    function real s4_3_to_real(input signed [7:0] fixed_val);
        real converted;
        begin
            converted = fixed_val / 8.0;  // Divide by 2^3 to shift fraction
            return converted;
        end
    endfunction
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10ns
    end
    
    // Test sequence
    initial begin
        // Apply reset
        reset_n = 0;
        
        #10;
        reset_n = 1;
        // h_bipolar(Floating State)
        h[0] = 8'sb00000000;
        h[1] = 8'sb00000000;
        h[2] = 8'sb00000000;
        h[3] = 8'sb00000000;
        h[4] = 8'sb00000000;
        h[5] = 8'sb00000000;
        h[6] = 8'sb00000000;
        h[7] = 8'sb00000000;
        h[8] = 8'sb10000000;
        h[9] = 8'sb10000000;
        h[10] = 8'sb10000000;
        h[11] = 8'sb11010000;
        h[12] = 8'sb11111000;
        h[13] = 8'sb11111000;
        h[14] = 8'sb11111000;
        h[15] = 8'sb11111000;
        h[16] = 8'sb11111000;
        h[17] = 8'sb11111000;
        h[18] = 8'sb11100000;
        h[19] = 8'sb11110000;
        h[20] = 8'sb11001000;
        h[21] = 8'sb11001000;
        h[22] = 8'sb11001000;
        h[23] = 8'sb11001000;
        h[24] = 8'sb11001000;
        h[25] = 8'sb11001000;
        h[26] = 8'sb11001000;
        h[27] = 8'sb11011000;
        h[28] = 8'sb11011000;
        h[29] = 8'sb11011000;
        h[30] = 8'sb11011000;
        h[31] = 8'sb11110000;
        h[32] = 8'sb11110000;
        h[33] = 8'sb11110000;
        h[34] = 8'sb11001000;
        h[35] = 8'sb11001000;
        h[36] = 8'sb11001000;
        h[37] = 8'sb11001000;
        h[38] = 8'sb11011000;
        h[39] = 8'sb11011000;
        h[40] = 8'sb11011000;
        h[41] = 8'sb11011000;
        h[42] = 8'sb11110000;
        h[43] = 8'sb11110000;
        h[44] = 8'sb11110000;
        h[45] = 8'sb11001000;
        h[46] = 8'sb11001000;
        h[47] = 8'sb11001000;
        h[48] = 8'sb11001000;
        h[49] = 8'sb11011000;
        h[50] = 8'sb11011000;
        h[51] = 8'sb11011000;
        h[52] = 8'sb10000000;
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        bias[3] = s4_3_to_real(h[3]);
        bias[4] = s4_3_to_real(h[4]);
        bias[5] = s4_3_to_real(h[5]);
        bias[6] = s4_3_to_real(h[6]);
        bias[7] = s4_3_to_real(h[7]);
        bias[8] = s4_3_to_real(h[8]);
        bias[9] = s4_3_to_real(h[9]);
        bias[10] = s4_3_to_real(h[10]);
        bias[11] = s4_3_to_real(h[11]);
        bias[12] = s4_3_to_real(h[12]);
        bias[13] = s4_3_to_real(h[13]);
        bias[14] = s4_3_to_real(h[14]);
        bias[15] = s4_3_to_real(h[15]);
        bias[16] = s4_3_to_real(h[16]);
        bias[17] = s4_3_to_real(h[17]);
        bias[18] = s4_3_to_real(h[18]);
        bias[19] = s4_3_to_real(h[19]);
        bias[20] = s4_3_to_real(h[20]);
        bias[21] = s4_3_to_real(h[21]);
        bias[22] = s4_3_to_real(h[22]);
        bias[23] = s4_3_to_real(h[23]);
        bias[24] = s4_3_to_real(h[24]);
        bias[25] = s4_3_to_real(h[25]);
        bias[26] = s4_3_to_real(h[26]);
        bias[27] = s4_3_to_real(h[27]);
        bias[28] = s4_3_to_real(h[28]);
        bias[29] = s4_3_to_real(h[29]);
        bias[30] = s4_3_to_real(h[30]);
        bias[31] = s4_3_to_real(h[31]);
        bias[32] = s4_3_to_real(h[32]);
        bias[33] = s4_3_to_real(h[33]);
        bias[34] = s4_3_to_real(h[34]);
        bias[35] = s4_3_to_real(h[35]);
        bias[36] = s4_3_to_real(h[36]);
        bias[37] = s4_3_to_real(h[37]);
        bias[38] = s4_3_to_real(h[38]);
        bias[39] = s4_3_to_real(h[39]);
        bias[40] = s4_3_to_real(h[40]);
        bias[41] = s4_3_to_real(h[41]);
        bias[42] = s4_3_to_real(h[42]);
        bias[43] = s4_3_to_real(h[43]);
        bias[44] = s4_3_to_real(h[44]);
        bias[45] = s4_3_to_real(h[45]);
        bias[46] = s4_3_to_real(h[46]);
        bias[47] = s4_3_to_real(h[47]);
        bias[48] = s4_3_to_real(h[48]);
        bias[49] = s4_3_to_real(h[49]);
        bias[50] = s4_3_to_real(h[50]);
        bias[51] = s4_3_to_real(h[51]);
        bias[52] = s4_3_to_real(h[52]);
        
        
                
        
        
        #1000000;
        // End the simulation
        #10 $finish;
    end

    //// File pointer for CSV file
    integer file;
    
    // Open CSV file for writing output data
    initial begin
        file = $fopen("Mult_behav.csv", "w");  // Open or create the file for writing
        // Check if the file was opened successfully
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Time (ns),output,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,h15,h16,h17,h17,h19,h20,h21,h22,h23,h24,h25,h26,h27,h28,h29,h30,h31,h32,h33,h34,h35,h36,h37,h38,h39,h40,h41,h42,h43,h44,h45,h46,h47,h48,h49,h50,h51,h52,h53\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    // Monitor and output P_bit_out data to CSV file
    always @(clk_delay) begin
        #5
        if (file) begin
            $fwrite(file, "%t,%b,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",
                    $time,
                    {mult_out[18], mult_out[17], mult_out[16], mult_out[15],
                     mult_out[14], mult_out[13], mult_out[12], mult_out[11]},
                    bias[0],
                    bias[1],
                    bias[2],
                    bias[3],
                    bias[4],
                    bias[5],
                    bias[6],
                    bias[7],
                    bias[8],
                    bias[9],
                    bias[10],
                    bias[11],
                    bias[12],
                    bias[13],
                    bias[14],
                    bias[15],
                    bias[16],
                    bias[17],
                    bias[18],
                    bias[19],
                    bias[20],
                    bias[21],
                    bias[22],
                    bias[23],
                    bias[24],
                    bias[25],
                    bias[26],
                    bias[27],
                    bias[28],
                    bias[29],
                    bias[30],
                    bias[31],
                    bias[32],
                    bias[33],
                    bias[34],
                    bias[35],
                    bias[36],
                    bias[37],
                    bias[38],
                    bias[39],
                    bias[40],
                    bias[41],
                    bias[42],
                    bias[43],
                    bias[44],
                    bias[45],
                    bias[46],
                    bias[47],
                    bias[48],
                    bias[49],
                    bias[50],
                    bias[51],
                    bias[52]);
        end
    end
    // Close the file at the end of simulation
    final begin
        if (file) begin
            $fclose(file);  // Close the file
            $display("Data written to Mult_behav.csv");
        end
    end
endmodule

