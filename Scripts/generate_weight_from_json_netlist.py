import Scripts.CustomScripts as CS
import Scripts.generate_weight_from_logic as GWL
import json

def find_top_module(netlist):
    modules = netlist.get("modules", {})
    # Gather names of modules that are instantiated in other modules
    instantiated_modules = set()
    for module_data in modules.values():
        for cell in module_data.get("cells", {}).values():
            # The cell dict should have a 'module' key referring to the submodule name
            module_ref = cell.get("module")
            if module_ref:
                instantiated_modules.add(module_ref)
    
    # The top module(s) are those not instantiated in any other module
    top_modules = [name for name in modules if name not in instantiated_modules]
    
    if len(top_modules) != 1:
        raise Exception("Could not uniquely determine the top module. Found: " + ", ".join(top_modules))
    
    return top_modules[0]

def generate_weights(filename,SaveCircuit=False,CircuitName=None):
    # Load the Yosys-generated JSON netlist
    if not filename.endswith('.json'):
        filename += '.json'
    
    with open(filename, 'r') as f:
        netlist = json.load(f)

    # Automatically determine the top module
    top_module_name = find_top_module(netlist)
    print("Detected top module:", top_module_name)
    if top_module_name not in netlist.get('modules', {}):
        raise KeyError(f"Module {top_module_name} not found in the netlist.")

    module = netlist['modules'][top_module_name]

    # Build a mapping for port nodes where numbering restarts for each port.
    # For each port, we assign new names as f"{port_name}{index}" where index restarts at 0.
    port_node_mapping = {}
    for port_name, port in module.get("ports", {}).items():
        bits = port.get("bits", [])
        for idx, bit in enumerate(bits):
            new_node_name = f"{port_name}{idx}"  # numbering restarts for each port
            port_node_mapping[str(bit)] = new_node_name

    # print("Port node mapping:", port_node_mapping)

    # Prepare a circuit dictionary with a set for nodes and a list for gates.
    circuit = {"nodes": set(), "gates": []}

    # Define a mapping from Yosys cell names to the gate types you want.
    cell_mapping = {
        "$_AND_": "AND",
        "$_OR_": "OR",
        "$_NOT_": "NOT",
        "$_ANDNOT_": "ANDNOT",
        "$_ORNOT_": "ORNOT",
        "$_NAND_": "NAND",
        "$_NOR_": "NOR",
        "$_XOR_": "XOR",
        "$_XNOR_": "XNOR",
        # Add additional mappings if desired.
    }

    # Iterate over each cell in the top module.
    for cell_name, cell in module.get("cells", {}).items():
        yosys_type = cell["type"]
        gate_type = cell_mapping.get(yosys_type, yosys_type)
        
        gate_nodes = []
        for port, nets in cell.get("connections", {}).items():
            # In Yosys JSON, nets is usually a list (even for a single connection)
            if isinstance(nets, list):
                net = nets[0]
            else:
                net = nets
            net_str = str(net)
            # Use the new name from our port mapping if it exists, otherwise use the raw net.
            node_name = port_node_mapping.get(net_str, net_str)
            gate_nodes.append(node_name)
            circuit["nodes"].add(node_name)
        
        circuit["gates"].append({"type": gate_type, "nodes": gate_nodes})

    # Convert the nodes set to a sorted list for reproducibility.
    circuit["nodes"] = sorted(list(circuit["nodes"]))

    # # Write the resulting circuit dictionary to a JSON file.
    # with open('circuit.json', 'w') as outfile:
    #     json.dump(circuit, outfile, indent=4)

    # print("Circuit has been written to circuit.json")


    # with open("circuit.json", 'r') as infile:
    #     circuit = json.load(infile)
    # print(circuit)

    # Preprocess the circuit to ensure that XOR and XNOR gates have the expected number of nodes.
    for gate in circuit["gates"]:
        gate_type = gate["type"]
        # Set expected number of nodes based on gate type.
        if gate_type == "XOR":
            expected_nodes = 4  # 3 provided + 1 hidden
        elif gate_type == "XNOR":
            expected_nodes = 5  # 3 provided + 2 hidden
        else:
            continue  # Skip other gate types

        gate_index = circuit["gates"].index(gate)

        # Ensure XOR has a single hidden node appended
        if gate_type == "XOR" and len(gate["nodes"]) == 3:
            # Ensure XOR has a single hidden node appended if it doesn't already have one.
            if len(gate["nodes"]) == 3:
                hidden_node = f"hidden_XOR_{gate_index}_3"
                # Append the hidden node so that the gate becomes [A, B, C, H]
                gate["nodes"].append(hidden_node)
                # Instead of simply appending, insert the hidden node into the circuit's overall node list
                # immediately after the XOR output node.
                output_node = gate["nodes"][2]  # The output node (C)
                if output_node in circuit["nodes"]:
                    idx = circuit["nodes"].index(output_node)
                    # Insert the hidden node right after the output node, if it isn't already there.
                    if idx + 1 >= len(circuit["nodes"]) or circuit["nodes"][idx + 1] != hidden_node:
                        circuit["nodes"].insert(idx + 1, hidden_node)
                else:
                    circuit["nodes"].append(hidden_node)
        # Ensure XNOR has exactly 5 nodes and in correct order
        elif gate_type == "XNOR":
            if len(gate["nodes"]) == 3:  # Initial state: ['A', 'B', 'C']
                # Generate hidden nodes
                hidden_0 = f"hidden_XNOR_{gate_index}_H0"
                hidden_1 = f"hidden_XNOR_{gate_index}_H1"
                
                # Insert H0 at position 2 (before C)
                gate["nodes"].insert(2, hidden_0)
                # Append H1 at the end
                gate["nodes"].append(hidden_1)

                # Ensure the hidden nodes are registered in the circuit's node list
                for hidden_node in [hidden_0, hidden_1]:
                    if hidden_node not in circuit["nodes"]:
                        circuit["nodes"].append(hidden_node)

    h_total, J_total, nodes = GWL.generate_circuit_weights(circuit,SaveCircuit,CircuitName)
    return h_total, J_total, nodes