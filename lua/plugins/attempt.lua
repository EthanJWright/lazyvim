return {
  "m-demare/attempt.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("attempt").setup({
      -- make ~/.attempt and set up typescript in it (npm init, npm i typescript, npx tsc --init)
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
