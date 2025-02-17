return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    {
      "<leader>dv",
      function()
        require("custom.dap_ui").open_scopes_buffer()
      end,
      desc = "Dap Variable Scopes",
        mode = { "n", "v"}
    },
    { "<leader>do", function()
      local dapui = require("../custom.dap_ui")
      dapui.open_console_buffer()
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
