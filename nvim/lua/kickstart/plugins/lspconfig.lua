return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Setup mason.nvim first
      require('mason').setup()

      -- Diagnostic configuration
      vim.diagnostic.config {
        virtual_text = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local servers = {
        cucumber_language_server = {
          settings = {
            cucumber = {
              features = { '**/e2e/**/*.feature' },
              glue = { '**/e2e/features/**/*.steps.ts' },
            },
          },
        },
        graphql = {},
        tailwindcss = {},
        html = {},
        jsonls = {},
        yamlls = {},
        eslint = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettier',
        'eslint',
        -- 'eslint_d',
        -- 'prettierd',
      })

      -- mason-tool-installer manages installation
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Empty ensure_installed here, disable automatic installation
      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = true,
        automatic_enable = true,
      }

      -- Track started servers per root dir (to avoid duplicates)
      local started_servers = {}

      local function is_server_started(server_name, root_dir)
        if not started_servers[server_name] then
          started_servers[server_name] = {}
        end
        return started_servers[server_name][root_dir] == true
      end

      local function mark_server_started(server_name, root_dir)
        if not started_servers[server_name] then
          started_servers[server_name] = {}
        end
        started_servers[server_name][root_dir] = true
      end

      -- Map filetypes to servers
      local ft_to_servers = {
        graphql = { 'graphql' },
        gql = { 'graphql' },
        css = { 'tailwindcss' },
        scss = { 'tailwindcss' },
        html = { 'html' },
        json = { 'jsonls' },
        yaml = { 'yamlls' },
        yml = { 'yamlls' },
        lua = { 'lua_ls' },
        cucumber = { 'cucumber_language_server' },
        -- Add more if needed
      }

      local lspconfig = require 'lspconfig'

      -- Function to setup LSP dynamically per buffer
      local function setup_lsp_for_buffer(bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
        if not ft then
          return
        end

        local servers_to_start = ft_to_servers[ft]
        if not servers_to_start then
          return
        end

        -- Root dir detection fallback - adjust to your project structure
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_dir = lspconfig.util.root_pattern('package.json', '.git')(fname) or vim.loop.cwd()

        for _, server_name in ipairs(servers_to_start) do
          if not is_server_started(server_name, root_dir) then
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            server_opts.root_dir = root_dir

            lspconfig[server_name].setup(server_opts)
            mark_server_started(server_name, root_dir)

            -- REMOVE THIS LINE:
            -- lspconfig[server_name].manager.try_add(bufnr)
          end
        end
      end

      -- Auto command to detect buffer open and setup LSP accordingly
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        callback = function(args)
          setup_lsp_for_buffer(args.buf)
        end,
      })

      -- Your existing LspAttach autocommand with keymaps and highlights
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          -- Highlight references under cursor
          if client and client.supports_method and client:supports_method 'textDocument/documentHighlight' then
            local hl_group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Toggle inlay hints if supported
          if client and client.supports_method and client:supports_method 'textDocument/inlayHint' then
            map('<leader>th', function()
              local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
              if enabled then
                vim.lsp.inlay_hint.disable { bufnr = bufnr }
              else
                vim.lsp.inlay_hint.enable { bufnr = bufnr }
              end
            end, 'Toggle Inlay Hints')
          end
        end,
      })
    end,
  },
}
