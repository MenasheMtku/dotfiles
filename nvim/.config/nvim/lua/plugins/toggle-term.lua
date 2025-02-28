return {
  {
    --https://github.com/akinsho/toggleterm.nvim
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<C-\>]], -- Change to any keybinding
        direction = "float",      -- Options: 'vertical', 'horizontal', 'float', 'tab'
        persist_mode = true,
      }
    end
  }
}
