module two_bit_mult_tb;
    // Num P-bits
    localparam num_Pbits = 14;
    
    // Inputs
    logic clk;
    logic reset_n;
    logic signed [7:0] h [0:num_Pbits-1];                     // Bias vector for 3 P-bits
    logic signed [7:0] I_0;
     
    // Outputs
    logic mult_out [0:num_Pbits-1];                            // States of the 3 P-bits
    logic [1:0] clk_delay;
    
    real bias [0:num_Pbits-1];
    // Instantiate the 3_P_bit_AND
    probabilistic_circuit uut (
        .clk(clk),
        .reset_n(reset_n),
        .h(h),
        .I_0(I_0),
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
        I_0 = 8'sb00001000;             // 1
        
        // h_bipolar(Floating State)
        h[0] = 8'sb00000000;
        h[1] = 8'sb00000000;
        h[2] = 8'sb00000000;
        h[3] = 8'sb00000000;
        h[4] = 8'sb11001000;
        h[5] = 8'sb11001000;
        h[6] = 8'sb11001000;
        h[7] = 8'sb11011000;
        h[8] = 8'sb10000000;
        h[9] = 8'sb10000000;
        h[10] = 8'sb11010000;
        h[11] = 8'sb11111000;
        h[12] = 8'sb11111000;
        h[13] = 8'sb11100000;
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
        
        #1000000;
        // h_bipolar(Output = 6, factors (3x2,2x3))
        h[0] = 8'sb00000000;
        h[1] = 8'sb00000000;
        h[2] = 8'sb00000000;
        h[3] = 8'sb00000000;
        h[4] = 8'sb11001000;
        h[5] = 8'sb11001000;
        h[6] = 8'sb11001000;
        h[7] = 8'sb11011000;
        h[8] = 8'sb10000000;
        h[9] = 8'sb10000000;
        h[10] = 8'sb10000000;
        h[11] = 8'sb01111111;
        h[12] = 8'sb01111111;
        h[13] = 8'sb10000000;
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
        
        #1000000;
        // h_bipolar(Output = 9, factors (3x3))
        h[0] = 8'sb00000000;
        h[1] = 8'sb00000000;
        h[2] = 8'sb00000000;
        h[3] = 8'sb00000000;
        h[4] = 8'sb11001000;
        h[5] = 8'sb11001000;
        h[6] = 8'sb11001000;
        h[7] = 8'sb11011000;
        h[8] = 8'sb10000000;
        h[9] = 8'sb10000000;
        h[10] = 8'sb01111111;
        h[11] = 8'sb10000000;
        h[12] = 8'sb10000000;
        h[13] = 8'sb01111111;
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
            $fwrite(file, "Time (ns),output,h1,h2,h3,h4,h10,h11,h12,h13\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    // Monitor and output P_bit_out data to CSV file
    always @(clk_delay) begin
        #5
        if (file) begin
            $fwrite(file, "%t,%b,%f,%f,%f,%f,%f,%f,%f,%f\n",
                    $time,
                    {mult_out[0], mult_out[1], mult_out[2], mult_out[3],
                     mult_out[10], mult_out[11], mult_out[12], mult_out[13]},
                    bias[0], bias[1], bias[2], bias[3],
                    bias[10], bias[11], bias[12], bias[13]);
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

