# .vim

Covers config files for ~/.vim directory.
~/.vim directory in a single place. Contains .vimrc and friends (for
sourcing) for easier access from new machines/nodes/images/etc. Right now, the
`master` branch is general-purpose oriented with focus on
[Haskell](https://www.haskell.org), however there is a plan to implement some
convenient branching strategy with e.g. language/style per branch/tag.

## Plugins:

Plugins are added with [Vim-Plug](https://github.com/junegunn/vim-plug), the
primary plugin manager I use.

* [gruvbox](https://github.com/morhetz/gruvbox) - a nice creamy colour theme.
* [vim-airline](https://github.com/vim-airline/vim-airline) - adds an airline
at the bottom of the vim screen with info about mode, filename, line, etc.
* [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes) -
themes for the vim airline.
* [coc](https://github.com/neoclide/coc.nvim) - connects to language servers
via [LSP](https://microsoft.github.io/language-server-protocol/) and provides
popups, warnings, code completion, etc.
* [haskell-vim](https://github.com/neovimhaskell/haskell-vim) - syntax
highlighting for haskell.
* [NERDTree](https://github.com/preservim/nerdtree) - sidebar with project
tree structure. Recently broke (might be vim incompatibility issue), thus most
of the configuration here is under development and mostly commented out.
* [vim-devicons](https://github.com/ryanoasis/vim-devicons) - icons for
filetypes, os, etc. for all compatible (NERDTree, vim-airline, etc.) plugins.
Requires [Nerd Font](https://github.com/ryanoasis/nerd-fonts) to be present.
* [fzf](https://github.com/junegunn/fzf) - fuzzy finder for text. Requires
something as a backend. By default, it uses find but can be enhanced with
[fd](https://github.com/sharkdp/fd) or
[rg](https://github.com/BurntSushi/ripgrep) utilities. I use `fd` but ***as
for now***, it's not reflected anywhere.
* [fzf.vim](https://github.com/junegunn/fzf.vim) - extended vim support for
fzf. Adds useful functions and else for fzf to work with buffers, registers,
etc.
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter) - displays git
info in the *signcolumn* which
[starting with vim 8.1.1564](https://github.com/vim/vim/commit/394c5d8870b15150fc91a4c058dc571fd5eaa97e)
can be merged with number column (replacing the latter when info exists for a
line).
* [vimagit](https://github.com/jreybert/vimagit) - an emacs
[magit](https://github.com/magit/magit) version for git. Unfortunately lacks
of features and is very slow, but I haven't found a nicer magit-like solution
for vim yet.

