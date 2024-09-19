set nocompatible
set encoding=utf-8

if has('filetype')
    filetype indent plugin on
endif

" ==============================================================================
" Indentation
" ==============================================================================

set shiftwidth=4
set softtabstop=4
set expandtab

if has('syntax')
    syntax on
endif

set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=

if has('mouse')
    set mouse=a
endif

set cmdheight=2
set timeout ttimeout ttimeoutlen=200

" ==============================================================================
" Highlight trailing spaces
" ==============================================================================

augroup trailingspaces
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

" ==============================================================================
" Mappings
" ==============================================================================

map Y $y
nnoremap <C-L> :nohl<CR><C-L>

" ==============================================================================
" Line numbers
" ==============================================================================

set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" ==============================================================================
" Windows/Buffers/split management config
" ==============================================================================

" Close all buffers but this one.
" Creates command to close all other buffers that can be run with `:BufOnly`
" -   %bd  --- delete all buffers
" -   e#   --- open the last buffer for editing
" -   bd#  --- delete [No Name] buffer that gets created
command! BufOnly silent! execute "%bd|e#|bd#"

nnoremap <silent> s <C-w>
" Closes the buffer leaving the window open
command! BufCloseSilent silent! execute "bd|sp|bn|bd"

" ==============================================================================
" Vim-Plug pluggins
" ==============================================================================

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

Plug 'mbbill/undotree'

call plug#end()

" ==============================================================================
" ColorScheme options
" ==============================================================================

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

set background=dark
"let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_contrast_dark = 'medium'

let g:gruvbox_invert_signs = 0

colorscheme gruvbox

hi! link haskellType GruvboxGreenBold
hi! link haskellIdentifier GruvboxYellow
hi! link haskellSeparator GruvboxFg3
hi! link haskellDelimiter GruvboxFg3
hi! link haskellOperators GruvboxRed
"
hi! link haskellBacktick haskellOperators
hi! link haskellStatement GruvboxOrange
hi! link haskellConditional GruvboxRed

hi! link haskellKeyword GruvboxPurpleBold
hi! link haskellLet GruvboxRed
hi! link haskellDefault GruvboxAqua
hi! link haskellWhere GruvboxRed
hi! link haskellBottom GruvboxAqua
hi! link haskellBlockKeywords GruvboxAqua
hi! link haskellImportKeywords GruvboxBlueBold
hi! link haskellDeclKeyword GruvboxRed
hi! link haskellDecl GruvboxRed
hi! link haskellDeriving GruvboxAqua
hi! link haskellAssocType GruvboxAqua

hi! link haskellNumber GruvboxPurple
hi! link haskellPragma GruvboxPurple

hi! link haskellString GruvboxGreen
hi! link haskellChar GruvboxGreen

" ==============================================================================
" Airline options
" ==============================================================================

let g:airline_theme = 'alduin'

" ==============================================================================
" Coc config
" ==============================================================================

set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugins before putting this into your config / when including new
" plugins (latter obviously requires this part to be disabled).
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ CheckBackspace() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
augroup cocCursonHighlight
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup notexactlysure
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" Applying code action to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language
" server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selection ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command to organize imports of the current buffer.
command! -nargs=0 OR  :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Automatically update status line whenever coc_status changes.
" Without this augroup the status line would be updated only when the buffer
" changes or when the user changes cursor location.
augroup statusLineAutoUpdate
    autocmd!
    autocmd User CocStatusChange redrawstatus
augroup END

" Mappings for CoCList.
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ==============================================================================
" NERDTree config
" ==============================================================================

" After a re-source, fix syntax matching issues (concealing brackets in
" NERDTree). After sourcing instead of [icon] it will just be icon:
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
    " For some reason the previous line causes the search to highlight and
    " also focuses NERDTree if open so we need :nohl\<CR> to hide highlighting
    " and \<C-W>p to move to the previous window.
    " TODO: make sure NERDTree is focused before going back or implement more
    " intelligent function.
    call feedkeys(":nohl\<CR>\<C-W>p")
endif

nnoremap <F1> :NERDTreeToggle<CR>

" Close the tab if NERDTree is the only window remaining in it.
" The 'official' README auto close script is not working correctly. This is a
" fix as per
" https://github.com/preservim/nerdtree/issues/1411#issuecomment-1980628702
" github thread.
augroup nerdTreeAutoCloseOnExit
    autocmd!
    autocmd BufEnter * if winnr('$') == 1
                \ && exists('b:NERDTree')
                \ && b:NERDTree.isTabTree()
                \ | call feedkeys(":quit\<CR>:\<BS>") | endif
augroup END

" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
" NOTE: This is useful if e.g. `:e somefile` command is issued while the
" focus is on the NERDTree sidebar.
" TODO: this does not work as expected so commenting out for future.
"augroup nerdTreeBringBackOnReplace
"    autocmd!
"    autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"                \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"augroup END

" ==============================================================================
" Cloe all sidebars config
"
" Here goes a config to close all sidebar windows (like help, NERDTree,
" QuickFix, UndoTree, etc.). It creates closeAllSidebars augroup that handles
" closing everything considered a sidebar by the IsSideBar() function. If any
" new plugin is connected that opens sidebars, the type of the sidebar should
" be added to this function.
" The type can be obtained by the following command (assuming sidebar is
" currently opened and focused):
"
" >>> :echo getbufvar(bufnr('%'), '&filetype')
"
" * getbufnr('%') - retrieves current buffer number
" * '&filetype'   - describes the filetype buffer property that we need
" * getbufvar     - retreives property associated with a specified buffer
"
" (as per https://vi.stackexchange.com/a/40159 VI stackexchange comment)
"
" TODO: This yet again does not work as expected so commenting out for now
" (needs debugging).
" ==============================================================================

"function! IsSideBar(buf_nr)
"    " Returns 1 if the buffer is actual a side bar" - A terminal
"    " - The NERDTree side bar
"    " - The QuickFix window
"    " - The Help window
"    " - The UndoTree side bar
"    " - ...
"    let buf_name = bufname(a:buf_nr)
"    let buf_type = getbufvar(a:buf_nr, '&filetype')
"    let readonly = getbufvar(a:buf_nr, '&readonly')
"
"    let term_buffers = term_list()
"
"    if readonly
"        return 1
"
"    elseif buf_type ==# 'qf'
"        " QuickFix, LocationList:
"        " Not Read Only
"        return 1
"
"    elseif buf_type ==# 'help'
"        " Read Only
"        " Help Window:
"        return 1
"
"    elseif buf_type ==# 'undotree'
"        " Not Read Only
"        return 1
"
"    elseif buf_type ==# 'nerdtree'
"        " Read Only
"        return 1
"
"    elseif index(term_buffers, a:buf_nr) >= 0
"        return 1
"
"    else
"        return 0
"
"    endif
"endfunction
"
"" Returns the number of window that are not side bars
"function! GetNumWindows()
"    let num_windows = 0
"
"    for win_nr in range(1, winnr('$'))
"        let buf_nr = winbufnr(win_nr)
"
"        if IsSideBar(buf_nr)
"            continue
"        endif
"
"        let num_windows = num_windows + 1
"    endfor
"
"    return num_windows
"endfunction
"
"function! KillSideBars()
"    let num_windows = GetNumWindows()
"    if num_windows > 0
"        " If there are some non side bar windows do nothing:
"        return
"    endif
"
"    " Delete the terminal buffers that don't correspond to a window
"    let term_buffers = term_list()
"    for buf_nr in term_buffers
"        if len(win_findbuf(buf_nr)) == 0
"            " Exit terminal not associated to a window
"            execute 'bd! ' . buf_nr
"        endif
"    endfor
"
"    let term_buffers = term_list()
"    let buf_nr = bufnr('%')
"    if index(term_buffers, buf_nr) >= 0
"        " Kill the terminal buffer and quit
"        call feedkeys("\<C-w>:bd!\<CR>:quit\<CR>:\<BS>")
"    else
"        " Kill the side bar window
"        call feedkeys(":quit\<CR>:\<BS>")
"    endif
"endfunction
"
"augroup closeAllSidebars
"    autocmd!
"    autocmd BufEnter * call KillSideBars()
"augroup END

" ==============================================================================
" fzf configuration
" ==============================================================================

let g:fzf_vim = {
            \ 'preview_window': ['hidden,right,50%,<70(up,40%)', 'ctrl-/'],
            \ 'buffers_jump': 1
            \ }

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" Namespace for fzf.vim exported commands to prevent potential clashes with
" other plugins.
let g:fzf_command_prefix = 'Fzf'

" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles!<CR>
nnoremap <silent> <C-p> :FzfHistory<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>` :FzfMarks<CR>
nnoremap <silent> <leader>l :FzfBLines<CR>

" ==============================================================================
" vim-gitgutter config
" ==============================================================================

let g:gitgutter_sign_added                   = ''
let g:gitgutter_sign_modified                = ''
let g:gitgutter_sign_removed                 = ''
let g:gitgutter_sign_removed_first_line      = ''
let g:gitgutter_sign_removed_above_and_below = '󰹹'
let g:gitgutter_sign_modified_removed        = ''

" ==============================================================================
" vim-gitgutter config
" ==============================================================================

let g:magit_refresh_gitgutter = 1
nnoremap <silent><nowait> <leader>s :GitGutterToggle<CR>

" ==============================================================================
" mbbill/undotree config
" ==============================================================================

nnoremap <F5> :UndotreeToggle<CR>

