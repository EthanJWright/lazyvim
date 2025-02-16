local M = {}

M.get_current_test_name = function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local current_node = ts_utils.get_node_at_cursor()

  if not current_node then
    vim.notify("No node found at cursor", vim.log.levels.ERROR)
    return nil
  end

  -- Keep track of describe blocks we're in
  local context = {}

  while current_node do
    if current_node:type() == "call_expression" then
      local child = current_node:child(0)
      if child then
        local child_text = vim.treesitter.get_node_text(child, 0)

        if
          child:type() == "identifier" and (child_text == "it" or child_text == "test" or child_text == "describe")
        then
          local args_node = current_node:child(1)
          if args_node and args_node:type() == "arguments" then
            for i = 0, (args_node:named_child_count() - 1) do
              local arg = args_node:named_child(i)
              if arg and (arg:type() == "string" or arg:type() == "template_string") then
                local name = vim.treesitter.get_node_text(arg, 0):gsub("^[`\"']", ""):gsub("[`\"']$", "")

                if child_text == "describe" then
                  table.insert(context, 1, name)
                else -- it or test
                  -- For a test block, return the full context
                  if #context > 0 then
                    return table.concat(context, " ") .. " " .. name
                  else
                    return name
                  end
                end
              end
            end
          end
        end
      end
    end
    current_node = current_node:parent()
  end

  vim.notify("No test node found in tree", vim.log.levels.WARN)
  return nil
end

return M
