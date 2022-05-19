function! GetBranchName()
  let l:fugitive_out = fugitive#Statusline()
  let l:branch_name = matchlist(l:fugitive_out, '\[Git(\(.*\))\]')
  if (len(l:branch_name) != 0)
    return l:branch_name[1] . " "
  endif
  return "NO GIT "
endfunction

function! mystatusline#SetStatusLine()

  set statusline=
  set statusline+=%#PmenuSel#
  set statusline+=\ %{GetBranchName()}
  " set statusline+=%#LineNr#
  set statusline+=%#StatusLine#
  set statusline+=\ %t
  set statusline+=\ %m
  set statusline+=\ %r
  set statusline+=%=
  set statusline+=%#StatusLine#
  " set statusline+=%#CursorColumn#
  set statusline+=\ buf:
  set statusline+=\ %n
  set statusline+=\ %y
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
  set statusline+=\ [%{&fileformat}\]
  set statusline+=\ %c:%l/%L
endfunction
