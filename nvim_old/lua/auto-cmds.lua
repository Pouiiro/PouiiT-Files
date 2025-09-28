-- local blend = 50

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'snacks_picker*', 'TelescopePrompt', 'floaterm*' },
--   callback = function(ctx)
--     local backdropName = 'TelescopeBackdrop'
--     local telescopeBufnr = ctx.buf
--
--     -- `Telescope` does not set a zindex, so it uses the default value
--     -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
--     local telescopeZindex = 50
--
--     local backdropBufnr = vim.api.nvim_create_buf(false, true)
--     local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
--       relative = 'editor',
--       border = 'none',
--       row = 0,
--       col = 0,
--       width = vim.o.columns,
--       height = vim.o.lines,
--       focusable = false,
--       style = 'minimal',
--       zindex = telescopeZindex - 1, -- ensure it's below the reference window
--     })
--
--     vim.api.nvim_set_hl(0, backdropName, { bg = '#000000', default = true })
--     vim.wo[winnr].winhighlight = 'Normal:' .. backdropName
--     vim.wo[winnr].winblend = blend
--     vim.bo[backdropBufnr].buftype = 'nofile'
--
--     -- close backdrop when the reference buffer is closed
--     vim.api.nvim_create_autocmd({ 'WinClosed', 'BufLeave' }, {
--       once = true,
--       buffer = telescopeBufnr,
--       callback = function()
--         if vim.api.nvim_win_is_valid(winnr) then
--           vim.api.nvim_win_close(winnr, true)
--         end
--         if vim.api.nvim_buf_is_valid(backdropBufnr) then
--           vim.api.nvim_buf_delete(backdropBufnr, { force = true })
--         end
--       end,
--     })
--   end,
-- })

local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
vim.api.nvim_create_autocmd('User', {
  pattern = 'NvimTreeSetup',
  callback = function()
    local events = require('nvim-tree.api').events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     vim.cmd 'ShowkeysToggle'
--   end,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('lsp_buf_conf', { clear = true }),
--   callback = function(event_context)
--     local client = vim.lsp.get_client_by_id(event_context.data.client_id)
--     -- vim.print(client.name, client.server_capabilities)
--
--     if not client then
--       return
--     end
--
--     local bufnr = event_context.buf
--
--     -- Mappings.
--     local map = function(mode, l, r, opts)
--       opts = opts or {}
--       opts.silent = true
--       opts.buffer = bufnr
--       vim.keymap.set(mode, l, r, opts)
--     end
--
--     map('n', '<space>rn', vim.lsp.buf.rename, { desc = 'varialbe rename' })
--     map('n', '<space>wl', function()
--       vim.print(vim.lsp.buf.list_workspace_folders())
--     end, { desc = 'list workspace folder' })
--
--     -- The blow command will highlight the current variable and its usages in the buffer.
--     -- if client.server_capabilities.documentHighlightProvider then
--     --   local gid = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
--     --   vim.api.nvim_create_autocmd('CursorHold', {
--     --     group = gid,
--     --     buffer = bufnr,
--     --     callback = function()
--     --       vim.lsp.buf.hover { border = 'rounded' }
--     --     end,
--     --   })
--     --
--     --   vim.api.nvim_create_autocmd('CursorMoved', {
--     --     group = gid,
--     --     buffer = bufnr,
--     --     callback = function()
--     --       vim.lsp.buf.clear_references()
--     --     end,
--     --   })
--     -- end
--   end,
--   nested = true,
--   desc = 'Configure buffer keymap and behavior based on LSP',
-- })
