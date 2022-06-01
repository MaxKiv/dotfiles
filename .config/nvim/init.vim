" My .vimrc / init.vim 
" 
" Detect OS
"
if !exists("this_os")
	if has("win64") || has("win32") || has("win16")
		let this_os = "Windows"
	else
		let this_os = substitute(system('uname'), '\n', '', '')
    endif
endif
" :options for all possible options
" :h [cmd] for man page of specific cmd
"
"------------------------------Sets------------------------------
"
set exrc                    " Attempts to source .vimrc in local dir first
set relativenumber          " Use relative numbers
set nu                      " Current line still shows global line number
set tabstop=4               " Set Tab width to 4
set softtabstop=4           " Use soft Tabs
set shiftwidth=4            " Set soft Tab width to 4
set expandtab               " Indent with the appropriate number of spaces
set autoindent              " Copy previous indentation level
set smartindent             " Do it smartly tho
set hidden                  " Save buffers 
set noerrorbells            " Yea
set nowrap                  " No wrapping
set smartcase               " Simple search, case-sensitive when capital letter present
set undodir=~/.vim/undodir  " Location of the undo data
set undofile                " Something to do with previous
set incsearch               " Show search hits while typing
set scrolloff=8             " Stop moving camera vertically when near edges of screen
set signcolumn=yes          " Add Git/Linting column
set cmdheight=2             " More space for displaying messages
set updatetime=100          " Set updatetime period in ms, default 4000 is noticable
set termguicolors           " Terminal colors, its not 1970
set nohlsearch              " Dont highlight search hits

if this_os == "Linux"
    set clipboard=unnamedplus   " Yank to clipboard
elseif this_os == "Windows"
    set clipboard=unnamed       " Yank to clipboard
endif

" TODO: where this?
:syntax enable

"------------------------------Plugins------------------------------
" Using vim-plug: https://github.com/junegunn/vim-plug
" 
" Install vim-plug if its not on this system yet
if this_os == "Linux"
	if empty(glob('~/.local/share/nvim/site'))
        silent ! sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
elseif this_os == "Windows"
	if empty(glob('$LOCALAPPDATA\nvim\autoload\plug.vim'))
	  silent ! powershell -Command "
	  \   New-Item -Path ~\AppData\Local\nvim -Name autoload -Type Directory -Force;
	  \   Invoke-WebRequest
	  \   -Uri 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	  \   -OutFile ~\AppData\Local\nvim\autoload\plug.vim
	  \ "
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

" Start plugin list
call plug#begin('~/.vim/plugged')

" ColorScheme pick your poison i pick gruvbox
Plug 'morhetz/gruvbox'

" Telescope - Gaze deeply into unknown regions using the power of the moon
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Je boi Tpope met de surround
Plug 'tpope/vim-surround'

" Je boi Tpope met de comment plugin
Plug 'tpope/vim-commentary'

" fzf fuzzy finder with update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" 
"
" The default plugin directory will be as follows:
"
"    - Vim (Linux/macOS): '~/.vim/plugged'
"
"    - Vim (Windows): '~/vimfiles/plugged'
"
"    - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
"
" You can specify a custom plugin directory by passing it as the argument
"
"    - e.g. `call plug#begin('~/.vim/plugged')`
"
"    - Avoid using standard Vim directory names like 'plugin'
"
" Make sure you use single quotes
"
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
"
" End plugin list
call plug#end()
colorscheme gruvbox

"------------------------------Remaps------------------------------
"
" Remap the useless S to replace word under cursor with content of 0 register
nnoremap S dis"0P





"autocmd VimEnter *
  "\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  "\|   PlugInstall --sync | q
  "\| endif
