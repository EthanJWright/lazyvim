return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>a"] = { name = "+all" },
      ["<leader>A"] = { name = "+attempt" },
      ["<leader>m"] = { name = "+marks" },
      ["<leader>c"] = { name = "+cmdheight" },
      ["<leader>b"] = { name = "+Buffers" },
      ["<leader>p"] = { name = "+Pick" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>i"] = { name = "+Info" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>r"] = { name = "+Runner" },
      ["<leader>y"] = { name = "+Copy" },
      ["<leader>s"] = { name = "+Search" },
      ["<leader>t"] = { name = "+Terminal" },
      ["<leader>j"] = { name = "+Jump" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
