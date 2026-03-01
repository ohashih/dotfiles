#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installer ==="
echo "DOTFILES_DIR: $DOTFILES_DIR"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if Homebrew is installed
check_homebrew() {
  if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    info "Homebrew is already installed"
  fi
}

# Install packages from Brewfile
install_brew_packages() {
  info "Installing Homebrew packages from Brewfile..."
  if [[ -f "$DOTFILES_DIR/brew/.Brewfile" ]]; then
    brew bundle --file="$DOTFILES_DIR/brew/.Brewfile"
  else
    warn "Brewfile not found at $DOTFILES_DIR/brew/.Brewfile"
  fi
}

# Stow packages
# Usage: stow_package <package_name> [target_dir]
stow_package() {
  local package="$1"
  local target="${2:-$HOME}"

  if [[ -d "$DOTFILES_DIR/$package" ]]; then
    info "Stowing $package -> $target"
    stow -v -d "$DOTFILES_DIR" -t "$target" "$package"
  else
    warn "Package not found: $package"
  fi
}

# Setup all packages with stow
setup_stow() {
  info "Setting up dotfiles with stow..."

  # Packages that go to $HOME
  local home_packages=(
    "zsh"
    "tmux"
    "p10k"
    "vim"
    "mise"
    "starship"
  )

  for pkg in "${home_packages[@]}"; do
    stow_package "$pkg"
  done

  # GPG needs special handling (copy files to ~/.gnupg)
  if [[ -f "$DOTFILES_DIR/gpg/gpg-agent.conf" ]]; then
    mkdir -p "$HOME/.gnupg"
    chmod 700 "$HOME/.gnupg"
    info "Copying GPG configuration to ~/.gnupg"
    cp "$DOTFILES_DIR/gpg/gpg-agent.conf" "$HOME/.gnupg/"
    chmod 600 "$HOME/.gnupg/gpg-agent.conf"
  fi

  # Kitty (copy files to ~/.config/kitty)
  if [[ -d "$DOTFILES_DIR/kitty" ]]; then
    mkdir -p "$HOME/.config/kitty"
    info "Copying Kitty configuration to ~/.config/kitty"
    cp -r "$DOTFILES_DIR/kitty/." "$HOME/.config/kitty/"
  fi
}

# Install Prezto
setup_prezto() {
  if [[ ! -d "$HOME/.zprezto" ]]; then
    info "Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
  else
    info "Prezto is already installed"
  fi
}

# Install TPM (Tmux Plugin Manager)
setup_tpm() {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    info "TPM is already installed"
  fi
}

# Setup fonts
setup_fonts() {
  info "Setting up fonts..."
  local font_dir="$HOME/Library/Fonts"
  mkdir -p "$font_dir"

  if [[ -d "$DOTFILES_DIR/fonts" ]]; then
    for font in "$DOTFILES_DIR/fonts"/*.ttf "$DOTFILES_DIR/fonts"/*.otf; do
      if [[ -f "$font" ]]; then
        local font_name=$(basename "$font")
        if [[ ! -f "$font_dir/$font_name" ]]; then
          info "Installing font: $font_name"
          cp "$font" "$font_dir/"
        fi
      fi
    done
  fi
}

# Main
main() {
  echo "Starting dotfiles installation..."
  echo ""

  check_homebrew
  install_brew_packages

  setup_stow
  setup_prezto
  setup_tpm
  setup_fonts

  echo ""
  echo "=== Installation Complete ==="
  echo ""
  echo "Next steps:"
  echo "  1. Restart your terminal or run: source ~/.zshrc"
  echo "  2. Run 'p10k configure' to customize your prompt"
  echo "  3. Open Neovim and run :Lazy to install plugins"
  echo "  4. In tmux, press prefix + I to install plugins"
  echo ""
}

# Run main
main "$@"
