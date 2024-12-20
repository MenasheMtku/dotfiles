return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- Ensure opts.formatting exists
      opts.formatting = opts.formatting or {}
      opts.formatting.format = opts.formatting.format or function(entry, item)
        return item
      end

      -- Add TailwindCSS colorizer formatting
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- Add icons (original LazyVim formatter)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end

      return opts
    end,
  },
}
