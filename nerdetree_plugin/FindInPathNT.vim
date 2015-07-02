" Author: Kyle Ferguson @kylegferg
" License: MIT

if exists("g:loaded_find_in_path_nt")
    finish
endif
let g:loaded_find_in_path_nt = 1

call NERDTreeAddMenuItem({'text': '(f)ind in path', 'shortcut': 'f', 'callback': 'FindInPathRecursively'})

function! FindInPathRecursively()
    let s:currentDirNode = g:NERDTreeDirNode.GetSelected()
    let s:path = s:currentDirNode.path.str()

    let s:pattern = input("Text to find in ".s:path."\n".
                    \ "----------------------------------------------------\n")

    execute "FindInPath ".s:path." ".s:pattern
endfunction
