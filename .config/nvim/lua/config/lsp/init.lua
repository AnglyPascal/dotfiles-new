-- LSP keymaps
local function on_attach(client, bufnr)
  local keymap = vim.keymap.set
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Navigation
  keymap("n", "gD",         vim.lsp.buf.declaration,     opts)
  keymap("n", "gd",         vim.lsp.buf.definition,      opts)
  keymap("n", "gK",         vim.lsp.buf.hover,           opts)
  keymap("n", "gi",         vim.lsp.buf.implementation,  opts)
  keymap("n", "gr",         vim.lsp.buf.references,      opts)
  keymap("n", "gds",        vim.lsp.buf.document_symbol, opts)
  keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  keymap("n", "<leader>cl", vim.lsp.codelens.run,        opts)
  keymap("n", "<leader>sh", vim.lsp.buf.signature_help,  opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename,          opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action,     opts)

  -- Diagnostics
  keymap("n", "<leader>aa", vim.diagnostic.setqflist, opts)
  keymap("n", "<leader>ae", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  keymap("n", "<leader>aw", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
  end, opts)
  keymap("n", "[c", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
  keymap("n", "]c", function() vim.diagnostic.jump({ count = 1,  float = true }) end, opts)

  -- bashls doesn't advertise formatting capability; enable it manually
  if client.name == "bashls" then
    client.server_capabilities.documentFormattingProvider = true
  end

  -- Inlay hints (toggle with <leader>ih)
  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    keymap("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
  end
end

-- Capabilities via blink.cmp
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
    filter = function(diag) return diag.source ~= "spell" end,
  },
  float = {
    source = true,
    border = "rounded",
    filter = function(diag) return diag.source ~= "spell" end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN]  = '',
    },
    linehl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg" },
    numhl  = { [vim.diagnostic.severity.WARN]  = "WarningMsg" },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Configure servers
require("config.lsp.servers").setup(on_attach, capabilities)
