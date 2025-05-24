return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  enabled = false,
  config = function()
    require('dropbar').setup {
      icons = {
        enable = true,
        kinds = {
          use_devicons = true,
          symbols = {
            Folder = '󰉋 ',
          },
        },
        ui = {
          bar = {
            separator = ' ',
            extends = '…',
          },
          menu = {
            separator = ' ',
            indicator = ' ',
          },
        },
      },
      bar = {
        enable = function(buf, win)
          return not vim.api.nvim_win_get_config(win).zindex
            and vim.bo[buf].buftype == ''
            and vim.api.nvim_buf_get_name(buf) ~= ''
            and not vim.wo[win].diff
            and vim.filetype ~= 'terminal'
            and not vim.api.nvim_buf_get_name(buf):find 'Neogit'
            and not vim.api.nvim_buf_get_name(buf):find 'Trouble'
            and not vim.api.nvim_buf_get_name(buf):find 'undotree'
            and not vim.api.nvim_buf_get_name(buf):find 'diffpanel'
        end,
        sources = function(buf, _)
          local sources = require 'dropbar.sources'
          local utils = require 'dropbar.utils'
          local filename = {
            get_symbols = function(buff, win, cursor)
              local symbols = sources.path.get_symbols(buff, win, cursor)
              return { symbols[#symbols] }
            end,
          }
          if vim.bo[buf].ft == 'markdown' then
            return {
              filename,
              utils.source.fallback {
                sources.treesitter,
                sources.markdown,
                sources.lsp,
              },
            }
          end
          return {
            filename,
            utils.source.fallback {
              sources.lsp,
              sources.treesitter,
            },
          }
        end,
      },
    }
  end,
}
