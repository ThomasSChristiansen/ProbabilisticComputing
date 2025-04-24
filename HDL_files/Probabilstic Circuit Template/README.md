# Versions
3 types have been made with different performances: 
1. Standard type using LUTs and is parallized. (High resource usage)
2. Time Multiplexed type using BRAM loading a single value/index pair and computing a single P-bit update sequentially. (Low resource usage)
3. Time Multiplexed type using BRAM holding a whole row at a time using an adder tree. Can be paralized better. (Low resource usage)
# Usage
- Make new Vivado project
- Copy all the files for the specific type from the folder `Probabilistic Circuit Template` as sources for the project.
- Copy the generated `.men` or `.coe` files to the project.
- Copy the circuit specific `grouped_update_order_LUT.sv` and `global_params.svh` (Only for Type 1).
- Copy the constraint file from the template folder.
- Set the testbench as simulation only in properties (if testbench is needed).
- Set the `num_Out` parameter in `global_params.svh`.
- Make sure the grouped update order is set appropriately for the specific circuit (Only for Type 1).
- Edit the `values` and `col_indices` to match the specific `.mem` files (Only for Type 1).
- Set the appropriate BRAM Depth and Width while loading the `.coe`as a init file. 