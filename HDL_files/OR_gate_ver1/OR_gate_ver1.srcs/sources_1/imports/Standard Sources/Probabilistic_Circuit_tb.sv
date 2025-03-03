module OR_gate_tb;
    // Inputs
    logic clk;
    logic reset_n;
    logic signed [7:0] h [0:2];                     // Bias vector for 3 P-bits
    logic signed [7:0] I_0;

    // Outputs
    logic OR_out [0:2];                            // States of the 3 P-bits
    
    real bias [0:2];
    // Instantiate the 3_P_bit_AND
    OR_gate uut (
        .clk(clk),
        .reset_n(reset_n),
        .h(h),
        .I_0(I_0),
        .m(OR_out)
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
        

        // Unconstrained 
        I_0 = 8'sb00000000;             // 0
        h[0] = 8'sb00000000;            // 0
        h[1] = 8'sb00000000;            // 0
        h[2] = 8'sb00000000;            // 0
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // Floating
        I_0 = 8'sb00001000;             // 1
        h[0] = 8'sb11110000;            // -2
        h[1] = 8'sb11110000;            // -2
        h[2] = 8'sb11100000;            // -4
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // A=0, B=0
        h[0] = 8'sb10000000;            // -16 (min val)
        h[1] = 8'sb10000000;            // -16 (min val
        h[2] = 8'sb11100000;            // -4
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // A=1, B=0
        h[0] = 8'sb01111111;            // 15.875 (max val)
        h[1] = 8'sb10000000;            // -16 (min val
        h[2] = 8'sb11100000;            // -4
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);

        #1000000;
        // A=0, B=1
        h[0] = 8'sb10000000;            // -16 (min val
        h[1] = 8'sb01111111;            // 15.875 (max val)
        h[2] = 8'sb11100000;            // -4
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // A=1, B=1
        h[0] = 8'sb01111111;            // 15.875 (max val)
        h[1] = 8'sb01111111;            // 15.875 (max val)
        h[2] = 8'sb11100000;            // -4
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // C=0
        h[0] = 8'sb11110000;            // -2
        h[1] = 8'sb11110000;            // -2
        h[2] = 8'sb10000000;            // -16 (min val
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // C=1
        h[0] = 8'sb11110000;            // -2
        h[1] = 8'sb11110000;            // -2
        h[2] = 8'sb01111111;            // 15.875 (max val)
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        
        #1000000;
        // End the simulation
        #10 $finish;
    end

    //// File pointer for CSV file
    integer file;
    
    // Open CSV file for writing output data
    initial begin
        file = $fopen("OR_out.csv", "w");  // Open or create the file for writing
        // Check if the file was opened successfully
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Time (ns),output,h1,h2,h3\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    // Monitor and output P_bit_out data to CSV file
    initial begin
        #75;
        // Loop to monitor P_bit_out over times
        forever begin
            #1; // Small delay to capture every time step
            if (file) begin
                $fwrite(file,"%t,%b,%f,%f,%f\n", $time, {OR_out[0], OR_out[1],OR_out[2]}, bias[0],bias[1],bias[2]);  // Write time and P_bit_out value to CSV file
            end
        end
    end
    
    // Close the file at the end of simulation
    final begin
        if (file) begin
            $fclose(file);  // Close the file
            $display("Data written to OR_out.csv");
        end
    end
endmodule

