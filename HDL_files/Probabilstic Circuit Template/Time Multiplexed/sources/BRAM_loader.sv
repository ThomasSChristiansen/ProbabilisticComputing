`timescale 1ns / 1ps
`include "global_params.svh"

module load_weight_bias (
    input  logic clk,
    input  logic reset_n,
    input  logic start_load,  // Trigger to start preloading a row
    input  logic [$clog2(num_Pbits+1)-1:0] current_row, // Initial row to load
    input logic compute_done,
    output logic data_valid,
    output logic load_done,
    output logic            [4:0]               row_length,
    output logic signed     [VAL_WIDTH-1:0]     value,
    output logic            [INDEX_WIDTH-1:0]   index,
    output logic signed     [h_WIDTH-1:0]       h   
);

//----------------------------------------------------------------------
// Internal signals
//----------------------------------------------------------------------
logic           [$clog2(num_Pbits+1)-1:0]       current_row_reg;
logic           [ROW_PTR_ADDR_WIDTH-1:0]        row_ptr_addrA, row_ptr_addrB;
logic           [ROW_PTR_WIDTH-1:0]             row_ptr_outA, row_ptr_outB;
logic           [VALUE_ADDR_WIDTH-1:0]          value_addrA;
logic           [COL_INDICES_ADDR_WIDTH-1:0]    col_index_addrA;
logic           [h_ADDR_WIDTH-1:0]              h_addrA;
logic signed    [h_WIDTH-1:0]                   h_outA;
logic signed    [VAL_WIDTH-1:0]                 value_outA;
logic           [INDEX_WIDTH-1:0]               col_index_outA;

logic [ROW_PTR_WIDTH-1:0] start_ptr, end_ptr, addr_counter;
logic last_data_valid;
logic data_valid_next;

// FSM state declaration
typedef enum logic [2:0] {
    SET_ADDR,   // latch current_row, compute row_ptrs
    WAIT_PTR,   // wait 1 cycle for BRAM latency (optional)
    STREAM_PREP,
    STREAM,     // loop from start_ptr to end_ptr - 1
    DONE        // signal completion
} state_t;

state_t state;
//----------------------------------------------------------------------
// FSM
//----------------------------------------------------------------------
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= SET_ADDR;
        current_row_reg     <= 0;
        addr_counter        <= 0;
        row_length          <= 0;
        start_ptr           <= 0;
        end_ptr             <= 0;
        data_valid          <= 0;
        data_valid_next     <= 0;
        load_done           <= 0;
        last_data_valid     <= 0;
        value               <= 0;
        index               <= 0;
        value_addrA         <= 0;
        col_index_addrA     <= 0;
    end else begin
        data_valid <= data_valid_next;
        data_valid_next <= 0;
        load_done <= 0;
        case (state)
            SET_ADDR: begin
                if (start_load) begin
                    current_row_reg <= current_row;
                    row_ptr_addrA   <= current_row;
                    row_ptr_addrB   <= current_row + 1;
                    h_addrA         <= current_row;
                    state           <= WAIT_PTR;
                end
            end

            WAIT_PTR: begin
                state <= STREAM_PREP;
            end
            
            STREAM_PREP: begin
                start_ptr    <= row_ptr_outA;
                end_ptr      <= row_ptr_outB;
                row_length   <= row_ptr_outB - row_ptr_outA;
                addr_counter <= 1;
                value_addrA     <= row_ptr_outA;
                col_index_addrA <= row_ptr_outA;
                value <= value_outA;
                index <= col_index_outA;
                if (row_ptr_outA == row_ptr_outB) begin
                    state <= DONE;
                end else begin
                    state <= STREAM;
                end
            end

            STREAM: begin
                value <= value_outA;
                index <= col_index_outA;
                if ((start_ptr + addr_counter) == (end_ptr+1)) begin
                    last_data_valid <= 1;
                    data_valid_next <= 0;
                end else begin
                    value_addrA     <= start_ptr + addr_counter;
                    col_index_addrA <= start_ptr + addr_counter;
                    data_valid_next <= 1;
                    addr_counter <= addr_counter + 1;
                    last_data_valid <= 0;
                end
            
                if (last_data_valid) begin
                    state <= DONE;
                    load_done <= 1;
                    data_valid_next <= 0;
                    last_data_valid <= 0;
                end
            end

            DONE: begin
                load_done <= 1;
                if (compute_done) begin
                    load_done <= 0;  // deassert before accepting new start
                    state     <= SET_ADDR;
                end
            end

            default: state <= SET_ADDR;
        endcase
    end
end


//----------------------------------------------------------------------
// BRAM instances
//----------------------------------------------------------------------
BRAM_row_ptr bram_row_ptr_inst (
    .clka(clk),
    .ena(1'b1),
    .addra(row_ptr_addrA),
    .douta(row_ptr_outA),
    .clkb(clk),
    .enb(1'b1),
    .addrb(row_ptr_addrB),
    .doutb(row_ptr_outB)
);

BRAM_values bram_values_inst (
    .clka(clk),
    .ena(1'b1),
    .addra(value_addrA),
    .douta(value_outA)
);

BRAM_col_indices bram_col_indices_inst (
    .clka(clk),
    .ena(1'b1),
    .addra(col_index_addrA),
    .douta(col_index_outA)
);

BRAM_h bram_h_inst (
    .clka(clk),
    .ena(1'b1),
    .addra(h_addrA),
    .douta(h_outA)
);

//assign value  = value_outA;
//assign index = col_index_outA;
assign h       = h_outA;

endmodule
