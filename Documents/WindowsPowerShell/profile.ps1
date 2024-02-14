
# upgrade the windows experience ...
Set-Alias grep findstr
function dotfiles {
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
# Utilities
function f() {
  param($Directory = $null)

  if ($null -eq $Directory) {
    $Directory = $PWD.Path
  }

  $result = $null

  try {

    # Color output from fd to fzf if running in Windows Terminal
    $script:RunningInWindowsTerminal = [bool]($env:WT_Session)
    if ($script:RunningInWindowsTerminal) {
      $script:DefaultFileSystemFdCmd = "fd.exe --color always . {0}"
    }
    else {
      $script:DefaultFileSystemFdCmd = "fd.exe . {0}"
    }

    # Wrap $Directory in quotes if there is space (to be passed in fd)
    if ($Directory.Contains(' ')) {
      $strDir = """$Directory"""
    }
    else {
      $strDir = $Directory
    }

    # Call fd to get directory list and pass to fzf
    Invoke-Expression (($script:DefaultFileSystemFdCmd -f '--type directory {0} --max-depth 1') -f $strDir) | fzf | ForEach-Object { $result = $_ }
  }
  catch {

  }

  if ($null -ne $result) {
    Set-Location $result
  }
}

Set-PSReadLineOption -EditMode Emacs

cd ~
