return {
  "EthanJWright/it-compiles.nvim",
  config = function()
    require("it-compiles").setup({
      command = {
        ts = "npm run tsc",
      },
    })
  end,
}
