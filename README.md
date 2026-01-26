# kurage's dotfiles

## Required

- [GNU Stow]

## Getting Start

1. Clone this repository

```shell
cd \
    && git clone git@github.com:ohashih/dotfiles.git \
    && cd dotfiles
```

2. Create Symlinks

```shell
stow -v -t ~/ zsh \
    && stow -v -t ~/ tmux \
    && stow -v -t ~/ vim \
    && stow -v -t ~/ kitty \
    && stow -v -t ~/ mise \
    && stow -v -t ~/ brew
```

## If you want to remove the symlinks

```shell
stow -vD -t ~/ zsh \
    && stow -vD -t ~/ tmux \
    && stow -vD -t ~/ vim \
    && stow -vD -t ~/ kitty \
    && stow -vD -t ~/ mise \
    && stow -vD -t ~/ brew
```

[GNU Stow]: https://www.gnu.org/software/stow/
