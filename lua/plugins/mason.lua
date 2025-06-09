return {
  { "mason-org/mason.nvim", version = "^1.*" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.*" },
  keys = {
    { "<leader>cm", false },
  },
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "js-debug-adapter")
  end,
}
