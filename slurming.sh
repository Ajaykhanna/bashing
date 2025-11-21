# Get information about mixed GPU nodes in the shared-gpu partition
sinfo -p shared-gpu -t mixed -O "NodeList,CPUsState,AllocMem,Gres,GresUsed"

# Get general information about all nodes in the shared-gpu partition
sinfo -p shared-gpu -o "%50N %10C %20m %30G %10T"

# Get detailed information about a specific node (cn4071)
scontrol show node cn4071

# SRUN command to extract a tar.gz file using pigz for parallel decompression
srun --nodes=1 --ntasks=32 --mem=50G --time=10:00:00 bash -c "tar -I 'pigz -p32 -9' -xvf cis_s2_namd_frames.tar.gz"

# Find All Contents Within a Directory and Delete Them
find /path/to/directory -mindepth 1 -print0 | parallel -0 rm -rf {}
