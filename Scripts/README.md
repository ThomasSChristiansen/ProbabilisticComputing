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

## Requirements

- Python 3.x
- [NumPy](https://numpy.org/)
- [Pandas](https://pandas.pydata.org/)
- [Matplotlib](https://matplotlib.org/)
- [NetworkX](https://networkx.github.io/) (used in CustomScripts.py)
- Standard Python libraries (e.g., `os`, `random`, `itertools`)

## Usage

Each script is structured as a module with functions that can be imported into your projects or run as standalone scripts. For example:

### Example (Python Shell)
```python
from comparison import comparison
comparison("data_FPGA.csv", "data_Python_Boltzmann.csv", savefig=True)

from simulate_p_circuit import simulate_p_bits, plot_probabilities
# Ensure that J_example and h_example are defined according to your simulation setup.
results = simulate_p_bits(num_steps=100000, I0=1.0, use_boltzmann=False, J_bipolar=J_example, h_bipolar=h_example)
plot_probabilities(num_steps=100000, J_bipolar=J_example, h_bipolar_dict={"Example": h_example}, node_order=["n0", "n1", "n2"])
