local use_local = true -- Set this to false to use git source instead
local git_source = "EthanJWright/vs-tasks.nvim"
local local_source = "~/localplug/vs-tasks.nvim"

return {
  dir = use_local and local_source or nil,
  [use_local and 1 or ""] = not use_local and git_source or nil,
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "ThePrimeagen/harpoon",
  },
  config = function()
    require("vstask").setup()
  end,
}
