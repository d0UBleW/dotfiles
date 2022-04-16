" OmniCppComplete initialization
" call omni#cpp#complete#Init()

" let g:AutoPairsMapCR = 0
" imap <silent><CR> <CR><Plug>AutoPairsReturn

" let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'
let g:ycm_clangd_binary_path = '/usr/local/bin/clangd'

let &makeprg = 'g++ -Wall -Wextra -std=c++17 % -o %<'

nnoremap <buffer> <silent> <F9> :w<CR>:make<CR>:cwindow<CR>
nnoremap <buffer> <silent> <S-F9> :!compile-cpp<CR>
nnoremap <buffer> <silent> <F10> :!"%:p:r"<CR>
nnoremap <buffer> <silent> <S-F10> :!./main.out<CR>
nnoremap <buffer> <silent> <leader>f zfa{

nnoremap <buffer> <C-F12> :w<CR>:!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --languages=c++ .<CR>

" set tags+=~/.vim/tags/systags

set tags+=~/.vim/tags/cpp_src
" let OmniCpp_NamespaceSearch = 1
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_ShowAccess = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" let OmniCpp_MayCompleteDot = 1 " autocomplete after .
" let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
" let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
" let OmniCpp_DefaultNamespaces = ['std', '_GLIBCXX_STD']

iabbrev <buffer> incl #include
iabbrev <buffer> defi #define
iabbrev <buffer> cc /*<CR><CR>/<Up>
iabbrev <buffer> forl for (int i = 0; i <NUM; i++) {<CR>}<Esc><Esc>?NUM<CR>cw
iabbrev <buffer> iff if (##) {<CR>}<Esc>?#<CR>nc2l
