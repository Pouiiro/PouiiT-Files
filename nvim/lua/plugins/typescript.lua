return {
  {
    {
      "pmizio/typescript-tools.nvim",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      event = "VeryLazy",
      config = function()
        require("typescript-tools").setup({
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
          settings = {
            code_lens = nil,
            separate_diagnostic_server = true,
            -- "change"|"insert_leave" determine when the client asks the server about diagnostic
            publish_diagnostic_on = "insert_leave",
            -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
            -- "remove_unused_imports"|"organize_imports") -- or string "all"
            -- to include all supported code actions
            expose_as_code_action = { "add_missing_imports" },
            tsserver_file_preferences = {
              includeCompletionsWithSnippetText = true,
              includeAutomaticOptionalChainCompletions = true,
              includeInlayFunctionParameterTypeHints = "all",
              includeCompletionsForImportStatements = true,
              includeInlayParameterNameHints = "all",
              includeCompletionsForModuleExports = true,
              importModuleSpecifierPreference = "non-relative",
              quotePreference = "single",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
              displayPartsForJSDoc = true,
              generateReturnInDocTemplate = true,
              autoImportFileExcludePatterns = { "**/__mocks__/**" },
            },
            jsx_close_tag = {
              enable = true,
            },
          },
        })
      end,
    },
  },
}
