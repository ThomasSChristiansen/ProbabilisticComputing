`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "global_params.svh"
module probabalistic_top_level_template(
    input logic clk,                            // Clock signal
    input logic reset_n,                        // Reset signal
    output logic LED
);
// Intermediate output storage
logic [num_Pbits-1:0] m;
logic [num_Out-1:0] pbit_out;
(* keep = "true" *) logic [HIST_SEL_SIZE-1:0] ILA_hist_sel;  // current histogram index (0 to 255)           
(* keep = "true" *) logic [HIST_DATA_SIZE:0] ILA_hist_data; // histogram counter data for the selected index


// Interconnection strengh
parameter I_0 = 8'sb00001000;  //I_0 = 1

// Internal signals
logic signed    [7:0]               result_Jm;// Weighted inputs for each P-bit
logic signed    [7:0]               addition_hi;// Inner Product
logic signed    [15:0]              product_I0;// Result 
logic signed    [7:0]               product_Jm;// Product of I0 and sum
logic signed    [8:0]               extended_addition;// hi+sum(J_ij+m_j)
logic signed    [8:0]               extended_result_Jm;
logic signed    [8:0]               extended_result_Jm_reg;
logic signed    [8:0]               acc_result;

// Inputs to decoder_test
logic                                       start_load;
logic           [$clog2(num_Pbits+1)-1:0]   current_row;
logic           [$clog2(num_Pbits)-1:0]     compute_row;


// Outputs from decoder_test
logic                               data_valid;
logic                               load_done;
logic signed    [VAL_WIDTH-1:0]     value;
logic           [INDEX_WIDTH-1:0]   index;
logic signed    [7:0]               h;
logic           [4:0]               row_length;   

logic preload_handled;
logic [7:0] current_I_i;
logic current_m;
logic index_m;
logic [$clog2(num_Pbits)-1:0] current_index;
logic compute_done, evaluate_done;
logic evaluate_enable;
logic update_cycle_done;
logic [4:0] ptr_idx;

typedef enum logic [2:0] {
    INIT,
    START_ROW,
    ACCUMULATE,
    COMPUTE,
    EVALUATE
} state_t;

state_t state;


// Instantiate
load_weight_bias load_weight_bias (
    .clk(clk),
    .reset_n(reset_n),
    .start_load(start_load),
    .compute_done(compute_done),
    .current_row(current_row),
    .load_done(load_done),
    .data_valid(data_valid),
    .value(value),
    .row_length(row_length),
    .index(index),
    .h(h)
);

always_ff @(posedge clk or negedge reset_n) begin
if (!reset_n) begin
    state               <= INIT;
    start_load          <= 0;
    current_index       <= 0;
    current_row         <= 0;
    acc_result          <= 0;
    evaluate_enable     <= 0;
    update_cycle_done   <= 0;
    product_Jm          <= 0;
    ptr_idx             <= 0;
    for (int i = 0; i < num_Pbits; i++) m[i] <= 0;
end else begin
         case (state)
            INIT: begin
                acc_result <= 0;
                current_row <= 0;
                start_load <= 1;
                update_cycle_done <= 0;
                ptr_idx <= 0;
                state <= START_ROW;
            end

            START_ROW: begin
                start_load <= 0;
                update_cycle_done <=0;
                if (data_valid) begin
//                    if (m[index])
//                        acc_result <= acc_result + {{1{value[7]}}, value};
                    index_m <= m[index];
                    product_Jm = value * m[index];
                    acc_result <= acc_result + {{1{product_Jm[7]}}, product_Jm};
                    ptr_idx <= ptr_idx + 1;     
                end else if (load_done ) begin 
                    state <= COMPUTE;
                    ptr_idx <= 0;
                    compute_done <= 1;
                end
            end

            COMPUTE: begin
                compute_done <= 0;
                // Clamp result_Jm
                if (acc_result > 8'sb01111111) 
                    result_Jm = 8'sb01111111;
                else if (acc_result < 8'sb10000000) 
                    result_Jm = 8'sb10000000;
                else 
                    result_Jm = acc_result[7:0];

                // Add h_i
                extended_addition = { {1{h[7]}}, h } + { {1{result_Jm[7]}}, result_Jm };
                if (extended_addition > 8'sb01111111) 
                    addition_hi = 8'sb01111111;
                else if (extended_addition < 8'sb10000000) 
                    addition_hi = 8'sb10000000;
                else 
                    addition_hi = extended_addition[7:0];

                // Final product
                product_I0 = I_0 * addition_hi;
                current_I_i <= product_I0 >>> 3;
                
                evaluate_enable <= 1;
                state <= EVALUATE;
            end

            EVALUATE: begin
                evaluate_enable <= 0;
                m[current_index] <= current_m;
                if (current_index == num_Pbits - 1) begin
                    pbit_out <= m[num_Pbits-1 -: num_Out];
                    current_index <= 0;
                    current_row <= 0;
                    update_cycle_done <= 1;
                    acc_result <= 0;
                    product_Jm <= 0;
                    start_load <= 1;
                    state <= START_ROW;
                end else begin
                    current_index <= current_index + 1;
                    current_row  <= current_index + 1;
                    update_cycle_done <= 0;
                    acc_result <= 0;
                    product_Jm <= 0;
                    start_load <= 1;
                    state <= START_ROW;
                end
            end

            default: state <= INIT;
        endcase
end
end

P_bit p_bit_inst (
    .clk(clk),
    .enable(evaluate_enable),
    .reset_n(reset_n),
    .I_i(current_I_i),
    .m_i(current_m),
    .seed(SEED) 
);

//// Instantiate the ILA logger
ILA_data_logger ILA_data_logger_inst(
    .clk(clk),
    .reset_n(reset_n),
    .out(pbit_out),
    .ILA_hist_sel(ILA_hist_sel),
    .ILA_hist_data(ILA_hist_data),
    .LED(LED),
    .update_cycle_done(update_cycle_done)
);
endmodule
