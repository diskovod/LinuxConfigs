" ------------------------------------
" DJ2KOD vim configuration file.
" ------------------------------------

" ------------------------------------
" Menu
" ------------------------------------
menu Dj2kod.themes.solarized <Esc>:colorscheme solarized<cr>
menu Dj2kod.themes.darkZ <Esc>:colorscheme darkZ<cr>


"-------------------------------------
"GUI
"-------------------------------------
set guioptions-=T
set wildmenu
set guifont=DejaVu\ Sans\ Mono\ Bold\ 10
set guitabtooltip=%!bufname($)

" ------------------------------------
" Editor
" ------------------------------------
set foldmethod=syntax
set nu
set tabstop=4
set foldcolumn=1
set foldlevel=100
set expandtab
set shiftwidth=4
set laststatus=2
"set cc=80
set foldtext=CustomFoldText()

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"-------------------------------------
"Globals
"-------------------------------------
let g:zoomwin_localoptlist = ["ai","ar","bh","bin","bl","bomb","bt","cfu","ci","cin","cink","cino","cinw","cms","com","cpt","diff","efm","eol","ep","et","fenc","fex","ff","flp","fo","ft","gp","imi","ims","inde","inex","indk","inf","isk","key","kmp","lisp","mps","ml","ma","mod","nf","ofu","oft","pi","qe","ro","sw","sn","si","sts","spc","spf","spl","sua","swf","smc","syn","ts","tx","tw","wm"]

"-------------------------------------
" Airline
"-------------------------------------
let g:airline#extensions#tabline#enabled = 1


"-------------------------------------
"Keymap
"-------------------------------------
map gf :tabe <cfile><cr>
map <C-S-Left> :tabprevious<cr>
map <C-S-Right> :tabnext<cr>
map <f6> <esc>oendif<esc>

imap <f6> <esc>oendif<esc>

noremap <f4> :execute ':!gvim' TokenUnderCursor(1, 0) '&' <cr>

nnoremap <F3> :call NerdTreeCtrl() <cr><cr>

if &diff
  noremap <silent> <s-F11> :diffget<cr>
  noremap <silent> <s-F10> :diffput<cr>
  noremap <silent> <a-g> :diffget<cr>
  noremap <silent> <a-p> :diffput<cr>
  map <space> ]czz
  map <S-space> [czz
"  map <s-f19> [czz
  map <cr> ]czz
  map <s-cr> [czz
  map <silent> <f5> :diffup<cr>
  imap <silent> <f5> <esc>:diffup<cr>a
  map <silent> <f2> :set diffopt^=iwhite<cr>
  map <silent> <s-f2> :set diffopt-=iwhite<cr>
  map <silent> <a-d> :set diff!<cr>
  cnoreab q qa
  cnoreab qq q
  cnoreab x xa
  cnoreab xx x
  map <F4> :q<cr>
 set go-=rRlL dip=filler,context:5000
  set lsp=3 wiw=80
  set fdm=manual fdc=0
  set noea " set ea in diftop.vim
  set co=159 lines=54
endif
"-------------------------------------
"Other
"-------------------------------------
set nocompatible
set completeopt-=preview
set nocp
filetype off
set rtp+=~/.vim/bundle/vundle
set backspace=indent,eol,start
set ic is vb sm cul cindent nowrap hls sm
set scr=3
set syntax=auto
filetype plugin indent on
execute pathogen#infect()
call vundle#rc()

syntax on
filetype plugin indent on


autocmd FileType c inoremap <CR> <CR>x<BS>
autocmd FileType c nnoremap o ox<BS>
autocmd FileType c nnoremap O Ox<BS>
autocmd FileType cpp inoremap <CR> <CR>x<BS>
autocmd FileType cpp nnoremap o ox<BS>
autocmd FileType cpp nnoremap O Ox<BS>

"-------------------------------------
" BUNDLE 
"-------------------------------------
Bundle 'Shougo/vimproc.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'amiorin/vim-project'
Bundle 'flazz/vim-colorschemes'
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'thisivan/vim-bufexplorer'
Bundle 'bogado/file-line'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'tpope/vim-obsession'
Bundle 'gmarik/vundle'
Bundle 'mihaifm/vimpanel'
Bundle 'scrooloose/nerdtree'
Bundle 'wesleyche/SrcExpl'
Bundle 'scrooloose/nerdcommenter'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'mattn/emmet-vim'

"Bundle 'scrooloose/syntastic'
"Bundle 'Valloric/YouCompleteMe'

"---------------------------
" Additional functionality
"---------------------------

command! CD cd %:p:h

fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

au BufRead * normal zR

function! IsTokenChar(is_fname, is_number, char)
      if a:char >= "0" && a:char <= "9"
	  return 1
      endif
      if a:is_number
	  return 0
      endif
      if a:char == "_"
	  return 1
      endif
      if a:char >= "A" && a:char <= "Z"
	  return 1
      endif
      if a:char >= "a" && a:char <= "z"
	  return 1
      endif
      if a:is_fname && (a:char == "/" || a:char == "." || a:char == "-" || a:char == "~")
	  return 1
      endif
      if a:is_fname == 2 && a:char == ":"
	  return 1
      endif
      return 0
endfunction
function! TokenUnderCursor(is_fname, is_number)
    echo ""
    let line = getline(".")
    let pos = col(".") - 1

    let begpos = pos -1
    while IsTokenChar(a:is_fname, a:is_number, strpart(line, begpos, 1)) == 1
	let begpos = begpos - 1
    endwhile
    
    let endpos = pos + 1
    while IsTokenChar(a:is_fname, a:is_number, strpart(line, endpos, 1)) == 1
	let endpos = endpos + 1
    endwhile

    let result = strpart(line, begpos+1, endpos-begpos-1)

    return result
endfunction

syn match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
syn match cUserFunctionPointer "(\s*\*\s*\h\w*\s*)\(\s\|\n\)*(" contains=cDelimiter,cOperator

hi def cFunction gui=bold guifg=yellowgreen
hi def link cUserFunction cFunction
hi def link cUserFunctionPointer cFunction

syn match cDelimiter    "[();\\]"
syn match cBraces display "[{}]"

" Links
hi def link cFunction Function
hi def link cIdentifier Identifier
hi def link cDelimiter Delimiter
hi def link cBraces Delimiter
hi def link cBoolean Boolean
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction

function! NerdTreeCtrl()
    if !exists(":NERDTree")
	    return
    endif

    if (nerdtree#isTreeOpen())
	execute ':NERDTreeClose'
    else
	execute ':NERDTree'
    endif
endfunction

au BufEnter /* call LoadCscope() 

" ------------------------------------
" Theme
" ------------------------------------
colorscheme darkZ
