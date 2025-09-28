local lspconfig = require("lspconfig")
local M = {}

function M.setup(on_attach, capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Manual server setup with your custom configs
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })

  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  })

  lspconfig.jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  })

  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
    settings = {
      typescript = {
        format = { indentSize = 2, convertTabsToSpaces = true },
      },
      javascript = {
        format = { indentSize = 2, convertTabsToSpaces = true },
      },
    },
  })

  lspconfig.bashls.setup({
    on_attach = on_attach,
    filetypes = { "sh", "bash", "zsh" },
    settings = {
      bashIde = {
        formatter = "beautysh"
      }
    }
  })

  -- Configure gopls
  lspconfig.gopls.setup {
    on_attach = on_attach,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          ST1021 = false, -- comment format
          ST1000 = false, -- package comment
          ST1020 = false, -- package comment
        },
        gofumpt = true,
      },
    },
  }

  lspconfig.protols.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      buf = {
        format = true,
        lint = false,
      }
    },
  })

  -- Simple setups for other servers
  lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
  lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })

  lspconfig.cmake.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "cmake" },
    init_options = {
      buildDirectory = "build_dev"
    },
    settings = {
      cmake = {
        buildDirectory = "build_dev"
      }
    }
  })
end

return M
