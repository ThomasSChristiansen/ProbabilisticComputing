# OSS CAD Suite - Yosys Script Generation and Execution

This repository contains a Python script that generates individual Yosys script files for each Verilog file in a designated source folder. It also explains how to run Yosys with these generated scripts and how to use the provided batch file for setting up your environment.

## Directory Structure

```
.
├── Sources/              # Folder containing Verilog source files (.v)
├── Synthesized/          # Folder where synthesized outputs will be placed
├── scripts/              # Folder where generated Yosys script files will be stored
└── USAGE.md              # This usage guide
```

## Requirements

- **OSS-CAD-SUITE:** The path to start.bat is needed

## Generate the .mem and . coe files for memory
The Python script `CircuitSynth.py` goes through all the steps for generating the necessary files for the Vivado project. \
It does the following steps:
- Synthesis via. Yosys and OSS CAD Suite.
- Imports the netlist
- Convert to weight matrix using library of probabilistic circuit.
- Save to .npz 
- Save to .mem/coe
- Generate the CSR matrix
- Save to .mem/coe

Use like the following example:
```python
from Scripts.CircuitSynth import CircuitSynth
CircuitSynth("Multiplier_8x8=16.v","8x8=16bIntFac",write_coe=True)
```


## Generating Yosys Scripts (OUTDATED)

The Python script `generate_yosys_scripts.py` scans the `Sources` folder for Verilog files and creates a corresponding Yosys script file for each one in the `scripts` folder.

To generate the scripts run:

```python
from Scripts.generate_yosys_scripts import generate_yosys_scripts
# Define your directories and top module (adjust as needed)
generate_yosys_scripts("Sources", "Synthesized", "scripts")
```

For each Verilog file, a `.ys`-script will be generated that:
- Loads the Verilog file using `read_verilog`
- Performs synthesis with the `synth` command
- Performs the `abc -g AND,OR,NOR,NAND` optimization
- Writes the synthesized output using `write_verilog` to the `Synthesized` folder

## Running Yosys with a Generated Script

To run Yosys using one of the generated script files:
- `cd` to the `Yosys` directory in terminal
- Execute `C:/PATH/TO/oss-cad-suite/start.bat`
- Run the wanted synthesis script with `yosys -s scripts\Synth_{circuit}.ys` (Ex. `yosys -s scripts\Synth_XOR.ys`)

This command will:
- Load the specified Verilog file
- Synthesize the design
- Output the synthesized Verilog to the designated file in the `Synthesized` folder

**Note:** Do not prepend the word `script` on the command line. The correct format is:
```bash
yosys -s <script_file>
```
and **not**
```bash
yosys script <script_file>
```
