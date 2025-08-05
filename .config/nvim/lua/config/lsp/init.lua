local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- LSP keymaps
local function on_attach(client, bufnr)
  local keymap = vim.keymap.set
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Navigation
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gK", vim.lsp.buf.hover, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "gds", vim.lsp.buf.document_symbol, opts)
  keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  keymap("n", "<leader>cl", vim.lsp.codelens.run, opts)
  keymap("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Diagnostics
  keymap("n", "<leader>aa", vim.diagnostic.setqflist, opts)
  keymap("n", "<leader>ae", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  keymap("n", "<leader>aw", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
  end, opts)
  keymap("n", "[c", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)
  keymap("n", "]c", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)

  -- Formatting
  if client.supports_method("textDocument/formatting") then
    keymap("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
end

-- Enhanced capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  float = {
    source = true,
    border = "rounded",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
})

-- Configure servers
require("config.lsp.servers").setup(on_attach, capabilities)

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})


