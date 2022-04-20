" OmniCppComplete initialization
" call omni#cpp#complete#Init()

set tags+=~/.vim/tags/systags

" let g:AutoPairsMapCR = 0
" imap <silent><CR> <CR><Plug>AutoPairsReturn

" let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'
let g:ycm_clangd_binary_path = '/usr/local/bin/clangd'

let &makeprg = "gcc -Wall -Wextra % -o %<"

let &equalprg = "clang-format %"

nnoremap <buffer> <silent> <F9> :w<CR>:make<CR>:cwindow<CR>
nnoremap <buffer> <silent> <F10> :!%:p:r<CR>

nnoremap <buffer> <C-F12> :w<CR>:!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --languages=c --langmap=c:.c.h .<CR>

iabbrev <buffer> #i #include
iabbrev <buffer> #d #define
iabbrev <buffer> cc /*<CR><CR>/<Up>
iabbrev <buffer> forl for (int i = 0; i <NUM; i++) {<CR>}<Esc>?NUM<CR>cw
iabbrev <buffer> iff if (##) {<CR>}<Esc>?#<CR>nc2l
