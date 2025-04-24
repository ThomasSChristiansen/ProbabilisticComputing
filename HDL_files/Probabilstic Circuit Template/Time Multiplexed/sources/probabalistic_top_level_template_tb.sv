`timescale 1ns / 1ps
`include "global_params.svh"
module probabalistic_top_level_tb;

    // Clock and reset
    logic clk;
    logic reset_n;
    
    time delay_ns;
    
    // Instantiate the DUT
    probabalistic_top_level_template dut (
        .clk(clk),
        .reset_n(reset_n)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Reset and stimulus
    initial begin
        $display("----- Starting Testbench -----");
        clk = 0;
        reset_n = 0;

        // Apply reset
        #10;
        reset_n = 1;
        $display("num_Pbits = %0d", num_Pbits);
        delay_ns = (num_Pbits * 140) * 200000;
        $display("Delay = %0t ns", delay_ns);
        #delay_ns;
        $finish;
    end
    
    
    logic [num_Out-1:0] out_vector;

    // Histogram update on update_cycle_done
    always_ff @(posedge clk) begin
        if (dut.update_cycle_done) begin
//            $display("[%0t] update_cycle_done HIGH", $time);
            // Capture output as a vector (match bit order as needed)
            out_vector = dut.pbit_out;

            // Increment histogram count
            output_occurrences[out_vector]++;
        end
    end
    

    int output_occurrences [0:2**(num_Out)-1];
    
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
            for (i = 0; i < 2**(num_Out); i = i + 1) begin  // For an 8-bit output, there are 256 possible patterns
                if (output_occurrences[i] != 0)
                    $fwrite(file, "%b,%0d\n", num_Out'(i), output_occurrences[i]);
            end
            $fclose(file);
            $display("Unique occurrence data written to UniqueOccurrences.csv");
            $display("----- Simulation Finished -----");
        end
    end

endmodule
