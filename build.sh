#!/bin/bash

# Install git
sudo apt-get install -y git

# Install deno and add it to PATH
curl -fsSL https://deno.land/install.sh > deno_install.sh

source deno_install.sh -y
source "$HOME/.deno/env"

# Remove deno install script
rm deno_install.sh

# Clone Revenge Next & Plugins source
git clone https://github.com/revenge-mod/revenge-bundle-next.git
git clone https://github.com/PalmDevs/revenge-next-plugins.git

# Apply my patch to fix plugin dependency mismatches with latest Revenge Next build
# NOTE: This will probably break frequently
cd revenge-next-plugins
git apply ../fix-plugins.patch
cd ..

# Move plugins to the appropriate folder
for PLUGIN_DIR in revenge-next-plugins/plugins/* ; do
  PLUGIN_ROOT=$(find "$PLUGIN_DIR" -name "index.*")
  STAGE=$(
    grep -Po "^\s*(async\s*)?(preInit|init|start)\(.*\)\s*\{\s*$" "$PLUGIN_ROOT" |\
    grep -Po "^\s*(async\s*)?(preInit|init|start)\(" |\
    grep -Po "(preInit|init|start)"
  )
  DEST_DIR="revenge-bundle-next/src/plugins/$STAGE"

  mkdir -p "$DEST_DIR"
  mv "$PLUGIN_DIR" "$DEST_DIR"
done

# Remove old plugins folder
rm -rf revenge-next-plugins

# Move to build folder
cd revenge-bundle-next

# Build Revenge Next
deno install
deno run --env-file=.env.example build

# Move Revenge Next bundle
mv dist/revenge.bundle ..

# Clean up build folder
cd ..
rm -rf revenge-bundle-next
