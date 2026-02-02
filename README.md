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

2. Setup

```shell
./install.sh
```

## If you want to remove the symlinks

```shell
stow -vD -t ~/ zsh \
    && stow -vD -t ~/ tmux \
    && stow -vD -t ~/ vim \
    && stow -vD -t ~/ kitty \
    && stow -vD -t ~/ mise \
    && stow -vD -t ~/ brew \
    && stow -v -t ~/ p10k \
    && stow -vD -t ~/ gpg
```

[GNU Stow]: https://www.gnu.org/software/stow/
