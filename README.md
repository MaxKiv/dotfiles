# My Dotfiles 🤓

This repository contains all the configuration of stuff I actively used at one
point. The most involved part is the `nvim` configuration, fully in `lua`.

### How to install?

Don't, you should really look into using `nix` for this instead!

#### 🐧 Unix/wsl

`bash
git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout
`

#### ⁉️ WSL

`bash
git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
alias dot='/mingw64/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout
`

#### 🪟 Windows

`ps1
git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
function dot {
    git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
}
dot checkout
`

# Alacritty

## Symlink alacritty config
On windows the alacritty config should be located in Appdata\Roaming, to make it
so:
`ps1
mkdir C:\Users\max\AppData\Roaming\alacritty
New-Item -ItemType SymbolicLink -Path "C:\Users\max\AppData\Roaming\alacritty\alacritty.yml" -Target "C:\Users\max\.config\alacritty\alacritty.yml"
`

