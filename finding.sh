# Find Files To Delete in a Range of Directories
# While Echoing Directory Names
find frame_{30001..87531}/gs_nm \
  -type f \( -name "*.out" -o -name "coords.xyz" \) \
  -exec sh -c '
    dir=$(dirname "$1")
    echo "Removing files from: $dir"
    rm -f "$1"
  ' sh {} \;

# Check if files are available
find frame_{30001..87531}/gs_nm -type f -name "*.out" -o -name "coords.xyz" -print
