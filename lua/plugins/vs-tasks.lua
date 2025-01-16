local use_local = true -- Set this to false to use git source instead
local git_source = nil
local local_source = "~/localplug/vs-tasks.nvim"

if not use_local then
  git_source = "EthanJWright/vs-tasks.nvim"
end

return {
  dir = use_local and local_source or nil,
  git_source,
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
