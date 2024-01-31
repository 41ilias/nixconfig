require'catppuccin'.setup {
    flavour = "mocha",
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
}

vim.cmd.colorscheme "catppuccin"
