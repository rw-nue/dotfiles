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
Bundle 'surround.vim'
Bundle 'taglist.vim'
Bundle 'ZenCoding.vim'
Bundle 'ref.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'Shougo/vimproc'
Bundle 'rking/ag.vim'
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

set number
set cindent
syntax on
set backspace=2
set tabstop=4
set wildmode=longest,list
set autoindent

set nobackup
set noswapfile

set encoding=utf8
set fileencoding=utf8
set fileencodings=utf8

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



inoremap <c-j> <esc>
vnoremap <c-j> <esc>

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
