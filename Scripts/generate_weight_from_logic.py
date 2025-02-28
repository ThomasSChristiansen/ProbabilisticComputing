import numpy as np
import os 
import glob
import Scripts.CustomScripts as CS

# Automatically find the "Circuit_Library" folder anywhere above this script.
folder = CS.find_folder_upwards("Circuit_Library")

# Get a list of all .npz files in the folder
file_list = glob.glob(os.path.join(folder, "*.npz"))

# Dictionary to store the loaded data
data_dict = {}

for file_path in file_list:
    # Extract the base file name (e.g., "MyCircuit.npz")
    base_name = os.path.basename(file_path)
    # Remove the extension to get the circuit name (e.g., "MyCircuit")
    circuit_name = os.path.splitext(base_name)[0]
    
    # Load the NPZ file
    data = np.load(file_path)
    # Use the circuit name to access the specific keys
    # (e.g., if circuit_name is "MyCircuit", keys are "MyCircuit_h" and "MyCircuit_J")
    try:
        h = data[f"{circuit_name}_h"]
        J = data[f"{circuit_name}_J"]
    except KeyError as e:
        print(f"Key error for file {base_name}: {e}")
        continue  # Skip files that do not match the naming convention
    
    # node_order is assumed to be saved under the key "node_order"
    node_order = data[f"{circuit_name}_node_order"]
    
    # Store the loaded arrays in our dictionary.
    data_dict[circuit_name] = {
        f"{circuit_name}_h": h,
        f"{circuit_name}_J": J,
        f"{circuit_name}_node_order": node_order
    }
# print(data_dict)
# for circuit_name, content in data_dict.items():
#     print(f"File: {circuit_name}.npz")
#     print(f"{circuit_name}_h:")
#     print(content[f"{circuit_name}_h"])
#     # {circuit_name}_h = content[f"{circuit_name}_h"]
#     print(f"{circuit_name}_J:")
#     print(content[f"{circuit_name}_J"])
#     print(f"{circuit_name}_node_order:")
#     print(content[f"{circuit_name}_node_order"])
#     print("\n")

# Weight library: maps gate type (string) to its (h, J) definition.
weight_library = {}
for circuit_name, content in data_dict.items():
    weight_library[circuit_name] = {
        "h": content[f"{circuit_name}_h"],
        "J": content[f"{circuit_name}_J"]
    }
print(weight_library)
def generate_circuit_weights(circuit,SaveCircuit=False,CircuitName=None):
    """
    Given a circuit description (with "nodes" and "gates"),
    compute the overall bias vector and weight matrix by summing
    the contributions from the individual gates.

    The circuit description is a dictionary with:
      - "nodes": a list of unique node names.
      - "gates": a list of gate dictionaries, each with:
           "type": gate type (e.g., "AND", "OR")
           "nodes": list of nodes for that gate (in the predefined order;
                    for AND and OR, assume order [input1, input2, output]).
    """
    nodes = list(dict.fromkeys(circuit["nodes"]))
    num_nodes = len(nodes)
    # Map each node name to an index.
    node_index = {node: idx for idx, node in enumerate(nodes)}
    
    # Initialize overall bias vector and weight matrix.
    h_total = np.zeros(num_nodes)
    J_total = np.zeros((num_nodes, num_nodes))
    
    # Process each gate.
    for gate in circuit["gates"]:
        gate_type = gate["type"]
        gate_nodes = gate["nodes"]
        if gate_type not in weight_library:
            raise ValueError(f"Gate type '{gate_type}' not defined in weight library.")
        gate_h = weight_library[gate_type]["h"]
        gate_J = weight_library[gate_type]["J"]
        
        if len(gate_nodes) != len(gate_h):
            raise ValueError(f"Gate of type '{gate_type}' expects {len(gate_h)} nodes, but got {len(gate_nodes)}.")
        
        # Add contributions from this gate into the overall Hamiltonian.
        for i, node in enumerate(gate_nodes):
            idx_i = node_index[node]
            h_total[idx_i] += gate_h[i]
            # For each pair of nodes in the gate, add the coupling.
            for j in range(i + 1, len(gate_nodes)):
                idx_j = node_index[gate_nodes[j]]
                J_total[idx_i, idx_j] += gate_J[i, j]
                J_total[idx_j, idx_i] += gate_J[j, i]  # Ensure symmetry.
    np.set_printoptions(threshold=np.inf, linewidth=200)
    print("Overall bias vector (h_total) in np.array format:")
    print("np.array(" + np.array2string(h_total, separator=", ") + ")")
    
    print("\nOverall weight matrix (J_total) in np.array format:")
    print("np.array(" + np.array2string(J_total, separator=", ") + ")")
    
    print("\nOrder of the matrix: {} x {}".format(len(circuit["nodes"]), len(circuit["nodes"])))
    print("\nNode order (mapping of node names to indices):")
    node_order = [None] * len(node_index)
    for node, idx in node_index.items():
        node_order[idx] = node
    nodes = list(node_order)
    print("[" + ", ".join('"' + str(s) + '"' for s in node_order) + "]")
    if SaveCircuit:
        # Ensure the folder exists
        save_folder = CS.find_folder_upwards("Circuit_Library")
        os.makedirs(save_folder, exist_ok=True)
        save_path = os.path.join(save_folder, f"{CircuitName}.npz")
        np.savez(save_path, **{f"{CircuitName}_h": h_total, f"{CircuitName}_J": J_total, f"{CircuitName}_node_order": node_order})
        print(f"Saved weight data to {save_path}")
    return h_total, J_total, nodes

def main():
    circuit = {
        "nodes": ["A0", "A1", "A2", "A3", "B0", "B1", "B2", "B3", "Cin0", "Cin1", "Cin2",
                  "P0", "P1", "P2", "P3", "P4", "P5", "P6", "P7", 
                  
                  "4bFA1_A3", "4bFA1_A2", "4bFA1_A1", "4bFA1_A0", "4bFA1_B3", "4bFA1_B2", "4bFA1_B1", "4bFA1_B0","4bFA1_Cout", 
                  "4bFA1_C2", "4bFA1_C1", "4bFA1_C0", "4bFA1_Cin", "4bFA1_S3", "4bFA1_S2", "4bFA1_S1", "4bFA1_S0",

                  "4bFA2_A3", "4bFA2_A2", "4bFA2_A1", "4bFA2_A0", "4bFA2_B3", "4bFA2_B2", "4bFA2_B1", "4bFA2_B0","4bFA2_Cout", 
                  "4bFA2_C2", "4bFA2_C1", "4bFA2_C0", "4bFA2_Cin", "4bFA2_S3", "4bFA2_S2", "4bFA2_S1", "4bFA2_S0", 

                  "4bFA3_A3", "4bFA3_A2", "4bFA3_A1", "4bFA3_A0", "4bFA3_B3", "4bFA3_B2", "4bFA3_B1", "4bFA3_B0","4bFA3_Cout", 
                  "4bFA3_C2", "4bFA3_C1", "4bFA3_C0", "4bFA3_Cin", "4bFA3_S3", "4bFA3_S2", "4bFA3_S1", "4bFA3_S0", "Buffer1"],
        "gates": [
            {"type": "AND", "nodes": ["A0", "B0", "P0"]},
            {"type": "AND", "nodes": ["A1", "B0", "4bFA1_A0"]},
            {"type": "AND", "nodes": ["A2", "B0", "4bFA1_A1"]},
            {"type": "AND", "nodes": ["A3", "B0", "4bFA1_A2"]},
            {"type": "Buffer", "nodes": ["Buffer1", "4bFA1_A3"]},
            
            {"type": "AND", "nodes": ["A0", "B1", "4bFA1_B0"]},
            {"type": "AND", "nodes": ["A1", "B1", "4bFA1_B1"]},
            {"type": "AND", "nodes": ["A2", "B1", "4bFA1_B2"]},
            {"type": "AND", "nodes": ["A3", "B1", "4bFA1_B3"]},
            {"type": "4bFA", "nodes": ["4bFA1_A3", "4bFA1_A2", "4bFA1_A1", "4bFA1_A0", "4bFA1_B3", "4bFA1_B2", "4bFA1_B1", 
                                       "4bFA1_B0", "4bFA1_Cout", "4bFA1_C2", "4bFA1_C1", "4bFA1_C0", "Cin0", "4bFA1_S3", 
                                       "4bFA1_S2", "4bFA1_S1", "P1"]},

            {"type": "AND", "nodes": ["A0", "B2", "4bFA2_B0"]},
            {"type": "AND", "nodes": ["A1", "B2", "4bFA2_B1"]},
            {"type": "AND", "nodes": ["A2", "B2", "4bFA2_B2"]},
            {"type": "AND", "nodes": ["A3", "B2", "4bFA2_B3"]},
            {"type": "4bFA", "nodes": ["4bFA1_Cout", "4bFA1_S3", "4bFA1_S2", "4bFA1_S1", "4bFA2_B3", "4bFA2_B2", "4bFA2_B1", 
                                       "4bFA2_B0", "4bFA2_Cout", "4bFA2_C2", "4bFA2_C1", "4bFA2_C0", "Cin1", "4bFA2_S3", 
                                       "4bFA2_S2", "4bFA2_S1", "P2"]},

            {"type": "AND", "nodes": ["A0", "B3", "4bFA3_B0"]},
            {"type": "AND", "nodes": ["A1", "B3", "4bFA3_B1"]},
            {"type": "AND", "nodes": ["A2", "B3", "4bFA3_B2"]},
            {"type": "AND", "nodes": ["A3", "B3", "4bFA3_B3"]},
            {"type": "4bFA", "nodes": ["4bFA2_Cout", "4bFA2_S3", "4bFA2_S2", "4bFA2_S1", "4bFA3_B3", "4bFA3_B2", "4bFA3_B1", 
                                       "4bFA3_B0", "P7", "4bFA3_C2", "4bFA3_C1", "4bFA3_C0", "Cin2", "P6", 
                                       "P5", "P4", "P3"]}
        ]
    }
    
    h_total, J_total, node_index = generate_circuit_weights(circuit)



if __name__ == "__main__":
    main()
