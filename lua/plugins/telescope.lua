return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
    },
  },
  keys = {
    { "<leader>,", vim.NIL },
    { "<leader>/", vim.NIL },
    -- { "<leader>:", vim.NIL },
    { "<leader><space>", vim.NIL },
    -- find
    { "<leader>fb", vim.NIL },
    { "<leader>ff", vim.NIL },
    { "<leader>fF", vim.NIL },
    { "<leader>fr", vim.NIL },
    { "<leader>fR", vim.NIL },
    -- git
    { "<leader>gc", vim.NIL },
    { "<leader>gs", vim.NIL },
    -- search
    { '<leader>s"', vim.NIL },
    { "<leader>sa", vim.NIL },
    { "<leader>sb", vim.NIL },
    { "<leader>sc", vim.NIL },
    { "<leader>sC", vim.NIL },
    { "<leader>sd", vim.NIL },
    { "<leader>sD", vim.NIL },
    { "<leader>sg", vim.NIL },
    { "<leader>sG", vim.NIL },
    { "<leader>sh", vim.NIL },
    { "<leader>sH", vim.NIL },
    { "<leader>sk", vim.NIL },
    { "<leader>sM", vim.NIL },
    { "<leader>sm", vim.NIL },
    { "<leader>so", vim.NIL },
    { "<leader>sR", vim.NIL },
    { "<leader>sw", vim.NIL },
    { "<leader>sW", vim.NIL },
    { "<leader>sw", vim.NIL },
    { "<leader>sW", vim.NIL },
    { "<leader>uC", vim.NIL },
    { "<leader>ss", vim.NIL },
    { "<leader>sS", vim.NIL },
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

    local launch_formatted = {}
    function _FIND_EDITS()
      local finders = require("telescope.finders")
      local pickers = require("telescope.pickers")
      local sorters = require("telescope.sorters")
      local state = require("telescope.actions.state")
      local before = require("before")

      -- edit table locations look like this:
      --  local location = { bufnr = bufnr, line = pos[1], col = pos[2] }

      launch_formatted = {}
      for i = 2, #before.edit_locations do
        local location = before.edit_locations[i]
        local text =
          vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), location.line - 1, location.line, false)[1]
        table.insert(launch_formatted, text)
      end

      local function get_edit_by_text(text, edit_locations)
        for i = 2, #edit_locations do
          local location = edit_locations[i]
          local line = vim.api.nvim_buf_get_lines(location.bufnr, location.line - 1, location.line, false)[1]
          if line == text then
            return location
          end
        end
      end

      local opts = {}

      pickers
        .new(opts, {
          prompt_title = "Edits",
          finder = finders.new_table({
            results = launch_formatted,
          }),
          sorter = sorters.get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            local goto_line = function()
              local selection = state.get_selected_entry(prompt_bufnr)
              actions.close(prompt_bufnr)

              local selected_text = launch_formatted[selection.index]
              local selected_location = get_edit_by_text(selected_text, before.edit_locations)

              if selected_location then
                vim.api.nvim_win_set_buf(0, selected_location.bufnr)
                vim.api.nvim_win_set_cursor(0, { selected_location.line, selected_location.col })
              end
            end
            map("i", "<CR>", goto_line)
            map("i", "<CR>", goto_line)

            return true
          end,
        })
        :find()
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
    telescope.load_extension("ui-select")

    require("telescope").setup({
      ["#"] = {
        -- #$REMAINDER
        -- # is caught prefix
        -- `input` becomes $REMAINDER
        -- in the above example #lua,md -> input: lua,md
        flag = "glob",
        cb = function(input)
          return string.format([[*.{%s}]], input)
        end,
      },
      -- filter for (partial) folder names
      -- example prompt: >conf $MY_PROMPT
      -- searches with ripgrep prompt $MY_PROMPT in paths that have "conf" in folder
      -- i.e. rg --glob="**/conf*/**" -- $MY_PROMPT
      [">"] = {
        flag = "glob",
        cb = function(input)
          return string.format([[**/{%s}*/**]], input)
        end,
      },
      -- filter for (partial) file names
      -- example prompt: &egrep $MY_PROMPT
      -- searches with ripgrep prompt $MY_PROMPT in paths that have "egrep" in file name
      -- i.e. rg --glob="*egrep*" -- $MY_PROMPT
      ["&"] = {
        flag = "glob",
        cb = function(input)
          return string.format([[*{%s}*]], input)
        end,
      },
    })
    require("telescope").load_extension("egrepify")
    require("telescope").load_extension("vstask")
  end,
}
