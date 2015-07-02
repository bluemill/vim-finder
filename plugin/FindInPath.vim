" Author: Kyle Ferguson @kylegferg
" License: MIT

if exists("g:loaded_find_in_path")
    finish
endif
let g:loaded_find_in_path = 1

let s:current_directory = getcwd()

function! s:searchInPath(...)

    " argument validation
    if a:0 < 2
        echohl WarningMsg
        echomsg "Missing required arguments"
        echomsg ":FindInPath {path} {search}"
        echohl None
        return
    endif
    let s:path = a:1
    let s:pattern = a:2

    " strip slashes from the ends
    let s:path_stripped = substitute(s:path, '/$', '', '')

    " set search pattern and search path to use with grep
    let s:search_pattern = '/' . s:pattern . '/gj'
    let s:search_path = s:path_stripped . '/**/*'

    " try to execute grep, catch errors
    try
        execute 'vimgrep '.s:search_pattern.' '.s:search_path
        execute 'cw'
    catch /^Vim\%((\a\+)\)\=:E/
        echohl WarningMsg
        echomsg 'Make sure you specify a path RELATIVE to your current working directory.'
        echomsg 'Your current working directory is '.s:current_directory
        echohl None
    endtry
endfunction

command! -nargs=* -complete=file FindInPath :call s:searchInPath(<f-args>)
