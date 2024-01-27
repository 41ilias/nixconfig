-- local present, treesitter-context = pcall(require, "treesitter-context")
-- if not present then
--     return
-- end

require'nvim-treesitter.configs'.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = false,
    },
})
