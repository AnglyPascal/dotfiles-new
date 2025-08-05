return {
  -- Python
  {
    "vim-scripts/indentpython.vim",
    ft = "python",
  },

  -- JavaScript/TypeScript
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    "neoclide/vim-jsx-improve",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    "pangloss/vim-javascript",
    ft = { "javascript", "javascriptreact" },
  },

  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- C/C++
  {
    "bfrg/vim-cpp-modern",
    ft = { "c", "cpp" },
    config = function()
      vim.g.cpp_type_name_highlight = 1
    end,
  },
  {
    "rhysd/vim-clang-format",
    ft = { "c", "cpp" },
  },

  -- Assembly
  {
    "shirk/vim-gas",
    ft = { "gas", "asm" },
  },
  {
    "kylelaker/riscv.vim",
    ft = "riscv",
  },

  -- Verilog
  {
    "vhda/verilog_systemverilog.vim",
    ft = { "verilog", "systemverilog" },
  },

  -- Code formatting tools
  {
    "google/vim-maktaba",
    lazy = true,
  },
  {
    "google/vim-codefmt",
    dependencies = { "google/vim-maktaba" },
    cmd = { "FormatCode", "FormatLines" },
  },
}
