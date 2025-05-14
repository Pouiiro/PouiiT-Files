return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local keymap = vim.keymap
    local nvim_tree = require 'nvim-tree'

    nvim_tree.setup {
      update_focused_file = {
        enable = true,
      },
      update_cwd = true,
      hijack_cursor = true,
      git = {
        ignore = false,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      view = {
        width = 38,
      },
      renderer = {
        highlight_git = true,
        root_folder_modifier = ':t',
        icons = {
          glyphs = {
            default = '',
            symlink = '',
            bookmark = '◉',
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '',
              deleted = '',
              untracked = '',
              ignored = '',
            },
            folder = {
              default = '',
              open = '',
              symlink = '',
            },
          },
          show = {
            git = false,
            file = true,
            folder = true,
            folder_arrow = false,
          },
        },
        indent_markers = {
          enable = true,
        },
      },
    }

    keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { silent = true })
    keymap.set('n', '<leader>E', '<Cmd>NvimTreeFindFile<CR>z.', { silent = true })
  end,
  -- opts = {
  --   update_focused_file = {
  --     enable = true,
  --   },
  -- },
}
