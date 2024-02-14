# corporate proxy settings
[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy('rb-proxy-de.bosch.com:8080')
[system.net.webrequest]::defaultwebproxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true

# Fzf integration doesnt work ...
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -EnableAliasFuzzySetLocation
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# upgrade the windows experience ...
Set-Alias grep findstr
function dot {
  git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
}
function ds {
  dot status
}
function sb {
  . $profile
}
function ll {
  dir @Args
}
function open {
  start @Args
}
function gs {
  git status
}
function gau {
  git add -u
}
function grd {
  & git rebase $Args origin/develop
}
function grc {
  & git rebase --continue
}
del alias:gl -Force
function gl {
  & git log --oneline --decorate --graph $Args
}
function glp {
  git log -p
}
del alias:gc -Force
function gc() {
  & git commit -m $Args
}
function gca() { & git commit -a -m $Args }
function gca() { & git cherry-pick $Args }
function gcpg($grep) {
  & git cherry-pick $(git rev-list --reverse --grep $grep develop..HEAD)
}

# I cant live without this
Set-PSReadLineOption -EditMode Emacs
