return {
  "williamboman/mason.nvim",
  keys = {
    { "<leader>cm", false },
  },
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "js-debug-adapter")
  end,
}
