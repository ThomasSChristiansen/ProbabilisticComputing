`timescale 1ns / 1ps

module P_bit_tb;

// Inputs
reg clk;
reg GE;               // Global enable
reg reset_n;          // Reset for LFSR
reg clamp_en;            // Clamping enable signal
reg clamp_value;      // Value to clamp to (0 or 1)
reg [7:0] tanh_in;    // Input to the Tanh LUT

// Outputs
wire s_out;
wire [31:0] LFSR_out;      // Output from LFSR
wire [31:0] Tanh_LUT_out;  // Output from Tanh LUT

// Instantiate the LFSR
LFSR lfsr_inst (
    .clk(clk),
    .reset_n(reset_n),
    .LFSR_out(LFSR_out)
);

// Instantiate the Tanh LUT
Tanh_LUT tanh_lut_inst (
    .Tanh_LUT_in(tanh_in),
    .Tanh_LUT_out(Tanh_LUT_out)
);

// Instantiate the Comparator
Comparator uut (
    .GE(GE),
    .clk(clk),
    .Tanh_LUT_out(Tanh_LUT_out),
    .LFSR_out(LFSR_out),
    .clamp_en(clamp_en),
    .clamp_value(clamp_value),
    .s_out(s_out)
);

// Clock generation
always #5 clk = ~clk; // 10ns clock period

// Test sequence
initial begin
    // Initialize inputs
    clk = 0;
    GE = 1;
    reset_n = 0;        // Apply reset
    clamp_en = 0;
    clamp_value = 0;
    tanh_in = 8'd128;   // Some input to the Tanh LUT

    // Display header
    $display("Time\t\tClamp\tClamp Value\tTanh_LUT_out\tLFSR_out\tOutput (s_out)");

    // Release reset after 10ns
    #10;
    reset_n = 1;

    // Case 1: Unclamped behavior (normal operation)
    #10;
    clamp_en = 0;
    $display("%0t\t%b\t%b\t\t%d\t%d\t%b", $time, clamp_en, clamp_value, Tanh_LUT_out, LFSR_out, s_out);

    // Case 2: Clamp to 0
    #10;
    clamp_en = 1;
    clamp_value = 0;
    $display("%0t\t%b\t%b\t\t%d\t%d\t%b", $time, clamp_en, clamp_value, Tanh_LUT_out, LFSR_out, s_out);

    // Case 3: Clamp to 1
    #10;
    clamp_value = 1;
    $display("%0t\t%b\t%b\t\t%d\t%d\t%b", $time, clamp_en, clamp_value, Tanh_LUT_out, LFSR_out, s_out);

    // Finish simulation
    #10;
    $finish;
end

endmodule
