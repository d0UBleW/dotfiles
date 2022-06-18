" let b:dispatch = "python3 %"

nnoremap <F10> :Start -wait=always /usr/bin/env python3 %<CR>
nnoremap <C-F10> :Start -wait=always /usr/bin/env python3 % 

setlocal wildignore=*.pyc
setlocal suffixesadd=.py

setlocal include=^\\s*\\<\\(import\\\|from\\)\\>\\s*\\zs\\(\\S\\+\\s\\{-\\}\\)*\\ze\\($\\\|\ as\\)

function! PyInclude(fname)
    let parts = split(a:fname, ' import ')
    let l = parts[0]
    if len(parts) > 1
        let r = parts[1]
        let l = join([l, r], '.')
    endif
    let fp = substitute(l, '\.', '/', 'g') . '.py'
    let found = glob(fp, 1)
    if len(found)
        return found
    endif
endfunction

setlocal includeexpr=PyInclude(v:fname)
iabbrev <buffer> iff if :<left>
iabbrev <buffer> cc '''<CR>
