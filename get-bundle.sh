#!/bin/bash

# Install dependencies
sudo apt-get install -y unzip

# Get latest artifact info
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $1" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/revenge-mod/revenge-bundle-next/actions/artifacts?per_page=1 \
  > latest.json

# Extract download API link
awk -F'"' '/"archive_download_url":/ {print $(NF-1)}' \
  latest.json > latest.link

# Call download API
cat latest.link | \
  xargs curl \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $1" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -I > latest.headers

# Extract actual download link
awk 'BEGIN {IGNORECASE=1} /Location:/ {gsub("\r", ""); print $2}' \
  latest.headers > latest.download

# Download and unzip the artifact
cat latest.download | xargs curl > latest.zip
unzip -o latest.zip

# Clean up unnecessary files
rm latest.*