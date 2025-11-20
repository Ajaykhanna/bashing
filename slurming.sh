# Get information about mixed GPU nodes in the shared-gpu partition
sinfo -p shared-gpu -t mixed -O "NodeList,CPUsState,AllocMem,Gres,GresUsed"

# Get general information about all nodes in the shared-gpu partition
sinfo -p shared-gpu -o "%50N %10C %20m %30G %10T"

# Get detailed information about a specific node (cn4071)
scontrol show node cn4071
