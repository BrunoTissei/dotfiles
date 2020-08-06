" ================================== Vim-Plug ==================================

" Insert Vim-plug plugins here:
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()


" =============================== Behavior Stuff ===============================

" Set mouse behavior to work with tmux
set mouse=a

" Sets how many lines of history VIM has to remember
set history=200

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Move to next line when pressing left on the last character
set whichwrap+=<,>,h,l

" Don't redraw while executing macros
set lazyredraw

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Turn backup off
set nobackup
set nowb
set noswapfile

" Reduce delays
set updatetime=50

" Ignore case when searching for pattern in text
set ignorecase

" Return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


" ================================= Shortcuts ==================================

" Set leader to ','
let mapleader = ","

" Disable highlight with ,<Ctrl+M>
noremap <silent> <leader><C-m> :noh<cr>

" Removes trailing spaces with F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:noh<Bar><cr>

" Reload init.vim configuration file
nnoremap <Leader>vr :source $MYVIMRC<cr>

" Save file with ,w
nnoremap <leader>w :w<cr>

" [fzf.vim] ,o to search files recursively in current directory
nnoremap <leader>f :Files .<cr>

" [fzf.vim] ,b to open buffers menu
nnoremap <leader>b :Buffers<cr>

" [fzf.vim] ,s to search for lines in current buffer
nnoremap <leader>s :BLines<cr>

" [fzf.vim] ,g to ripgrep over all files in current directory
nnoremap <leader>g :Rg<cr>

" [fzf.vim] ,c to for current buffer tags
nnoremap <leader>c :BTags<cr>

" [fzf.vim] ,C to for current dir (recursively) tags
nnoremap <leader>C :Tags<cr>

" [fzf.vim] ,O to search in $COMPETITIVE directory only
nnoremap <leader>O :Files $COMPETITIVE<cr>

" [nerdtree] Toggle NerdTree with ',ne'
nnoremap <leader>ne :NERDTreeToggle<cr>

" Toggle Number with ',ne'
nnoremap <leader>e :call NumberToggle()<cr>

" Map Ctrl+C to function call
vnoremap <silent> <C-C> y:call ClipboardYank()<cr>

" Single C++ file compile
map <F2> :call CompileNormal()<cr>
map <F3> :call CompileComplete()<cr>

" Easier movement beginning and end of line
map <M-a> ^
map <M-e> $

" W and Q do the same as w and q
cabb W w
cabb Q q

" ================================ Visual Stuff ================================

" Set colorscheme
set termguicolors
set background=dark
colorscheme deep-space

" Highlight matching brackets
set showmatch

" Stop weird behaviour of highlighting first bracket after typing the second
set mat=4

" Highlight search results
set hlsearch

" Display line numbers
set number

" Set number of columns in line number indicator
set nuw=5

" Height of the command bar
set cmdheight=1

" Remove tilde end_of_buffer
set fcs=eob:\


" ============================== Indenting Stuff ==============================

" Tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Indents
set autoindent
set smartindent
set cindent


" ================== Easier Movement Through Windows and Tabs ==================

" Move through windows with Ctrl + [j,k,h,l]
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move through windows with Ctrl + ArrowKeys
map <C-Down>  <C-W>j
map <C-Up>    <C-W>k
map <C-Left>  <C-W>h
map <C-Right> <C-W>l

" Move through tabs with [H,L]
nnoremap H gT
nnoremap L gt


" ============================= NERDTree [plugin] ==============================

" Set NERDTree size
let g:NERDTreeWinSize=45


" ============================= Deoplete [plugin] ==============================

let g:python3_host_prog = '/usr/bin/python3'

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Disable preview window
set completeopt-=preview


" ============================= Polyglot [plugin] ==============================

let g:polyglot_disabled = ['csv']


" ================================= Functions ==================================

" Toggles between number, nonumber and relative number
func! NumberToggle()
    if &relativenumber == 1
        set relativenumber!
        set invnumber
    elseif &number == 0
        set invnumber!
    else
        set relativenumber
    endif
endfunc

" The selected content is yank using xclip command
func! ClipboardYank()
    call system('xclip -i -selection clipboard', @@)
endfunc

" Simple compilation
func! CompileNormal()
    :w
    set makeprg=g++\ -DLOCAL\ -std=c++17\ -Wall\ -Wextra\ -g\ %
    :make
endfunc

" Slower compilation, but sanitized
func! CompileComplete()
    :w
    set makeprg=g++\ -DLOCAL\ -Wall\ -Wextra\ -pedantic\ -std=c++17\ -O2\
                \ -Wshadow\ -Wformat=2\ -Wfloat-equal\ -Wconversion\
                \ -Wlogical-op\ -Wshift-overflow=2\ -Wduplicated-cond\
                \ -Wcast-qual\ -Wcast-align\ -D_GLIBCXX_DEBUG\
                \ -D_GLIBCXX_DEBUG_PEDANTIC\ -D_FORTIFY_SOURCE=2\
                \ -fsanitize=address\ -fsanitize=undefined\
                \ -fno-sanitize-recover\ -fstack-protector\ -g\ %
    :make
endfunc

" Create centralized titles
func! MakeTitle()
    call inputsave()
    let comm = input('Enter comment symbol: ')
    let title = input('Enter title: ')
    let chars = input('Enter repeating character: ')
    call inputrestore()

    let title     = " " . title . " "
    let num_left  = (80 - len(comm) - 1 - len(title)) / 2
    let num_right = ((80 - len(comm) - 1 - len(title) - 1) / 2) + 1

    call setline('.',
                \ comm . " " .
                \ repeat(chars, num_left) .
                \ title .
                \ repeat(chars, num_right))
endfunc
