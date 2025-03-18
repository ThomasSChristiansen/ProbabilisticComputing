# Usage
- Make new Vivado project
- Copy all the files from the folder `Probabilistic Circuit Template` as sources for the project except `grouped_update_order_LUT.sv` and `global_params.svh`.
- Copy the generated `.men` files to the project .
- Copy the circuit specific `grouped_update_order_LUT.sv` and `global_params.svh`.
- Copy the constraint file from the template folder.
- Set the testbench as simulation only in properties (if testbench is needed).
- Set the `num_Out` parameter in `global_params.svh`.
- Make sure the grouped update order is set appropriately for the specific circuit.
- Edit the `values` and `col_indices` to match the specific `.mem` files