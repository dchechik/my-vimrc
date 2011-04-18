
" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^	]*	\)\{'.n.'}\zs[^	]*/'
    execute 'normal! 0'.n.'f	'
  elseif a:colnr == 1
    match Keyword /^[^\t	]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
