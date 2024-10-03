local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local state = require("telescope.actions.state")

local M = {}

local function get_git_branches()
  local handle = io.popen("git branch --list")
  if not handle then
    return {}
  end
  local result = handle:read("*a")
  handle:close()

  local branches = {}
  for branch in result:gmatch("[^\r\n]+") do
    table.insert(branches, branch:match("%s*(.*)"))
  end

  return branches
end

local function branches(opts)
  local branch_list = get_git_branches()
  pickers
    .new(opts, {
      prompt_title = "Branch to diff",
      finder = finders.new_table({
        results = branch_list,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        local get_branch = function()
          local selection = state.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local branch_name = selection[1]

          -- Execute DiffViewOpen with the selected branch name using vim.schedule
          vim.schedule(function()
            vim.cmd("DiffviewOpen " .. branch_name)
          end)
        end
        map("i", "<CR>", get_branch)
        map("n", "<CR>", get_branch)
        return true
      end,
    })
    :find()
end

M.branches = branches

return M
