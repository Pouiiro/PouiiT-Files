return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>ci',
        '<cmd>TSToolsRemoveUnusedImports<cr>',
        -- function()
        --   local bufnr = vim.api.nvim_get_current_buf()
        --   require("typescript-tools")
        --   require('vtsls').commands['remove_unused_imports'](bufnr)
        --   save_buffer_after_delay(100)
        -- end,
        mode = '',
        desc = '[i] Remove unused imports',
      },
      {
        '<leader>cv',
        '<cmd>TSToolsRemoveUnused<cr>',
        -- function()
        --   local bufnr = vim.api.nvim_get_current_buf()
        --   require('vtsls').commands['remove_unused'](bufnr)
        --   save_buffer_after_delay(100)
        -- end,
        mode = '',
        desc = '[v] Remove unused variables',
      },
      {
        '<leader>cm',
        '<cmd>TSToolsAddMissingImports<cr>',
        -- function()
        --   local bufnr = vim.api.nvim_get_current_buf()
        --   require('vtsls').commands['add_missing_imports'](bufnr)
        --   save_buffer_after_delay(100)
        -- end,
        mode = '',
        desc = '[m] Add missing imports',
      },
    },
    opts = {
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', stop_after_first = true },
        typescript = { 'prettierd', stop_after_first = true },
        javascriptreact = { 'prettierd', stop_after_first = true },
        typescriptreact = { 'prettierd', stop_after_first = true },
        css = { 'prettierd', stop_after_first = true },
        html = { 'prettierd', stop_after_first = true },
        json = { 'prettierd', stop_after_first = true },
        yaml = { 'prettierd', stop_after_first = true },
        markdown = { 'prettierd', stop_after_first = true },
        graphql = { 'prettierd', stop_after_first = true },
        nix = { 'alejandra' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
