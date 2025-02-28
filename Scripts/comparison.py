import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os

def comparison(file_path_FPGA, file_path_Python_Boltzmann, savefig=False, filename="Comparison"):
    # Load data
    data_FPGA = pd.read_csv(file_path_FPGA, low_memory=False, dtype={'case': str})
    data_Python_Boltzmann = pd.read_csv(file_path_Python_Boltzmann, low_memory=False, dtype={'case': str})

    # Strip whitespace from column names
    data_FPGA.columns = data_FPGA.columns.str.strip()
    data_Python_Boltzmann.columns = data_Python_Boltzmann.columns.str.strip()

    # Merge based on both 'label' and 'case' columns
    merged_df = pd.merge(data_FPGA, data_Python_Boltzmann, on=['label', 'case'])

    # Get unique labels
    unique_labels = merged_df["label"].unique()

    # Check if Boltzmann data is present
    boltzmann_present = 'normalized_counts_Boltzmann' in merged_df.columns

    # Determine the number of datasets
    num_datasets = 2 + int(boltzmann_present)  # FPGA, Python, and optionally Boltzmann
    width = 1 / num_datasets  # Adjust width dynamically
    offsets = np.linspace(-width * (num_datasets - 1) / 2, width * (num_datasets - 1) / 2, num_datasets)


    # Iterate through each label and create a separate plot
    for label in unique_labels:
        # Filter data for the current label
        subset = merged_df[merged_df["label"] == label].sort_values(by="case")

        # Extract values
        cases = subset["case"]
        data_fpga = subset["normalized_count_FPGA"]
        data_python = subset["normalized_counts_Python"]

        # Define x locations
        spacing_factor = 0.5
        x = np.arange(len(cases)) * (1 + spacing_factor)

        # Create a new figure for each label
        plt.figure(figsize=(8, 4))

        # Plot bars using evenly spaced offsets
        plt.bar(x + offsets[0], data_fpga, width, label="Behavioural Sim", color="orange", edgecolor='black')
        plt.bar(x + offsets[1], data_python, width, label="Python Sim", color="skyblue", edgecolor='black')

        # If Boltzmann data is present, plot it
        if boltzmann_present:
            data_boltzmann = subset["normalized_counts_Boltzmann"]
            plt.bar(x + offsets[2], data_boltzmann, width, label="Boltzmann", color="black", alpha=0.6, edgecolor='black')

        # Formatting
        plt.title(f"{label}")
        plt.xlabel("Cases")
        plt.ylabel("Probability")
        plt.xticks(x, cases, rotation=90)
        plt.legend()
        plt.grid(axis='y', linestyle='--', alpha=0.7)

        # Show plot for the current label before moving to the next one
        plt.tight_layout()
        if savefig:
            os.makedirs("Plots", exist_ok=True)
            plot_filename = f"Plots/{filename}_{label.replace(' ', '_')}.png"
            plt.savefig(plot_filename, dpi=300)
            print(f"Saved plot: {plot_filename}")
        plt.show()
