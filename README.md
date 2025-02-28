# Probabilistic Computing Project

This repository contains implementations and tools for probabilistic computing using p-bits. The setup instructions below will guide you through cloning the repository, setting up a virtual environment, and ensuring proper configuration for running the project.

---

## **1. Clone the Repository**
First, clone the repository to your local machine:

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

---

## **2. Create and Activate the Virtual Environment**
Ensure you have **Python 3.8+** installed, then create a virtual environment:

```bash
python -m venv .venv
```

### ** Windows**
```cmd
.venv\Scripts\activate
```


✅ **If you see `.venv` in your terminal prompt, your environment is activated!**

---

## **3. Run Setup Script for `PYTHONPATH`**
This script ensures your project directory is included in `PYTHONPATH` automatically.

### ** Windows**
```cmd
post-venv-setup.bat
```

---

## **4. Install Dependencies**
Run the following command to install all required Python packages:

```bash
pip install -r requirements.txt
```

If using **Poetry**, install dependencies with:

```bash
poetry install
```

---

## **5. Verify Setup**
Run these tests to confirm everything is working:

### **Check Python Path**
```bash
python -c "import sys; print(sys.path)"
```
You should see a path similar to:

```
'C:\Users\thoma\OneDrive - Aarhus Universitet\Probabilistic Computing\Python Codes'
```

### **Check if Dependencies are Installed**
```bash
python -c "import numpy; import pandas; import matplotlib; print('All packages installed!')"
```

If everything is correct, you’ll see:
```
All packages installed!
```

---

## **6. Running the Project**
To run your scripts or Jupyter Notebooks, first activate the virtual environment:

```bash
.venv\Scripts\activate  # Windows
source .venv/bin/activate  # macOS/Linux
```

Then execute:

```bash
python your_script.py
```

or open Jupyter Notebook:

```bash
jupyter notebook
```

---

## **7. Deactivating the Virtual Environment**
When you're done, deactivate the virtual environment:

```bash
deactivate
```

---

## **Troubleshooting**
### **PYTHONPATH Not Set?**
If `PYTHONPATH` is not set, manually run:
```bash
echo $PYTHONPATH  # macOS/Linux
echo %PYTHONPATH%  # Windows
```
If empty, re-run:
```bash
bash post-venv-setup.sh  # macOS/Linux
post-venv-setup.bat  # Windows
```

### **Issues with Dependencies?**
Ensure all dependencies are installed:
```bash
pip install -r requirements.txt
```
