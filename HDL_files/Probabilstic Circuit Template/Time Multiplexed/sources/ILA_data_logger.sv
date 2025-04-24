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
parameter FREEZE_TIME = 32'd1000000000;    // Number of clock cycles until freeze

// Histogram counters: 256 entries, 32 bits each.
logic [HIST_DATA_SIZE:0] hist [0:NUM_STATES_TRACKED-1];
logic [num_Out-1:0] out_vector;

// Freeze signal and counter
logic freeze;
logic [31:0] freeze_counter;

// List of the 20 specific 16-bit states to track
logic [num_Out-1:0] tracked_states [0:NUM_STATES_TRACKED-1] = '{
    8'd0,
    8'd1,
    8'd2,
    8'd3,
    8'd4,
    8'd5,
    8'd6,
    8'd7,
    8'd8,
    8'd9,
    8'd10,
    8'd11,
    8'd12,
    8'd13,
    8'd14,
    8'd15,
    8'd16,
    8'd18,
    8'd20,
    8'd21,
    8'd22,
    8'd24,
    8'd25,
    8'd26,
    8'd27,
    8'd28,
    8'd30,
    8'd32,
    8'd33,
    8'd35,
    8'd36,
    8'd39,
    8'd40,
    8'd42,
    8'd44,
    8'd45,
    8'd48,
    8'd49,
    8'd50,
    8'd52,
    8'd54,
    8'd55,
    8'd56,
    8'd60,
    8'd63,
    8'd64,
    8'd65,
    8'd66,
    8'd70,
    8'd72,
    8'd75,
    8'd77,
    8'd78,
    8'd80,
    8'd81,
    8'd84,
    8'd88,
    8'd90,
    8'd91,
    8'd96,
    8'd98,
    8'd99,
    8'd100,
    8'd104,
    8'd105,
    8'd108,
    8'd110,
    8'd112,
    8'd117,
    8'd120,
    8'd121,
    8'd126,
    8'd130,
    8'd132,
    8'd135,
    8'd140,
    8'd143,
    8'd144,
    8'd150,
    8'd154,
    8'd156,
    8'd165,
    8'd168,
    8'd169,
    8'd180,
    8'd182,
    8'd195,
    8'd196,
    8'd210,
    8'd225
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
