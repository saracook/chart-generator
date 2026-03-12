#!/bin/bash
set -e

echo "Carina Charts Generator"
echo "======================="
echo ""

# Load Anaconda
module load anaconda3
eval "$(conda shell.bash hook)"

# Create/activate environment
conda env list | grep -q "^charts " || conda create -n charts python=3.9 -y
conda activate charts

# Only install if imports fail
if ! python -c "import matplotlib, numpy, pandas" 2>/dev/null; then
    echo "→ Installing dependencies..."
    pip install -r requirements.txt
    echo "✓ Dependencies installed"
else
    echo "✓ All dependencies present"
fi

# Generate charts
echo ""
echo "Generating charts..."
python main.py

echo "✓ Done! Check output/ directory"
