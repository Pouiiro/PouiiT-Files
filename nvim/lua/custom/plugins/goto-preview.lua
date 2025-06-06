return {
  'olivergrass/goto-preview',
  event = 'BufEnter',
  branch = 'extend-picker-support',
  config = function()
    local preview = require 'goto-preview'

    preview.setup {
      width = 150, -- Width of the floating window
      height = 28, -- Height of the floating window
      border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
      default_mappings = false, -- Bind default mappings
      debug = false, -- Print debug information
      opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
      resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
      post_open_hook = function(buf, _)
        -- Set up key mappings to close the float immediately
        vim.api.nvim_buf_set_keymap(buf, 'n', 'Q', '<CMD>close<CR>', { noremap = true, silent = true, nowait = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', 'qq', '<CMD>close<CR>', { noremap = true, silent = true, nowait = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<CMD>close<CR>', { noremap = true, silent = true, nowait = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', '<CMD>close<CR>', { noremap = true, silent = true, nowait = true })
      end,
      post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      references = { -- Configure the telescope UI for slowing the references cycling window.
        provider = 'snacks',
        -- telescope = require("telescope.themes").get_dropdown { hide_preview = false },
      },
      -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
      focus_on_open = true, -- Focus the floating window when opening it.
      dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
      force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
      bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
      stack_floating_preview_windows = true, -- Whether to nest floating windows
      preview_window_title = { enable = true, position = 'center' }, -- Whether to set the preview window title as the filename
      zindex = 1, -- Starting zindex for the stack of floating windows
    }

    local map = vim.keymap.set
    map('n', '<C-t>', preview.goto_preview_type_definition, { desc = 'Peek type definition', noremap = true, silent = true })
    map('n', '<C-d>', preview.goto_preview_definition, { desc = 'Peek to definition', noremap = true, silent = true })
    map('n', '<C-i>', preview.goto_preview_references, { desc = 'Find implementations', noremap = true, silent = true })
  end,
}
