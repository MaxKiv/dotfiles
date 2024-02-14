This repo contains all my dotfiles in 1 place.

## TODO
Split Unix/Windows into branches

## Fast install

	curl -Lks https://bit.ly/dotfiles_maxkiv | /bin/bash
	
	sb

## Other install options
### Unix/wsl

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	dot checkout
	
### MinGW Windows

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	alias dot='/mingw64/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	dot checkout

### Powershell Windows

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	function dtf {
 		git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
	}
	dot checkout


## Windows: Alacritty

	# Symlink alacritty config
	mkdir C:\Users\max\AppData\Roaming\alacritty
	New-Item -ItemType SymbolicLink -Path "C:\Users\max\AppData\Roaming\alacritty\alacritty.yml" -Target "C:\Users\max\.config\alacritty\alacritty.yml"

