set nocompatible              " be iMproved, required
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
" filetype off                  " required

let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set hidden
set laststatus=2
let g:airline_powerline_fonts = 1
set nowrap        " don't wrap lines
set tabstop=2 shiftwidth=2 expandtab
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" set cursorline
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
 				  " case-sensitive otherwise

set smarttab      " insert tabs on the start of a line according to
                  " shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

filetype plugin indent on

if &t_Co >= 256 || has("gui_running")
  colorscheme flattr
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

" set list
" set listchars=tab:..,trail:.,extends:#,nbsp:.
"In some files, like HTML and XML files, tabs are fine and showing them is
"really annoying, you can disable them easily using an autocmd declaration:
" autocmd filetype html,xml set listchars-=tab:..

" Rspec
let g:rspec_command = "spec {spec}"

" Unite
let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
" nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>f :Unite grep:.<cr>
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".bundle" --ignore "tmp" --ignore ".git" --ignore ".bzr" -g ""'
endif

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" NERDTree
noremap <Leader>n :NERDTreeToggle<cr>

set pastetoggle=<leader>P
set mouse=a
" Buffer Bye
:nnoremap <Leader>q :Bdelete<CR>
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" VimRubySupport
autocmd FileType ruby compiler ruby

map <leader>bk <Esc>:bd!<cr>
map <leader>w <Esc>:w!<cr>
noremap <leader>wq :q<CR>
inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>v

" Window splitting

nmap <silent> <leader>sh :leftabove vnew<cr>
nmap <silent> <leader>sl :rightbelow vnew<cr>
nmap <silent> <leader>sk :leftabove new<cr>
nmap <silent> <leader>sj :rightbelow new<cr>
nmap <silent> <leader>swh :topleft vnew<cr>
nmap <silent> <leader>swl :botright vnew<cr>
nmap <silent> <leader>swk :topleft new<cr>
nmap <silent> <leader>swj :botright new<cr>

" Scroll the window next to the current one
" "   (especially useful for two-window split)
nmap <silent> <leader>j <c-w>w<c-d><c-w>W
nmap <silent> <leader>k <c-w>w<c-u><c-w>W

" Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”? Use
" this:
nmap <silent> ,/ :nohlsearch<CR>

"This lets you use w!! to save a read-only file after you opened the file:
cmap w!! w !sudo tee % >/dev/null

" Move lines up and down
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


"Rspec config
map <Leader><Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
" Automatic formatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e

let g:rspec_command = "Dispatch spec {spec}"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'bling/vim-airline'
Bundle 'nanotech/jellybeans.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'thoughtbot/vim-rspec'
Bundle 'cseelus/vim-colors-clearance' 
Bundle 'vim-scripts/twilight256.vim'
Bundle 'farseer90718/flattr.vim'
Bundle 'moll/vim-bbye'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'altercation/vim-colors-solarized'
" The following are examples of different formats supported.
" Keep Bundle commands between vundle#begin/end.
" plugin on GitHub repo
Bundle 'Shougo/unite.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
call unite#filters#matcher_default#use(['matcher_fuzzy'])
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
