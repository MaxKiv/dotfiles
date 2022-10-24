# Contains all my bashrc aliases

# Sourcing .bashrc
alias sb='source ~/.bashrc'

# Vim
alias nv='nvim'
alias vim='nvim'

# .Dotfiles management
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no

# ESP development
alias gidf=". $HOME/git/esp-idf/export.sh"
alias bidf="idf.py build"
alias cidf="idf.py fullclean"
alias scr="screen /dev/ttyUSB0 115200,cs8"

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

# mkdir and cd :)
mkcd() {
  mkdir "$1" && cd "$_"
}

# Select dir by modified date with fzf
ca() {
  cd $(ls -t | fzf)
}

# mkdir and cd combined bless
mkcd() {
  mkdir "$1" && cd "$_"
}

### Notes ###
export NOTE_DIR="$HOME/git/Information"
note() {
  if [ $# -eq 0 ]
  then
    echo "-----------------"
    echo "Create a new note"
    echo "-----------------"
    echo "Usage:"
    echo "note <note name>"
  else
    file=${1%.*}
    touch $NOTE_DIR/$file.md
    $EDITOR $NOTE_DIR/$file.md
  fi
}

find_note() {
  local file

  file="$(find $NOTE_DIR -iname '*.md' -exec basename -s .md {} \; | fzf --bind 'J:preview-down,K:preview-up' --height 100% --preview 'if file -i {}|grep -q binary; then file -b {}; else glow -s dark $HOME/Documents/notes/{}.md; fi')"

  if [[ -n $file ]]
  then
     $EDITOR $NOTE_DIR/"$file".md
  fi
}

### WSL ###
# CD to Windows path :) - only c drive for now
cdw() {
  arg=$1
  len=${#arg}
  str=${arg:3:len}
  path="/mnt/c/"$str
  mod="${path//\\//}"
  cd $mod
}

# run admin command prompt in wsl XD 
wsudo() {
  powershell.exe -Command "Start-Process 'cmd.exe' -Verb runAs"
}
