local M = {}

M.open_markdown_in_browser = function()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return
  end

  local file_url = "file://" .. filepath

  -- Detect OS and use appropriate command
  if vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", file_url }, { detach = true })
  elseif vim.fn.has("unix") == 1 then
    -- Get default browser using xdg-settings
    local browser_desktop = vim.fn.systemlist("xdg-settings get default-web-browser")[1]
    if browser_desktop and browser_desktop ~= "" then
      vim.fn.jobstart({ "gtk-launch", browser_desktop, file_url }, { detach = true })
    else
      vim.notify("Could not determine default browser", vim.log.levels.ERROR)
      return
    end
  elseif vim.fn.has("win32") == 1 then
    vim.fn.jobstart({ "cmd.exe", "/c", "start", file_url }, { detach = true })
  else
    vim.notify("Unsupported OS", vim.log.levels.ERROR)
    return
  end

  vim.notify("Opening " .. vim.fn.fnamemodify(filepath, ":t") .. " in browser")
end

return M
