# Contains all my bashrc aliases

# Sourcing .bashrc
alias sb='source ~/.bashrc'

# glow markdown viewer
alias glow='./home/max/git/glow'

# Vim
alias nv='nvim'
alias vim='nvim'

# .Dotfiles management
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no

alias cf='cd $HOME/.config/nvim/'
initcmp () {
    dotfiles add $HOME/.config/nvim/init.vim 
    dotfiles commit -m "$1"
    dotfiles push;
    }
bsrccmp () {
    dotfiles add $HOME/.bashrc
    dotfiles add $HOME/.bash_aliases
    dotfiles commit -m "$1"
    dotfiles push;
    }

# tmux () {
#   tmux new-session -A -s "$1";
# }

# CD to Windows path :) - only c drive for now
cdw() {
  # get arg length
  arg=$1
  len=${#arg}
  # substring
  str=${arg:3:len}
  path="/mnt/c/"$str
  # echo $path
  # replace backslashes
  mod="${path//\\//}"
  # mod=$path | tr '\' '/'
  # echo $mod
  cd $mod
}

# Select dir by modified date with fzf
ca() {
  cd $(ls -t | fzf)
}

mkcd() {
  mkdir "$1" && cd "$_"
}
