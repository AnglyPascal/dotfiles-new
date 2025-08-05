return {
  -- Modern completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              vsnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Command line completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- CoC for specific languages (keeping for TypeScript/JS/Rust/OCaml/C/C++)
  {
    "neoclide/coc.nvim",
    branch = "release",
    ft = {
      "javascript", "javascriptreact", "typescript", "typescriptreact",
      "ocaml", "c", "cpp", "rust",
    },
    build = "yarn install --frozen-lockfile",
    config = function()
      vim.g.coc_global_extensions = { "coc-tsserver" }

      -- CoC keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      keymap("n", "gK", ":call ShowDocumentation()<CR>", opts)

      -- Define the function for documentation
      vim.cmd([[
        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('gK', 'in')
          endif
        endfunction
      ]])

      -- Auto-completion mappings
      vim.cmd([[
        inoremap <silent><expr> <C-k> coc#refresh()
        inoremap <expr><Up> coc#pum#visible() ? coc#pum#prev(1) : ""
        inoremap <silent><expr> <Down> coc#pum#visible() ? coc#pum#next(1): ""
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
      ]])

      -- Navigation
      vim.cmd([[
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> gn <Plug>(coc-rename)
      ]])

      -- Format command
      vim.cmd([[
        command! -nargs=0 Format :call CocActionAsync('format')
      ]])

      -- Language-specific format keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "ocaml", "c", "rust" },
        callback = function()
          vim.keymap.set("n", "<leader>f", ":Format<CR>", { buffer = true })
        end,
      })

      -- Override for C++ (use clang-format)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cpp",
        callback = function()
          vim.keymap.set("n", "<leader>f", ":<C-u>ClangFormat<CR>", { buffer = true })
        end,
      })

      -- Disable format for yacc/lex files
      vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
        pattern = { "*.y", "*.l" },
        callback = function()
          vim.keymap.set("n", "<leader>f", "<nop>", { buffer = true })
        end,
      })
    end,
  },
}
