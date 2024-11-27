return  {
  "catppuccin/nvim",
  lazy = false ,
  name = "catppuccin",
  priority = 1000,
  config = function()
    --   require("catppuccin").setup({
    --   flavour = "macchiato",
    -- })
    -- Apply theme
    vim.cmd.colorscheme "catppuccin"
  end
}
