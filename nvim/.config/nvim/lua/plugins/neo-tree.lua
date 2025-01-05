return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,          -- Show hidden files by default
          hide_dotfiles = false,   -- Ensure dotfiles are visible
          hide_gitignored = false, -- Show files ignored by .gitignore
          never_show = {           -- Ensure specific folders/files are never hidden
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    })
    -- Keymaps
    vim.keymap.set("n", "<C-a>", ":Neotree filesystem reveal toggle left<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal toggle float<CR>", {})
  end,
}
