`timescale 1ns / 1ps

module Tanh_LUT_tb;
    
    // Testbench signals
    logic signed [7:0] Tanh_LUT_in;
    logic [31:0] Tanh_LUT_out;
    
    // Instantiate the Tanh_LUT module
    Tanh_LUT uut (
    .Tanh_LUT_in(Tanh_LUT_in),
    .Tanh_LUT_out(Tanh_LUT_out)
    );
    
    // Test procedure
    initial begin
    // Initialize the input
    Tanh_LUT_in = 8'sb10000000;
    
    // Loop through every signed 8-bit value
    repeat (256) begin
      #10;  // Wait for 10 ns before displaying results
      Tanh_LUT_in <= Tanh_LUT_in + 1;  // Use non-blocking assignment to increment
    end
    // End the simulation
    $finish;
    end
    
    //// File pointer for CSV file
    integer file;
    
    // Open CSV file for writing output data
    initial begin
        file = $fopen("Tanh_output.csv", "w");  // Open or create the file for writing
        // Check if the file was opened successfully
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Time(ns),Tanh_LUT_in,Tanh_LUT_out\n");
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
                $fwrite(file, "%t,%b,%b\n", $time, Tanh_LUT_in, Tanh_LUT_out);  // Write time and P_bit_out value to CSV file
            end
        end
    end
    
    // Close the file at the end of simulation
    final begin
        if (file) begin
            $fclose(file);  // Close the file
            $display("Data written to Tanh_output.csv");
        end
    end
endmodule
