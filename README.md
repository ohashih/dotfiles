# kurage's dotfiles

## Required

- [GNU Stow]

## Getting Start

1. Clone this repository

        cd \
            && git clone git@github.com:ohashih/dotfiles.git \
            && cd dotfiles

2. Create Symlinks

        stow -v -t ~/ zsh \
            && stow -v -t ~/ tmux \
            && stow -v -t ~/ vim

## If you want to remove the symlinks

        stow -vD -t ~/ zsh \
            && stow -vD -t ~/ tmux \
            && stow -vD -t ~/ vim

[GNU Stow]: https://www.gnu.org/software/stow/
