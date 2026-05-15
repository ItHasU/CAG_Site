#!/bin/bash
# Usage: ./upload.sh [--prod]

# Load environment variables
. .env

# Read files to ignore
EXCLUDE_OPTS=()
# Convert .gitignore patterns to rsync excludes
while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    # Strip leading **/ (git recursive pattern -> rsync matches by name at any depth)
    pattern="${line#\*\*/}"
    EXCLUDE_OPTS+=(--exclude="$pattern")
done < .gitignore

# Determine target destination based on arguments
if [ "$1" = "--prod" ]; then
    # Production deployment: Target root directory /
    DEST="/"
else
    # Preview deployment (default): Target /preview subdirectory
    DEST="/preview"
fi

echo "Starting deployment to $DEST..."

if [ "$1" = "--prod" ]; then
    # Check for uncommitted changes before production deployment.
    if ! git diff --quiet HEAD; then
        echo "Error: Uncommitted changes detected! Please commit or stash your work before running production deployment (--prod)."
        exit 1
    else
        # Working directory is clean. Tag the current successful state with a timestamp for rollback safety.
        TAG=$(date +%Y-%m-%d_%H-%M-%S)
        echo "No uncommitted changes detected. Creating Git tag $TAG for deployment backup."
        git tag -a "$TAG" -m "Deployment backup $TAG" || { echo "Warning: Could not create required tag $TAG."; } # Warn but don't fail the script on tagging failure.
    fi
fi

# Execute rsync: Use --delete flag for both preview and production uploads.
rsync -avz --delete "${EXCLUDE_OPTS[@]}" www/ "${USER}@${HOST}:${FOLDER}${DEST}"