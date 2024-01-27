local map = vim.keymap.set
local opts = { noremap=true, silent=true }

map('n', '<leader>d', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'open [d]iagnostic floating popup' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next [d]iagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous [d]iagnostic' })

local on_attach = function(_, bufnr)

  local nmap = function(keys, func, desc)
    desc = 'LSP: ' .. desc
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local tsp = require('telescope.builtin')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]implementation')
  nmap('gr', tsp.lsp_references, '[g]oto [r]eferences')

  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

  nmap('<leader>ws', tsp.lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
  -- trying <leader>wd instead of <leader>ds 
  nmap('<leader>wd', tsp.lsp_document_symbols, '[w]orkspace [d]ocument symbols')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove folder')
  nmap('<leader>wl', function() 
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[w]orkspace [l]ist folders')

  nmap('<leader>fm', vim.lsp.buf.format, '[f]or[m]at current buffer')
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
}

-- Language Servers

-- lspconfig.lua_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- 
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.stdpath('config') .. "/lua"] = true,
--         },
--       },
--     },
--   },
-- }

local lspconfig = require 'lspconfig'

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {
            disableOrganizeImports = false,
            analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                autoImportCompletions = true,
            },
        },
    },
}

lspconfig.ltex.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}


local flake8 = require('efmls-configs.linters.flake8')
local black = require('efmls-configs.formatters.black')

lspconfig.efm.setup({
    filetypes = {
        "python",
    },

    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
    },

    settings = {
        languages = {
            python = { flake8, black }, 
        }
    }
})

-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
-- 
-- lspconfig.bashls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
-- 
-- lspconfig.html.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         html = {
--             indent_size = 2
--         }
--     }
-- }
-- 
-- lspconfig.cssls.setup{
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
-- 
-- lspconfig.dockerls.setup{
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
-- 
-- lspconfig.jsonls.setup{
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
-- 
-- lspconfig.omnisharp.setup {
--     cmd = { "omnisharp" },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
