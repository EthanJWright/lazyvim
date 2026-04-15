return {
  { "shaunsingh/nord.nvim" },
  { "rose-pine/neovim" },
  { "NTBBloodbath/sweetie.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "navarasu/onedark.nvim" },
  { "ray-x/starry.nvim" },
  { "catppuccin/nvim" },
  { "askfiy/visual_studio_code" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "serhez/teide.nvim" },
  {
    "ember-theme/nvim",
    name = "ember",
    priority = 1000,
    config = function()
      require("ember").setup({ variant = "ember" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight",
      -- colorscheme = "teide",
      colorscheme = "ember",
      -- colorscheme = "witch-dark",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "kanagawa",
      -- colorscheme = "rose-pine",
      -- colorscheme = "lytmode",
      -- colorscheme = "visual_studio_code",
    },
  },
}
