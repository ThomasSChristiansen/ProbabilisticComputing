module Full_Adder_tb;
    // Inputs
    logic clk;
    logic reset_n;
    logic signed [7:0] h [0:4];                     // Bias vector for 3 P-bits
    logic signed [7:0] I_0;

    // Outputs
    logic Full_Adder_out [0:4];                            // States of the 3 P-bits
    
    real bias [0:5];
    // Instantiate the 3_P_bit_AND
    Full_Adder uut (
        .clk(clk),
        .reset_n(reset_n),
        .h(h),
        .I_0(I_0),
        .m(Full_Adder_out)
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
        I_0 = 8'sb00001000;            
        h[0] = 8'sb11111000;
        h[1] = 8'sb11111000;
        h[2] = 8'sb11111000;
        h[3] = 8'sb11111000;
        h[4] = 8'sb11100000;
        bias[0] = s4_3_to_real(h[0]);
        bias[1] = s4_3_to_real(h[1]);
        bias[2] = s4_3_to_real(h[2]);
        bias[3] = s4_3_to_real(h[3]);
        bias[4] = s4_3_to_real(h[4]);

        #10000000;
        // End the simulation
        #10 $finish;
    end

    //// File pointer for CSV file
    integer file;
    
    // Open CSV file for writing output data
    initial begin
        file = $fopen("Full_Adder.csv", "w");  // Open or create the file for writing
        // Check if the file was opened successfully
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Time (ns),output,h1,h2,h3,h4,h5\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    // Monitor and output P_bit_out data to CSV file
    initial begin
        #125;       // Set to avoid X data
        // Loop to monitor P_bit_out over times
        forever begin
            #1; // Small delay to capture every time step
            if (file) begin
                $fwrite(file,"%t,%b,%f,%f,%f,%f,%f\n", $time, {Full_Adder_out[0], Full_Adder_out[1],Full_Adder_out[2],
                                                         Full_Adder_out[3],Full_Adder_out[4]},
                                                         bias[0],bias[1],bias[2],bias[3],bias[4]);  // Write time and P_bit_out value to CSV file
            end
        end
    end
    
    // Close the file at the end of simulation
    final begin
        if (file) begin
            $fclose(file);  // Close the file
            $display("Data written to Full_Adder.csv");
        end
    end
endmodule

