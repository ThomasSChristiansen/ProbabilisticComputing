import os
import glob

def generate_yosys_scripts(src_dir, out_dir, script_dir):
    # Ensure the output and script directories exist
    os.makedirs(out_dir, exist_ok=True)
    os.makedirs(script_dir, exist_ok=True)

    # Get all Verilog files from the source directory
    verilog_files = glob.glob(os.path.join(src_dir, "*.v"))

    for verilog_file in verilog_files:
        # Extract a base name without extension
        base_name = os.path.basename(verilog_file)
        name_without_ext = os.path.splitext(base_name)[0]
        
        # Create a unique Yosys script file name for each Verilog file and place it in the script_dir
        script_filename = f"Synth_{name_without_ext}.ys"
        script_filepath = os.path.join(script_dir, script_filename)
        
        # Define the output file for the synthesized design
        out_file = os.path.join(out_dir, f"{name_without_ext}_synthesized.json")
        
        # Build the Yosys script content for this file
        script_content = f"""
# script.ys
read_verilog {verilog_file}
synth
abc -g AND,NAND,NOR,OR
write_json {out_file}
show -prefix {out_file}
        """
        
        # Write the script content to the script file
        with open(script_filepath, "w") as f:
            f.write(script_content.strip())
        
        print(f"Generated script: {script_filepath}")

def generate_yosys_script(src_dir, verilog_filename, out_dir, script_dir):
    # Construct the full path to the Verilog file using the specific filename
    verilog_file = os.path.join(src_dir, verilog_filename)
    
    # Ensure that the output and script directories exist
    os.makedirs(out_dir, exist_ok=True)
    os.makedirs(script_dir, exist_ok=True)
    
    # Extract the base name and remove the extension
    base_name = os.path.basename(verilog_file)
    name_without_ext = os.path.splitext(base_name)[0]
    
    # Create the Yosys script file name and full path
    script_filename = f"Synth_{name_without_ext}.ys"
    script_filepath = os.path.join(script_dir, script_filename)
    
    # Define the output file for the synthesized design
    out_file = os.path.join(out_dir, f"{name_without_ext}_synthesized.json")
    
    # Build the Yosys script content for this file
    script_content = f"""
# Yosys script for synthesizing {base_name}
read_verilog {verilog_file}
synth
abc -g AND,NAND,NOR,OR
write_json {out_file}
show -prefix {name_without_ext}
    """
    
    # Write the script content to the .ys file
    with open(script_filepath, "w") as f:
        f.write(script_content.strip())
    
    print(f"Generated script: {script_filepath}")
