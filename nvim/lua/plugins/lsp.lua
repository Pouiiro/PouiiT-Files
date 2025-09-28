return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    keys[#keys + 1] = { "<leader>ca", false }
    keys[#keys + 1] = { "<leader>cA", false }

    local editedOpts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
      },
      servers = {
        cucumber_language_server = {
          settings = {
            cucumber = {
              features = { "**/e2e/**/*.feature" },
              glue = { "**/e2e/features/**/*.steps.ts" },
            },
          },
        },
        graphql = {},
        tailwindcss = {},
        biome = {},
      },
    }

    return vim.tbl_deep_extend("force", opts, editedOpts)
  end,
}
