"          ╭────────────────────ihsensible.vim─────────────────────╮
"          Maintainer:     ihsan, ihsanl[at]pm[dot]me              │
"          Description:    personal defaults                       │
"          First Appeared: 2020 Jun 22 11:47:47                    │
"          License:        MIT                                     │
"          ╰───────────────────────────────────────────────────────╯

syntax on

let g:is_posix = 1
let mapleader = '\'
let spaceindent = 3
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_dirhistmax = 0

"maps
cnorea E e
cnorea H h
cnorea Q q
cnorea W w
cnorea BD bd
cnorea Bd bd
cnorea Q! q!
cnorea Qa qa
cnorea WQ wq
cnorea Wq wq
cnorea qw wq
cnorea rg Rg
cnorea wQ wq
nn cn :cn<cr>
nn cp :cp<cr>
cnorea man Man
nn <silent> j gj
nn <silent> k gk
nn co :copen<cr>
nn <m-c> :make<cr>
nn <m-.> :cd %:p:h<cr>
nn <silent><m-n> :bn<cr>
nn <silent><m-p> :bp<cr>
cnorea cdc tcd %:p:h<cr>
nn <leader>e :se cole=0<cr>
nn <leader>v :se cole=3<cr>
nm <leader>r :so $MYVIMRC<cr>
xn // y/\V<c-r>=escape(@",'/\')<cr><cr>
nn <leader>d :exe 'norm! a'.system("date '+%Y %b %d %X'\|tr -d '\n'")<cr>

" switch between windows with meta (shift)? o
nn  <silent> <m-o>   :winc w<cr>
nn  <silent> <m-s-o> :winc p<cr>
im  <silent> <m-o>   <esc>:winc w<cr>
tma <silent> <m-o>   <c-\><c-n>:winc w<cr>
tma <silent> <m-s-o> <c-\><c-n>:winc p<cr>

"set
se ic
se nu
se sb
se bri
se lbr
se scs
se spr
se wic
se list
se noea
se noru
se nocul
se nosmd
se noswf
se sbr=↪
se cole=2
se cocu=nc
se mmp=20000
se noet ci pi sts=0
se wim=longest,full
exe 'set sw='.spaceindent
exe 'set ts='.spaceindent
au FileType gitcommit se tw=50
au FileType vimwiki,vim se tw=79
hi ErrorMsg ctermfg=Red ctermbg=237
se listchars=tab:\┊\ ,trail:•,nbsp:+
if has('nvim') | se icm=nosplit sd='1000 | endif
au FileType sql se mp=cat\ %\ \\\|\ mysql\ -uroot

" wildmenu
if has("wildmenu")
	se wildignore+=*.a,*.o
	se wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
	se wildignore+=.DS_Store,.git,.hg,.svn
	se wildignore+=*~,*.swp
endif

" add +x flag for file
aug chmod
	au!
	au BufWritePost *
		\ if getline(1) =~ "^#!.*/bin/" |
			\ sil !chmod +x <afile> |
		\ endif
aug end

" mkdir -p for vim on write
augroup Mkdir
	autocmd!
	autocmd BufWritePre *
		\ if !isdirectory(expand("<afile>:p:h")) |
			\ call mkdir(expand("<afile>:p:h"), "p") |
		\ endif
augroup end

" better markdown mode
au FileType markdown setl et
au FileType markdown setl tw=79
au FileType markdown setl fo+=ro
au FileType markdown setl com-=n:#
au FileType markdown setl com-=fb:-
au FileType markdown setl com+=n:- " Auto append - in new line.

" better terminal buffer " TODO: pluginize-vip
if has('nvim')
	aug custom_term
		au!
		au TermOpen term://* startinsert
		au TermEnter * setl nonu nornu nomod
		au TermClose * :bd!
	aug end
endif
fun! TermTest(cmd)
	cal termopen(a:cmd, {'on_exit': 's:OnExit'})
endf
fun! s:OnExit(job_id, code, event) dict
	if a:code == 0
		clo
	end
endf
tno <silent> <Esc> <c-\><c-n>
tma <silent> <c-w> <c-\><c-n><c-w>
tno <silent> <m-n> <c-\><c-n>:bn<cr>
tno <silent> <m-p> <c-\><c-n>:bp<cr>
nm <m-t> :let $DIR=expand('%:p:h')<cr>:ter<cr>cd $DIR;tput clear<cr>

if has('persistent_undo')
	se udf
	se udir=~/.cache/vim
end
if has('unnamedplus')
	se cb=unnamed,unnamedplus
end
scripte utf-8

aug dynamic_smartcase
	au!
	au CmdLineEnter : se nosmartcase
	au CmdLineLeave : se smartcase
aug end

" toggle things
nm <silent> <m-0> :call ToggleStatusLine()<cr>
nn <silent> <m-1> :set cuc!<cr>
nn <silent> <m-2> :20Lexplore<cr>
nm <silent> <m-3> :se rnu! nu!<cr>
tma <silent> <m-3> <c-\><c-n>:se rnu! nu!<cr>

" vim: set filetype=vim fdm=marker :
