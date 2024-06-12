-- local cmp = require'cmp'
--
-- cmp.setup {
--     mapping = {
--         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-y>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<CR>"] = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = false,
--         },
--         ["<C-n>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif require("luasnip").expand_or_jumpable() then
--                 vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
--             else
--                 fallback()
--             end
--         end, {
--             "i",
--             "s",
--         }),
--         ["<C-p>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif require("luasnip").jumpable(-1) then
--                 vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
--             else
--                 fallback()
--             end
--         end, {
--             "i",
--             "s",
--         }),
--     },
--     sources = {
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--     },
-- }

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})
