# kurage's dotfiles

## Prerequisites test

- [GNU Stow]

## Instrcutions

1. Clone this repository:

        $ cd \
            && git clone git@github.com:ohashih/dotfiles.git \
            && cd dotfiles

2. Select and place dotfiles

        $ stow -v -t ~/ zsh \
            && stow -v -t ~/ tmux \
            && stow -v -t ~/ vim

3. If you want to remove the symlinks, just use the -D arguement:

        $ stow -vD -t ~/ zsh \
            && stow -vD -t ~/ tmux \
            && stow -vD -t ~/ vim

[GNU Stow]: https://www.gnu.org/software/stow/
