" =============================================================================
" Filename: spaceline.vim
" Author: glepnir
" URL: https://github.com/glepnir/spaceline.vim
" License: MIT License
" =============================================================================

function! spaceline#vimode#vim_mode()
  let status= exists('g:spaceline_custom_vim_status') ? get(g:,'spaceline_custom_vim_status') : 
			  \ {"n": "NORMAL",
			  \ "V":"VISUAL",
			  \ "v":"VISUAL",
			  \ "\<C-v>": "VISUAL",
			  \ "i":"INSERT",
			  \ "R":"REPLACE",
			  \ "r":"REPLACE",
			  \ "s":"🅢  ",
			  \ "t":"🅣  ",
			  \ "c":"🅒  ",
			  \ "!":"SE "}
  return status[mode()]
endfunction
