return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cond = function()
    return require("utils.copilot-private").is_ai_enabled()
  end,
  config = function()
    require("utils.spinner"):init()

    require("codecompanion").setup({
      strategies = {
        chat = {
          icons = {
            buffer_pin = " ",
            buffer_watch = "👀 ",
          },
          name = "copilot",
          model = "gpt-4.1",
          slash_commands = {
            ["file"] = {
              -- Location to the slash command in CodeCompanion
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file using Snacks",
              opts = {
                provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                contains_code = true,
              },
            },
            ["git_files"] = {
              description = "List git files",
              ---@param chat CodeCompanion.Chat
              callback = function(chat)
                local handle = io.popen("git ls-files")
                if handle ~= nil then
                  local result = handle:read("*a")
                  handle:close()
                  chat:add_context({ role = "user", content = result }, "git", "<git_files>")
                else
                  return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
                end
              end,
              opts = {
                contains_code = false,
              },
            },
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                  n = { "<C-b>", "gb" },
                },
              },
            },
          },
          roles = {
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter)
              return "CodeCompanion (" .. adapter.formatted_name .. ")"
            end,

            ---The header name for your messages
            ---@type string
            user = "Me",
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      opts = {
        log_level = "DEBUG",
        show_model_choices = true,
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            title = "CodeCompanion actions", -- The title of the action palette
          },
        },
        chat = {
          icons = {
            chat_context = "📎️", -- You can also apply an icon to the fold
          },
          opts = {
            wrap = true,
            number = false,
            relativenumber = false,
          },
          fold_context = true,
          fold_reasoning = true,
          intro_message = "Welcome✨! Press ? for options",
          separator = "─", -- The separator between the different messages in the chat buffer
          show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          show_tools_processing = true, -- Show the loading message when tools are being executed?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
          child_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
            row = "center",
            col = "center",
            relative = "editor",
            opts = {
              wrap = true,
              number = false,
              relativenumber = false,
            },
          },
          window = {
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
              number = false,
              relativenumber = false,
            },
          },
        },
      },
      send = {
        callback = function(chat)
          vim.cmd("stopinsert")
          chat:submit()
          chat:add_buf_message({ role = "llm", content = "" })
        end,
        index = 1,
        description = "Send",
      },
    })
  end,
}
