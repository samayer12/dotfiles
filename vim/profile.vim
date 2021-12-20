Plug 'nathangrigg/vim-beancount'
" {{{
augroup vimrc_beancount
  au!
  autocmd FileType beancount let b:beancount_root='main.beancount'
augroup END

augroup vimrc_beancount2
  au!
  autocmd FileType beancount command! -buffer BeancountFormat call <SID>FormatBeancountFile()
augroup END

fun! <SID>FormatBeancountFile()
  diffoff
  let l:file = expand('%')
  vnew
  exec 'read ! bean-format '.l:file
  normal ggdd
  let &filetype='beancount'
  setlocal readonly nomodified nobuflisted bufhidden=delete buftype=nofile noswapfile
  autocmd QuitPre <buffer> diffoff!
  autocmd BufHidden <buffer> diffoff!
  diffthis
  wincmd p
  diffthis
endfun

let g:markdown_fenced_languages += ['beancount']
" }}}

fun! g:ConfigAerial()
  lua <<EOF
  vim.g.aerial = {
    backends = { "lsp", "markdown" },
    -- Enum: persist, close, auto, global
    --   persist - aerial window will stay open until closed
    --   close   - aerial window will close when original file is no longer visible
    --   auto    - aerial window will stay open as long as there is a visible
    --             buffer to attach to
    --   global  - same as 'persist', and will always show symbols for the current buffer
    close_behavior = "auto",

    -- Set to false to remove the default keybindings for the aerial buffer
    default_bindings = true,

    -- Enum: prefer_right, prefer_left, right, left, float
    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    default_direction = "prefer_right",

    -- A list of all symbols to display. Set to false to display all symbols.
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Method",
      "Struct",
    },

    -- Enum: split_width, full_width, last, none
    -- Determines line highlighting mode when multiple buffers are visible
    highlight_mode = "split_width",

    -- When jumping to a symbol, highlight the line for this many ms
    -- Set to 0 or false to disable
    highlight_on_jump = 300,

    -- Fold code when folding the tree. Only works when manage_folds is enabled
    link_tree_to_folds = true,

    -- Fold the tree when folding code. Only works when manage_folds is enabled
    link_folds_to_tree = false,

    -- Use symbol tree for folding. Set to true or false to enable/disable
    -- 'auto' will manage folds if your previous foldmethod was 'manual'
    manage_folds = "auto",

    -- The maximum width of the aerial window
    max_width = 40,

    -- The minimum width of the aerial window.
    -- To disable dynamic resizing, set this to be equal to max_width
    min_width = 10,

    -- Set default symbol icons to use Nerd Font icons (see https://www.nerdfonts.com/)
    nerd_font = "auto",

    -- Whether to open aerial automatically when entering a buffer.
    -- Can also be specified per-filetype as a map (see below)
    open_automatic = false,

    -- If open_automatic is true, only open aerial if the source buffer is at
    -- least this long
    open_automatic_min_lines = 0,

    -- If open_automatic is true, only open aerial if there are at least this many symbols
    open_automatic_min_symbols = 0,

    -- Set to true to only open aerial at the far right/left of the editor
    -- Default behavior opens aerial relative to current window
    placement_editor_edge = false,

    -- Run this command after jumping to a symbol (false will disable)
    post_jump_cmd = "normal! zz",

    -- If close_on_select is true, aerial will automatically close after jumping to a symbol
    close_on_select = false,

    -- Options for opening aerial in a floating win
    float = {
      -- Controls border appearance. Passed to nvim_open_win
      border = "rounded",

      -- Controls row offset from cursor. Passed to nvim_open_win
      row = 1,

      -- Controls col offset from cursor. Passed to nvim_open_win
      col = 0,

      -- The maximum height of the floating aerial window
      max_height = 100,

      -- The minimum height of the floating aerial window
      -- To disable dynamic resizing, set this to be equal to max_height
      min_height = 4,
    },

    lsp = {
      -- Fetch document symbols when LSP diagnostics change.
      -- If you set this to false, you will need to manually fetch symbols
      diagnostics_trigger_update = true,

      -- Set to false to not update the symbols when there are LSP errors
      update_when_errors = true,
    },

    treesitter = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },

    markdown = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },
  }
EOF
endfun
PlugIfNeovim 'stevearc/aerial.nvim', {}, function('g:ConfigAerial')

fun! g:ConfigDressing()
  lua <<EOF
    require('dressing').setup({
      input = {
        -- Default prompt string
        default_prompt = "➤ ",

        -- When true, <Esc> will close the modal
        insert_only = true,

        -- These are passed to nvim_open_win
        anchor = "SW",
        relative = "cursor",
        row = 0,
        col = 0,
        border = "rounded",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        max_width = nil,
        min_width = 20,

        -- Window transparency (0-100)
        winblend = 10,
        -- Change default highlight groups (see :help winhl)
        winhighlight = "",

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf", "builtin", "nui" },

        -- Options for telescope selector
        telescope = {
          -- can be 'dropdown', 'cursor', or 'ivy'
          theme = "dropdown",
          },

        -- Options for fzf selector
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
            },
          },

        -- Options for nui Menu
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
            },
          max_width = 80,
          max_height = 40,
          },

        -- Options for built-in selector
        builtin = {
          -- These are passed to nvim_open_win
          anchor = "NW",
          relative = "cursor",
          row = 0,
          col = 0,
          border = "rounded",

          -- Window transparency (0-100)
          winblend = 10,
          -- Change default highlight groups (see :help winhl)
          winhighlight = "",

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          width = nil,
          max_width = 0.8,
          min_width = 40,
          height = nil,
          max_height = 0.9,
          min_height = 10,
          },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
      },
    })
EOF
endfun
PlugIfNeovim 'stevearc/dressing.nvim', {}, function('g:ConfigDressing')
