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

## Usage instructions

The instructions will be updated once I write a script for uniform
installation but until that there are couple of things that need to be done
by hands:

1. Clone to `~/.vim` directory
   ```shell
   git clone git@github.com:NMikle/.vim.git ~/.vim
   ```
    **Note:** The `~/.vim` directory must be empty (or non-existent) prior to
    this command execution. If your directory contains some settings, you
    _might_ wish to back it up first.
2. Vim resolves config in the following order (see `:help .vimrc`):
   - ~/.vimrc
   - ~/.vim/vimrc
   - the rest of places

   I like my file named `.vimrc` (with a dot) but for this to be resolved we
   need to help vim find this file:
   ```shell
   ln -s ~/.vim/.vimrc ~/.vimrc
   ```
   This creates a symlink to a `~/.vim/.vimrc` and puts this symlink where vim
   can find it (`~/.vimrc`)

   **Note:** if you already have `~/.vimrc`, you need to back it up and re-run
   the command.
3. `ln` command creates a symlink with _execute_ permissions. To remove
   execute permission run:
   ```shell
   chmod -h 644 ~/.vimrc
   ```
   this will set symlink permissions to `rw-r--r--` which I found to be
   default for my `~/.vimrc`
4. You will need couple extra things on the system for plugins to work. This
   list depends on the plugins installed and your goals, but for me, it is:
   - nvm, node, npm (for the CoC)
   - haskell-language-server (use [ghcup](https://www.haskell.org/ghcup/) to
     install haskell tools) for the CoC to work with haskell files (specified
     in [coc settings](./coc-settings.json))
   - some sort of dev-icons. I use
     [JetBrains Mono](https://www.jetbrains.com/lp/mono/) with
     [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) which you can
     install like this
     ```shell
     brew tap homebrew/cask-fonts
     brew install font-jetbrains-mono-nerd-font
     ```
     **Note:** you also need to enable/use this font in your terminal
     settings.
   - [fd](https://github.com/sharkdp/fd) as `fzf` search backend and
     [bat](https://github.com/sharkdp/bat) for `fzf` preview feature.

This list is just my preference and should be adjusted for your needs. Once I
finish the auto install script, installation should become automatic.

