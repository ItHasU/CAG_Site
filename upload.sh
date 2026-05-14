#!/bin/bash
# Usage: ./upload.sh [--dry-run]

# Read upload options
. .env
DEST="$USER@$HOST:$FOLDER"

# Read files to ignore
EXCLUDE_OPTS=()
# Convert .gitignore patterns to rsync excludes
while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    # Strip leading **/ (git recursive pattern -> rsync matches by name at any depth)
    pattern="${line#\*\*/}"
    EXCLUDE_OPTS+=(--exclude="$pattern")
done < .gitignore

# Check for force run
DRY="--dry-run -v"
if [ "$1" = "--force" ]; then
    # Clear dry options to force execution
    DRY=""
else
    # Won't run the sync
    echo "DRY RUN. Use --force to perform the real upload"
fi

rsync -avz --delete $DRY "${EXCLUDE_OPTS[@]}" www/ "$DEST"