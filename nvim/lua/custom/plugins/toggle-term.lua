return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  config = function()
    -- custom setup
    require('toggleterm').setup {
      direction = 'float', -- float|horizontal|vertical|tab
      float_opts = {
        border = 'curved', -- single|double|curved|shadow
        -- winblend = 5, -- transparency, recommended: 5
      },
      persist_mode = true,
      highlights = {
        Normal = { link = 'ToogleTermNormal' },
        NormalFloat = { link = 'ToogleTermNormalFloat' },
        FloatBorder = { link = 'ToggleTermFloatBorder' },
      },
      on_create = function()
        -- disable sign column (annoying black space at the left)
        vim.cmd [[ setlocal signcolumn=no ]]
      end,
      size = function(term)
        -- secondary terminal
        if term.display_name == '[terminal]' then
          return 10
        end

        -- default
        return vim.o.columns * 0.7
      end,
    }

    -- require toggleterm:terminal instance
    local toggleterm_terminal = require 'toggleterm.terminal'

    -- general toggleterm terminal instance
    local Terminal = toggleterm_terminal.Terminal

    -- main terminal
    local main_term = Terminal:new {
      display_name = '  TERMINAL ',
      on_open = function()
        vim.cmd [[ startinsert! ]]
      end,
    }

    -- secondary terminal
    local secondary_term = Terminal:new {
      -- cmd = "<cmd>",
      -- dir = "~/",
      display_name = '[terminal]',
      hidden = false,
      direction = 'horizontal',
      on_open = function()
        vim.cmd [[ startinsert! ]]
      end,
    }

    -- numbered terminals (1-5)
    local numbered_terms = {}
    for i = 1, 5 do
      numbered_terms[i] = Terminal:new {
        display_name = string.format('  TERMINAL %d ', i),
        on_open = function()
          vim.cmd [[ startinsert! ]]
        end,
      }
    end

    -- global: main term toggle
    function _G.main_term_toggle()
      main_term:toggle()
    end

    -- global: secondary term toggle
    function _G.secondary_term_toggle()
      secondary_term:toggle()
    end

    -- global: toggle numbered terminals with <C-1> ... <C-5>
    for i = 1, 5 do
      _G['numbered_term_toggle_' .. i] = function()
        numbered_terms[i]:toggle()
      end
    end

    -- global: attach general key shortcuts
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-b>', function()
        main_term_toggle()
      end, opts)
    end

    -- set global toggleterm keymaps
    vim.cmd [[ autocmd! TermOpen term://* lua set_terminal_keymaps() ]]
    -- keymaps for <C-1> ... <C-5> in normal mode
    for i = 1, 5 do
      vim.keymap.set({ 't', 'n' }, '<C-' .. i .. '>', function()
        _G['numbered_term_toggle_' .. i]()
      end, { noremap = true, silent = true })
    end
  end,
}
