# Probabilistic Computing Scripts

This repository contains a collection of Python scripts located in the **Scripts** folder. These scripts are part of the Probabilistic Computing project and provide tools for simulating p-bit (probabilistic bit) circuits, analyzing simulation data, generating hardware initialization code, and visualizing probability distributions.

## Overview

- **comparison.py**  
  Loads CSV data from FPGA and Python Boltzmann simulations, merges them based on common labels, and generates plots comparing normalized probability distributions. It supports saving the plots automatically.

- **CustomScripts.py**  
  Contains utility functions for:
  - Converting between bipolar and binary representations.
  - Calculating fixed-point ranges.
  - Generating SystemVerilog initialization code (e.g., seed generation, parameter formatting).

- **generate_bar_plots.py**  
  Reads simulation output CSV files, processes the data according to a provided label mapping, and generates bar plots showing the probability distribution of output cases. It can also export the computed counts to CSV.

- **generate_weight_from_logic.py**  
  Scans a designated `Circuit_Library` folder for NPZ files containing circuit weight data, extracts bias vectors (`h`) and weight matrices (`J`), and constructs a weight library. It also includes a function to compute overall circuit weights from a logic circuit description.

- **simulate_p_circuit.py**  
  Implements functions to:
  - Compute binary energy for given states.
  - Generate Boltzmann distributions based on Ising-like energy models.
  - Simulate p-bit dynamics using both iterative updates and direct Boltzmann sampling.
  - Plot the resulting probability distributions from simulations.

---
## Usage

Each script is structured as a module with functions that can be imported into your projects or run as standalone scripts. For example:

### Example of Simulating a Probabilistic Circuit
#### Steps
- Load the desired `circuit.npz` from the Circuit_Library
- Define the input/output states with `push0` for 0 and `push1`for 1. One would need to know the input/output names before setting. Leave blank for no changes.
- Define the bits that wanna be looked at with `selected_bits`.
- Pass to the simulation script.
- Plots should then begin showing.
```python
import Scripts.simulate_p_circuit as simulate_p_circuit
import Scripts.CustomScripts as CS

J, h, node_order = CS.load_npz_data("8bIntFac_v4.npz", target_folder="Circuit_Library")

# Define your target_names dictionary
target_names = {
    "Floating State": {
    },
    "1x15": {
        "a0": "push1",
        "a1": "push0",
        "a2": "push0",
        "a3": "push0",
        "a4": "push0",
        "a5": "push0",
        "a6": "push0",
        "a7": "push0",
        "b0": "push1",
        "b1": "push1",
        "b2": "push1",
        "b3": "push1",
        "b4": "push0",
        "b5": "push0",
        "b6": "push0",
        "b7": "push0",
    },
}

# Get the updated configurations:
configured_h = CS.update_all_configurations(target_names, h, node_order)

selected_bits = {
    "Floating State": ["s7","s6","s5","s4","s3","s2","s1","s0"],  
    "1x15": ["s7","s6","s5","s4","s3","s2","s1","s0"],  
    # "15x15": ["P7","P6","P5","P4","P3","P2","P1","P0"], 
    # "Factor 14": [3, 2, 1, 0, 7, 6, 5, 4], 
}
simulate_p_circuit.plot_probabilities(num_steps=100000, savefig=True, save_csv=False,J_bipolar=J, node_order=node_order,
                                      h_bipolar_dict=configured_h, use_python=True, use_boltzmann=False, 
                                      filename="8bx8b=8b_Integer_Factorization", figWidth=68, selected_bits=selected_bits)
