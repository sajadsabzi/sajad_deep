#!/bin/bash
chmod +x run_notebook.sh
# Exit on error
set -e

# Check if notebook name was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <notebook_file.ipynb>"
    exit 1
fi

# Extract base name (without extension)
NOTEBOOK_PATH="$1"
BASENAME=$(basename "$NOTEBOOK_PATH" .ipynb)
SCRIPT_NAME="${BASENAME}.py"
LOG_NAME="${BASENAME}.log"

# Convert notebook to script
echo "Converting $NOTEBOOK_PATH to $SCRIPT_NAME..."
jupyter nbconvert --to script "$NOTEBOOK_PATH"

# Run the script with nohup in the background
echo "Running $SCRIPT_NAME in background..."
nohup python3 "$SCRIPT_NAME" >"$LOG_NAME" 2>&1 &

echo "Done. Output is being logged to $LOG_NAME"

tail -f $LOG_NAME