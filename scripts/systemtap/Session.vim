let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <Plug>(neocomplcache_start_omni_complete) 
inoremap <silent> <Plug>(neocomplcache_start_auto_complete_no_select) 
inoremap <silent> <Plug>(neocomplcache_start_auto_complete) =neocomplcache#mappings#popup_post()
inoremap <silent> <expr> <Plug>(neocomplcache_start_unite_quick_match) unite#sources#neocomplcache#start_quick_match()
inoremap <silent> <expr> <Plug>(neocomplcache_start_unite_complete) unite#sources#neocomplcache#start_complete()
imap <silent> <Plug>IMAP_JumpBack =IMAP_Jumpfunc('b', 0)
imap <silent> <Plug>IMAP_JumpForward =IMAP_Jumpfunc('', 0)
map! <S-Insert> <MiddleMouse>
map  :e ~/sanoma/content-library/src 
map c :GhcModTypeClear
map 	 :GhcModTypeInsert
map  :GhcModType
map  :GhciReload
nmap  :GhciFile
vmap  :GhciRange
nmap  :GhciRange
omap  :GhciRange
vmap <NL> <Plug>IMAP_JumpForward
nmap <NL> <Plug>IMAP_JumpForward
map  :NERDTreeFind
map  :NERDTreeToggle
nnoremap <silent>  :CtrlP
map  :setlocal spell spelllang= 
map  :setlocal spell spelllang=en_us 
map  :ConqueTermTab zsh
nmap ; " 
xmap S <Plug>VSurround
nmap <silent> \ups :call Perl_RemoveGuiMenus()
nmap <silent> \lps :call Perl_CreateGuiMenus()
vnoremap <silent> \\w :call EasyMotion#WB(1, 0)
onoremap <silent> \\w :call EasyMotion#WB(0, 0)
nnoremap <silent> \\w :call EasyMotion#WB(0, 0)
vnoremap <silent> \\t :call EasyMotion#T(1, 0)
onoremap <silent> \\t :call EasyMotion#T(0, 0)
nnoremap <silent> \\t :call EasyMotion#T(0, 0)
vnoremap <silent> \\n :call EasyMotion#Search(1, 0)
onoremap <silent> \\n :call EasyMotion#Search(0, 0)
nnoremap <silent> \\n :call EasyMotion#Search(0, 0)
vnoremap <silent> \\k :call EasyMotion#JK(1, 1)
onoremap <silent> \\k :call EasyMotion#JK(0, 1)
nnoremap <silent> \\k :call EasyMotion#JK(0, 1)
vnoremap <silent> \\j :call EasyMotion#JK(1, 0)
onoremap <silent> \\j :call EasyMotion#JK(0, 0)
nnoremap <silent> \\j :call EasyMotion#JK(0, 0)
vnoremap <silent> \\gE :call EasyMotion#EW(1, 1)
onoremap <silent> \\gE :call EasyMotion#EW(0, 1)
nnoremap <silent> \\gE :call EasyMotion#EW(0, 1)
vnoremap <silent> \\f :call EasyMotion#F(1, 0)
onoremap <silent> \\f :call EasyMotion#F(0, 0)
nnoremap <silent> \\f :call EasyMotion#F(0, 0)
vnoremap <silent> \\e :call EasyMotion#E(1, 0)
onoremap <silent> \\e :call EasyMotion#E(0, 0)
nnoremap <silent> \\e :call EasyMotion#E(0, 0)
vnoremap <silent> \\b :call EasyMotion#WB(1, 1)
onoremap <silent> \\b :call EasyMotion#WB(0, 1)
nnoremap <silent> \\b :call EasyMotion#WB(0, 1)
vnoremap <silent> \\W :call EasyMotion#WBW(1, 0)
onoremap <silent> \\W :call EasyMotion#WBW(0, 0)
nnoremap <silent> \\W :call EasyMotion#WBW(0, 0)
vnoremap <silent> \\T :call EasyMotion#T(1, 1)
onoremap <silent> \\T :call EasyMotion#T(0, 1)
nnoremap <silent> \\T :call EasyMotion#T(0, 1)
vnoremap <silent> \\N :call EasyMotion#Search(1, 1)
onoremap <silent> \\N :call EasyMotion#Search(0, 1)
nnoremap <silent> \\N :call EasyMotion#Search(0, 1)
vnoremap <silent> \\ge :call EasyMotion#E(1, 1)
onoremap <silent> \\ge :call EasyMotion#E(0, 1)
nnoremap <silent> \\ge :call EasyMotion#E(0, 1)
vnoremap <silent> \\F :call EasyMotion#F(1, 1)
onoremap <silent> \\F :call EasyMotion#F(0, 1)
nnoremap <silent> \\F :call EasyMotion#F(0, 1)
vnoremap <silent> \\E :call EasyMotion#EW(1, 0)
onoremap <silent> \\E :call EasyMotion#EW(0, 0)
nnoremap <silent> \\E :call EasyMotion#EW(0, 0)
vnoremap <silent> \\B :call EasyMotion#WBW(1, 1)
onoremap <silent> \\B :call EasyMotion#WBW(0, 1)
nnoremap <silent> \\B :call EasyMotion#WBW(0, 1)
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
onoremap <silent> io :normal vio
vmap <silent> io <Plug>InnerOffside
vmap sd :call SqlTable(@*)
vmap st :call SqlType(@*)
vmap sh :call SqlHelp(@*)
map tn :tabnext
map tb :tabprevious
map td :call ToDatabase()
map tp :call SqlHelp("")
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
vmap <silent> <Plug>IMAP_JumpBack `<i=IMAP_Jumpfunc('b', 0)
vmap <silent> <Plug>IMAP_JumpForward i=IMAP_Jumpfunc('', 0)
vmap <silent> <Plug>IMAP_DeleteAndJumpBack "_<Del>i=IMAP_Jumpfunc('b', 0)
vmap <silent> <Plug>IMAP_DeleteAndJumpForward "_<Del>i=IMAP_Jumpfunc('', 0)
nmap <silent> <Plug>IMAP_JumpBack i=IMAP_Jumpfunc('b', 0)
nmap <silent> <Plug>IMAP_JumpForward i=IMAP_Jumpfunc('', 0)
nnoremap <silent> <Plug>SurroundRepeat .
nmap <F2> :wa|exe "mksession! " . v:this_session:so ~/sessions/
nnoremap <F5> :GundoToggle
nnoremap <silent> <F9> :TagbarToggle 
nnoremap <silent> <F8> :TlistToggle
map <S-Insert> <MiddleMouse>
imap S <Plug>ISurround
imap s <Plug>Isurround
imap <NL> <Plug>IMAP_JumpForward
imap  <Plug>Isurround
nmap Ç :AsyncCscopeFindSymbol =expand('<cword>')
inoremap \pr liftIO $ print 
inoremap \io liftIO 
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set autoindent
set background=dark
set backspace=eol,indent,start
set completefunc=neocomplcache#complete#manual_complete
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set grepprg=ack\ --color-lineno=RED
set guifont=Terminus\ Bold\ 14
set helplang=en
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:>-,trail:-
set mouse=a
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim/bundle/vimproc,~/.vim/bundle/vim2hs,~/.vim/bundle/ghcmod-vim,~/.vim/bundle/256-jungle,~/.vim/bundle/ManPageView,~/.vim/bundle/syntastic,~/.vim/bundle/adrian.vim,~/.vim/bundle/ansi_blows.vim,~/.vim/bundle/colorful256.vim,~/.vim/bundle/vundle,~/.vim/bundle/neocomplcache,~/.vim/bundle/nightshade.vim,~/.vim/bundle/surround.vim,~/.vim/bundle/neco-ghc,~/.vim/bundle/clang-complete,~/.vim/bundle/rubycomplete.vim,~/.vim/bundle/ruby.vim,~/.vim/bundle/nerdtree,~/.vim/bundle/vim-scala,~/.vim/bundle/python-mode,~/.vim/bundle/tagbar,~/.vim/bundle/vimprj,~/.vim/bundle/DfrankUtil,~/.vim/bundle/vim-mercenary,~/.vim/bundle/vim-flake8,~/.vim/bundle/EasyMotion,~/.vim/bundle/ctrlp.vim,~/.vim/bundle/ack.vim,~/.vim/bundle/AsyncCommand,~/.vim/bundle/LaTeX-Suite-aka-Vim-LaTeX,~/.vim/bundle/Solarized,~/.vim/bundle/vim-colorschemes,~/.vim/bundle/Gundo,~/.vim/bundle/vim-misc,~/.vim/bundle/vim-easytags,~/.vim/bundle/sudo.vim,~/.vim/bundle/systemtap,~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/vundle,~/.vim/bundle/vimproc/after,~/.vim/bundle/vim2hs/after,~/.vim/bundle/ghcmod-vim/after,~/.vim/bundle/256-jungle/after,~/.vim/bundle/ManPageView/after,~/.vim/bundle/syntastic/after,~/.vim/bundle/adrian.vim/after,~/.vim/bundle/ansi_blows.vim/after,~/.vim/bundle/colorful256.vim/after,~/.vim/bundle/vundle/after,~/.vim/bundle/neocomplcache/after,~/.vim/bundle/nightshade.vim/after,~/.vim/bundle/surround.vim/after,~/.vim/bundle/neco-ghc/after,~/.vim/bundle/clang-complete/after,~/.vim/bundle/rubycomplete.vim/after,~/.vim/bundle/ruby.vim/after,~/.vim/bundle/nerdtree/after,~/.vim/bundle/vim-scala/after,~/.vim/bundle/python-mode/after,~/.vim/bundle/tagbar/after,~/.vim/bundle/vimprj/after,~/.vim/bundle/DfrankUtil/after,~/.vim/bundle/vim-mercenary/after,~/.vim/bundle/vim-flake8/after,~/.vim/bundle/EasyMotion/after,~/.vim/bundle/ctrlp.vim/after,~/.vim/bundle/ack.vim/after,~/.vim/bundle/AsyncCommand/after,~/.vim/bundle/LaTeX-Suite-aka-Vim-LaTeX/after,~/.vim/bundle/Solarized/after,~/.vim/bundle/vim-colorschemes/after,~/.vim/bundle/Gundo/after,~/.vim/bundle/vim-misc/after,~/.vim/bundle/vim-easytags/after,~/.vim/bundle/sudo.vim/after,~/.vim/bundle/systemtap/after
set scrolloff=10
set shortmess=aOstT
set showcmd
set showmatch
set sidescrolloff=10
set smartcase
set smartindent
set smarttab
set softtabstop=4
set nostartofline
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=4
set tags=./tags,./TAGS,tags,TAGS,~/.vimtags
set termencoding=utf-8
set undodir=~/.undodir/
set undofile
set viminfo=
set wildmenu
set wildmode=list:longest
set window=13
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/scripts/systemtap
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 ~/scripts/systemtap/keyb.stp
args keyb.stp
edit ~/scripts/systemtap/keyb.stp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=neocomplcache#complete#manual_complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'stp'
setlocal filetype=stp
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},!^F,o,O,e,0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,-
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal nonumber
set numberwidth=5
setlocal numberwidth=5
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=8
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'stp'
setlocal syntax=stp
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 4 - ((3 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 0
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=aOstT
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
