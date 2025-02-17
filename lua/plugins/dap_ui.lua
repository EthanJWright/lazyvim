return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    { "<leader>do", function()
      local dapui = require("dapui")
      
      -- Get the console buffer directly
      local console_buf = dapui.elements.console.buffer()
      if not console_buf or not vim.api.nvim_buf_is_valid(console_buf) then
        vim.notify("DAP UI console buffer not available", vim.log.levels.ERROR)
        return
      end

      -- Create a split and set it to the console buffer
      vim.cmd('vsplit')
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
    end, desc = "Open Debug Output" },  },
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end,
}
