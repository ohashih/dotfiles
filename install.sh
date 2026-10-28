#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd -P)"
EXPECTED_DOTFILES_DIR="$HOME/git/kurage/dotfiles"
BREWFILE="$DOTFILES_DIR/brew/.Brewfile"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

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

# Check prerequisites
check_prerequisites() {
  if [[ $(uname -m) != "arm64" ]]; then
    error "This installer supports Apple Silicon Mac only (uname -m: $(uname -m))"
    exit 1
  fi

  # kitty.conf などが ~/git/kurage/dotfiles を参照している
  if [[ "$DOTFILES_DIR" != "$EXPECTED_DOTFILES_DIR" ]]; then
    warn "DOTFILES_DIR is not $EXPECTED_DOTFILES_DIR; some configs (e.g. kitty scrollback_pager) may not work"
  fi
}

# Check if Homebrew is installed
check_homebrew() {
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    info "Homebrew is already installed"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"
}

# Install packages from Brewfile
install_brew_packages() {
  info "Installing Homebrew packages from Brewfile..."
  if [[ -f "$BREWFILE" ]]; then
    brew bundle --file="$BREWFILE" || warn "Some Brewfile entries failed to install"
  else
    warn "Brewfile not found at $BREWFILE"
  fi
}

# Move a conflicting target (real file/dir or foreign symlink) to $BACKUP_DIR
# Usage: backup_target <relative_path_from_home> <package_source_path>
backup_target() {
  local rel="$1"
  local src="$2"
  local target="$HOME/$rel"

  if [[ ! -e "$target" && ! -L "$target" ]]; then
    return
  fi
  # 既に stow 済み (repo を指している) ならそのまま
  if [[ "$(realpath "$target" 2>/dev/null)" == "$src" ]]; then
    return
  fi

  info "Backing up $target -> $BACKUP_DIR/$rel"
  mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
  mv "$target" "$BACKUP_DIR/$rel"
}

# Back up every top-level entry of a package (children of .config/.gnupg)
backup_conflicts() {
  local package="$1"
  local pkg_dir="$DOTFILES_DIR/$package"
  local entry name child

  for entry in "$pkg_dir"/.[!.]* "$pkg_dir"/*; do
    [[ -e "$entry" ]] || continue
    name="$(basename "$entry")"
    [[ "$name" == ".DS_Store" ]] && continue

    if [[ "$name" == ".config" || "$name" == ".gnupg" ]]; then
      for child in "$entry"/.[!.]* "$entry"/*; do
        [[ -e "$child" ]] || continue
        [[ "$(basename "$child")" == ".DS_Store" ]] && continue
        backup_target "$name/$(basename "$child")" "$child"
      done
    else
      backup_target "$name" "$entry"
    fi
  done
}

# Stow packages
# Usage: stow_package <package_name>
stow_package() {
  local package="$1"

  if [[ -d "$DOTFILES_DIR/$package" ]]; then
    info "Stowing $package -> $HOME"
    backup_conflicts "$package"
    stow -v --restow -d "$DOTFILES_DIR" -t "$HOME" "$package"
  else
    warn "Package not found: $package"
  fi
}

# Setup all packages with stow
setup_stow() {
  info "Setting up dotfiles with stow..."

  # ~/.config や ~/.gnupg 自体が単一パッケージへの symlink に畳まれないよう先に作る
  mkdir -p "$HOME/.config" "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"

  local packages=(
    "zsh"
    "tmux"
    "vim"
    "mise"
    "sheldon"
    "kitty"
    "gh"
    "karabiner"
    "gpg"
    "brew"
    "git"
    "p10k"
    "editorconfig"
  )

  for pkg in "${packages[@]}"; do
    stow_package "$pkg"
  done

  if [[ -d "$BACKUP_DIR" ]]; then
    warn "Existing files were moved to $BACKUP_DIR"
  fi
}

# Install runtimes via mise (~/.config/mise/config.toml)
setup_mise() {
  if command -v mise &>/dev/null; then
    info "Installing tools with mise..."
    mise install || warn "mise install failed"
    eval "$(mise activate bash --shims)"
  else
    warn "mise not found; run 'brew bundle' first"
  fi
}

# Brewfile の cargo エントリは mise の rust が入ってから再実行する
install_remaining_brew_packages() {
  if ! brew bundle check --no-upgrade --file="$BREWFILE" &>/dev/null; then
    info "Retrying Brewfile entries that depend on mise tools..."
    brew bundle --file="$BREWFILE" || warn "Some Brewfile entries failed to install"
  fi
}

# Install zsh plugins via sheldon (prezto/zplug から移行)
setup_sheldon() {
  if command -v sheldon &>/dev/null; then
    info "Locking zsh plugins with sheldon..."
    sheldon lock --update || warn "sheldon lock failed"
  else
    warn "sheldon not found; run 'brew bundle' first"
  fi
}

# Install TPM (Tmux Plugin Manager) and plugins
setup_tpm() {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    info "TPM is already installed"
  fi

  info "Installing tmux plugins..."
  "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "tmux plugin install failed"
}

# Install Neovim plugins (lazy-lock.json に揃える)
setup_nvim() {
  if command -v nvim &>/dev/null; then
    info "Restoring Neovim plugins with lazy.nvim..."
    nvim --headless "+Lazy! restore" +qa || warn "Lazy restore failed"
  else
    warn "nvim not found; run 'brew bundle' first"
  fi
}

# Setup fonts
setup_fonts() {
  info "Setting up fonts..."
  local font_dir="$HOME/Library/Fonts"
  local src_dir="$DOTFILES_DIR/fonts/Library/Fonts"
  local font font_name
  mkdir -p "$font_dir"

  shopt -s nullglob
  for font in "$src_dir"/*.ttf "$src_dir"/*.otf; do
    font_name="$(basename "$font")"
    if [[ ! -f "$font_dir/$font_name" ]]; then
      info "Installing font: $font_name"
      cp "$font" "$font_dir/"
    fi
  done
  shopt -u nullglob
}

# Main
main() {
  echo "Starting dotfiles installation..."
  echo ""

  check_prerequisites
  check_homebrew
  install_brew_packages

  setup_stow
  setup_mise
  install_remaining_brew_packages
  setup_sheldon
  setup_tpm
  setup_nvim
  setup_fonts

  echo ""
  echo "=== Installation Complete ==="
  echo ""
  echo "Next steps:"
  echo "  1. Restart your terminal (open a new kitty window)"
  echo "  2. Restore secrets manually:"
  echo "     - ~/.ssh, GPG secret key (gpg --import; used by git signingkey)"
  echo "     - ~/.aws, ~/.zsh/secret.zshrc, ~/secrets"
  echo "  3. Authenticate: gh auth login / :Copilot auth in Neovim"
  echo "  4. Grant permissions to Karabiner-Elements and kitty in System Settings"
  echo "  5. Install ~/bin binaries, GUI apps not in Brewfile, and ~/.claude manually"
  echo ""
}

# Run main
main "$@"
