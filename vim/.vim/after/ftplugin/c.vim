" OmniCppComplete initialization
" call omni#cpp#complete#Init()

" set tags+=~/.vim/tags/systags

let g:AutoPairsMapCR = 0
imap <silent><CR> <CR><Plug>AutoPairsReturn

let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'

let &makeprg = 'gcc -Wall -Wextra % -o %<'

nnoremap <silent> <F9> :w<CR>:make<CR>:cwindow<CR>

nnoremap <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --languages=c .<CR>
