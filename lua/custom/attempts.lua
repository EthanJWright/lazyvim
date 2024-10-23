local M = {}

M.attempt_dir = vim.fn.expand("~") .. "/.attempt/ts/src/"

function M.clear_attempts()
  local src_dir = M.attempt_dir
  local count = 0
  -- Check if directory exists
  if vim.fn.isdirectory(src_dir) == 1 then
    -- Get all files in the directory
    local files = vim.fn.glob(src_dir .. "*", false, true)
    print("File names: " .. vim.inspect(files))
    for _, file in ipairs(files) do
      -- Delete each file
      vim.fn.delete(file)
      count = count + 1
    end
  end
  if count > 0 then
    print("Cleared " .. count .. " attempts")
  else
    print("No attempts to clear")
  end
end

return M
