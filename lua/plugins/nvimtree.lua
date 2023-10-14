return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    diagnostics = {
      enable = true,
    },
    view = {
      -- adaptive_size = true,
      number = true,
      relativenumber = true,
    },
    renderer = {
      indent_width = 1,
      full_name = true,
      highlight_opened_files = "all",
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
  },
}
