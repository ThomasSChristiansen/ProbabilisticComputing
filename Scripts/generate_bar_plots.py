import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os

def generate_bar_plots(file_path, label_mapping, savefig=False, save_csv=False, figWidth=8, selected_bits=None):
    # Extract the base file name (without extension) for naming outputs
    base_name = os.path.splitext(os.path.basename(file_path))[0]

    # Load the data
    data = pd.read_csv(file_path, low_memory=False)
    data.columns = data.columns.str.strip()  # Remove whitespace from column names
    
    # Automatically detect the number of h variables
    h_columns = [col for col in data.columns if col.startswith('h')]

    # Ensure h columns are floats
    for col in h_columns:
        data[col] = pd.to_numeric(data[col], errors='coerce').fillna(0).astype(float)

    # Convert h_columns into a single tuple-representing column
    data['_h_tuple'] = list(zip(*[data[col] for col in h_columns]))  

    # Use pd.unique() for fast retrieval of unique labels
    unique_h_values = set(pd.unique(data['_h_tuple']))

    # Check if all label mappings exist in the dataset
    missing_labels = set(label_mapping.keys()) - unique_h_values
    if missing_labels:
        raise ValueError(f"Error: The following labels in 'label_mapping' are NOT present in the dataset:\n{missing_labels}")

    # Dynamically determine bit length from the number of unique outputs
    unique_outputs = data['output'].dropna().astype(str).apply(lambda x: x.strip()).unique()
    max_output_value = max(int(x, 2) for x in unique_outputs if x.isdigit())
    bit_length = max_output_value.bit_length()

    # Apply the label mapping to create a descriptive label column
    data['label'] = data['_h_tuple'].map(label_mapping)

    # Apply the corrected function for dynamic bit-length output conversion
    data['output_cleaned'] = data['output'].astype(str).str.zfill(bit_length)
    
    # Apply bit selection based on label
    def filter_bits(row):
        # If no selected_bits provided, return the full output
        if selected_bits is None:
            return row['output_cleaned']
        # Otherwise, perform bit selection based on the provided indices
        label = row['label']
        if label in selected_bits:
            bit_indices = selected_bits[label]
            return ''.join([row['output_cleaned'][i] for i in bit_indices])
        return row['output_cleaned']  # Default to full output if label not in selected_bits
    
    data['filtered_output'] = data.apply(filter_bits, axis=1)
    
    # Compute value counts based on filtered output
    counts = data.value_counts(subset=['label', 'filtered_output']).unstack(fill_value=0)
    
    # Define all possible cases dynamically
    # possible_cases = [f"{i:0{bit_length}b}" for i in range(2**bit_length)]
    all_results = []  # To store the results for all labels

    # Plot each unique label
    for label, row in counts.iterrows():
        possible_cases = sorted(row.index)

        # Align counts with all possible cases, filling missing ones with 0
        aligned_counts = [row.get(case, 0) for case in possible_cases]

        # Normalize counts to probability distribution
        total = sum(aligned_counts)
        normalized_counts = [c / total if total > 0 else 0 for c in aligned_counts]
        
        # Append results to the list
        all_results.append({
            'label': label,
            'possible_cases': possible_cases,
            'normalized_counts': normalized_counts
        })
        
        # Plot the distribution
        plt.figure(figsize=(figWidth, 5))
        plt.bar(possible_cases, normalized_counts, tick_label=possible_cases, edgecolor='black')
        plt.title(f"{label}: Bar Plot of Output Cases")
        plt.ylabel("Probability")
        plt.margins(x=0.01)
        plt.xticks(rotation=90)
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()

        # Save figure to /Plots
        if savefig:
            os.makedirs("Plots", exist_ok=True)
            file_name = f"{base_name}_{label.replace(' ', '_').replace('=', '_')}.png"
            plt.savefig(os.path.join("Plots", file_name), dpi=300)
        plt.show()

    # Save all results to CSV
    if save_csv:
        csv_filename = f"{base_name}_behav_counts.csv"
        results_df = pd.DataFrame([
            {
                'label': result['label'],
                'case': case,
                'normalized_count_FPGA': normalized_count
            }
            for result in all_results
            for case, normalized_count in zip(result['possible_cases'], result['normalized_counts'])
        ])
        results_df.to_csv(csv_filename, index=False)
        print(f"Labeled results saved to '{csv_filename}'")