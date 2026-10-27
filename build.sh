#!/bin/bash

# Install git
sudo apt-get install -y git

# Install deno and add it to PATH
curl -fsSL https://deno.land/install.sh > deno_install.sh

source deno_install.sh -y
source "$HOME/.deno/env"

# Remove deno install script
rm deno_install.sh

# Clone Revenge Next source
git clone https://github.com/revenge-mod/revenge-bundle-next.git

# Move to build folder
cd revenge-bundle-next

# Add plugins repo URL to env file
sed -i 's/REVENGE_DEFAULT_PLUGIN_REPOSITORY_URL=/REVENGE_DEFAULT_PLUGIN_REPOSITORY_URL=https:\/\/rvp.palmdevs.me\//' .env.example

# Build Revenge Next
deno install
deno run --env-file=.env.example build

# Move Revenge Next bundle
mv dist/revenge.bundle ..

# Clean up build folder
cd ..
rm -rf revenge-bundle-next
