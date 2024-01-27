require('telescope').setup{
    mappings = {
        n = { ["q"] = require("telescope.actions").close },
    },
}

-- telescope.setup {
--     defaults = {
--         vimgrep_arguments = {
--             "rg",
--             "-L",
--             "--color=never",
--             "--no-heading",
--             "--with-filename",
--             "--line-number",
--             "--column",
--             "--smart-case",
--         },
--         prompt_prefix = "   ",
--         selection_caret = "  ",
--         entry_prefix = "  ",
--         initial_mode = "insert",
--         selection_strategy = "reset",
--         sorting_strategy = "ascending",
--         layout_strategy = "horizontal",
--         layout_config = {
--             horizontal = {
--                 prompt_position = "top",
--                 preview_width = 0.55,
--                 results_width = 0.8,
--             },
--             vertical = {
--                 mirror = false,
--             },
--             width = 0.87,
--             height = 0.80,
--             preview_cutoff = 120,
--         },
--         file_sorter = require("telescope.sorters").get_fzy_sorter,
--         generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--         file_ignore_patterns = { "node_modules" },
--         path_display = { "truncate" },
--         winblend = 0,
--         border = {},
--         borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--         color_devicons = true,
--         set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--         file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--         grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--         qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--         -- Developer configurations: Not meant for general override
--         buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
--     },
-- }
--
--
-- -- Mappings
local map = vim.keymap.set
local builtin = require 'telescope.builtin'

-- TODO: find a better way to handle keymappings
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fa", function() builtin.find_files({follow=true, no_ignore=true, hidden=true}) end)

map("n", "<leader>fs", builtin.live_grep)
map("n", "<leader>fw", function() builtin.grep_string({search=vim.fn.expand("<cword>")}) end)
map("n", "<leader>fo", builtin.buffers)

map("n", "<leader>fg", builtin.git_files)
map("n", "<leader>fb", builtin.git_branches)

map("n", "<leader>vrc", function()
    builtin.find_files({
        prompt_title = "==  neovim  ==",
        cwd =  vim.env.DOTFILES,
        hiden = true,
    })
end)
