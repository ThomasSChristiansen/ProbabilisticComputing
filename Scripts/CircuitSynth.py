import os
import subprocess
import sys
from Scripts.generate_yosys_scripts import generate_yosys_script
from Scripts.generate_weight_from_json_netlist import generate_weights_from_json_netlist
import Scripts.CustomScripts as CS

def CircuitSynth(verilog_filename, CircuitName,PathToStart_Bat="C:/Users/thoma/Desktop/oss-cad-suite/oss-cad-suite/start.bat"):
    # Determine the project root relative to this file
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    yosys_dir = os.path.join(project_root, "Yosys")
    
    # Build absolute paths for Yosys subdirectories
    sources_dir      = os.path.join(yosys_dir, "Sources")
    synthesized_dir  = os.path.join(yosys_dir, "Synthesized")
    scripts_dir      = os.path.join(yosys_dir, "scripts")
    
    # Construct the full path to the Verilog file and check if it exists.
    verilog_filepath = os.path.join(sources_dir, verilog_filename)
    if not os.path.isfile(verilog_filepath):
        print(f"Error: The Verilog file '{verilog_filepath}' does not exist.")
        sys.exit(1)

    # Generate the Yosys script file
    generate_yosys_script(sources_dir, verilog_filename, synthesized_dir, scripts_dir)

    # Extract name without extension to match the generated script filename
    name_without_ext = os.path.splitext(verilog_filename)[0]

    # Run the batch file, ensuring the working directory is set to yosys_dir
    result = subprocess.run(
        [PathToStart_Bat],
        cwd=yosys_dir,
        input=f"yosys -s scripts/Synth_{name_without_ext}.ys\n",
        text=True,
        capture_output=True
    )
    print(result.stdout)

    # Generate weights from JSON netlist and create memory files
    h_total, J_total, _ = generate_weights_from_json_netlist(
        os.path.join(synthesized_dir, f"{name_without_ext}_synthesized.json"),
        SaveCircuit=True,
        CircuitName=CircuitName
    )
    CS.generate_mem_files(J_total, h_total, CircuitName)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python CircuitSynth.py <verilog_filename> [CircuitName]")
        sys.exit(1)
    verilog_filename = sys.argv[1]
    
    # Determine the project root relative to this file (as in CircuitSynth)
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    yosys_dir = os.path.join(project_root, "Yosys")
    sources_dir = os.path.join(yosys_dir, "Sources")
    
    # Construct the full path to the verilog file in Yosys/Sources
    verilog_filepath = os.path.join(sources_dir, verilog_filename)
    if not os.path.isfile(verilog_filepath):
        print(f"Error: The verilog file '{verilog_filepath}' does not exist.")
        sys.exit(1)
    
    circuit_name = sys.argv[2] if len(sys.argv) > 2 else os.path.splitext(verilog_filename)[0]
    CircuitSynth(verilog_filename, circuit_name)