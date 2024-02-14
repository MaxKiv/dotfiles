
# Fzf integration
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -EnableAliasFuzzySetLocation
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# upgrade the windows experience ...
Set-Alias grep findstr
function dot {
  git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
}
function sb {
  . $profile
}
function ll {
  dir @Args
}
function gs {
  git status
}
function gl {
  git log
}
function glp {
  git log -p
}
function gc($msg) {
  git commit -m "$msg"
}

Set-PSReadLineOption -EditMode Emacs

cd ~
