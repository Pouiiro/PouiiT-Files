return {
  "mistricky/codesnap.nvim",
  build = "make",
  lazy = false,
  keys = {
    { "<leader>cf", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  },
  opts = {
    save_path = "~/Pictures",
    has_breadcrumbs = true,
    bg_theme = "bamboo",
  },
}
