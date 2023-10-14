return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-ui-select.nvim"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
    },
  },
  keys = {
    { "<leader>,",       vim.NIL },
    { "<leader>/",       vim.NIL },
    { "<leader>:",       vim.NIL },
    { "<leader><space>", vim.NIL },
    -- find
    { "<leader>fb",      vim.NIL },
    { "<leader>ff",      vim.NIL },
    { "<leader>fF",      vim.NIL },
    { "<leader>fr",      vim.NIL },
    { "<leader>fR",      vim.NIL },
    -- git
    { "<leader>gc",      vim.NIL },
    { "<leader>gs",      vim.NIL },
    -- search
    { '<leader>s"',      vim.NIL },
    { "<leader>sa",      vim.NIL },
    { "<leader>sb",      vim.NIL },
    { "<leader>sc",      vim.NIL },
    { "<leader>sC",      vim.NIL },
    { "<leader>sd",      vim.NIL },
    { "<leader>sD",      vim.NIL },
    { "<leader>sg",      vim.NIL },
    { "<leader>sG",      vim.NIL },
    { "<leader>sh",      vim.NIL },
    { "<leader>sH",      vim.NIL },
    { "<leader>sk",      vim.NIL },
    { "<leader>sM",      vim.NIL },
    { "<leader>sm",      vim.NIL },
    { "<leader>so",      vim.NIL },
    { "<leader>sR",      vim.NIL },
    { "<leader>sw",      vim.NIL },
    { "<leader>sW",      vim.NIL },
    { "<leader>sw",      vim.NIL },
    { "<leader>sW",      vim.NIL },
    { "<leader>uC",      vim.NIL },
    { "<leader>ss",      vim.NIL },
    { "<leader>sS",      vim.NIL },
  },
  opts = function()
    local Util = require("lazy.util")
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end
    local open_selected_with_trouble = function(...)
      return require("trouble.providers.telescope").open_selected_with_trouble(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      Util.telescope("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      Util.telescope("find_files", { hidden = true, default_text = line })()
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-f>"] = actions.to_fuzzy_refine,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }
  end,
  init = function()
    local telescope = require("telescope")
    telescope.load_extension('ui-select')
  end
}
