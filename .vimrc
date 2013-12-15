" Cp is never ok
set nocp 
" Needed for vundle 
filetype off 

" Plugin handling

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Encoding utf-8
set enc=utf-8
" Installed bundles 
Plugin 'gmarik/Vundle.vim'
Plugin 'Shougo/vimproc' 
Plugin '256-jungle'
Plugin 'ManPageView'
Plugin 'scrooloose/syntastic'
Plugin 'adrian.vim'
Plugin 'ansi_blows.vim'
Plugin 'colorful256.vim'
Plugin 'neocomplcache'
Plugin 'nightshade.vim'
Plugin 'surround.vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'rubycomplete.vim'
Plugin 'ruby.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'derekwyatt/vim-scala'
Plugin 'phleet/vim-mercenary'
Plugin 'nvie/vim-flake8'
Plugin 'EasyMotion'
Plugin 'ctrlp.vim'
Plugin 'Cpp11-Syntax-Support'
Plugin 'ack.vim'
Plugin 'AsyncCommand'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'Solarized'
Plugin 'flazz/vim-colorschemes'
Plugin 'Gundo'
Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'
Plugin 'sudo.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'Puppet-Syntax-Highlighting'
Plugin 'tComment'  
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'

call vundle#end()

" Remapped leader key to something I can actually type 
let mapleader=","

" Latest colorscheme
"elflord 
"dante 
colorscheme peppers 


let hs_highlight_types = 1

" Pastebin installer

let g:pastebin_emailid="e.klerks@i-bytes.nl"
let g:pastebin_language="haskell"
let g:ctrlp_regexp = 1

let g:easytags_include_members=0

" Activate filetypes again 
filetype plugin indent on

" Mapped commands 
map <C-g><C-l> :GhciRange<CR>
vmap <C-g><C-l> :GhciRange<CR>
nmap <C-g><C-f> :GhciFile<CR>
map <C-g><C-r> :GhciReload<CR>
map <C-g><C-t> :GhcModType<CR>
map <C-g><C-i> :GhcModTypeInsert<CR>
map <C-g>c :GhcModTypeClear<CR>
map <C-n><C-t> :NERDTreeToggle<CR>
map <C-n><C-f> :NERDTreeFind<CR>
map <C-c><C-p> :e ~/sanoma/content-library/src<CR> 
nnoremap <silent> <F9> :TagbarToggle<CR> 
map <C-s><C-c> :setlocal spell spelllang=en_us<CR> 
map <C-s><C-s> :setlocal spell spelllang=<CR> 
nnoremap <F5> :GundoToggle<CR>

" CtrlP mapping 
let g:ctrlp_map = '<c-p>'
let g:ctrl_cmd='CtrlP'


" Option neocomplcaches
" let g:acp_enableAtStartup = 1
" let g:neocomplcache_enable_at_startup = 1
" let g:neocomplcache_omni_patterns = {}
" let g:neocomplcache_ctags_program = "/usr/bin/ctags"
" let g:neocomplcache_ctags_arguments_list = {'c' : "-R", 'c++' : "-R"}
" let g:neocomplcache_enable_smart_case= 1
" let g:neocomplcache_enable_quick_match = 1
" let g:neocomplcache_enable_smart_case = 1
" let g:neocomplcache_include_paths = {'c' : "/usr/local/include/;/usr/include", 'c++' : '/home/eklerks/genode-13.11/base/include;/home/eklerks/genode-13.11/silence/src/;/home/eklerks/genode-13.11/silence/include/;/home/eklerks/genode-13.11/libports/include/stdcxx/'}
" let g:neocomplcache_enable_caching_message = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completion = 1
" let g:neocomplcache_enable_wildcard = 1 
" let g:neocomplcache_enable_fuzzy_completion = 1
" let g:neocomplcache_enable_cursor_hold_i = 1
" let g:neocomplcache_auto_completion_start_length = 2
" let g:neocomplcache_enable_auto_select = 1 
" 
" Activate syntax highlighting 
syntax on

" Handy leader mappings  
inoremap <Leader>io liftIO 
inoremap <Leader>pr liftIO $ print 
nnoremap <Leader>. :CtrlPTag<cr>


if has('gui_running')
    set guifont=Terminus\ Bold\ 14
endif

" Haskell specific 
let g:jmacro_conceal = 0
let g:hpaste_author = 'eklerks'
let g:haskell_conceal = 0

" Change grep program (obsolete since ack plugin)
set grepprg=ack\ --color-lineno=RED


let g:prevline = &statusline

" File specific stuff 
autocmd BufEnter *.groff setlocal filetype=groff
autocmd BufEnter *.zsh setlocal filetype=zsh
autocmd BufEnter ~/scripts/* setlocal filetype=zsh 
autocmd BufEnter *.pl setlocal filetype=perl 
autocmd BufEnter * set relativenumber
autocmd BufEnter *.hs setlocal filetype=haskell

autocmd BufEnter ~/scripts/systemtap/* setlocal filetype=stp


" Setting the undodir for saving the undo tree  

set undofile
set undodir =~/.undodir/
set undolevels=1000

" Setting vim info 

set viminfo="'200,<100,%,''20,/100,:100,@100,f1,s30"
nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>:so ~/sessions/

" Set easy tags directory 

" let g:easytags_by_filetype="/home/eklerks/.vim/easytags"
" let g:easytags_events = ['BufWritePost']


set lazyredraw
map <C-t><C-o> <ESC>:ConqueTermTab zsh<CR>
map tb <ESC>:tabprevious<CR>
map tn <ESC>:tabnext<CR>

" Change vim directory 
set autochdir
set autoindent
" Map backspace 
set backspace=eol,indent,start
" Case, tab and indent. 
set smartcase 
set smartindent 
set smarttab 
" Search options (highlight and incremental)
set hlsearch
set incsearch
" Status amounts
set laststatus=2
set linespace=0
set listchars=tab:>-,trail:-
set matchtime=5
" Enable mouse for terminals
set mouse=a
" Disable annoying stuff 
set noerrorbells
set nostartofline
set novisualbell
" Minimal 5 columns for numbering 
set number
set numberwidth=5
" Relative numbering And ruler  
set relativenumber
set ruler
" Number of lines above us if we scroll
set scrolloff=10
" Abbreviate annoying messages 
set shortmess=aOstT
" Show some more 
set showcmd
set showmatch
set sidescrolloff=10
" Tab configuration
set softtabstop=4
set tabstop=2
set expandtab
" Custom status line 
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
" Activate command line completion
set wildmenu
set wildmode=list:longest
set wildoptions="df"
" Show line break
set showbreak ="+++ "

" Tex specific stuff
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf="evince"

" Small snippet for tag completion 
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" Easy completion  ,, cannot type ,, easily know, but that is never needed 
" except for python, which is a retarded language any way. 
inoremap <Leader>, <c-r>=Smart_TabComplete()<cr>


" Local definitions 

" autocmd BufEnter,BufWritePost ~/sources/genode-13.11/silence/* set tags=/home/eklerks/sources/genode-13.11/silence/tags
autocmd BufEnter,BufWritePost ~/sources/genode-13.11/silence/* let g:easytags_cmd="~/sources/genode-13.11/silence/build-tags.sh" 
autocmd BufEnter,BufWritePost ~/sources/genode-13.11/silence/* let g:easytags_file="/home/eklerks/.globaltags"

autocmd BufEnter,BufWritePost ~/sources/genode-13.11/silence/* set tags=/home/eklerks/sources/genode-13.11/silence/tags,~/.globaltags

autocmd BufEnter,BufWritePost ~/sources/genode-13.11/silence/* let g:easytags_dynamic_files = 1
" autocmd BufEnter,BufWritePost *.h, *.hpp, *.cpp, *.cc :NeoComplCacheDisable<cr> 

let g:clang_user_options = '-std=c++11'
let g:clang_library_path="/usr/lib/llvm-3.4/lib"
set completeopt=menu,menuone,longest
