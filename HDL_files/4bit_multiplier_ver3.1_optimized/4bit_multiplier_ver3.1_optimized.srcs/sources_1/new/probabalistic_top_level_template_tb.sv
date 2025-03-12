`timescale 1ns / 1ps

module probabalistic_top_level_template_tb;

    // Testbench signals for inputs
    logic clk;
    logic reset_n;
    logic clamp [0:7];
    logic clamp_EN;
    
    // Output from the UUT
    logic out [0:7];
    logic [1:0] clk_delay;
    // Instantiate the Unit Under Test (UUT)
    probabalistic_top_level_template uut (
        .clk(clk),
        .reset_n(reset_n),
        .clamp(clamp),
        .clamp_EN(clamp_EN),
        .out(out),
        .clk_delay(clk_delay)
    );
    
    // Clock generation: 10 ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Stimulus: generate reset, change clamp values, etc.
    initial begin
        // Initialize inputs
        reset_n = 0;
        // Initialize clamp unpacked array
        for (int i = 0; i < 8; i++) begin
            clamp[i] = 1'b1;
        end
        clamp_EN = 1;
        
        
        // Hold reset for 20 ns
        #10;
        reset_n = 1;
        
        #1000000
        
        // Finish the simulation
        $finish;
    end
    logic [7:0] out_vector;
    // Sample the 8-bit output vector on the positive clock edge
    always @(clk_delay) begin
        #5
        // Combine the individual bits into one vector (assume out[7] is MSB)    
        out_vector = {out[7], out[6], out[5], out[4], out[3], out[2], out[1], out[0]};
        
        // Increment the count for this pattern
        output_occurrences[out_vector]++;
        $display("Time: %0t, out_vector: %08b, count: %0d", $time, out_vector, output_occurrences[out_vector]);
    end
    
    //// Assume that output_occurrences is declared for an 8-bit pattern
    int output_occurrences [0:255];
    
    //// File pointer for CSV file
    integer file;
    
    //// Open CSV file for writing unique occurrence data
    initial begin
        file = $fopen("UniqueOccurrences.csv", "w");  // Open or create the file for writing
        if (file) begin
            // Write the header of the CSV file
            $fwrite(file, "Pattern,Occurrence\n");
        end else begin
            $display("Error opening file.");
        end
    end
    
    //// At the end of simulation, loop over the output_occurrences array and write non-zero entries
    final begin
        integer i;
        if (file) begin
            for (i = 0; i < 256; i = i + 1) begin  // For an 8-bit output, there are 256 possible patterns
                if (output_occurrences[i] != 0)
                    $fwrite(file, "%08b,%0d\n", i, output_occurrences[i]);
            end
            $fclose(file);
            $display("Unique occurrence data written to UniqueOccurrences.csv");
        end
    end

endmodule
