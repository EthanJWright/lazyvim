return -- lazy.nvim
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      signature = {
        enabled = false
      }
    },
    cmdline = {
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
      icons = {
        ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
        ["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
        [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
      },
    },
    popupmenu = {
      enabled = true, -- disable if you use something like cmp-cmdline
      ---@type 'nui'|'cmp'
      backend = "nui", -- backend to use to show regular cmdline completions
      -- You can specify options for nui under `config.views.popupmenu`
    },
    history = {
      -- options for the message history that you get with `:Noice`
      view = "split",
      opts = { enter = true },
      filter = { event = "msg_show", ["not"] = { kind = { "search_count", "echo" } } },
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type table<string, NoiceViewOptions>
    views = {}, -- @see the section on views below
    ---@type NoiceRouteConfig[]
    routes = {}, -- @see the section on routes below
    ---@type NoiceFormatOptions
    format = {}, -- @see section on formatting
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
}
