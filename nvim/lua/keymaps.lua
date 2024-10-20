-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- File tree keymaps
vim.keymap.set({ 'n' }, '<leader>e', function()
  local api = require 'nvim-tree.api'
  api.tree.collapse_all(true)
  api.tree.toggle { find_file = true, focus = true }
end, { desc = 'Open file tree', noremap = true, silent = true })

-- Movement in insert mode
keymap.set('i', '<C-e>', '<C-o>A')
keymap.set('i', '<C-i>', '<C-o>I')

-- Select All
keymap.set('n', '<C-a>', 'ggVG')

-- Split window
keymap.set('n', 'ss', ':split<Return>')
keymap.set('n', 'sv', ':vsplit<Return>')
keymap.set('n', 'sc', '<C-w>q')

-- Resize window
keymap.set('n', "<C-'>", '<C-w><')
keymap.set('n', '<C-ö>', '<C-w>>')
keymap.set('n', '<C-ä>', '<C-w>+')
keymap.set('n', '<C-å>', '<C-w>-')

-- Typescript
keymap.set('n', '<C-t>', ':Lspsaga peek_type_definition<cr>', { noremap = true, silent = true, desc = 'Peek to type definition' })
keymap.set('n', '<C-d>', ':Lspsaga peek_definition<cr>', { noremap = true, silent = true, desc = 'Peek to definition' })
keymap.set('n', '<C-f>', ':Lspsaga code_action<cr>', { noremap = true, silent = true, desc = 'Code actions' })
keymap.set('n', '<C-i>', ':Lspsaga finder<cr>', { noremap = true, silent = true, desc = 'Find implementations' })
keymap.set('n', '<C-h>', ':Lspsaga hover_doc<cr>', { noremap = true, silent = true, desc = 'Hover definition' })
keymap.set('n', '<C-o>', ':Lspsaga outline<cr>', { noremap = true, silent = true, desc = 'Outline of current buffer' })
keymap.set('n', '<C-n>', ':Lspsaga rename<cr>', { noremap = true, silent = true, desc = 'Rename instances' })
keymap.set('n', '<C-j>', ':lua vim.lsp.buf.signature_help()<cr>', { noremap = true, silent = true, desc = 'Show doc cmp help' })

-- Tabs
keymap.set('n', '<tab>', '<cmd>bnext<cr>', opts)
keymap.set('n', '<s-tab>', '<cmd>bprev<cr>', opts)

-- Diags move
vim.keymap.set('n', '<C-,>', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<C-m>', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

-- Save on C-s
vim.keymap.set({ 'i', 'n', 'v' }, '<C-s>', '<cmd>:w<cr><esc>', opts)

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', opts)

-- D J T C
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', opts)
-- vim.keymap.set('n', '<C-1>', '<cmd>BufferLineGroupToggle Json<cr>', opts)
-- vim.keymap.set('n', '<C-2>', '<cmd>BufferLineGroupToggle Dot<cr>', opts)
-- vim.keymap.set('n', '<C-1>', '<cmd>BufferLineGroupToggle Tests<cr>', opts)
-- vim.keymap.set('n', '<C-4>', '<cmd>BufferLineGroupToggle Config<cr>', opts)

vim.keymap.set('n', '<leader>xz', '<cmd>:DiagWindowShow<cr>', { desc = 'New diags', noremap = true, silent = true })
