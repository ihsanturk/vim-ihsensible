" =============================================================================
" File:        ihsensible.vim
" Description: Personal sensible configuration for vim.
" Author:      ihsan <ihsanl at pm dot me>
" Created At:  1592826467
" License:     MIT License
" =============================================================================

let spaceindent=3
let mapleader = '\'
let g:netrw_liststyle=3
let g:netrw_dirhistmax = 0

" maps
nn j gj
nn k gk
cnorea H h
cnorea Q q
cnorea W w
cnorea Q! q!
cnorea Qa qa
cnorea WQ wq
cnorea Wq wq
cnorea qw wq
cnorea rg Rg
cnorea wQ wq
nn <space> za
nn cn :cn<cr>
nn cp :cp<cr>
cnorea man Man
nn co :copen<cr>
nn <m-c> :make<cr>
nn gf :e <cfile><cr>
nn <m-.> :cd %:p:h<cr>
cnorea cdc cd %:p:h<cr>:
nn <silent><m-n> :bn<cr>
nn <silent><m-p> :bp<cr>
nn <leader>% :source %<cr>
nn <silent> <c-c> :noh<cr>
nn <leader>e :se cole=0<cr>
nn <leader>v :se cole=3<cr>
nm <leader>r :so $MYVIMRC<cr>
au FileType help nn <buffer> q :q<cr>
nn <leader>c :exec "e " . $MYVIMRC<cr>
xn // y/\V<c-r>=escape(@",'/\')<cr><cr>
nn <leader>C :exec "tabe " . $MYVIMRC<cr>
nn <leader>d :exe 'norm! a'.system("date '+%Y %b %d %X'\|tr -d '\n'")<cr>


" switch between windows with meta (shift)? o
nn <m-o> <c-w>w
nn <m-s-o> <c-w>p
im <m-o> <esc><c-w>w
tma <m-o> <c-\><c-n><c-w>w
tma <m-s-o> <c-\><c-n><c-w>p

" sets
se ic
se sb
se awa
se bri
se lbr
se scs
se spr
se tgc
se wic
se list
se noea
se noru
se nocul
se nosmd
se noswf
se sbr=↪
se cole=2
se nowrap
se cocu=nc
se mouse=a
se mmp=20000
se noet ci pi sts=0
exe 'set sw='.spaceindent
exe 'set ts='.spaceindent
hi Visual gui=none cterm=none
au FileType vimwiki,vim se tw=79
hi ErrorMsg ctermfg=Red ctermbg=237
if has('nvim') | se icm=nosplit sd='1000 | endif
au FileType sql se mp=cat\ %\ \\\|\ mysql\ -uroot
au BufWritePost * if getline(1) =~ "^#!.*/bin/" | sil !chmod +x <afile> | endif

" mkdir -p for vim on write
augroup Mkdir
	autocmd!
	autocmd BufWritePre *
		\ if !isdirectory(expand("<afile>:p:h")) |
			\ call mkdir(expand("<afile>:p:h"), "p") |
		\ endif
augroup END

" better markdown mode
au FileType markdown setl com-=n:#
au FileType markdown setl com-=fb:-
au FileType markdown setl com+=n:- " Auto append - in new line.
au FileType markdown setl fo+=ro
au FileType markdown setl tw=79
au FileType markdown setl et

" better terminal buffer " TODO: pluginize-vip
if has('nvim')
	aug custom_term
		au!
		au BufEnter,TermOpen term://* start
		au TermEnter * setl nonu nornu nomod
		au TermClose * :bd!
	aug END
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
nm <m-t> :let $DIR=expand('%:p:h')<cr>:ter<cr>cd $DIR;tput clear<cr>


" persistent undo
if has('persistent_undo')
	se udf
	se udir=~/.cache/vim
end
if has('unnamedplus')
	se cb=unnamed,unnamedplus
end
scripte utf-8

" dynamic smartcase
aug dynamic_smartcase
	au!
	au CmdLineEnter : se nosmartcase
	au CmdLineLeave : se smartcase
aug END

" toggle things
nm <silent> <m-0> :call ToggleStatusLine()<cr>
nn <silent> <m-1> :set cuc!<cr>
"-----------<m-2> open fzf on left hand side
nm <silent> <m-3> :se rnu! nu!<cr>
nm <silent> <m-4> :call ToggleSignColumn()<cr>
nm <silent> <m-8> :call Toggle80ColRule()<cr>

func! Toggle80ColRule()
	if &cc == 80
		se cc=0
	else
		call Set80ColRule()
	end
endf
func! Set80ColRule()
	if exists('+colorcolumn')
		se cc=80
	else
		au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
	end
endf

func! ToggleStatusLine()
	if &ls == 2
		se ls=0
	else
		se ls=2
	end
endf

func! ToggleSignColumn()
	if &scl == 'no'
		se scl=yes
	else
		se scl=no
	end
endf

" vim: set filetype=vim fdm=marker :
