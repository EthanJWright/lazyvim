local M = {}

M.open_scopes_buffer = function()
  local dapui = require("dapui")
  -- Get the scopes buffer directly
  local scopes_buf = dapui.elements.scopes.buffer()
  if not scopes_buf or not vim.api.nvim_buf_is_valid(scopes_buf) then
    vim.notify("DAP UI scopes buffer not available", vim.log.levels.ERROR)
    return
  end

  -- Create a split and set it to the scopes buffer
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, scopes_buf)

  -- Set up keymaps for expanding/collapsing
  vim.keymap.set("n", "<CR>", function()
    -- Get cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    -- Trigger the expand/collapse action at cursor
    vim.api.nvim_buf_set_keymap(scopes_buf, "n", "<CR>", "", {
      callback = function()
        dapui.elements.scopes.toggle(row - 1) -- -1 because lua is 1-based but API expects 0-based
      end,
      noremap = true,
      silent = true,
    })
  end, { buffer = scopes_buf })

  -- Set up auto-refresh when debug state changes
  local group = vim.api.nvim_create_augroup("DapScopesBuffer", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "DapProgressUpdate",
    group = group,
    callback = function()
      if vim.api.nvim_buf_is_valid(scopes_buf) then
        dapui.elements.scopes.render()
      end
    end,
  })
end

M.open_console_buffer = function()
  local dapui = require("dapui")
  -- Get the console buffer directly
  local console_buf = dapui.elements.console.buffer()
  if not console_buf or not vim.api.nvim_buf_is_valid(console_buf) then
    vim.notify("DAP UI console buffer not available", vim.log.levels.ERROR)
    return
  end

  -- Create a split and set it to the console buffer
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, console_buf)

  -- Set up auto-scroll
  local autoscroll = true
  vim.keymap.set("n", "G", function()
    autoscroll = true
    vim.cmd("normal! G")
  end, { silent = true, buffer = console_buf })

  -- Set up cursor movement handling
  local group = vim.api.nvim_create_augroup("DapConsoleBuffer", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMoved" }, {
    group = group,
    buffer = console_buf,
    callback = function()
      if vim.api.nvim_get_current_buf() == console_buf then
        local lnum = vim.api.nvim_win_get_cursor(0)[1]
        autoscroll = lnum == vim.api.nvim_buf_line_count(console_buf)
      end
    end,
  })

  -- Set up auto-scroll on new content
  vim.api.nvim_buf_attach(console_buf, false, {
    on_lines = function()
      if autoscroll and vim.fn.mode() == "n" and vim.api.nvim_get_current_buf() == console_buf then
        vim.cmd("normal! G")
      end
    end,
  })
end

return M
