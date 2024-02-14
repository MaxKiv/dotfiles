This repo contains all my dotfiles in 1 place.

## Fast install

	curl -Lks https://bit.ly/dotfiles_maxkiv | /bin/bash
	
	sb

## Other install options
### Unix/wsl

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	dotfiles checkout
	
### MinGW Windows

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	alias dotfiles='/mingw64/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	dotfiles checkout

### Powershell Windows

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles
	function dtf {
 		git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
	}
	dotfiles checkout


## Windows: Alacritty

	# Symlink alacritty config
	mkdir C:\Users\max\AppData\Roaming\alacritty
	New-Item -ItemType SymbolicLink -Path "C:\Users\max\AppData\Roaming\alacritty\alacritty.yml" -Target "C:\Users\max\.config\alacritty\alacritty.yml"

