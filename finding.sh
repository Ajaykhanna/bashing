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

# Finding With Parallel Execution
find frame_{1..87531} -type f \( -name "*.out" -o -name "coords.xyz" \) -print0 | \
parallel -0 -j 10 '
  dir=$(dirname "{}")
  echo "Removing files from: $dir"
  rm -f "{}"
'

# Finding Specific Files, Echoing Their Names, and Deleting Them
find . -type f -name "*.chk" -exec sh -c 'echo "Deleting: {}"; rm "{}"' \;

# Finding Multiple Specific File Types, Echoing Their Names, and Deleting Them
find . -type f \( -name "*.chk" -o -name "*.qlog" -o -name "*.err" -o -name "*.fchk" -o -name "*.mwfn" -o -name "*.cub" \) -exec sh -c 'echo "Deleting: {}"; rm "{}"' \;

# Finding Files in a Range of Directories
find frame_{30001..87531}/gs_nm -type f \( -name "*.out" -o -name "coords.xyz" \) -print
