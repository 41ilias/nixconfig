-- local ok, oil = pcall(require, "oil")
-- if not ok then
--     return
-- end
--
local oil = require 'oil'
oil.setup({
    default_file_explorer = false,
    float = {
        max_width = 150,
        max_height = 20,
    }
})

vim.keymap.set('n', '<leader>e', oil.toggle_float, { desc = 'toggle file [E]xplorer'})
