syntax on
autocmd FileType * set formatoptions=tcql nocindent comments&

autocmd FileType java,c,cc,cpp,sqc set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

:set showmatch
:set ruler
:set matchtime=1

"function InsertTabWrapper()
"  let col = col('.') - 1
"  if !col || getline('.')[col - 1] !~ '\k'
"    return "\<tab>"
"  else
"    return "\<c-p>"
"  endif
"endfunction
"
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

:set viminfo='10,\"100,:20,%,n~/.viminfo
:au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
:set hlsearch

"function! s:CheckOutFile()
" if filereadable(expand("%")) && ! filewritable(expand("%"))
"   let option = confirm("Readonly file, do you want to checkout from p4?"
"         \, "&Yes\n&No", 1, "Question")
"   if option == 1
"#     PEdit
"   endif
"   edit!
" endif
"endfunction
"au FileChangedRO * nested :call <SID>CheckOutFile()

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
"  (thanks Douglas Potts)
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
    map ,sp :sp <C-R>=expand("%:p:h") . "/" <CR>
    map ,vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
    map ,sp :sp <C-R>=expand("%:p:h") . "\" <CR>
    map ,vsp :vsp <C-R>=expand("%:p:h") . "\" <CR>
endif

set path=.,~/tellapart/dev/tellapart/rye,~/tellapart/dev/tellapart/thrift

set incsearch
set winminheight=0
set winheight=9999

source ~/.vim/supertab.vim
source ~/.vim/plugin/conque_term.vim
source ~/.vim/conque_term.vim
source ~/.vim/thrift.vim
source ~/.vim/python_fn.vim

"" highlight RedundantSpaces ctermbg=red guibg=red
highlight RedundantSpaces ctermbg=blue guibg=blue
highlight TooLong ctermbg=blue guibg=blue
"" make sure that we override this highlight even if a colorscheme is used.
autocmd colorscheme * highlight RedundantSpaces ctermbg=blue guibg=blue
autocmd colorscheme * highlight TooLong ctermbg=blue guibg=blue
"autocmd BufWinEnter *.java match RedundantSpaces /^\s*\t\+\|\s\+$/
"autocmd BufWinEnter *.py match RedundantSpaces /^\s*\t\+\|\s\+$/
"autocmd BufWinEnter *.thrift match RedundantSpaces /^\s*\t\+\|\s\+$/
autocmd BufWinEnter *.py match TooLong /\%<82v.\%>81v/
autocmd BufWinEnter *.js match TooLong /\%<82v.\%>81v/
autocmd BufWinEnter *.thrift match TooLong /\%<82v.\%>81v/
autocmd BufWinEnter *.rb match TooLong /\%<82v.\%>81v/
autocmd BufWinEnter *.java match TooLong /\%<102v.\%>101v/
autocmd Syntax * syn match RedundantSpaces /^\s*\t\+\|\s\+$/

" maps for window splitsa
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" au BufNewFile,BufRead *.vimrc,*.c,*.cc,*.h,*.java,*.thrift,*.py match TooLong /\%<82v.\%>81v/
":autocmd FileType vimrc,thrift,py,java,c,cc,cpp,sqc
"hi link TooLong Warning
"hi Warning ctermbg=Grey ctermfg=DarkRed gui=none guifg=DarkRed guibg=Grey
" autocmd colorscheme * highlight Warning ctermbg=Grey ctermfg=DarkRed gui=none guifg=DarkRed guibg=Grey
"match TooLong /\%<82v.\%>81v/

"set pastetoggle=<F10>

" map block comment/uncomment
:map <C-R> :s_^_//_
:map <C-E> :s_^\([ \t]*\)//_\1_

" fold regexes

"set foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2
"map \z :set foldmethod=expr foldlevel=0 foldcolumn=0<CR>

filetype plugin indent on

" Supertab settings
" supertab + eclim == java win
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = [ 's:ContextText', 's:ContextDiscover']
let g:SuperTabDefaultCompletionTypeDiscovery = [ "&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>" ]
"" #let g:SuperTabContextDefaultCompletionType = "<c-x><c-i>"
let g:SuperTabLongestHighlight = 1

" turn off context super tab for python since we don't have vim compiled with
" python.
"autocmd FileType py,js call SuperTabSetDefaultCompletionType("<c-x><c-i>")
" this is the call that actually works, i don't think the above does.
"autocmd BufWinEnter *.py,*.js call SuperTabSetDefaultCompletionType("<c-x><c-i>")

" Eclim settings
" ,i imports whatever is needed for current line
nnoremap <silent> ,i :JavaImport<cr>
" ,im imports all missing
nnoremap <silent> ,im :JavaImportMissing<cr>
" ,ic cleans and imports
nnoremap <silent> ,ic :JavaImportClean<cr>:JavaImportSort<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> ,d :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> ,<cr> :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> ,jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> ,jc :JavaCorrect<cr>
" ,lc opens file
nnoremap <silent> ,lc :LocateFile<cr>
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'
"split explorer vertically
let g:netrw_altv = 1
" tree style listing
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_browse_split=4

"let g:EclimLocatFileDefaultAction = "vsplit"
let g:EclimLocatFileDefaultAction = ":vsplit"
let g:EclimJavaImportPackageSeparationLevel = 1

set bg=dark
set autoread


highlight DiffAdd cterm=none ctermfg=Black ctermbg=Green gui=none guifg=Black guibg=Green
highlight DiffDelete cterm=none ctermfg=Black ctermbg=Red gui=none guifg=Black guibg=Red
highlight DiffChange cterm=none ctermfg=Black ctermbg=Yellow gui=none guifg=Black guibg=Yellow
highlight DiffText cterm=none ctermfg=Black ctermbg=Magenta gui=none guifg=Black guibg=Magenta

if has("gui")
  colorscheme inkpot
endif

source ~/.vim/csv.vim

"hack, only do this if has gui because we can only do this in MacVim.
if has("gui")
  source ~/.vim/ropevim.vim
endif
