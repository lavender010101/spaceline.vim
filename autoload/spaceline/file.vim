" =============================================================================
" Filename: spaceline.vim
" Author: glepnir
" URL: https://github.com/glepnir/spaceline.vim
" License: MIT License
" =============================================================================

function! spaceline#file#file_type() abort
  return &filetype ==? 'help'             ? '  '  :
  \      &filetype ==? 'defx'             ? '  ' :
  \      &filetype ==? 'chadtree'         ? '  ' :
  \      &filetype ==? 'nerdtree'         ? '  ' :
  \      &filetype ==? 'denite'           ? '  ' :
  \      &filetype ==? 'vim-plug'         ? '  ' :
  \      &filetype ==? 'vista'            ? ' 識' :
  \      &filetype ==? 'vista_kind'       ? '  ' :
  \      &filetype ==? 'dbui'             ? '  ' :
  \      &filetype ==? 'magit'            ? '  ' :
  \      &filetype =~? '\v^mundo(diff)?$' ? '  ' :
  \      spaceline#utils#line_is_lean() || spaceline#utils#line_is_plain() ? ' '  :
  \ ''
  " \      s:line_column()
endfunction

function! spaceline#file#cursor_line() abort
  let l:line = line('.') . "/" . line('$')
  return l:line
endfunction

function! spaceline#file#cursor_column() abort
  let l:column = line('.') . "/" . line('$')
  return l:column
endfunction

function! s:line_column()
  let l:line = line('.') . "/" . line('$')
  let l:column = col('.'). "/" . col('$')
  return ' '.l:line.' : '.l:column
endfunction


function! spaceline#file#file_size()abort
  if !filereadable(expand('%:p'))
    return ''
  endif
  return s:size(@%)
endfunction

function! spaceline#file#file_name() abort
  if empty(expand('%:t')) || index(g:spaceline_shortline_filetype, &filetype) >= 0
    return ''
  endif
  let mo = s:file_is_modified()
  let fname = s:current_file_name()
  if empty(mo)
    return fname
  else
    return fname. ''.mo
  endif
endfunction

function! spaceline#file#file_encode()
  let l:encode = (&fenc !=# "" ? &fenc : &enc)
  return ' ' . l:encode
endfunction

function! spaceline#file#file_format()
  return winwidth(0) > 70 ? (&fileformat . ' ' ) : ''
endfunction

function! s:current_file_name()
  return ('' != s:file_readonly() ? s:file_readonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction

function! s:file_is_modified() abort
  return spaceline#utils#line_is_lean() || spaceline#utils#line_is_plain() ?  ''  :
  \      &modified                                       ?  ' *' :
  \      &modifiable                                     ?  ''  : ' -'
  " \      &modified                                       ?  ' ' :
endfunction

function! s:file_readonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    " return ""
    return "!"
  else
    return ""
  endif
endfunction

function! s:size(f) abort
    let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.'b'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
  return size
endfunction
