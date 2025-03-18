`timescale 1ns / 1ps
`include "global_params.svh"
module ILA_data_logger(
    input logic clk,
    input logic reset_n,
    input logic [0:num_Out-1] out,
    input logic [1:0] clk_delay,
    output logic [7:0] ila_hist_sel,   // current histogram index (0 to 255)
    output logic [HIST_DATA_SIZE:0] ila_hist_data,  // histogram counter data for the selected index
    output logic LED
    );

// Parameters for histogram and freeze time
parameter NUM_PATTERNS = 2**(num_Out);  // For an 8-bit output, NUM_PATTERNS = 256
parameter FREEZE_TIME = 32'd100000000;    // Number of clock cycles until freeze

// Histogram counters: 256 entries, 32 bits each.
logic [HIST_DATA_SIZE:0] hist [0:NUM_PATTERNS-1];
logic [num_Out-1:0] out_vector;

// Freeze signal and counter
logic freeze;
logic [31:0] freeze_counter;

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        freeze_counter <= 32'd0;
        freeze <= 1'b0;
    end else begin
        if (freeze_counter < FREEZE_TIME) begin
            freeze_counter <= freeze_counter + 1;
            freeze <= 1'b0;
        end else begin
            freeze <= 1'b1;  // Once we reach FREEZE_TIME, stop updating the histogram
        end
    end
end

// Histogram update: only update if not frozen
always_ff @(posedge clk_delay) begin
    if (!freeze) begin
        out_vector <= out;  // Capture the current 8-bit output vector
        hist[out_vector] <= hist[out_vector] + 1;  // Increment the corresponding counter
    end
end

// Now, to read out the histogram after convergence, create a multiplexer:
logic [7:0] hist_sel;  // 8-bit counter to select one histogram entry (0 to 255)

// Only run the readout multiplexer when the histogram is frozen.
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        hist_sel <= 8'd0;
    else if (freeze)  // only cycle through once freeze is active
        hist_sel <= hist_sel + 1;
end

// Multiplexer output: read the selected histogram counter.
logic [HIST_DATA_SIZE:0] hist_out = hist[hist_sel];

// Mark these signals as "keep" so they are preserved for debugging.
(* keep = "true" *) logic [7:0] ila_hist_sel;
(* keep = "true" *) logic [HIST_DATA_SIZE:0] ila_hist_data;

assign ila_hist_sel = hist_sel;
assign ila_hist_data = hist_out;
assign LED = freeze;

endmodule
