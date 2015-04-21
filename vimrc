" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    " Nice to have
    set backspace=indent,eol,start
    command! -bar -nargs=* Rc e $MYVIMRC
    command! -bar -nargs=* Rl :source $MYVIMRC
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'roman/golden-ratio'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'fatih/vim-go'
NeoBundle 'scrooloose/syntastic' " Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_elixir_checkers = ['elixir']
" }}} Syntastic
NeoBundle 'Shougo/vimproc.vim', { 'build' : {
            \   'windows' : 'mingw32-make -f make_mingw32.mak',
            \   'cygwin'  : 'make -f make_cygwin.mak',
            \   'mac'     : 'make -f make_mac.mak',
            \   'unix'    : 'make -f make_unix.mak',
            \ }}
NeoBundle 'Shougo/unite.vim', { 'depends' : [ 'Shougo/vimproc.vim' ] } " Unite {{{
if executable ('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -a'
    let g:unite_source_grep_recursive_opt=''
endif
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_file_rec_max_cache_files=5000
let g:unite_enable_start_insert = 1
let g:unite_prompt='» '
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nmap <space> [unite]
nnoremap [unite] <nop>
nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<cr>
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=lines line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=processes process<cr>
nnoremap <silent> [unite]n :<C-u>Unite file file/new<cr>
nnoremap <slinet> [unite]m :<C-u>Unite -buffer-name=mapping mapping<cr>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]? :<C-u>execute 'Unite -buffer-name=search grep:.::' . expand("<cword>")<cr>
" Fugitive on [unite]
nnoremap [unite]ga :Git add %:p<CR><CR>
nnoremap [unite]gs :Gstatus<CR>
nnoremap [unite]gc :Gcommit -v -q<CR>
nnoremap [unite]gt :Gcommit -v -q %:p<CR>
nnoremap [unite]gd :Gdiff<CR>
nnoremap [unite]ge :Gedit<CR>
nnoremap [unite]gr :Gread<CR>
nnoremap [unite]gw :Gwrite<CR><CR>
nnoremap [unite]gl :silent! Glog<CR>:bot copen<CR>
nnoremap [unite]gp :Ggrep<Space>
nnoremap [unite]gm :Gmove<Space>
nnoremap [unite]gb :Git branch<Space>
nnoremap [unite]go :Git checkout<Space>
nnoremap [unite]gps :Dispatch! git push<CR>
nnoremap [unite]gpl :Dispatch! git pull<CR>
nnoremap [unite]s <C-W><C-W>
" }}} Unite
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim', { 'depends' : [ 'Shougo/unite.vim' ] } " {{{
let g:vimfiler_as_default_explorer = 1
nnoremap <silent> [unite]e :<C-u>VimFiler<cr>
" }}} VimFiler
NeoBundle 'Shougo/unite-ssh', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet' " NeoSnippet {{{
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" }}} NeoSnippet

NeoBundle 'Shougo/unite-outline' " Unite outline {{{
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<cr>
" }}} Unite outline

NeoBundle 'Shougo/unite-help' " Unite help {{{
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]H :<C-u>UniteWithCursorWord -buffer-name=help help<CR>
" }}} Unite help

NeoBundle 'thinca/vim-unite-history' " Unite history {{{
let g:unite_source_history_yank_enable=1
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yank history/yank<cr>
" }}} Unite history
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundleFetch 'Shougo/unite.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'noahfrederick/vim-hemisu'
NeoBundle 'vim-scripts/DeleteTrailingWhitespace'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'mattreduce/vim-mix'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline' " AirLine {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='powerlineish'
" }}}
NeoBundle 'troydm/pb.vim'
NeoBundle 'vim-scripts/ZoomWin' " ZoomWin {{{
map <leader>z <Plug>ZoomWin
" }}}
NeoBundle 'vim-scripts/kickAssembler-syntax'
" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

call unite#custom#source('file,file/new,buffer,file_rec',
            \ 'matchers', 'matcher_fuzzy')
call unite#custom#source('buffer,file,file_rec',
            \ 'sorters', 'sorter_rank')
syntax enable
set term=screen-256color
set t_Co=256
set background=dark
colorscheme hemisu
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L
" Disable the macvim toolbar
set guioptions-=T
set guifont=Anonymous\ Pro:h18

" Tabs & Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set laststatus=2

" Search
set gdefault
set incsearch
set hlsearch
set ignorecase
set smartcase

" Encoding
set encoding=utf-8
set fileformats=unix

" Backup & Swap
set nobackup
set nowritebackup
set noswapfile

" Text wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" No folding by default
set nofoldenable
augroup FileTypes
    au!
    au FileType ruby    setlocal shiftwidth=2 tabstop=2
    au FileType snippet setlocal shiftwidth=4 tabstop=4
    au FileType snippet setlocal shiftwidth=4 tabstop=4
    au FileType elixir  setlocal shiftwidth=2 tabstop=2
    au FileType erlang  setlocal shiftwidth=4 tabstop=4
    au FileType make    setlocal noexpandtab shiftwidth=4 tabstop=4
    au FileType snippet setlocal expandtab shiftwidth=4 tabstop=4
    au BufNewFile,BufRead *.app.src set filetype=erlang
    au BufNewFile,BufRead *.config  set filetype=erlang
    au BufNewFile,BufRead *.asm set filetype=kickass
    au BufNewFile,BufRead *.s set filetype=kickass
augroup END

augroup TrailingWhitespace
    au!
    au BufWritePre * :DeleteTrailingWhitespace
augroup END

" Handle mouse {{{
if has('mouse')
    set mouse=a
    if &term =~ "xterm" || &term =~ "screen"
        autocmd VimEnter *    set ttymouse=xterm2
        autocmd FocusGained * set ttymouse=xterm2
        autocmd BufEnter *    set ttymouse=xterm2
    endif
endif
" }}}

" Handle cursor shape {{{
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

function! CheatSheet()
    sp | e ~/.vim/cheat-sheet.txt
endfunction
au BufNewFile,BufRead cheat-sheet set filetype=help

" Bindings
nno ; :
" Jump anywhere
nno <leader>j :call EasyMotion#S(1,1,2)<cr>
" Vertical split
nno <leader>v <C-W>v
" Horizontal split
nno <leader>s <C-W>s
" Cycle over panes
nno <tab> <C-W><C-W>
" Close current pane
nno <leader>x <C-W>c
" Close buffer
nno <leader>X :bd<CR>
" Copy to Clipboard
vno <leader>y :Pbyank<CR>
" Pase from Clipboard
nno <leader>p :Pbpaste<CR>
" Reset search
nno <CR> :nohlsearch<CR><CR>
" Reformat code
nno <leader>f gg=G``
" Toggle fullscreen
nno <leader>F :set invfu<CR>
" Edit self
nno <leader>rc :Rc<cr>
" Reload self
nno <leader>rl :Rl<cr>
" Explorer
nno <leader>n :VimFilerExplorer<cr>
" Cheat sheet
nno <leader>c :call CheatSheet()<cr>
" Move line left
nno < <<
nmap < <<
" Move line right
nno > >>
nmap > >>
" Move selection left
vmap < <gv
" Move selection right
vmap > >gv
" Better search
nno / /\V
vno / /\V
