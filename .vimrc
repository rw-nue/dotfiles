set nocompatible
filetype off            " for NeoBundle
 
if has('vim_starting')
        set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
 
" ここから NeoBundle でプラグインを設定します
 
" NeoBundle で管理するプラグインを追加します。
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'ctrlp.vim'
NeoBundle 'haya14busa/vim-easymotion'
NeoBundle "surround.vim"
NeoBundle 'taglist.vim'
NeoBundle 'ZenCoding.vim'
NeoBundle 'ref.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'rking/ag.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tobyS/pdv'
NeoBundle 'git://github.com/thinca/vim-qfreplace.git'
NeoBundle '2072/PHP-Indenting-for-VIm'
NeoBundle 'szw/vim-tags'
NeoBundle 'slim-template/vim-slim'
NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : 'Tlist',},}
NeoBundle 'thinca/vim-quickrun'
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
\    'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'KazuakiM/vim-qfsigns', 'KazuakiM/vim-qfstatusline', 'dannyob/quickfixstatus'],
\    'autoload' : {
\        'filetypes': ['php'],},}
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {
\    'autoload' : {
\        'filetypes': 'php',},}
 

filetype plugin indent on       " restore filetype

map <Space> <Plug>(easymotion-prefix)
nmap w <Plug>(easymotion-w)
nmap b <Plug>(easymotion-b)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

map <Space>l <Plug>(easymotion-lineforward)
map <Space>h <Plug>(easymotion-linebackward)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
let g:EasyMotion_use_smartsign_jp = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcv'

syntax on
set number
set cindent
set smartcase
set backspace=2
set tabstop=4
set shiftwidth=4
set wildmode=longest,list
set wildmenu
set cmdheight=2
set autoindent
set smartindent
set smarttab
set expandtab
highlight LineNr ctermfg=darkyellow

set nobackup
set noswapfile

set encoding=utf8
set fileencoding=utf8
set fileencodings=utf8

set incsearch
set hlsearch

" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ステータス行に表示させる情報の指定(どこからかコピペしたので細かい意味はわかっていない)
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title

augroup filetypedetect
au! BufRead , BufNewFile *.ctp	 setfiletype php
augroup END

nmap ,l :call PHPLint()<CR>
function! PHPLint()
 let result = system( &ft . ' -l ' . bufname(""))
 echo result
endfunction

inoremap <C-J> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-J> :call PhpDocSingle()<CR>
vnoremap <C-J> :call PhpDocRange()<CR>

au BufNewFile,BufRead *.ctp set ft=php

" augroup InsertHook
" autocmd!
" autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
" autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
" augroup END


" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow



nnoremap [Prefix] <nop>
nmap <space> [Prefix]

noremap [Prefix]j <c-f><cr><cr>
noremap [Prefix]k <c-b><cr><cr>

function! IsEndSemicolon()
	let c = getline(".")[col("$")-2]
	if c != ';'
		return 1
	else
		return 0
	endif
endfunction
inoremap <expr>;; IsEndSemicolon() ?  "<C-O>$;<CR>" : "<C-O>$<CR>"

noremap <C-y> :source ~/.vimrc<CR>
nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>
inoremap <C-S-w> <Esc>:tabclose<CR>
nnoremap <S-h> gT
nnoremap <S-l> gt
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

let g:NERDCreateDefaultMappings = 0 
let NERDSpaceDelims = 1 
nmap ,c <Plug>NERDCommenterToggle
vmap ,c <Plug>NERDCommenterToggle


" バッファ一覧
noremap <C-b><c-f> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
" vim-indent-guides
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=7
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_start_level=2
" let g:indent_guides_guide_size=1

set pastetoggle=<F10>
nnoremap <F10> :set paste!<CR>:set paste?<CR>

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
""""""""""""""""""""""""""""""






" PDV (phpDocumentor for Vim)
" ===========================
"
" Version: 1.0.1
" 
" Copyright 2005 by Tobias Schlitt <toby@php.net>
" Inspired by phpDoc script for Vim by Vidyut Luther (http://www.phpcult.com/).
"
" Provided under the GPL (http://www.gnu.org/copyleft/gpl.html).
"
" This script provides functions to generate phpDocumentor conform
" documentation blocks for your PHP code. The script currently
" documents:
" 
" - Classes
" - Methods/Functions
" - Attributes
"
" All of those supporting all PHP 4 and 5 syntax elements. 
"
" Beside that it allows you to define default values for phpDocumentor tags 
" like @version (I use $id$ here), @author, @license and so on. 
"
" For function/method parameters and attributes, the script tries to guess the 
" type as good as possible from PHP5 type hints or default values (array, bool, 
" int, string...).
"
" You can use this script by mapping the function PhpDoc() to any
" key combination. Hit this on the line where the element to document
" resides and the doc block will be created directly above that line.
" 
" Installation
" ============
" 
" For example include into your .vimrc:
" 
" source ~/.vim/php-doc.vim
" imap <C-o> :set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i
"
" This includes the script and maps the combination <ctrl>+o (only in
" insert mode) to the doc function. 
"
" Changelog
" =========
"
" Version 1.0.0
" -------------
"
"  * Created the initial version of this script while playing around with VIM
"  scripting the first time and trying to fix Vidyut's solution, which
"  resulted in a complete rewrite.
"
" Version 1.0.1
" -------------
"  * Fixed issues when using tabs instead of spaces.
"  * Fixed some parsing bugs when using a different coding style.
"  * Fixed bug with call-by-reference parameters. 
"  * ATTENTION: This version already has code for the next version 1.1.0,
"  which is propably not working!
"
" Version 1.1.0 (preview)
" -------------
"  * Added foldmarker generation.
" 

if has ("user_commands")

" {{{ Globals

" After phpDoc standard
let g:pdv_cfg_CommentHead = "/**"
let g:pdv_cfg_Comment1 = " * "
let g:pdv_cfg_Commentn = " * "
let g:pdv_cfg_CommentTail = " */"
let g:pdv_cfg_CommentSingle = "//"

" Default values
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = "rwnue <wakabayashi@novatrade.co.jp>"
let g:pdv_cfg_Copyright = "Novatrade , Inc."
let g:pdv_cfg_License = "PHP Version 5.3 {@link http://www.php.net/license/3_0.txt}"

let g:pdv_cfg_ReturnVal = "void"

" Wether to create @uses tags for implementation of interfaces and inheritance
let g:pdv_cfg_Uses = 1

" Options
" :set paste before documenting (1|0)? Recommended.
let g:pdv_cfg_paste = 1

" Wether for PHP5 code PHP4 tags should be set, like @access,... (1|0)?
let g:pdv_cfg_php4always = 1
 
" Wether to guess scopes after PEAR coding standards:
" $_foo/_bar() == <private|protected> (1|0)?
let g:pdv_cfg_php4guess = 1

" If you selected 1 for the last value, this scope identifier will be used for
" the identifiers having an _ in the first place.
let g:pdv_cfg_php4guessval = "protected"

"
" Regular expressions 
" 

let g:pdv_re_comment = ' *\*/ *'

" (private|protected|public)
let g:pdv_re_scope = '\(private\|protected\|public\)'
" (static)
let g:pdv_re_static = '\(static\)'
" (abstract)
let g:pdv_re_abstract = '\(abstract\)'
" (final)
let g:pdv_re_final = '\(final\)'

" [:space:]*(private|protected|public|static|abstract)*[:space:]+[:identifier:]+\([:params:]\)
let g:pdv_re_func = '^\s*\([a-zA-Z ]*\)function\s\+\([^ (]\+\)\s*(\s*\(.*\)\s*)\s*[{;]\?$'
" [:typehint:]*[:space:]*$[:identifier]\([:space:]*=[:space:]*[:value:]\)?
let g:pdv_re_param = ' *\([^ &]*\) *&\?\$\([A-Za-z_][A-Za-z0-9_]*\) *=\? *\(.*\)\?$'

" [:space:]*(private|protected|public\)[:space:]*$[:identifier:]+\([:space:]*=[:space:]*[:value:]+\)*;
let g:pdv_re_attribute = '^\s*\(\(private\|public\|protected\|var\|static\)\+\)\s*\$\([^ ;=]\+\)[ =]*\(.*\);\?$'

" [:spacce:]*(abstract|final|)[:space:]*(class|interface)+[:space:]+\(extends ([:identifier:])\)?[:space:]*\(implements ([:identifier:][, ]*)+\)?
let g:pdv_re_class = '^\s*\([a-zA-Z]*\)\s*\(interface\|class\)\s*\([^ ]\+\)\s*\(extends\)\?\s*\([a-zA-Z0-9]*\)\?\s*\(implements*\)\? *\([a-zA-Z0-9_ ,]*\)\?.*$'

let g:pdv_re_array  = "^array *(.*"
let g:pdv_re_float  = '^[0-9.]\+'
let g:pdv_re_int    = '^[0-9]\+$'
let g:pdv_re_string = "['\"].*"
let g:pdv_re_bool = "\(true\|false\)"

let g:pdv_re_indent = '^\s*'

" Shortcuts for editing the text:
let g:pdv_cfg_BOL = "norm! o"
let g:pdv_cfg_EOL = ""

" }}}  

 " {{{ PhpDocSingle()
 " Document a single line of code ( does not check if doc block already exists )

func! PhpDocSingle()
    let l:endline = line(".") + 1
    call PhpDoc()
    exe "norm! " . l:endline . "G$"
endfunc

" }}}
 " {{{ PhpDocRange()
 " Documents a whole range of code lines ( does not add defualt doc block to
 " unknown types of lines ). Skips elements where a docblock is already
 " present.
func! PhpDocRange() range
    let l:line = a:firstline
    let l:endLine = a:lastline
	let l:elementName = ""
    while l:line <= l:endLine
        " TODO: Replace regex check for existing doc with check more lines
        " above...
        if (getline(l:line) =~ g:pdv_re_func || getline(l:line) =~ g:pdv_re_attribute || getline(l:line) =~ g:pdv_re_class) && getline(l:line - 1) !~ g:pdv_re_comment
			let l:docLines = 0
			" Ensure we are on the correct line to run PhpDoc()
            exe "norm! " . l:line . "G$"
			" No matter what, this returns the element name
            let l:elementName = PhpDoc()
            let l:endLine = l:endLine + (line(".") - l:line) + 1
            let l:line = line(".") + 1 
        endif
        let l:line = l:line + 1
    endwhile
endfunc

 " }}}
" {{{ PhpDocFold()

" func! PhpDocFold(name)
" 	let l:startline = line(".")
" 	let l:currentLine = l:startLine
" 	let l:commentHead = escape(g:pdv_cfg_CommentHead, "*.");
"     let l:txtBOL = g:pdv_cfg_BOL . matchstr(l:name, '^\s*')
" 	" Search above for comment start
" 	while (l:currentLine > 1)
" 		if (matchstr(l:commentHead, getline(l:currentLine)))
" 			break;
" 		endif
" 		let l:currentLine = l:currentLine + 1
" 	endwhile
" 	" Goto 1 line above and open a newline
"     exe "norm! " . (l:currentLine - 1) . "Go\<ESC>"
" 	" Write the fold comment
"     exe l:txtBOL . g:pdv_cfg_CommentSingle . " {"."{{ " . a:name . g:pdv_cfg_EOL
" 	" Add another newline below that
" 	exe "norm! o\<ESC>"
" 	" Search for our comment line
" 	let l:currentLine = line(".")
" 	while (l:currentLine <= line("$"))
" 		" HERE!!!!
" 	endwhile
" 	
" 
" endfunc


" }}}

" {{{ PhpDoc()

func! PhpDoc()
    " Needed for my .vimrc: Switch off all other enhancements while generating docs
    let l:paste = &g:paste
    let &g:paste = g:pdv_cfg_paste == 1 ? 1 : &g:paste
    
    let l:line = getline(".")
    let l:result = ""

    if l:line =~ g:pdv_re_func
        let l:result = PhpDocFunc()

    elseif l:line =~ g:pdv_re_attribute
        let l:result = PhpDocVar()

    elseif l:line =~ g:pdv_re_class
        let l:result = PhpDocClass()

    else
        let l:result = PhpDocDefault()

    endif

"	if g:pdv_cfg_folds == 1
"		PhpDocFolds(l:result)
"	endif

    let &g:paste = l:paste

    return l:result
endfunc

" }}}
" {{{  PhpDocFunc()  

func! PhpDocFunc()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

    "exe g:pdv_cfg_BOL . "DEBUG:" . name. g:pdv_cfg_EOL

	" First some things to make it more easy for us:
	" tab -> space && space+ -> space
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(funcname\)\(parameters\)
    let l:indent = matchstr(l:name, g:pdv_re_indent)
	
	let l:modifier = substitute (l:name, g:pdv_re_func, '\1', "g")
	let l:funcname = substitute (l:name, g:pdv_re_func, '\2', "g")
	let l:parameters = substitute (l:name, g:pdv_re_func, '\3', "g") . ","
    let l:scope = PhpDocScope(l:modifier, l:funcname)
    let l:static = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_static) : ""
	let l:abstract = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_abstract) : ""
	let l:final = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_final) : ""
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Comment1 . funcname . " " . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL

	while (l:parameters != ",") && (l:parameters != "")
		" Save 1st parameter
		let _p = substitute (l:parameters, '\([^,]*\) *, *\(.*\)', '\1', "")
		" Remove this one from list
		let l:parameters = substitute (l:parameters, '\([^,]*\) *, *\(.*\)', '\2', "")
		" PHP5 type hint?
		let l:paramtype = substitute (_p, g:pdv_re_param, '\1', "")
		" Parameter name
		let l:paramname = substitute (_p, g:pdv_re_param, '\2', "")
		" Parameter default
		let l:paramdefault = substitute (_p, g:pdv_re_param, '\3', "")

        if l:paramtype == ""
            let l:paramtype = PhpDocType(l:paramdefault)
        endif
        
        if l:paramtype != ""
            let l:paramtype = " " . l:paramtype
        endif
		exe l:txtBOL . g:pdv_cfg_Commentn . "@param" . l:paramtype . " $" . l:paramname . " " . g:pdv_cfg_EOL
	endwhile

	if l:static != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@static" . g:pdv_cfg_EOL
    endif
	if l:abstract != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@abstract" . g:pdv_cfg_EOL
    endif
	if l:final != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@final" . g:pdv_cfg_EOL
    endif
    if l:scope != ""
    	exe l:txtBOL . g:pdv_cfg_Commentn . "@access " . l:scope . g:pdv_cfg_EOL
    endif
	exe l:txtBOL . g:pdv_cfg_Commentn . "@return " . g:pdv_cfg_ReturnVal . g:pdv_cfg_EOL

	" Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
    return l:modifier ." ". l:funcname
endfunc

" }}}  
 " {{{  PhpDocVar() 

func! PhpDocVar()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(funcname\)\(parameters\)
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

    let l:indent = matchstr(l:name, g:pdv_re_indent)

	let l:modifier = substitute (l:name, g:pdv_re_attribute, '\1', "g")
	let l:varname = substitute (l:name, g:pdv_re_attribute, '\3', "g")
	let l:default = substitute (l:name, g:pdv_re_attribute, '\4', "g")
    let l:scope = PhpDocScope(l:modifier, l:varname)

    let l:static = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_static) : ""

    let l:type = PhpDocType(l:default)
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Comment1 . l:varname . " " . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL
    if l:static != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@static" . g:pdv_cfg_EOL
    endif
    exe l:txtBOL . g:pdv_cfg_Commentn . "@var " . l:type . g:pdv_cfg_EOL
    if l:scope != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@access " . l:scope . g:pdv_cfg_EOL
    endif
	
    " Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
	return l:modifier ." ". l:varname
endfunc

" }}}
"  {{{  PhpDocClass()

func! PhpDocClass()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

    "exe g:pdv_cfg_BOL . "DEBUG:" . name. g:pdv_cfg_EOL

	" First some things to make it more easy for us:
	" tab -> space && space+ -> space
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(classname\)\(parameters\)
    let l:indent = matchstr(l:name, g:pdv_re_indent)
	
	let l:modifier = substitute (l:name, g:pdv_re_class, '\1', "g")
	let l:classname = substitute (l:name, g:pdv_re_class, '\3', "g")
	let l:extends = g:pdv_cfg_Uses == 1 ? substitute (l:name, g:pdv_re_class, '\5', "g") : ""
	let l:interfaces = g:pdv_cfg_Uses == 1 ? substitute (l:name, g:pdv_re_class, '\7', "g") . "," : ""

	let l:abstract = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_abstract) : ""
	let l:final = g:pdv_cfg_php4always == 1 ?  matchstr(l:modifier, g:pdv_re_final) : ""
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Comment1 . l:classname . " " . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL
    if l:extends != "" && l:extends != "implements"
    	exe l:txtBOL . g:pdv_cfg_Commentn . "@uses " . l:extends . g:pdv_cfg_EOL
    endif

	while (l:interfaces != ",") && (l:interfaces != "")
		" Save 1st parameter
		let interface = substitute (l:interfaces, '\([^, ]*\) *, *\(.*\)', '\1', "")
		" Remove this one from list
		let l:interfaces = substitute (l:interfaces, '\([^, ]*\) *, *\(.*\)', '\2', "")
		exe l:txtBOL . g:pdv_cfg_Commentn . "@uses " . l:interface . g:pdv_cfg_EOL
	endwhile

	if l:abstract != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@abstract" . g:pdv_cfg_EOL
    endif
	if l:final != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@final" . g:pdv_cfg_EOL
    endif
	exe l:txtBOL . g:pdv_cfg_Commentn . "@package " . g:pdv_cfg_Package . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@version " . g:pdv_cfg_Version . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@copyright " . g:pdv_cfg_Copyright . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@author " . g:pdv_cfg_Author g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@license " . g:pdv_cfg_License . g:pdv_cfg_EOL

	" Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
	return l:modifier ." ". l:classname
endfunc

" }}} 
" {{{ PhpDocScope() 

func! PhpDocScope(modifiers, identifier)
" exe g:pdv_cfg_BOL . DEBUG: . a:modifiers . g:pdv_cfg_EOL
    let l:scope  = ""
    if  matchstr (a:modifiers, g:pdv_re_scope) != "" 
        if g:pdv_cfg_php4always == 1
            let l:scope = matchstr (a:modifiers, g:pdv_re_scope)
        else
            let l:scope = "x"
        endif
    endif
    if l:scope =~ "^\s*$" && g:pdv_cfg_php4guess
        if a:identifier[0] == "_"
            let l:scope = g:pdv_cfg_php4guessval
        else
            let l:scope = "public"
        endif
    endif
    return l:scope != "x" ? l:scope : ""
endfunc

" }}}
" {{{ PhpDocType()

func! PhpDocType(typeString)
    let l:type = ""
    if a:typeString =~ g:pdv_re_array 
        let l:type = "array"
    endif
    if a:typeString =~ g:pdv_re_float 
        let l:type = "float"
    endif
    if a:typeString =~ g:pdv_re_int 
        let l:type = "int"
    endif
    if a:typeString =~ g:pdv_re_string
        let l:type = "string"
    endif
    if a:typeString =~ g:pdv_re_bool
        let l:type = "bool"
    endif
	if l:type == ""
		let l:type = g:pdv_cfg_Type
	endif
    return l:type
endfunc
    
"  }}} 
" {{{  PhpDocDefault()

func! PhpDocDefault()
	" Line for the comment to begin
	let commentline = line (".") - 1
    
    let l:indent = matchstr(getline("."), '^\ *')
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . indent

    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . " " . g:pdv_cfg_EOL
	
    " Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
endfunc

" }}}

endif " user_commands

map <C-b> :% ! phpBeautifier<CR>

function! s:PhpStylist()
  execute "w"
  normal ggdG
  execute "0r!~/bin/phpStylist %"
  normal Gdd
endfunction
command! PhpStylist call <SID>PhpStylist()

:map! <C-L> <Esc>$a
:map! <C-H> <Esc>^i

:map <C-L> <Esc>$a
:map <C-H> <Esc>^i
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
"mysqlの場合
let g:sql_type_default='mysql'

" vim-tags {{{
"
" use this in local vimrc
" augroup MyAutoCmd
" autocmd!
" autocmd BufNewFile,BufRead $HOME/xxx/**.php setlocal tags=$HOME/.vim/tags/xxx.tags
" augroup END
"}}}
" taglist.vim {{{
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
"}}}


nnoremap <Leader>r :QuickRun<CR>
" let g:quickrun_config = {
" \    '_' : {
" \        'hook/close_buffer/enable_failure':    1,
" \        'hook/close_buffer/enable_empty_data': 1,
" \        'runner':                              'vimproc',
" \        'runner/vimproc/updatetime':           60,
" \        'outputter':                           'multi:buffer:quickfix',
" \        'outputter/buffer/split':              ':botright',
" \        'outputter/buffer/close_on_empty':     1,},
" \    'watchdogs_checker/_' : {
" \        'hook/close_quickfix/enable_exit':           1,
" \        'hook/back_window/enable_exit':              0,
" \        'hook/back_window/priority_exit':            1,
" \        'hook/quickfix_status_enable/enable_exit':   1,
" \        'hook/quickfix_status_enable/priority_exit': 2,
" \        'hook/qfsigns_update/enable_exit':           1,
" \        'hook/qfsigns_update/priority_exit':         3,
" \        'hook/qfstatusline_update/enable_exit':      1,
" \        'hook/qfstatusline_update/priority_exit':    4,},
" \    'watchdogs_checker/php' : {
" \        'command':     'php',
" \        'exec':        '%c -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0 -l %o %s:p',
" \        'errorformat': '%m\ in\ %f\ on\ line\ %l',},}

let s:hooks = neobundle#get_hooks('vim-watchdogs')
function! s:hooks.on_source(bundle)
    "vim-qfsigns
    nnoremap <Leader>sy :QfsignsJunmp<CR>
    " vim-qfstatusline (This setting is userd at lightline)
    " let g:Qfstatusline#UpdateCmd = function('lightline#update')
    "vim-watchdogs
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:watchdogs_check_BufWritePost_enables = {
    \   'php' : 0,}
    let g:watchdogs_check_CursorHold_enable = 1
endfunction
unlet s:hooks




let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    let g:php_cs_fixer_path = '$HOME/.vim/phpCsFixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
    let g:php_cs_fixer_level='all'              " which level ?
    let g:php_cs_fixer_config='default'         " configuration
    let g:php_cs_fixer_php_path='php'           " Path to PHP
    " If you want to define specific fixers:
    let g:php_cs_fixer_fixers_list = 'linefeed,short_tag,indentation'
    let g:php_cs_fixer_enable_default_mapping=1 " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run=0                " Call command with dry-run option
    let g:php_cs_fixer_verbose=0                " Return the output of command if 1, else an inline information.
    nnoremap <Leader>php :call PhpCsFixerFixFile()<CR>:e!<CR>
endfunction
unlet s:hooks
"}}}
"wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O "$HOME/.vim/phpCsFixer/php-cs-fixer
"chmod a+x $HOME/.vim/phpCsFixer/php-cs-fixer
so ~/.dotfiles/.vimrc.local
call neobundle#end()
