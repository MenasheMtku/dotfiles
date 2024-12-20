return {
--  "nvimtools/none-ls.nvim",
--  config = function()
--    local null_ls = require("null-ls")
--    null_ls.setup({
--      sources = {
--        null_ls.builtins.formatting.stylua,
--        null_ls.builtins.diagnostics.erb_lint,
--        null_ls.builtins.diagnostics.rubocop,
--        null_ls.builtins.formatting.rubocop,
--        null_ls.builtins.formatting.prettier.with({
--          filetypes = {
--            "html",
--            "css",
--            "scss",
--            "javascript",
--            "javascriptreact",
--            "typescript",
--            "typescriptreact",
--            "vue",
--            "svelte",
--          },
--          extra_args = { "--plugin=prettier-plugin-tailwindcss" }, -- Add TailwindCSS support
--        }),
--      },
--    })

    --vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

    -- Keybinding to format the current file
--    vim.keymap.set("n", "<leader>gf", function()
    --  vim.lsp.buf.format({ async = true })
--    end, { desc = "Format code with null-ls" })
--  en------d,
}
