local use_local = true -- Set this to false to use git source instead
local git_source = nil
local local_source = "~/localplug/vs-tasks.nvim"

if not use_local then
  git_source = "EthanJWright/vs-tasks.nvim"
end

return {
  dir = use_local and local_source or nil,
  git_source,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "ThePrimeagen/harpoon",
    "folke/snacks.nvim",
  },
  config = function()
    require("vstask").setup({
      picker = "snacks", -- Use snacks.nvim picker instead of telescope
      -- picker = "ui_select", -- Use snacks.nvim picker instead of telescope
      -- ui_select_behaviors = {
      --   tasks = "background_job", -- Default: run tasks in background
      --   launches = "current", -- Default: run launches in current window
      --   jobs = "current", -- Default: open jobs in current window
      -- },
    })
  end,
}
