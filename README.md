# kurage's dotfiles

## Prerequisites test

- [GNU Stow]

## Instrcutions

1. Clone this repository:

    $ cd \
        && git clone git@github.com:ohashih/dotfiles.git \
        && cd dotfiles

2. Select and place dotfiles

    $ stow -v git \
        && stow -v zsh \
        && stow -v tmux \
        && stow -v vim

3. If you want to remove the symlinks, just use the -D arguement:

    $ stow -vD git \
        && stow -vD zsh \
        && stow -vD tmux \
        && stow -vD vim

[GNU Stow]: https://www.gnu.org/software/stow/
