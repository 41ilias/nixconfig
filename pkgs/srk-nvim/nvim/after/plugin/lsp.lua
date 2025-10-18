require("neodev").setup {}

local lspconfig = require "lspconfig"

local servers = {

  bashls = true,

  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },

  -- Formatting will be done via conform with prettier
  ts_ls = {
    server_capabilities = {
      documentFormattingProvider = false,
    },
  },

  lua_ls = {
    server_capabilities = {
      semanticTokensProvider = vim.NIL,
    },
  },
}

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

local conform = require "conform"
conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    typescript = { { "prettierd", "prettier" } },
  },
}

local on_attach = function(args)
  local bufnr = args.buf
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

  local settings = servers[client.name]
  if type(settings) ~= "table" then
    settings = {}
  end

  local nmap = function(keys, func, desc)
    desc = "LSP: " .. desc
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  local tsp = require "telescope.builtin"

  -- TODO: investigate what this does? Copied from TjDevries
  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
  nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
  nmap("gT", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[g]oto [i]implementation")
  nmap("gr", tsp.lsp_references, "[g]oto [r]eferences")

  nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

  nmap("<leader>ws", tsp.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
  nmap("<leader>wd", tsp.lsp_document_symbols, "[w]orkspace [d]ocument symbols")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[w]orkspace [l]ist folders")

  nmap("<leader>fm", conform.format, "[f]or[m]at current buffer")

  -- Override server capabilities
  if settings.server_capabilities then
    for k, v in pairs(settings.server_capabilities) do
      if v == vim.NIL then
        ---@diagnostic disable-next-line: cast-local-type
        v = nil
      end

      client.server_capabilities[k] = v
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = on_attach,
})
