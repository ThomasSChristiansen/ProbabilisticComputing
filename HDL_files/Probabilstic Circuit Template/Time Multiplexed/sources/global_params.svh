// pbit_params.svh
// Global parameter definitions for all p-bit modules

`ifndef GLOBAL_PARAMS_SVH
`define GLOBAL_PARAMS_SVH

// Define the number of P-bits globally
parameter num_Pbits = 459;
parameter num_Out = 16;
parameter HIST_DATA_SIZE = 20;
parameter HIST_SEL_SIZE = $clog2(90);
parameter COL_INDICES_ADDR_WIDTH = 12;
parameter VALUE_ADDR_WIDTH = 12;
parameter ROW_PTR_ADDR_WIDTH = 9;
parameter h_ADDR_WIDTH = 9;
parameter h_WIDTH = 9;
parameter ROW_PTR_WIDTH = 16;
parameter VAL_WIDTH = 9;
parameter INDEX_WIDTH = 16;
parameter SEED = 32'b10110101110001010100100100010011;
`endif
