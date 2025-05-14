-- typescript enhancements

return {
  'pmizio/typescript-tools.nvim',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  event = 'VeryLazy',
  config = function()
    require('typescript-tools').setup {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        code_lens = 'all',
        publish_diagnostic_on = 'change',
        expose_as_code_action = 'all',
        tsserver_file_preferences = {
          includeCompletionsWithSnippetText = true,
          includeAutomaticOptionalChainCompletions = true,
          includeInlayFunctionParameterTypeHints = 'all',
          includeCompletionsForImportStatements = true,
          includeInlayParameterNameHints = 'all',
          includeCompletionsForModuleExports = true,
          importModuleSpecifierPreference = 'non-relative',
          quotePreference = 'single',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          displayPartsForJSDoc = true,
          generateReturnInDocTemplate = true,
        },
        separate_diagnostic_server = true,
        jsx_close_tag = {
          enable = false,
        },
      },
    }
  end,
}
