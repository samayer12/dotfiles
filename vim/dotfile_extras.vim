" these functions aren't loaded at startup, but only when they are invoked
" (see :help autoload)

if (!exists('s:dotfile_extras_script'))
  let s:dotfile_extras_script = expand('<sfile>')
  autocmd BufWritePost dotfile_extras.vim exec 'source ' . s:dotfile_extras_script
endif

function! dotfile_extras#MakeEslint(targets)
  let l:eslintBin = dotfile_extras#FindEslintBinary()
  let l:targets = a:targets
  if (len(l:targets) == 0)
    let l:targets = './'
  endif
  set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m
  set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m
  exec 'set makeprg=' . l:eslintBin
  echom 'make ' . l:targets . ' --format compact'
  exec 'make ' . l:targets . ' --format compact'
endfunction
function! dotfile_extras#FindEslintBinary()
  let l:eslintBin = 'node_modules/.bin/eslint'
  if (empty(glob(l:eslintBin)))
    echom 'using global eslint'
    let l:eslintBin = system('command -v eslint')
  endif
  if (empty(l:eslintBin))
    echoerr "Can't find eslint"
    return
  endif
  return l:eslintBin
endfunction

" puts all eslint issues into quickfix list
function! dotfile_extras#rungulpeslint()
  " expects the built-in 'compact' formatter
  set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m
  set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m
  set makeprg=gulp
  make eslint --machine-format
endfunction

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

func! dotfile_extras#ProseMode()
  Goyo

  " booleans
  let b:autoindent    = &autoindent
  let b:copyindent    = &copyindent
  let b:list          = &list
  let b:showcmd       = &showcmd
  let b:showmode      = &showmode
  let b:smartindent   = &smartindent
  let b:spell         = &spell

  " non-booleans
  let b:complete      = &complete
  let b:formatoptions = &formatoptions
  let b:sidescrolloff = &sidescrolloff
  let b:whichwrap     = &whichwrap

  setlocal nocopyindent nolist noshowcmd noshowmode nosmartindent spell
  setlocal complete+=s formatoptions=tcq formatoptions+=an sidescrolloff=0 whichwrap+=h,l
  "        ^ complete from thesarus
  "                    ^ default formatoptions
  "                                      ^ add Auto-format and Numbered lists

  set autoindent " appears necessary to have paragraph formatting keep indent past the 2nd line

  LightOne " setlocal bg=light
  hi SpellBad guibg=pink guifg=red
  " my terminals don't undercurl, as termguicolor would have them do, so
  " mispelled words must be highlighted
  hi EndOfBuffer ctermfg=bg guifg=bg
  " hide "~" at end of buffer
endfu
if (!exists('*dotfile_extras#CodeMode')) " this function sources vimrc and you can't redefine function while it's executing
  func dotfile_extras#CodeMode()
    Goyo!
    exec 'setlocal ' . (b:autoindent  ? '':'no') . 'autoindent'
    exec 'setlocal ' . (b:copyindent  ? '':'no') . 'copyindent'
    exec 'setlocal ' . (b:list        ? '':'no') . 'list'
    exec 'setlocal ' . (b:showcmd     ? '':'no') . 'showcmd'
    exec 'setlocal ' . (b:showmode    ? '':'no') . 'showmode'
    exec 'setlocal ' . (b:smartindent ? '':'no') . 'smartindent'
    exec 'setlocal ' . (b:spell       ? '':'no') . 'spell'
    exec 'setlocal complete='     .b:complete
    exec 'setlocal formatoptions='.b:formatoptions
    exec 'setlocal sidescrolloff='.b:sidescrolloff
    exec 'setlocal whichwrap='    .b:whichwrap
    source $MYVIMRC
  endfu
endif


" I very rarely use this because scrolling can get really funky (a paragraph
" is either all-visible or all-hidden. It's still nice to have for when you
" need to read long paragraphs in vim.
func! dotfile_extras#SoftWrappedProcessorMode()
  Goyo 80
  setlocal nonumber
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  setlocal breakindent
  map <buffer> j gj
  map <buffer> k gk
  " setlocal formatprg=par -jw80
  "setlocal spell spelllang=en_us
  "set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  "set complete+=s
endfu

" visor style terminal buffer
  " https://www.reddit.com/r/neovim/comments/3cu8fl/quick_visor_style_terminal_buffer/
if (!exists('s:termbuf'))
  let s:termbuf = 0
endif
function! dotfile_extras#ToggleTerm()

  "normal mx
  "normal H
  botright 20 split
  "wincmd p
  "normal `x
  "wincmd p

  if (s:termbuf && bufexists(s:termbuf))
    exe 'buffer' . s:termbuf
  else
    echom s:termbuf . ' does not exist'
    terminal ++curwin
    let s:termbuf=bufnr('%')
    "tnoremap <buffer> <F4> <C-\><C-n>:close<cr>
    tnoremap <buffer> <F4> <C-w><C-q>
    nnoremap <buffer> <F4> i<C-w><C-q>
    vnoremap <buffer> <F4> <esc>i<C-w><C-q>
  endif
endfunction
