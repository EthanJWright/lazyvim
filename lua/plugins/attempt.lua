return {
  "m-demare/attempt.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("attempt").setup({
      dir = vim.fn.expand("~") .. "/.attempt/",
      ext_options = { "lua", "js", "py", "ts" },
      run = {
        lua = { "w !lua" },
        py = { "w !python3" },
        js = { "w !node" },
        ts = { "w !ts-node" },
      },
    })
  end,
}
