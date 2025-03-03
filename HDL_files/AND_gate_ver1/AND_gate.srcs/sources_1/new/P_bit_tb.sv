module P_bit_tb;

    logic clk;
    logic reset_n;
    logic [31:0] seed;
    logic signed [7:0] I_i;  // Weighted input
    logic m_i;               // Output state of the P-bit
    logic enable;
    integer bias;
    // Instantiate the P_bit module
    P_bit uut (
        .clk(clk),
        .reset_n(reset_n),
        .I_i(I_i),           // Weighted input
        .seed(seed),         // Seed for LFSR
        .m_i(m_i),            // Output state
        .enable(enable)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset_n = 0;
        seed = 32'b11011010111000011110101101111000;  // Example seed for LFSR
        enable = 1;
        
        // Release reset
        #10 reset_n = 1;

        // Test cases
        I_i = 8'sd0 <<< 3; bias = 0;            // Floating mode
        #10000 
        I_i = 8'sd10 <<< 3; bias = 10;          // Pushed to 1
        #10000 
        I_i = -8'sd10 <<< 3; bias = -10;        // Pushed to 0
        #10000 
        $finish;
    end

    //// File pointer for CSV file
    integer file;
    
    // Open CSV file for writing output data
    initial begin
        file = $fopen("P_bit_uncon_float_1_0.csv", "w");  // Open or create the file for writing
        // Check if the file was opened successfully
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Time(ns),m_i,bias\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    // Monitor and output P_bit_out data to CSV file
    initial begin
        // Loop to monitor P_bit_out over times
        forever begin
            #1; // Small delay to capture every time step
            if (file) begin
                $fwrite(file, "%t,%b,%d\n", $time, m_i , bias);  // Write time and P_bit_out value to CSV file
            end
        end
    end
    
    // Close the file at the end of simulation
    final begin
        if (file) begin
            $fclose(file);  // Close the file
            $display("Data written to P_bit_uncon_float_1_0.csv");
        end
    end
endmodule
