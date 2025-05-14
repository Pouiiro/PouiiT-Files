return {
  'voldikss/vim-floaterm',
  lazy = false,
  config = function()
    vim.g.floaterm_shell = 'zsh'
    vim.g.floaterm_titleposition = 'center'
    vim.g.floaterm_giteditor = false
    -- vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    vim.g.floaterm_borderchars = '━┃━┃┏┓┛┗'
    -- vim.g.floaterm_borderchars = '━┃━┃╭╮╯╰'

    vim.g.floaterm_title = ' Terminal $1 out of $2 '

    vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = 'NONE', fg = '#28ffbb' })

    -- Function to create or toggle a terminal with a given number
    local function toggle_terminal(term_number)
      local term_name = 'Terminal' .. term_number
      local is_floaterm_open = vim.fn['floaterm#terminal#get_bufnr'](term_name)

      if is_floaterm_open == -1 then
        -- Create a new terminal
        vim.cmd('FloatermNew --width=120 --height=25 --name=' .. term_name)
      else
        -- Toggle the terminal
        vim.cmd('FloatermToggle ' .. term_name)
      end
    end

    -- Key mappings for Ctrl+1 to Ctrl+5
    vim.keymap.set({ 'n', 't' }, '<C-1>', function()
      toggle_terminal(1)
    end)
    vim.keymap.set({ 'n', 't' }, '<C-2>', function()
      toggle_terminal(2)
    end)
    vim.keymap.set({ 'n', 't' }, '<C-3>', function()
      toggle_terminal(3)
    end)
    vim.keymap.set({ 'n', 't' }, '<C-4>', function()
      toggle_terminal(4)
    end)
    vim.keymap.set({ 'n', 't' }, '<C-5>', function()
      toggle_terminal(5)
    end)
  end,
}
