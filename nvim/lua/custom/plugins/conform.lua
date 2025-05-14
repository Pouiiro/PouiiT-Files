return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        json = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        css = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        graphql = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        html = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        bash = { 'shfmt', 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        sh = { 'shfmt', 'prettierd', 'prettier', 'biome-check', 'biome', stop_after_first = true },
        cucumber = { 'reformat-gherkin' },
      },
    },
  },
}
