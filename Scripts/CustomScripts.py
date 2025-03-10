import numpy as np
import random
import itertools
import matplotlib.pyplot as plt
import pandas as pd
import networkx as nx
import os

def bipolar_to_binary(J_bipolar, h_bipolar):
    """
    Calculate the weight matrix J and bias vector h binary representation

    Parameters:
    J_bipolar: Matrix of interconnection weights
    h_bipolar: Vector of self bias.

    Returns:
    Matrix, Vector of mapped to binary. 
    """
    J_binary = 2.0 * J_bipolar
    ones_vec = np.ones(J_bipolar.shape[0])
    h_binary = h_bipolar - J_bipolar.dot(ones_vec)
    for i in range(len(h_binary)):
        if h_binary[i] > 15.875:
            h_binary[i] = 15.875
        elif h_binary[i] < -16:
            h_binary[i] = -16.0
    return J_binary, h_binary

def fixed_point_range_signed(I, F):
    """
    Calculate the range and step size of a fixed-point representation s[I][F].
    
    Parameters:
    I (int): Number of integer bits (including sign bit)
    F (int): Number of fractional bits

    Returns:
    tuple: Min value, Max value, and Step size
    """
    min_value = -2**(I)
    max_value = 2**(I) - 2**-F
    step_size = 2**-F

    # Display results
    print(f"Fixed-Point Notation: s[{I}][{F}]")
    print(f"Minimum Value: {min_value}")
    print(f"Maximum Value: {max_value}")
    print(f"Step Size: {step_size}")

    return min_value, max_value, step_size

def fixed_point_range_unsigned(I, F):
    """
    Calculate the range and step size of a fixed-point representation s[I][F].
    
    Parameters:
    I (int): Number of integer bits (including sign bit)
    F (int): Number of fractional bits

    Returns:
    tuple: Min value, Max value, and Step size
    """
    min_value = 0
    max_value = 2**(I) - 2**-F
    step_size = 2**-F

    # Display results
    print(f"Fixed-Point Notation: s[{I}][{F}]")
    print(f"Minimum Value: {min_value}")
    print(f"Maximum Value: {max_value}")
    print(f"Step Size: {step_size}")

    return min_value, max_value, step_size


def decimal_to_s4_3(value):
    """
    Convert a decimal number to s[4][3] fixed-point representation (8-bit signed).

    Parameters:
    value (float): Decimal number to convert.

    Returns:
    str: 8-bit signed binary string in s[4][3] format.
    int: Signed integer representation in s[4][3].
    """
    # Define fixed-point properties
    integer_bits = 4
    fractional_bits = 3
    total_bits = 8
    min_value = -2**(integer_bits)  # -16
    max_value = 2**(integer_bits) - 2**-fractional_bits  # 15.875
    step_size = 2**-fractional_bits  # 0.125

    # Clamp value to valid range
    value = max(min_value, min(max_value, value))

    # Scale and round to nearest fixed-point step
    fixed_point_value = round(value / step_size)

    # Convert to signed 8-bit two’s complement representation
    if fixed_point_value < 0:
        fixed_point_value = (1 << total_bits) + fixed_point_value  # Convert to two’s complement

    # Convert to binary string
    binary_representation = format(fixed_point_value & 0xFF, '08b')  # Mask to 8 bits

    return binary_representation, fixed_point_value - (256 if fixed_point_value >= 128 else 0)

def generate_seed(index):
    """
    Generate a 32-bit random binary seed for SystemVerilog.

    Parameters:
    index (int): The index for the seed parameter.

    Returns:
    str: SystemVerilog-formatted parameter string.
    """
    seed_value = ''.join(random.choice('01') for _ in range(32))
    return f"parameter seed{index} = 32'b{seed_value};"

def generate_seed_array(num_seeds):
    """
    Generate a SystemVerilog formatted seed array initialization.

    Parameters:
    num_seeds (int): Number of seeds to generate.

    Returns:
    str: SystemVerilog-formatted logic array declaration.
    """
    seed_parameters = [generate_seed(i) for i in range(num_seeds)]
    seed_array_init = f"logic [31:0] seed [0:{num_seeds-1}] = '{{{', '.join(f'seed{i}' for i in range(num_seeds))}}};"

    return "\n".join(seed_parameters) + "\n" + seed_array_init

def generate_verilog_params(J_bipolar, h_bipolar):
    """
    Generate SystemVerilog initialization code for given J and h values.

    Parameters:
    J_bipolar (np.array): Bipolar weight matrix.
    h_bipolar (np.array): Bipolar bias vector.

    Returns:
    tuple: Verilog formatted strings for J parameters, J array initialization, and h parameters.
    """
    J_binary, h_binary = bipolar_to_binary(J_bipolar, h_bipolar)
    print("Converted to binary:")
    print(J_binary)
    print(np.array2string(h_binary, separator=","))
    J_binary_formatted = ""
    for i in range(J_binary.shape[0]):
        for j in range(J_binary.shape[1]):
            bin_value, _ = decimal_to_s4_3(J_binary[i, j])
            J_binary_formatted += f"parameter J_{i:02d}{j:02d} = 8'sb{bin_value};\n"

    h_binary_formatted = ""
    for i in range(h_binary.shape[0]):
        bin_value, _ = decimal_to_s4_3(h_binary[i])
        h_binary_formatted += f"parameter h{i} = 8'sb{bin_value};\n"
    
    J_array_init = "logic signed [7:0] J [0:{}][0:{}] = '{{".format(
        J_binary.shape[0] - 1, J_binary.shape[1] - 1
    )
    J_rows = [f"{{{', '.join(f'J_{i:02d}{j:02d}' for j in range(J_binary.shape[1]))}}}"
              for i in range(J_binary.shape[0])]
    J_array_init += ",\n".join(J_rows) + "};"

    # Generate h array initialization.
    h_array_init = "logic signed [7:0] h [0:{}] = '{{".format(h_binary.shape[0] - 1)
    h_array_init += ",".join(f"h{i}" for i in range(h_binary.shape[0])) + "};"

    return J_binary_formatted, J_array_init, h_binary_formatted, h_array_init

def generate_verilog_biases(label_mapping_binary=None):
    # Convert to Verilog-style format
    for key, label in label_mapping_binary.items():
        print("#1000000;")
        print(f"// h_bipolar({label})")  # Use the formatted (A, B, D) string
        
        for i, value in enumerate(key):  # Use key tuple to iterate over values
            if (value > 15.875):
                value = 15.875
            elif (value < -16):
                value = -16
            binary_str, _ = decimal_to_s4_3(value)  # Get binary representation
            print(f"h[{i}] = 8'sb{binary_str};")

        # Generate bias assignments
        for i in range(len(key)):
            print(f"bias[{i}] = s4_3_to_real(h[{i}]);")
        print()  # Add a newline for readability

        for i in range(len(key)):
            print(f"bias[{i}],")
    return

def generate_mem_files(J_bipolar, h_bipolar, file_prefix):
    """
    Generate external mem files for h, J, and seeds.

    The files are written in plain text and stored in the "bram" subfolder:
      - "{file_prefix}_h.mem": one 8-bit binary number per line.
      - "{file_prefix}_J.mem": one row per line; each row is a space-separated list
        of 8-bit binary numbers.
      - "{file_prefix}_seeds.mem": one 32-bit binary seed per line. The number of seeds 
         equals the length of h_bipolar.

    The binary strings are generated using the S4.3 fixed-point conversion.
    """
    import os
    # Ensure the "bram" folder exists.
    bram_folder = "bram"
    if not os.path.exists(bram_folder):
        os.makedirs(bram_folder)

    # Convert bipolar parameters to binary fixed-point values.
    J_binary, h_binary = bipolar_to_binary(J_bipolar, h_bipolar)
    
    # Construct full file paths.
    h_file = os.path.join(bram_folder, f"{file_prefix}_h.mem")
    J_file = os.path.join(bram_folder, f"{file_prefix}_J.mem")
    seed_file = os.path.join(bram_folder, f"{file_prefix}_seeds.mem")
    
    # Write the h memory file.
    with open(h_file, "w") as f:
        for i in range(h_binary.shape[0]):
            bin_value, _ = decimal_to_s4_3(h_binary[i])
            f.write(bin_value + "\n")
    
    # Write the J memory file.
    with open(J_file, "w") as f:
        for i in range(J_binary.shape[0]):
            row_vals = []
            for j in range(J_binary.shape[1]):
                bin_value, _ = decimal_to_s4_3(J_binary[i, j])
                row_vals.append(bin_value)
            f.write(" ".join(row_vals) + "\n")
    
    # Generate seed mem file based on the length of h_bipolar.
    num_seeds = h_binary.shape[0]
    with open(seed_file, "w") as f:
        for i in range(num_seeds):
            # Generate a random 32-bit binary string.
            seed_value = ''.join(random.choice('01') for _ in range(32))
            f.write(seed_value + "\n")
    
    print(f"Mem files generated in folder '{bram_folder}':")
    print(f"  {file_prefix}_h.mem")
    print(f"  {file_prefix}_J.mem")
    print(f"  {file_prefix}_seeds.mem")


def truth_table_probabilities(truth_table=None,columns=None,output_columns=None,figWidth=28):
    # Convert to DataFrame
    df = pd.DataFrame(truth_table, columns=columns)

    # Count occurrences of each output combination
    output_counts = df.groupby(output_columns).size().reset_index(name='Count')

    # Compute probabilities
    output_counts['Probability'] = (output_counts['Count'] / len(df)) 
    output_counts.drop(columns=['Count'], inplace=True)

    # Convert binary output states to string representation for labeling
    output_counts['Output State'] = output_counts[output_columns].astype(str).agg(''.join, axis=1)

    # Generate all possible 4-bit binary output states
    all_output_states = [''.join(map(str, state)) for state in itertools.product([0, 1], repeat=len(output_columns))]

    # Ensure all possible states are in the dataframe, filling missing ones with probability 0
    output_counts = output_counts.set_index('Output State').reindex(all_output_states, fill_value=0).reset_index()

    # Plot the probability distribution with all possible states
    plt.figure(figsize=(figWidth, 5))
    plt.bar(output_counts['Output State'], output_counts['Probability'], color='blue', alpha=0.7)
    plt.xlabel("Output State (P3P2P1P0)")
    plt.ylabel("Probability")
    plt.margins(0.01)
    plt.title("Probability Distribution of truth table States")
    plt.xticks(rotation=90)
    plt.grid(axis='y', linestyle='--', alpha=0.7)

    # Show the plot
    plt.show()

def generate_group_update_order(J_bipolar, var_names, group_bit_width=3):
    """
    Generate and print SystemVerilog lookup table lines based on the update order
    computed from the given J_bipolar interaction matrix.
    
    Parameters:
        J_bipolar (np.array): The interaction matrix.
        var_names (list of str): List of variable names corresponding to each index.
        group_bit_width (int): Bit width used for encoding the group index in SV (default is 3).
    """
    # Build an undirected graph. Each node corresponds to a variable.
    G = nx.Graph()
    num_nodes = J_bipolar.shape[0]
    G.add_nodes_from(range(num_nodes))

    # Add edges between nodes that interact (i.e. nonzero entry in J_bipolar).
    for i in range(num_nodes):
        for j in range(i + 1, num_nodes):
            if J_bipolar[i, j] != 0:
                G.add_edge(i, j)

    # Use a greedy graph coloring algorithm.
    coloring = nx.algorithms.coloring.greedy_color(G, strategy=nx.algorithms.coloring.strategy_saturation_largest_first)

    # Group nodes by their assigned color.
    update_groups = {}
    for node, color in coloring.items():
        update_groups.setdefault(color, []).append(node)

    # Sort the groups for neat output.
    update_order = [sorted(update_groups[color]) for color in sorted(update_groups)]

    # Print out the update order with variable names.
    print("Update order groups (variables that can be updated simultaneously):")
    for step, group in enumerate(update_order):
        group_names = [var_names[i] for i in group]
        print(f"Step {step + 1}: {group_names}")
    print(f"\nClock cycles needed for full update (sequential) = {3*len(var_names)}")
    print(f"Clock cycles needed for full update (parallelized) = {3*len(update_order)}")
    print(f"Speed increase percentage = {(((3*len(var_names))/(3*len(update_order)))-1)*100:.2f}")
    print(f"Speed factor increase = {(3*len(var_names))/(3*len(update_order)):.2f}")
    # ---------------------------
    # Generate SystemVerilog lookup table lines.
    # For each update group, we generate a line such as:
    # 3'b001 : Pbit_EN = 14'b100100001000000;
    # ---------------------------

    num_vars = len(var_names)

    print("\nSystemVerilog lookup table:")
    for group_index, group in enumerate(update_order):
        # Create a binary representation of the group index (e.g., 3'b001).
        group_bin = format(group_index, f'0{group_bit_width}b')
        # Create a 14-bit string where each bit is 1 if the corresponding variable index is in the update group.
        pbit_en_bits = ''.join(['1' if i in group else '0' for i in range(num_vars)])
        print(f"{group_bit_width}'b{group_bin} : Pbit_EN = {num_vars}'b{pbit_en_bits};")

    # ---- Plotting the Graph ----

    # Create a layout for visualization.
    pos = nx.spring_layout(G)  # seed for reproducible layout

    # Prepare a color list for nodes based on their update group.
    node_colors = [coloring[i] for i in G.nodes()]

    # Draw the graph with node labels.
    nx.draw(G, pos, with_labels=False, labels={i: var_names[i] for i in G.nodes()},
            node_color=node_colors, cmap=plt.cm.Set3, node_size=200, font_size=10)

    plt.title("Graph of Variable Interactions with Update Groups")
    plt.show()


def load_npz_data(file_name, target_folder="Circuit_Library"):
    """
    Searches upward for the folder 'target_folder', loads the npz file with the given file_name,
    and returns the weight matrix (J), bias vector (h), and node order.

    The NPZ file is assumed to contain keys of the form:
       "{circuit_name}_h", "{circuit_name}_J", and "node_order"
    where circuit_name is derived from the file name (without extension).
    """
    # Find the target folder.
    folder = find_folder_upwards(target_folder)
    print(f"Found folder: {folder}")
    
    # Build the full file path.
    file_path = os.path.join(folder, file_name)
    if not os.path.isfile(file_path):
        raise FileNotFoundError(f"File '{file_path}' not found.")
    
    # Load the npz file.
    data = np.load(file_path)
    
    # Extract the circuit name from the file name (without extension).
    circuit_name = os.path.splitext(file_name)[0]
    
    # Build the keys.
    h_key = f"{circuit_name}_h"
    J_key = f"{circuit_name}_J"
    node_order_key = f"{circuit_name}_node_order"
    try:
        h = data[h_key]
        J = data[J_key]
    except KeyError as e:
        raise KeyError(f"Key {e} not found in the NPZ file. Ensure the file uses the naming convention.")
    
    # 'node_order' is assumed to be stored with that key.
    try:
        node_order = data[node_order_key]
    except KeyError:
        raise KeyError("Key 'node_order' not found in the NPZ file.")
    
    return J, h, node_order

def find_folder_upwards(target_folder, start_dir=None):
    """
    Starting from 'start_dir' (or the directory of the current file if None),
    go upward until a folder named 'target_folder' is found.
    Returns the absolute path to the target folder.
    Raises FileNotFoundError if not found.
    """
    if start_dir is None:
        start_dir = os.path.dirname(os.path.abspath(__file__))
    current_dir = start_dir
    while True:
        candidate = os.path.join(current_dir, target_folder)
        if os.path.isdir(candidate):
            return os.path.abspath(candidate)
        parent_dir = os.path.dirname(current_dir)
        if parent_dir == current_dir:
            # Reached the root directory
            raise FileNotFoundError(f"Folder '{target_folder}' not found in any parent directories of {start_dir}.")
        current_dir = parent_dir

def update_all_configurations(target_names, h_bipolar, node_order):
    """
    For each configuration in target_names, update a copy of h_bipolar based on
    the node names in node_order. The target_names is a nested dictionary mapping
    configuration labels to a dictionary that maps node names to target strings.
    
    Returns a dictionary mapping configuration labels to the updated h arrays.
    """
    # Map target strings to numeric values.
    target_value_map = {
        "push0": -16.0,
        "push1": 15.875
    }
    
    # Convert node_order to a list if it's a numpy array.
    if isinstance(node_order, np.ndarray):
        node_order = node_order.tolist()
    
    # Ensure h_bipolar is at least 1-dimensional.
    h_bipolar = np.atleast_1d(h_bipolar)
    
    updated_configurations = {}
    for config_label, mapping in target_names.items():
        # Create a copy of the original h_bipolar array for this configuration.
        h_updated = np.array(h_bipolar)
        for node, target_str in mapping.items():
            # Strip any whitespace from the target string.
            target_str = target_str.strip()
            if node in node_order:
                idx = node_order.index(node)
                # Get the numeric value from the map.
                new_value = target_value_map.get(target_str)
                if new_value is None:
                    raise ValueError(f"Target string '{target_str}' not defined in target_value_map.")
                h_updated[idx] = new_value
            else:
                print(f"Warning: Node '{node}' not found in node_order; skipping update for config '{config_label}'.")
        updated_configurations[config_label] = h_updated.tolist()
    return updated_configurations