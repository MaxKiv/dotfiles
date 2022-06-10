This repo contains all my dotfiles in 1 place.

## Fast install

	curl -Lks https://bit.ly/dotfiles_maxkiv | /bin/bash
	
	sb

## Other install options

	git clone --bare git@github.com:MaxKiv/dotfiles.git $HOME/.dotfiles

	alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME

	dotfiles checkout

## TODO
add to install script:

* nvim
* tmux + tpm (git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)
* fzf
* powerline fonts (https://github.com/powerline/fonts)

## On windows LUL

	cd "C:\"
	git clone git@github.com:MaxKiv/dotfiles.git 
	mklinnk "C:\dotfiles\.config\alacritty\alacritty.yml" "%APPDATA%\Roaming\alacritty\alacritty.yml"
