return {
  "nvim-neotest/neotest",
  event = "LspAttach",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    -- "thenbe/neotest-playwright",
  },
  keys = {
    { "<leader>tr", "<cmd>Neotest run <cr>", desc = "run nearest test" },
    { "<leader>tl", "<cmd>Neotest run last<cr>", desc = "run last test" },
    { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "run test file" },
    { "<leader>tt", "<cmd>Neotest summary<cr>", desc = "open list" },
  },
  config = function()
    require("neotest").setup({
      floating = {
        border = "rounded",
      },
      discovery = {
        filterDir = function(name)
          vim.notify("Filtering " .. name, vim.log.levels.INFO, { title = "neotest" })
          return name ~= "node_modules" and name ~= "e2e"
        end,
      },
      adapters = {
        require("neotest-vitest")({
          filter_dir = function(name, rel_path, root)
            local full_path = root .. "/" .. rel_path

            if full_path:match("^__tests__") then
              return true
            else
              return name ~= "node_modules"
            end
          end,
        }),
        -- require("neotest-playwright").adapter({
        --   options = {
        --     persist_project_selection = true,
        --     enable_dynamic_test_discovery = true,
        --   },
        -- }),
      },
    })
  end,
}
