local api = vim.api

-- Metals configuration
local metals_config = require("metals").bare_config()

metals_config.settings = {
  superMethodLensesEnabled = false,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  fallbackScalaVersion = "3.1.1",
  javaHome = "/home/ahsan/git/jdk-20",
}

-- Enhanced capabilities for Metals
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Debug configurations
local dap = require("dap")
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(_, _)
  require("metals").setup_dap()
end

-- Scala-specific keymaps
api.nvim_create_autocmd("FileType", {
  pattern = "scala",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Formatting and imports
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<leader>i", "<cmd>MetalsOrganizeImports<cr>", opts)

    -- LSP navigation
    vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
    vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist, opts)
    vim.keymap.set("n", "<leader>ae", function()
      vim.diagnostic.setqflist({ severity = "E" })
    end, opts)
    vim.keymap.set("n", "<leader>aw", function()
      vim.diagnostic.setqflist({ severity = "W" })
    end, opts)
    vim.keymap.set("n", "[c", function()
      vim.diagnostic.goto_prev({ wrap = false })
    end, opts)
    vim.keymap.set("n", "]c", function()
      vim.diagnostic.goto_next({ wrap = false })
    end, opts)
  end,
})

-- Metals autocmd
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
