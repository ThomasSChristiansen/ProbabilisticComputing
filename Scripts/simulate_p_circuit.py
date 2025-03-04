import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from itertools import product
import os

def compute_energy_binary(m, J, h, I0=1.0):
    """
    Compute the Ising-like energy for a binary state m in {0,1}^N
    using the binary parameters J and h.
    
    The energy is defined as:
        E(m) = -½ * m^T J m - h^T m
    and then scaled by the global factor I0.
    """
    interaction = -0.5 * m @ J.dot(m)
    bias = - h @ m 
    return I0 * (interaction + bias)

def boltzmann_distribution_binary(J, h, I0=1.0):
    """
    Enumerate all 2^N binary states, compute their energy,
    and return the normalized Boltzmann probabilities based on exp(-E).
    """
    N = len(h)
    all_states = (np.array(state) for state in product([0, 1], repeat=N))
    energies = np.array([compute_energy_binary(state, J, h, I0) for state in all_states])
    weights = np.exp(-energies)
    return weights / np.sum(weights)

def threshold(x, y):
    """Return 1 if x < y else 0."""
    return 1 if x < y else 0

def simulate_p_bits(num_steps=None, I0=None, use_boltzmann=None,J_bipolar=None,h_bipolar=None):
    """
    Simulate a P-circuit.

    J_bipolar/h_bipolar parameters are converted to the binary domain as follows:
        J_binary = 2 * J_bipolar
        h_binary = h_bipolar - J_bipolar · 1
    where "1" is a vector of ones (length 5).
    """
    # Convert to binary parameters
    J_binary = 2.0 * J_bipolar
    ones_vec = np.ones(len(h_bipolar))  # Now 5 p-bits instead of 3
    h_binary = h_bipolar - J_bipolar.dot(ones_vec)
    
    # Use the binary parameters for simulation
    J = J_binary.copy()
    h = h_binary.copy()

    # If using the Boltzmann method, sample directly from the distribution.
    if use_boltzmann:
        N = len(h_bipolar)
        all_states = (np.array(state) for state in product([0, 1], repeat=N))
        p = boltzmann_distribution_binary(J, h, I0)
        # Sample num_steps states according to the Boltzmann distribution.
        indices = np.random.choice(len(all_states), num_steps, p=p)
        return np.array([state for i, state in enumerate(all_states) if i in indices])
    
    # Initialize the p-bits randomly
    m = np.random.choice([0, 1], size=len(h_bipolar))
    
    # Record the history of states
    m_history = []
    for _ in range(num_steps):
        for i in range(len(h_bipolar)):  # Update each of the p-bits sequentially.
            # Compute the input to p-bit i.
            I_i = I0 * (h[i] + J[i].dot(m))

            # Determine the activation probability using a shifted and scaled tanh.
            activation_function = (np.tanh(I_i) + 1) / 2
            random_value = np.random.uniform(0, 1)
            m[i] = threshold(random_value, activation_function)
        m_history.append(m.copy())
    
    return np.array(m_history)

def plot_probabilities(num_steps=100000, savefig=False, save_csv=False, J_bipolar=None, h_bipolar_dict=None, node_order=None,
                       use_python=True, use_boltzmann=True, filename="Python_Sim_Results", figWidth=8, selected_bits=None,I0=1.0):
    """
    Plot probability distributions for different cases of h_bipolar values.
    This function iterates over multiple h_bipolar configurations and generates results for each.
    """
    if not h_bipolar_dict:
        print("Error: No h_bipolar values provided.")
        return
    
    # Convert node_order to a list if it's a numpy array.
    if isinstance(node_order, np.ndarray):
        node_order = node_order.tolist()
        
    if node_order is None:
        raise ValueError("node_order must be provided.")
    
    # If selected_bits is not provided, use all indices.
    if (selected_bits == "All"):
        print("No selected_bits provided - All will be chosen")
        selected_bits = {}
        for label, h_val in h_bipolar_dict.items():
            n_bits = len(h_val)
            # Use indices 0..n_bits-1
            selected_bits[label] = list(range(n_bits))
    
    # Convert selected_bits from node names to indices if necessary.
    for config, bits in selected_bits.items():
        # If the configuration is set to "All", replace it with a full list of indices.
        if bits == "All":
            n_bits = len(h_bipolar_dict[config])
            selected_bits[config] = list(range(n_bits))
        # Otherwise, if the bits are provided as node names, convert them.
        elif bits and isinstance(bits[0], str):
            try:
                selected_bits[config] = [node_order.index(n) for n in bits]
            except ValueError as e:
                raise ValueError(f"Error converting selected bits for configuration '{config}': {e}")

    
    all_results = []

    for label, h_bipolar in h_bipolar_dict.items():
        if label not in selected_bits:
            continue  # Skip configurations without a matching selected_bits entry.
        
        h_bipolar_processed = [
            15.875 if x == "push1" else (-16.0 if x == "push0" else float(x))
            for x in h_bipolar]
        
        bits_indices = selected_bits[label]
        print(f"Processing case: {label} (h_bipolar = {h_bipolar_processed}) with selected bits {bits_indices}")
        
        bit_range = len(bits_indices)
        all_states = np.array(list(product([0, 1], repeat=bit_range)))

        # Generate simulation results
        results = None
        if use_python:
            results = simulate_p_bits(num_steps=num_steps, I0=I0, use_boltzmann=False, J_bipolar=J_bipolar, h_bipolar=h_bipolar_processed)
        else: 
            results = np.array([])

        # Ensure results_boltzmann is always defined
        results_boltzmann = None
        if use_boltzmann:
            results_boltzmann = simulate_p_bits(num_steps=num_steps, I0=I0, use_boltzmann=True, J_bipolar=J_bipolar, h_bipolar=h_bipolar_processed)
        else:
            results_boltzmann = np.array([])
        np.set_printoptions(threshold=np.inf, linewidth=200)

        # Convert negative indices to positive indices without reordering.
        n_bits = len(h_bipolar_processed)
        positive_indices = [i if i >= 0 else n_bits + i for i in bits_indices]
        bit_range = len(positive_indices)
        all_states = np.array(list(product([0, 1], repeat=bit_range)))

        # Compute probabilities from simulation
        state_probabilities = {tuple(state): 0 for state in all_states}
        if use_python:
            unique_states, counts = np.unique(results[:,positive_indices], axis=0, return_counts=True)
            probabilities = counts / np.sum(counts)
            for state, prob in zip(unique_states, probabilities):
                state_probabilities[tuple(state)] = prob

        # Compute Boltzmann probabilities if used
        state_probabilities_b = {tuple(state): 0 for state in all_states}
        if use_boltzmann:
            unique_states_b, counts_b = np.unique(results_boltzmann[:,positive_indices], axis=0, return_counts=True)
            probabilities_b = counts_b / np.sum(counts_b)
            for state, prob in zip(unique_states_b, probabilities_b):
                state_probabilities_b[tuple(state)] = prob

        # Prepare data for plotting
        states_str = [''.join(map(str, state)) for state in all_states]
        prob_values = [state_probabilities[tuple(state)] for state in all_states]
        prob_values_b = [state_probabilities_b[tuple(state)] for state in all_states] if use_boltzmann else []

        x = np.arange(len(states_str))
        bar_width = 0.8  # Adjust bar width dynamically
        max_prob = max(prob_values) - max(prob_values)/2
        highest_prob_indices = [i for i, prob in enumerate(prob_values) if prob > max_prob]

        # Create bar plot
        plt.figure(figsize=(figWidth, 5))

        if use_python and use_boltzmann:
            bar_width = 0.8/2
            plt.bar(x - bar_width/2, prob_values, bar_width, color='skyblue', label='Python Simulation', edgecolor='black')
            plt.bar(x + bar_width/2, prob_values_b, bar_width, color='orange', label='Boltzmann', edgecolor='black')
        elif use_python:
            plt.bar(x, prob_values, bar_width, color='skyblue', label='Python Simulation', edgecolor='black')
        elif use_boltzmann:
            plt.bar(x, prob_values_b, bar_width, color='orange', alpha=0.6, label='Boltzmann', edgecolor='black')

        colors = ['red' if i in highest_prob_indices else 'black' for i in range(len(states_str))]
        plt.xticks(x, states_str, rotation=90)

        # Set x-axis labels' color
        ax = plt.gca()
        for tick, color in zip(ax.get_xticklabels(), colors):
            tick.set_color(color)
        plt.margins(x=0.01)
        plt.title(f"{label}")
        plt.xlabel('States')
        plt.ylabel('Probability')
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.legend()
        plt.tight_layout()

        if savefig:
            os.makedirs("Plots", exist_ok=True)
            plot_filename = f"Plots/{filename}_{label.replace(' ', '_')}.png"
            plt.savefig(plot_filename, dpi=300)
            print(f"Saved plot: {plot_filename}")

        plt.show()
        plt.close()

        # Optionally, save the results to a CSV file
        for i, state_str in enumerate(states_str):
            entry = {'label': label, 'case': state_str, 'normalized_counts_Python': prob_values[i]}
            if use_boltzmann:
                entry['normalized_counts_Boltzmann'] = prob_values_b[i]
            all_results.append(entry)

    if save_csv:
        results_df = pd.DataFrame(all_results)
        csv_filename = f"{filename}_counts.csv"
        results_df.to_csv(csv_filename, index=False)
        print(f"All results saved to '{csv_filename}'")