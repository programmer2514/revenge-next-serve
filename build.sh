#!/bin/bash

# Install git
sudo apt-get install -y git

# Install bun
curl -fsSL https://bun.com/install | bash

# Add bun to path
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Clone Revenge Next & Plugins source
git clone https://github.com/revenge-mod/revenge-bundle-next.git
git clone https://github.com/PalmDevs/revenge-next-plugins.git

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
bun install
bun run build

# Move Revenge Next bundle
mv dist/revenge.bundle ..

# Clean up build folder
cd ..
rm -rf revenge-bundle-next

