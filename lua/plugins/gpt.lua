return {
  "EthanJWright/gpt.nvim",
  init = function()
    local gpt = require("gpt.chat")
    gpt.setup({
      gpt_command = "g ", -- cli to interact with chat gpt
    })
  end,
}
