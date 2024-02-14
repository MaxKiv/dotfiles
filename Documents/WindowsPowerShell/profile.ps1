# corporate proxy settings
[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy('rb-proxy-de.bosch.com:8080')
[system.net.webrequest]::defaultwebproxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true

# Fzf integration doesnt work ...
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -EnableAliasFuzzySetLocation
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Setup Zoxide
if (Get-Command -Name "zoxide" -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# upgrade the windows experience ...
Set-Alias grep findstr
function dot {
  git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
}
function ds {
  dot status
}
function sb {
  . $HOME\Documents\WindowsPowerShell\profile.ps1
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
function gf {
  git fetch -t -p
}
function gau {
  git add -u
}
function gcam {
  git commit --amend --no-edit $Args
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
function gpf {
  git push --force-with-lease
}
del alias:gc -Force
function gc() {
  & git commit -m $Args
}
function gca() { & git commit -a -m $Args }
function gcpg($grep) {
  & git cherry-pick $(git rev-list --reverse --grep $grep develop..HEAD)
}

function gsw {
    $branchList = @() # Initialize an array to store both local and remote branches

    # Use `git branch` to list local branches and add them to the array
    $localBranches = git branch | ForEach-Object { $_.Trim() }
    $branchList += $localBranches

    # Use `git for-each-ref` to list remote branches and add them to the array
    $remoteBranches = git for-each-ref --format="%(refname:short)" "refs/remotes/origin/" | ForEach-Object { $_.Trim() }
    $branchList += $remoteBranches

    # Use `fzf` to interactively select a branch from the combined list
    $selectedBranch = $branchList | fzf --ansi --preview 'git show --color=always {1}' | ForEach-Object { $_.Trim() }

    if (-not [string]::IsNullOrEmpty($selectedBranch)) {
        # Use `git switch` to switch to the selected branch
        git switch $selectedBranch
    } else {
        Write-Host "No branch selected."
    }
}


# I cant live without this
Set-PSReadLineOption -EditMode Emacs
