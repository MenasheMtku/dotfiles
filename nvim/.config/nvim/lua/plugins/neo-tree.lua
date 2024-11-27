return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        -- Show hidden files
        filtered_items = {
          visible = true, -- Show hidden files by default
          hide_dotfiles = false, -- Show dotfiles (e.g., .gitignore)
          hide_gitignored = false, -- Show Git-ignored files
        },
        follow_current_file = true, -- Focus on the current file
        group_empty_dirs = true, -- Group empty directories
      },
      window = {
        mappings = {
          ["<C-a>"] = "reveal", -- Reveal current file in Neo-tree
          ["a"] = "add", -- Add a file
          ["A"] = "add_directory", -- Add a directory
          ["r"] = "rename", -- Rename a file/directory
          ["d"] = "delete", -- Delete a file/directory
          ["y"] = "copy", -- Copy a file/directory
          ["p"] = "paste", -- Paste a file/directory
          ["H"] = "toggle_hidden", -- Toggle hidden files visibility
        },
      },
      default_component_configs = {
        indent = {
          padding = 1, -- Padding for tree structure
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        name = {
          trailing_slash = false,
        },
      },
    })

    -- Keybinding to open Neo-tree
    vim.keymap.set("n", "<C-a>", ":Neotree filesystem reveal left<CR>", { noremap = true, silent = true })
  end,
}

