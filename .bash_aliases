# Contains all my bashrc aliases

# Sourcing .bashrc
alias sb='source ~/.bashrc'

# Essential
alias fj='fg'
alias shutdown='shutdown now'
alias reboot='reboot now'

# Vim
alias nv='nvim'
alias vim='nvim'

# .Dotfiles management
alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dot config --local status.showUntrackedFiles no
alias ds='dot status'

# bat is the better cat
alias cat='batcat'

# Embedded
alias logic="$HOME/Downloads/Logic-2.4.1-master.AppImage"

# ESP development
alias gidf=". $HOME/git/esp-idf/export.sh"
alias ridf=". $HOME/export-esp.sh"
#alias scr="screen /dev/ttyUSB0 115200,cs8"
export OPENOCD_COMMANDS="-f interface/ftdi/esp32_devkitj_v1.cfg -f target/esp32.cfg"

# ESP development
alias gidf8=". $HOME/esp/ESP8266_RTOS_SDK/export.sh"
# alias bidf="idf.py build"
# alias cidf="idf.py fullclean"
# alias scr="screen /dev/ttyUSB0 115200,cs8"

initcmp () {
    dot add $HOME/.config/nvim/init.vim
    dot commit -m "$1"
    dot push;
    }
bsrccmp () {
    dot add $HOME/.bashrc
    dot add $HOME/.bash_aliases
    dot commit -m "$1"
    dot push;
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

# turn on/off keyboard
strd() {
  xinput set-int-prop 17 "Device Enabled" 8 0
}
drts() {
  xinput set-int-prop 17 "Device Enabled" 8 1
}

# git stuff
alias gs='git status'
alias gl='git log --oneline --decorate --graph'
alias glp='git log -p'
alias gpf='git push --force-with-lease'
alias gf='git fetch -p -t'
alias gau='git add -u'
alias gcam='git commit --amend --no-edit'

# global pushd/popd
function gpushd() {
  filename="$HOME/.gstack.dirs"
  newdir=$(readlink -f "$1")
  if [ "$newdir" != "" ]; then
    echo $newdir >> $filename
  else
    newdir=$(readlink -f ".")
    echo $newdir >> $filename
  fi
}
function gpopd() {
  filename="$HOME/.gstack.dirs"
  dir=$(tail -n 1 $filename)
  sed -i '$ d' $filename
  if [ "$dir" != "" ]; then
    cd "$dir"
  fi
}

# Tired of 9000+ zip formats, stolen from asinghani dotfiles
extract () {
    if [[ -f $1 ]] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
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

### FZF ###

# open a file selected by fzf in vim
vf() {
  vim $(fzf)
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

### Tmux ###
tma() {
  tmux a -t "$1"
}
tmf() {
  local session=$(tmux ls | cut -d":" -f1 | fzf)
  tmux a -t "$session"
}
tmd() {
  local session=$(tmux ls | cut -d":" -f1 | fzf)
  tmux kill-session -t "$session"
}
alias tms='tmux new-session -s'
alias tml='tmux list-session'

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

exp() {
  explorer.exe .
}

# nvim config
nvu() {
  nvim -u "/home/max/projects/nvim/init.lua"
}
