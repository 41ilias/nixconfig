local map = vim.keymap.set


map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- WIP
map('n', 'Q', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>' , { desc = 'close buffer'})

map('n', 'J', 'mzJ`z' , { desc = 'append next line to current line'})

map('n', '<ESC>', vim.cmd.noh, { desc = 'stop highlighting search'})

map('n', 'n', 'nzzzv', { desc = 'center and unfold next item while searching'})
map('n', 'N', 'Nzzzv', { desc = 'center and unfold prev item while searching'})

map('n', '<C-d>', '<C-d>zz', { desc = 'center the line when scrolling down'})
map('n', '<C-u>', '<C-u>zz', { desc = 'center the line when scrolling up'})

map({'n', 'v'}, '<leader>y', '\"+y', { desc = 'yank to clipboard'})
map({'n', 'v'}, '<leader>Y', '\"+Y', { desc = 'yank until EOL to clipboard'})
map({'n', 'v'}, '<leader>d', '\"_d', { desc = 'delete to blackhole'})
map({'n', 'v'}, '<leader>D', '\"_D', { desc = 'delete until EOL to blackhole'})

map('x', '<leader>p', '\"_dP', { desc = 'Paste over selection without loosing it'})

-- WIP
-- map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "tmux-sessionizer"} )

map("v", "K", ":m '<-2<CR>gv=gv", { desc = 'move up visual selection'})
map("v", "J", ":m '>+1<CR>gv=gv", { desc = 'move down visual selection'})

map("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "move down in quickfix list"} )
map("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "move up in quickfix list"} )

-- Learn about location lists
map("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "move down in location list"} )
map("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "move up in location list"} )
