return {
  'nvim-pack/nvim-spectre',
  event = 'VeryLazy',
  config = function()
    require('spectre').setup {
      live_update = true,
      open_cmd = 'VNewFloat',
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = {
            '-i',
            '',
            '-E',
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = 'Toggle Spectre',
    })
    vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = 'Search current word',
    })
    vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = 'Search on current file',
    })

    -- Function to open a floating window
    local function open_float()
      -- Define window width and height
      local width = math.floor(vim.o.columns * 0.8) -- 40% of the total width
      local height = math.floor(vim.o.lines * 0.7) -- 40% of the total height

      -- Calculate the starting row and column to center the window
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      -- Create a buffer for the floating window
      local buf = vim.api.nvim_create_buf(false, true) -- [false: listed, true: scratch]

      -- Set the options for the floating window
      local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded', -- Can use single, double, shadow, etc.
      }

      -- Open the floating window
      vim.api.nvim_open_win(buf, true, opts)
    end

    vim.api.nvim_create_user_command('VNewFloat', open_float, {})
  end,
}
