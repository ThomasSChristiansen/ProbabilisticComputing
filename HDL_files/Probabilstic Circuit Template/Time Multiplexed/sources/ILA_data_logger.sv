`timescale 1ns / 1ps
`include "global_params.svh"
module ILA_data_logger(
    input logic clk,
    input logic reset_n,
    input logic [num_Out-1:0] out,
    input logic update_cycle_done,
    output logic [HIST_SEL_SIZE-1:0] ILA_hist_sel,   // current histogram index (0 to 255)
    output logic [HIST_DATA_SIZE:0] ILA_hist_data,  // histogram counter data for the selected index
    output logic LED
    );

// Parameters for histogram and freeze time
parameter NUM_STATES_TRACKED = 90;
parameter FREEZE_TIME = 64'd500000000000;    // Number of clock cycles until freeze

// Histogram counters: 256 entries, 32 bits each.
logic [HIST_DATA_SIZE:0] hist [0:NUM_STATES_TRACKED-1];
logic [num_Out-1:0] out_vector;

// Freeze signal and counter
logic freeze;
logic [63:0] freeze_counter;

// List of the 20 specific 16-bit states to track
logic [num_Out-1:0] tracked_states [0:NUM_STATES_TRACKED-1] = '{
    16'd0,
    16'd1,
    16'd2,
    16'd3,
    16'd4,
    16'd5,
    16'd6,
    16'd7,
    16'd8,
    16'd9,
    16'd10,
    16'd11,
    16'd12,
    16'd13,
    16'd14,
    16'd15,
    16'd16,
    16'd18,
    16'd20,
    16'd21,
    16'd22,
    16'd24,
    16'd25,
    16'd26,
    16'd27,
    16'd28,
    16'd30,
    16'd32,
    16'd33,
    16'd35,
    16'd36,
    16'd39,
    16'd40,
    16'd42,
    16'd44,
    16'd45,
    16'd48,
    16'd49,
    16'd50,
    16'd52,
    16'd54,
    16'd55,
    16'd56,
    16'd60,
    16'd63,
    16'd64,
    16'd65,
    16'd66,
    16'd70,
    16'd72,
    16'd75,
    16'd77,
    16'd78,
    16'd80,
    16'd81,
    16'd84,
    16'd88,
    16'd90,
    16'd91,
    16'd96,
    16'd98,
    16'd99,
    16'd100,
    16'd104,
    16'd105,
    16'd108,
    16'd110,
    16'd112,
    16'd117,
    16'd120,
    16'd121,
    16'd126,
    16'd130,
    16'd132,
    16'd135,
    16'd140,
    16'd143,
    16'd144,
    16'd150,
    16'd154,
    16'd156,
    16'd165,
    16'd168,
    16'd169,
    16'd180,
    16'd182,
    16'd195,
    16'd196,
    16'd210,
    16'd225
};



always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        freeze_counter <= 32'd0;
        freeze <= 1'b0;
        for (int i = 0; i < NUM_STATES_TRACKED; i++) begin
            hist[i] <= '0;
        end
    end else begin
        if (freeze_counter < FREEZE_TIME) begin
            freeze_counter <= freeze_counter + 1;
            freeze <= 1'b0;
        end else begin
            freeze <= 1'b1;  // Once we reach FREEZE_TIME, stop updating the histogram
            $display("Time constraint reached");
        end
    end
end

// Histogram update logic
always_ff @(posedge clk) begin
    if (!freeze && update_cycle_done) begin
        for (int i = 0; i < NUM_STATES_TRACKED; i++) begin
            if (out === tracked_states[i]) begin
                hist[i] <= hist[i] + 1;
            end else if (out == tracked_states[i]) begin
                hist[i] <= hist[i] + 1;
            end
        end
    end
end

// Now, to read out the histogram after convergence, create a multiplexer:
logic [$clog2(NUM_STATES_TRACKED)-1:0] hist_sel;  // 8-bit counter to select one histogram entry (0 to 255)

// Only run the readout multiplexer when the histogram is frozen.
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        hist_sel <= 8'd0;
    end else if (freeze && hist_sel < NUM_STATES_TRACKED - 1) begin  // only cycle through once freeze is active
        hist_sel <= hist_sel + 1;
    end
end

// Multiplexer output: read the selected histogram counter.
logic [HIST_DATA_SIZE:0] hist_out;
assign hist_out = (hist_sel < NUM_STATES_TRACKED) ? hist[hist_sel] : '0;

//// Mark these signals as "keep" so they are preserved for debugging.
//(* keep = "true" *) logic [7:0] ILA_hist_sel;
//(* keep = "true" *) logic [HIST_DATA_SIZE:0] ILA_hist_data;

assign ILA_hist_sel = hist_sel;
assign ILA_hist_data = hist_out;
assign LED = freeze;

endmodule
