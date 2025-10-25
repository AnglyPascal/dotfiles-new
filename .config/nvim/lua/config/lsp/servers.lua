local M = {}

function M.setup(on_attach, capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- clangd
  vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- lua_ls
  vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
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

  -- pyright
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
      vim.bo[bufnr].formatprg = 'yapf'
    end,
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

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    group = vim.api.nvim_create_augroup('python_yapf', { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      vim.keymap.set('n', '<leader>f', function()
        local view = vim.fn.winsaveview()
        vim.cmd('%!yapf')
        vim.fn.winrestview(view)
      end, { buffer = bufnr, desc = 'Format with yapf' })
    end,
  })

  -- jsonls
  vim.lsp.config('jsonls', {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  -- yamlls
  vim.lsp.config('yamlls', {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
    root_markers = { '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  })

  -- ts_ls
  vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    root_markers = { 'package.json', 'tsconfig.json', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      typescript = {
        format = { indentSize = 2, convertTabsToSpaces = true },
      },
      javascript = {
        format = { indentSize = 2, convertTabsToSpaces = true },
      },
    },
  })

  -- bashls
  vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash', 'zsh' },
    root_markers = { '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      bashIde = {
        formatter = "beautysh"
      }
    },
  })

  -- gopls
  vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          ST1021 = false,
          ST1000 = false,
          ST1020 = false,
        },
        gofumpt = true,
      },
    },
  })

  -- protols
  vim.lsp.config('protols', {
    cmd = { 'protols' },
    filetypes = { 'proto' },
    root_markers = { 'buf.yaml', 'buf.work.yaml', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      buf = {
        format = true,
        lint = false,
      }
    },
  })

  -- cssls
  vim.lsp.config('cssls', {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- rust_analyzer
  vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- cmake
  vim.lsp.config('cmake', {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      buildDirectory = "build_dev"
    },
    settings = {
      cmake = {
        buildDirectory = "build_dev"
      }
    },
  })

  -- Start LSP servers on appropriate filetypes
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('lsp_start', { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype

      -- Map filetypes to servers
      local ft_to_server = {
        c = 'clangd',
        cpp = 'clangd',
        objc = 'clangd',
        objcpp = 'clangd',
        cuda = 'clangd',
        lua = 'lua_ls',
        python = 'pyright',
        json = 'jsonls',
        jsonc = 'jsonls',
        yaml = 'yamlls',
        javascript = 'ts_ls',
        javascriptreact = 'ts_ls',
        typescript = 'ts_ls',
        typescriptreact = 'ts_ls',
        sh = 'bashls',
        bash = 'bashls',
        zsh = 'bashls',
        go = 'gopls',
        gomod = 'gopls',
        gowork = 'gopls',
        gotmpl = 'gopls',
        proto = 'protols',
        css = 'cssls',
        scss = 'cssls',
        less = 'cssls',
        rust = 'rust_analyzer',
        cmake = 'cmake',
      }

      local server = ft_to_server[ft]
      if server then
        -- Schedule to run after FileType event completes
        vim.schedule(function()
          vim.lsp.enable(server, bufnr)
        end)
      end
    end,
  })
end

return M
