local map = vim.keymap.set
-- [[ Basic Keymaps ]]
--  See `:help map()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
-- map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save' })
map('i', '<C-s>', '<cmd>w<cr><ESC>', { desc = 'Save' })

map('n', '<leader>q', '<cmd>qall!<cr>', { noremap = true, silent = true, desc = 'Quit' })

map('x', 'p', [["_dP]], { noremap = true, silent = true })

-- Buffer shit (tabs)
map('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'next buffer' })
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'previous buffer' })

map('n', '<C-x>', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'Open diag float' })
map('n', '<C-f>', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = 'Code actions' })
map('n', '<C-h>', function()
  vim.lsp.buf.hover { border = 'single', max_height = 25, max_width = 120, focusable = false, silent = true }
end, { noremap = true, silent = true, desc = 'Hover definition' })
map('n', '<C-j>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Show doc cmp help' })
map('n', '<C-,>', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Go to next diagnostic' })
map('n', '<C-m>', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Go to previous diagnostic' })

-- Copilot
map({ 'i', 'c' }, '<C-n>', function()
  require('copilot.suggestion').next()
end, { noremap = true, desc = 'Select next copilot', silent = true })

-- Map for <C-y> in insert and command modes
map({ 'i', 'c' }, '<C-y>', function()
  -- Accept the Copilot suggestion
  local cmp = require 'cmp'

  -- Check if cmp is active
  if cmp.visible() then
    cmp.close()
  end

  require('copilot.suggestion').accept()
end, { noremap = true, desc = 'Close cmp and accept copilot', silent = true })

map({ 'i', 'c' }, '<C-p>', function()
  require('copilot.suggestion').prev()
end, { noremap = true, desc = 'Select previous copilot', silent = true })

map({ 'n' }, '<leader>X', function()
  vim.cmd ':TSC' -- Run the TypeScript compiler
end, { noremap = true, silent = true, desc = 'Run tsc ' })

map({ 'n' }, '<leader>x', function()
  Snacks.picker.diagnostics()
end, { noremap = true, silent = true, desc = 'Show diagnostics' })

map('n', '<leader>sa', function()
  Snacks.picker.pickers()
end, { desc = 'get all pickers' })

map('n', '<C-n>', function()
  Snacks.notifier.show_history()
end, { desc = 'Notifications history' })

map('n', '<leader>sl', '<CMD>SessionSearch<CR>', { desc = 'Session lens' })
map('n', '<leader>sr', '<CMD>SessionRestore<CR>', { desc = 'Session restore' })

-- TS handlers
map('n', '<leader>tu', '<cmd>TSToolsRemoveUnusedImports<CR>', { desc = '[i] Remove unused imports' })
map('n', '<leader>tv', '<cmd>TSToolsRemoveUnused<CR>', { desc = '[v] Remove unused variables' })
map('n', '<leader>ti', '<cmd>TSToolsAddMissingImports<CR>', { desc = '[m] Add missing imports' })
map('n', '<leader>tr', '<cmd>TSToolsRenameFile<CR>', { desc = '[r] Rename file' })

-- Resize window
map('n', "<C-'>", '<C-w><')
map('n', '<C-ö>', '<C-w>>')
map('n', '<C-ä>', '<C-w>+')
map('n', '<C-å>', '<C-w>-')

-- Movement in insert mode
map('i', '<C-e>', '<C-o>A')
map('i', '<C-i>', '<C-o>I')

-- Select All
vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>normal! ggVG<CR>', { noremap = true, silent = true, desc = 'Select all' })

-- Split window
map('n', 'ss', ':split<Return>')
map('n', 'sv', ':vsplit<Return>')
map('n', 'sc', '<C-w>q')

-- Toggle term
map('n', '<leader>hh', ':TermNew size=20 direction=horizontal<cr>', { desc = 'Toggle horizontal terminal', silent = true })
map('n', '<leader>vv', ':TermNew size=60 direction=vertical<cr>', { desc = 'Toggle vertical terminal', silent = true })
map('n', '<C-b>', '<cmd>lua main_term_toggle()<cr>', { desc = 'Toggle floating terminal', silent = true })
map('n', '<leader>st', '<cmd>TermSelect<cr>', { desc = 'Open terminal selector', silent = true, noremap = true })

-- Menu
-- Keyboard users
map('n', '<C-.>', function()
  require('menu').open 'default'
end, { desc = 'Open menu with keyboard', noremap = true, silent = true })

-- mouse users + nvimtree users!
map({ 'n', 'v' }, '<RightMouse>', function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == 'NvimTree' and 'nvimtree' or 'default'

  require('menu').open(options, { mouse = true })
end, {})
