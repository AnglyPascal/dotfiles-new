return {
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
}
