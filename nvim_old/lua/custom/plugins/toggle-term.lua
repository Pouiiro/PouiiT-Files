return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      persist_mode = true,
      highlights = {
        Normal = { link = 'ToogleTermNormal' },
        NormalFloat = { link = 'ToogleTermNormalFloat' },
        FloatBorder = { link = 'ToggleTermFloatBorder' },
      },
      on_create = function()
        vim.cmd [[ setlocal signcolumn=no ]]
      end,
      size = function(term)
        if term.display_name == '[terminal]' then
          return 10
        end
        return vim.o.columns * 0.7
      end,
    }

    local Terminal = require('toggleterm.terminal').Terminal

    -- Lazy main terminal
    local main_term = nil
    function _G.main_term_toggle()
      if not main_term then
        main_term = Terminal:new {
          display_name = '  TERMINAL ',
          on_open = function()
            vim.cmd [[ startinsert! ]]
          end,
        }
      end
      main_term:toggle()
    end

    -- Lazy secondary terminal
    local secondary_term = nil
    function _G.secondary_term_toggle()
      if not secondary_term then
        secondary_term = Terminal:new {
          display_name = '[terminal]',
          hidden = false,
          direction = 'horizontal',
          on_open = function()
            vim.cmd [[ startinsert! ]]
          end,
        }
      end
      secondary_term:toggle()
    end

    -- Lazy numbered terminals (1–5)
    local numbered_terms = {}

    for i = 1, 5 do
      _G['numbered_term_toggle_' .. i] = function()
        if not numbered_terms[i] then
          numbered_terms[i] = Terminal:new {
            display_name = string.format('  TERMINAL %d ', i),
            on_open = function()
              vim.cmd [[ startinsert! ]]
            end,
          }
        end
        numbered_terms[i]:toggle()
      end
    end

    -- Keymaps in terminal mode
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-b>', function()
        main_term_toggle()
      end, opts)
    end

    vim.cmd [[ autocmd! TermOpen term://* lua set_terminal_keymaps() ]]

    -- Global keymaps for numbered terminals
    for i = 1, 5 do
      vim.keymap.set({ 't', 'n' }, '<C-' .. i .. '>', function()
        _G['numbered_term_toggle_' .. i]()
      end, { noremap = true, silent = true })
    end
  end,
}
