#!/usr/bin/env bash

set -e

echo "🚀 Starting Doom Emacs full setup..."

# -----------------------------
# 1. Pacman packages
# -----------------------------
echo "📦 Installing core dependencies..."
sudo pacman -S --needed --noconfirm \
  ripgrep fd cmake nodejs npm \
  pandoc xclip maim scrot graphviz \
  python-pip shellcheck git unzip gcc

# -----------------------------
# 2. Python tools
# -----------------------------
echo "🐍 Installing Python tools..."
pip install --user --break-system-packages \
  isort pipenv pytest nose || true

# -----------------------------
# 3. Fix npm permissions (user-level install)
# -----------------------------
echo "📦 Configuring npm global directory..."

mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

# Add to zshrc if not already present
if ! grep -q 'npm-global' ~/.zshrc; then
  echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
fi

export PATH="$HOME/.npm-global/bin:$PATH"

# Optional: install marked (not required but nice)
npm install -g marked || true

# -----------------------------
# 4. Install Symbola font (AUR)
# -----------------------------
echo "🔤 Installing Symbola font (AUR)..."

if command -v yay &> /dev/null; then
  yay -S --noconfirm ttf-symbola
elif command -v pamac &> /dev/null; then
  pamac build --no-confirm ttf-symbola
else
  echo "⚠️ yay/pamac not found. Skipping Symbola font."
fi

# -----------------------------
# 5. Reload environment
# -----------------------------
echo "🔄 Reloading shell config..."
source ~/.zshrc || true

# -----------------------------
# 6. Doom sync
# -----------------------------
echo "🧠 Syncing Doom Emacs..."
~/.emacs.d/bin/doom sync

# -----------------------------
# 7. Final check
# -----------------------------
echo "🩺 Running Doom Doctor..."
~/.emacs.d/bin/doom doctor

echo "✅ Setup complete!"
