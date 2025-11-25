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


# Find All Contents Within a Directory and Delete Them
# This command recursively finds every file and subdirectory inside a specific folder and deletes them in parallel using multiple CPU cores. It effectively empties the directory without deleting the directory itself.
find /path/to/directory -mindepth 1 -print0 | parallel -0 rm -rf {}

# Here is the breakdown of each part:
# 1. find /path/to/directory
# Starts the search inside the specified directory.
# 2. -mindepth 1
# Crucial Safety Feature: This tells find to ignore the top-level directory itself (depth 0).
# Without this, the command would attempt to delete /path/to/directory as well. With this flag, it only matches the contents inside.
# 3. -print0
# Prints the full name of each found file or directory followed by a null character (instead of a newline).
# Why? This handles filenames with spaces, newlines, or special characters correctly so the next command doesn't misinterpret them.
# 4. | (Pipe)
# Passes the list of found items from find to the next command (parallel).
# 5. parallel -0
# GNU Parallel: A tool that executes jobs in parallel using one or more computers.
# -0: Tells parallel to use the null character as the delimiter (matching the -print0 from find).
# 6. rm -rf {}
# rm: The remove command.
# -r (recursive): Deletes directories and their contents.
# -f (force): Deletes without asking for confirmation.
# {}: A placeholder that parallel
# ` replaces with the filename it received from the pipe.
# 
# Summary
# This is a high-performance delete command. It is significantly faster than a standard rm -rf /path/to/directory/* when dealing with millions of files because it utilizes multiple # processor cores to perform the deletion operations simultaneously.