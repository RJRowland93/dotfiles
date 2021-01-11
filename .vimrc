syntax on

set hidden
set belloff=all
" Set + register for copy/paste
set clipboard=unnamedplus
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set rnu
" set nowrap
set wrap linebreak nolist
set ignorecase
set smartcase
set incsearch
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set splitbelow
set splitright
set splitbelow
set splitright
set lisp
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

if empty(glob('~/.vim/autoload/plug.vim'))
 silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'freitass/todo.txt-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-utils/vim-man'
" Plug 'lyuts/vim-rtags'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
" Plug 'tpope/vim-surround'

" Code evaluation
" Plug 'metakirby5/codi.vim'
" Plug 'kovisoft/slimv'

" Clojure
" Plug 'tpope/vim-salve'
" Plug 'tpope/vim-projectionist'
" Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-fireplace'
" Plug 'guns/vim-clojure-static'
" Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}

" Lisp
Plug 'kien/rainbow_parentheses.vim'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
let maplocalleader = ","
let g:netrw_banner = 0
let g:tmux_navigator_no_mappings = 1
let g:lisp_rainbow = 1
"horizontal repl
"let g:slimv_repl_split = 2
"vertical repl
let g:slimv_repl_split = 4
let g:slimv_clhs_root = 'file:///usr/local/doc/Hyperspec/Data'
let g:iced_enable_default_key_mappings = v:true

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -nargs=1 NewZettel :execute ":e" $NOTES_DIR . strftime("%Y%m%d%H%M") . "-<args>.md"
command! NewJournal :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-journal.md"
command! NewDecision :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-decision.md"
command! NewPrediction :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-prediction.md"
command! NewWeeklyReview :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-weekly-review.md"
command! NewDevLog :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-dev-log.md"
command! NewWorkout :execute ":e" $JOURNAL_DIR . strftime("%Y%m%d") . "-workout.md"
nnoremap <leader>ni :e $NOTES_DIR/index.md<CR>:cd $NOTES_DIR<CR>
nnoremap <leader>ji :e $JOURNAL_DIR/index.md<CR>:cd $JOURNAL_DIR<CR>
nnoremap <leader>nz :NewZettel
nnoremap <leader>nj :NewJournal<CR>
nnoremap <leader>nd :NewDecision<CR>
nnoremap <leader>np :NewPrediction<CR>
nnoremap <leader>nr :NewWeeklyReview<CR>
nnoremap <leader>nl :NewDevLog<CR>
nnoremap <leader>nw :NewWorkout<CR>

inoremap jj <esc>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
" nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :Find<SPACE>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" fun! GoCoc()
"     inoremap <buffer> <silent><expr> <TAB>
"                 \ pumvisible() ? "\<C-n>" :
"                 \ <SID>check_back_space() ? "\<TAB>" :
"                 \ coc#refresh()
"
"     inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"     inoremap <buffer> <silent><expr> <C-space> coc#refresh()
"
"     " GoTo code navigation.
"     nmap <buffer> <leader>gd <Plug>(coc-definition)
"     nmap <buffer> <leader>gy <Plug>(coc-type-definition)
"     nmap <buffer> <leader>gi <Plug>(coc-implementation)
"     nmap <buffer> <leader>gr <Plug>(coc-references)
"     nnoremap <buffer> <leader>cr :CocRestart
" endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
" autocmd FileType typescript :call GoYCM()
" autocmd FileType cpp,cxx,h,hpp,c :call GoCoc()

