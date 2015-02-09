set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Plugin 'ctrlp.vim'
Bundle 'unite.vim'
Plugin 'haya14busa/vim-easymotion'
"Plugin 'Lokaltog/vim-easymotion'
Bundle 'cake.vim'
Bundle 'neocomplcache'
Bundle "surround.vim"
Bundle 'taglist.vim'
Bundle 'ZenCoding.vim'
Bundle 'ref.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'Shougo/vimproc'
Bundle 'rking/ag.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

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
set tabstop=2
set shiftwidth=2
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

inoremap <C-L> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-L> :call PhpDocSingle()<CR>
vnoremap <C-L> :call PhpDocRange()<CR>

au BufNewFile,BufRead *.ctp set ft=php

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END


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
:set runtimepath +=$HOME/.vim/bundle/snipmate/after
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
