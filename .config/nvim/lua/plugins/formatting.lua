return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black", "isort" },
      ["tex"] = { "latexindent" },
    },
  },
}
