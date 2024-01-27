-- local present, gitsigns = pcall(require, "gitsigns")
-- if not present then
--     return
-- end
--
require'gitsigns'.setup {
  numhl = true,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- hunk navigation
    vim.keymap.set('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(gs.next_hunk)
      return '<ignore>'
    end, { expr = true, desc = 'next [h]unk' })

    vim.keymap.set('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(gs.prev_hunk)
      return '<ignore>'
    end, { expr = true, desc = 'prev [h]unk' })

    -- hunk actions
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = '[h]unk [s]tage' })
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[h]unk [U]ndo stage' })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = '[h]unk [r]eset' })

    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = '[h]unk [p]review' })
    vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = '[h]unk [b]lame line' })

    vim.keymap.set('n', '<leader>hq', gs.setqflist, { desc = 'send all [h]unks to [q]uickfix list' })

    vim.keymap.set('n', '<leader>dc', function() gs.diffthis('~') end, { desc = '[d]iff against last [c]ommit' })
    vim.keymap.set('n', '<leader>di', gs.diffthis, { desc = '[d]iff against [i]index' })
  end
}
