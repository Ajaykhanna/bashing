# 1. Continous Tail
tail -f /path/to/logfile.log # Defaults last 5 output Lines


# 2. Continue Tail to backup file
tail -f /path/to/logfile.log | tee backup.log

# 3. Fast Polling: Continously Read and Buffer
#!/bin/bash
LOGFILE="/path/to/logfile.log"
BUFFER="/tmp/logbuffer.txt"

while true; do
    if [ -s "$LOGFILE" ]; then
        cat "$LOGFILE" >> "$BUFFER"
        echo "=== Captured at $(date) ===" >> "$BUFFER"
    fi
    sleep 0.1  # Adjust interval as needed
done

# 4. inotify: Instant Detection and Tailing
#!/bin/bash
LOGFILE="/path/to/logfile.log"

inotifywait -m -e modify,open "$LOGFILE" |
while read path action file; do
    if [ -s "$LOGFILE" ]; then
        echo "=== Last content before purge ==="
        cat "$LOGFILE"
        echo "================================"
    fi
done

# 5. stdbuf for Unbuffered Output
stdbuf -oL tail -f /path/to/logfile.log | while IFS= read -r line; do
    echo "$line" | tee -a permanent_backup.log
done

# 6. Watch with Very Short Interval
watch -n 0.1 'tail -n 50 /path/to/logfile.log | tee -a backup.log'

# 7. Continous Tail with Custom Lines
tail -n 25 -f /path/to/logfile.log

# 8. Tail with Custom Interval
tail -f /path/to/logfile.log --step-internal 1  