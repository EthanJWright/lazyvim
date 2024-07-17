return {
  "m-demare/attempt.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("attempt").setup()
  end,
}
