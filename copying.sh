# Bash Program to Copy in Serial
#!/bin/bash

# Define source and destination paths
SOURCE_BASE_DIR="/vast/home/akhanna2/data/nexmd/ex_sp"
DEST_BASE_DIR="/usr/projects/ml4chem/akhanna2/data/ex_sp"

# Create the destination base directory if it doesn't exist
mkdir -p "$DEST_BASE_DIR"

# Loop through the desired frame range
for i in {1..30000}; do
    SOURCE_PATH="${SOURCE_BASE_DIR}/frame_${i}"
    
    # Check if the source directory exists before attempting to copy
    if [ -d "$SOURCE_PATH" ]; then
        echo "Copying directory ${SOURCE_PATH}..."
        cp -Rpv "$SOURCE_PATH" "$DEST_BASE_DIR/"
    else
        echo "Warning: Source directory ${SOURCE_PATH} not found. Skipping."
    fi
done

echo "Copy operation complete."


# Bash Program to Copy in Paralle
#!/bin/bash

# Define source and destination paths
SOURCE_BASE_DIR="/vast/home/akhanna2/data/nexmd/ex_sp"
DEST_BASE_DIR="/usr/projects/ml4chem/akhanna2/data/ex_sp"

# Create the destination base directory if it doesn't exist
mkdir -p "$DEST_BASE_DIR"

# Define the copy function
# This function will be executed in parallel by GNU Parallel
copy_frame() {
    local i=$1
    local source_path="${SOURCE_BASE_DIR}/frame_${i}"
    
    # Check if the source directory exists before attempting to copy
    if [ -d "$source_path" ]; then
        echo "Copying directory ${source_path}..."
        # -p: Preserves attributes | -R: Recursive | -v: Verbose output
        # -W: Copies whole files without checksum, potentially faster for local copies
        cp -Rpv "$source_path" "$DEST_BASE_DIR/"
    else
        echo "Warning: Source directory ${source_path} not found. Skipping."
    fi
}

# Export the function so 'parallel' can access it
export -f copy_frame
export SOURCE_BASE_DIR
export DEST_BASE_DIR

echo "Starting parallel copy..."

# Use 'parallel' to execute the copy_frame function for each frame number
# -j 20: Run up to 20 jobs in parallel. Adjust this number based on your system.
# ::: {1..30000}: The list of arguments to pass to the function (the frame numbers)
parallel -j 20 copy_frame ::: {1..30000}

echo "Parallel copy operation complete."
