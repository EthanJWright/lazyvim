return {
  "nvim-telescope/telescope-fzf-native.nvim",
  enabled = vim.fn.executable("make") == 1,
  build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  config = function()
    -- local Util = require("lazyvim.util")
    -- Util.on_load("telescope.nvim", function()
    --   require("telescope").load_extension("fzf")
    -- end)
  end,
}
