" dotfile_extras.vim - Optional/deferred vim configurations 
" (see :help autoload)
" Author:       Jon Smithers <mail@jonsmithers.link>
" URL:          https://github.com/jonsmithers/dotfiles/blob/master/vim/dotfile_extras.vim
" Last Updated: 2019-08-23

if (!exists('s:dotfile_extras_script'))
  let s:dotfile_extras_script = expand('<sfile>')
  autocmd BufWritePost dotfile_extras.vim exec 'source ' . s:dotfile_extras_script
endif

function! dotfile_extras#ToggleScrollMode()
  if exists('s:scroll_mode')
    unmap k
    unmap j
    unmap d
    unmap u
    unlet s:scroll_mode
    echom 'scroll mode off'
  else
    nnoremap j <C-e>j
    nnoremap k <C-y>k
    nnoremap d <C-d>
    nnoremap u <C-u>
    let s:scroll_mode = 1
    echom 'scroll mode on'
  endif
endfunction

