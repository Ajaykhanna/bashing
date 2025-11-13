# Parallel Taring
ARCHIVE_NAME="run2_nexmd_100K_RPA.tar.zst"
SOURCE_ITEMS="calude_extracted_frames/ ./loop_batch* ./*.py ./*.out input.ceon ./*.txt"
tar -cv --use-compress-program="zstd -22 --ultra -T0" -f "$ARCHIVE_NAME" $SOURCE_ITEMS
# Breakdown of the command:
# -c: Create a new archive.
# -v: Verbose mode, which shows the files being archived.
# -f: Specify the filename of the archive.
# $ARCHIVE_NAME: The name of the output file. Using the .tar.zst extension is a common convention.
# $SOURCE_ITEMS: The directories and files to be archived.

# Untaring with Parallel Decompression
pzstd -dc -T0 "$ARCHIVE_NAME" | tar -xf -
# Breakdown of the command:
# - pzstd: This is the parallel zstd (de)compressor utility. It is often installed alongside the main zstd program.
# -d: Tells pzstd to decompress.
# -c: Tells pzstd to write the output to standard output (stdout), so it can be piped to tar.
# -T0: Instructs pzstd to use all available threads for decompression, maximizing parallelism.
# "$ARCHIVE_NAME": The name of your compressed archive file.
# |: The pipe character, which sends the stdout of pzstd to the stdin of tar.
# tar: The archiving utility.
# -x: Tells tar to extract files from the archive.
# -f -: Tells tar to read the archive from standard input (stdin) instead of a file. 

# Option 1: Use pigz for parallel compression
tar -I 'pigz -p 4 -9' -cf archive.tar.gz /path/to/directory
# Breakdown of the command:
# tar: The main command, which archives multiple directories and files into a single .tar file
# -I 'pigz -p 4 -9': Use pigz (a parallel implementation of gzip) with 4 threads and maximum compression level (-9).
# -c: Create a new archive.
# -f: Specify the filename of the archive.
# archive.tar.gz: The name of the output file. Using the .tar.gz extension is a common convention.
# /path/to/directory: The directory you want to compress. All subdirectories and files will be included.

# Option 2: Use pbzip2 for parallel bzip2 compression
tar -I pbzip2 -cf archive.tar.bz2 /path/to/directory
# Breakdown of the command:
# tar: The main command, which archives multiple directories and files into a single .tar file.
# -I pbzip2: Use pbzip2 for parallel bzip2 compression.
# -c: Create a new archive.
# -f: Specify the filename of the archive.
# archive.tar.bz2: The name of the output file. Using the .tar.bz2 extension is a common convention.
# /path/to/directory: The directory you want to compress. All subdirectories and files will be included. 

# Option 3: Use xz for maximum compression
tar -cf ./ex_sp_root_4.tar.xz ./ex_sp --use-compress-program='xz -T8'
# Breakdown of the command:
# tar: The main command, which archives multiple directories and files into a single .tar file.
# -c: Create a new archive.
# -f: Specify the filename of the archive.
# ./ex_sp_root_4.tar.xz: The name of the output file. Using the .tar.xz extension is a common convention.
# ./ex_sp: The directory you want to compress. All subdirectories and files will be included.
# --use-compress-program='xz -T8': Use xz with 8 threads for maximum compression.

# Standard Taring with Different Compression Methods
# Option 1: Use xz for maximum compression
tar -cJvf archive.tar.xz /path/to/directory
# Breakdown of the command:
# tar: The main command, which archives multiple directories and files into a single .tar file.
# -c: Create a new archive.
# -J: Compress the archive using xz.
# -v: Verbose mode, which shows the progress of files being added.
# -f: Specify the filename of the archive.
# archive.tar.xz: The name of the output file. Using the .tar.xz extension is a common convention.
# /path/to/directory: The directory you want to compress. All subdirectories and files will be included. 

# To set a higher compression level for xz
XZ_OPT='-9' tar -cJf archive.tar.xz /path/to/directory

# Option 2: Use zstd for the best balance of speed and compression
tar --zstd -cvf archive.tar.zst /path/to/directory


# Option 3: Use bzip2 for high, but slower, compression 
bzip2 provides a better compression ratio than gzip but is slower. While a good option, xz and zstd are often superior. 
tar -cjvf archive.tar.bz2 /path/to/directory


