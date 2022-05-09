
filetype off

call pathogen#runtime_append_all_bundles()

nnoremap <leader>n :execute 'NERDTreeToggle ' . getcwd()<CR>

if has("syntax")
  syntax on
end

set background=dark
set number

colorscheme neon

map <C-H> <C-w>h
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-L> <C-w>l


nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

vmap <TAB> >gv
vmap <S-TAB> <gv

let g:bufExplorerShowRelativePath=1

set hidden
" ----------------------------------------------------------------------------
" Backups
" ----------------------------------------------------------------------------

set nobackup " do not keep backups after close
set nowritebackup " do not keep a backup while working
set noswapfile " don't keep swp files either

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

filetype plugin indent on

" override default detection of .md files as modula2
autocmd! filetypedetect BufNewFile,BufRead *.md setfiletype markdown

" custom filetypes
autocmd! filetypedetect BufNewFile,BufRead *.ejs setfiletype ejs

" Always start on first line when editing git commit messages
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------
set autoindent " automatic indent new lines
set smartindent " be smart about it
set shiftwidth=2
set tabstop=2
set expandtab
set pastetoggle=<F2>

" highlight trailing spaces and tabs
highlight TrailWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match TrailWhitespace /\s\+$\| \+\ze\t/
match TrailWhitespace /\s\+$/
autocmd BufWinEnter * match TrailWhitespace /\s\+$/
autocmd InsertEnter * match TrailWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Strip whitespace by file type
autocmd FileType c,cpp,erb,go,html,js,json,java,php,py,ruby,sh autocmd BufWritePre <buffer> :%s/\s\+$//e

" -----------------------------------------------------------------------------
"  Syntastic
" -----------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" -----------------------------------------------------------------------------
"  Nerdtree
" -----------------------------------------------------------------------------
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = '[RO]'
let g:NERDTreeNodeDelimiter = "\u00a0"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                       " buffer number
set statusline+=%f\                           " filename
set statusline+=%h%m%r%w                      " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]  " file type
set statusline+=%=                            " right align remainder
set statusline+=0x%-8B                        " character value
set statusline+=%-14(%l,%c%V%)                " line, character
set statusline+=%<%P                          " file position

" Autocomplete highlighting (for dark term e.g terminator)
highlight PmenuSel ctermfg=black ctermbg=grey

" Visual highlighting
highlight Visual ctermfg=White ctermbg=LightBlue

" CtrlP Ctags support
nnoremap <leader>. :CtrlPTag<cr>
" CtrlP settings
let g:ctrlp_max_files=10000
let g:ctrlp_custom_ignore = '\v[\/](coverage|log|node_modules|tmp)|(\.(swp|ico|git|gif|png|jpg))$'

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
set runtimepath^=~/.vim/bundle/ctrlp.vim
filetype plugin indent on
