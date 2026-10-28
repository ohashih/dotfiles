# kurage's dotfiles

## Required

- Apple Silicon Mac
- [GNU Stow] (`install.sh` installs it via Homebrew)

## Getting Start

1. Clone this repository

```
cd \
    && git clone git@github.com:ohashih/dotfiles.git ~/dotfiles \
    && cd ~/dotfiles
```

2. Setup

```
./install.sh
```

`install.sh` does the following (safe to re-run):

- Install Homebrew and packages in `brew/.Brewfile`
- Stow all packages to `$HOME` (existing real files are moved to `~/.dotfiles_backup/<timestamp>/`)
- `mise install`, `sheldon lock --update`, TPM plugins, Neovim plugins (`Lazy! restore`), fonts

3. Manual steps

- Restore secrets: `~/.ssh`, GPG secret key (`gpg --import`; used as git `signingkey`), `~/.aws`, `~/.zsh/secret.zshrc`, `~/secrets`
- Authenticate: `gh auth login`, `:Copilot auth` in Neovim
- Grant permissions to Karabiner-Elements and kitty in System Settings
- Install `~/bin` binaries, GUI apps not in Brewfile, and `~/.claude`
- macOS defaults are not managed

## Update Brewfile

```
brew bundle dump --force --file=brew/.Brewfile
```

## If you want to remove the symlinks

```
for pkg in zsh tmux vim mise sheldon kitty gh karabiner gpg brew git p10k editorconfig; do
    stow -vD -t ~/ "$pkg"
done
```

[GNU Stow]: https://www.gnu.org/software/stow/
