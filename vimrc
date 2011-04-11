" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled=[]

if !has('ruby')
  call add(g:pathogen_disabled, 'command-t')
endif

if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
endif

filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set nocompatible " don't behave like vi

" Let me switch buffers w/o saving
set hidden

" Colors!
syntax enable
set background=dark
colorscheme solarized

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Default tab settings, spaces not tabs, 2 spaces (overidden with autocmd)
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Make command line two lines high
set ch=2

" Always display the status line
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Speed up redraws
set ttyfast

" Keep at least 3 lines above/below, left/right cursor
set scrolloff=3 sidescroll=3

" Increase command history
set history=200

" Use forward slashes in file paths, even in Windows
set shellslash

" Show which mode we're in (insert, visual, etc.)
set showmode

" Enable enhanced command-line completion.
if has("wildmenu")
  set wildmenu
  set wildmode=list:longest
endif

" Prepended to beginning of wrapped lines
set showbreak=↪

if v:version >= 703
  " Show relative line numbers
  set relativenumber
  " Display a column marker at the column
  set colorcolumn=85
else
  " Show absolute line numbers
  set number
endif


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Character encoding
set encoding=utf-8

" Be quiet!
set visualbell
set noerrorbells

" This makes it easy to see which line we're on
set cursorline

" Allow backspace anywhere
set backspace=indent,eol,start



" searching
set ignorecase  " ignore case during search...
set smartcase   " except if we specify upper case chars
set incsearch   " incrementally search
set hlsearch    " highlight search term
set showmatch   " show matching bracket
set gdefault    " apply substitutions globally on lines (/g)

"
" Key Mappings
"
" \ is the default leader character, comma is easier
let mapleader = ","

" use perl/python regex expressions
nnoremap / /\v
vnoremap / /\v

" Rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Display current tab settings
nmap <C-S-Tab> :call Stab()<CR><CR>

" make it easier to switch windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" open files in the same directory as the current
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

" text bubbling, requires unimpaired plugin
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" emacs style jump to end of line
imap <C-e> <C-o>A
imap <C-a> <C-o>I

" paste mode disables formatting during a paste operation
set pastetoggle=<F2>

" clear highlight search results
nnoremap <leader><space> :noh<CR>

" tab is easier to jump between matching bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" movement by screen lines, not file lines
nnoremap k gk
nnoremap j gj
" allow for previous k/j behavior
nnoremap gk k
nnoremap gj j

" force me to not use arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" no more accidental help!
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" shortcut for :
nnoremap ; :

" Strip all whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Ack shortcut
nnoremap <leader>a :Ack

" quicker escaping
inoremap jj <ESC>

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

"
" Plugin settings
"

" netrw
let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split

"
" Autocommands
"
if has("autocmd")
  " Enable file type detection, along with language-dependent indenting
  filetype plugin indent on
endif " has("autocmd")


"
" Functions
"

" Enable soft word wrap (not compatible with 'set list')
command! -nargs=* Wrap set wrap linebreak nolist

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction
