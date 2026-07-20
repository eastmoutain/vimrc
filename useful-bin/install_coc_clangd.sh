#!/bin/bash
set -e

echo "==> Installing coc-clangd..."

# Install dependencies
echo "==> Installing dependencies..."
sudo apt install -y clangd

# Add coc.nvim to .vimrc (if not already present)
if ! grep -q "coc.nvim" ~/.vimrc 2>/dev/null; then
  echo "==> Adding coc.nvim to .vimrc..."
  cat >> ~/.vimrc << 'EOF'

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
EOF
fi

# Install vim plugins
echo "==> Installing vim plugins..."
vim +PlugInstall +qa

# Install coc-clangd extension
echo "==> Installing coc-clangd..."
vim -c "CocInstall coc-clangd" -c "qa"

# Create coc settings
echo "==> Creating coc settings..."
mkdir -p ~/.config/coc
cat > ~/.config/coc/coc-settings.json << 'EOF'
{
  "clangd.arguments": [
    "--background-index",
    "-j=4"
  ]
}
EOF

echo "==> Done!"