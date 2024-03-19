return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    init = function(_, opts)
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        --	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        --	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      -- TODO: make more cool terms!
      -- for creating terminals below
      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = "node", hidden = true })
      function _NODE_TOGGLE()
        node:toggle()
      end

      local dust = Terminal:new({ cmd = "dust", hidden = true, close_on_exit = false })
      function _DUST_TOGGLE()
        dust:toggle()
      end

      local htop = Terminal:new({ cmd = "btm", hidden = true })
      function _HTOP_TOGGLE()
        htop:toggle()
      end

      local wttr = Terminal:new({ cmd = "curl wttr.in", hidden = true, close_on_exit = false })
      function _WTTR_TOGGLE()
        wttr:toggle()
      end

      local python = Terminal:new({ cmd = "python3", hidden = true })
      function _PYTHON_TOGGLE()
        python:toggle()
      end

      local float = Terminal:new({ direction = "float", hidden = true })
      function _FLOAT_TOGGLE()
        float:toggle()
      end

      local bottom = Terminal:new({ direction = "horizontal", hidden = true })
      function _BOTTOM_TOGGLE()
        bottom:toggle()
      end

      function _RUN_TEST()
        local currentFile = vim.fn.expand("%:p")
        local testCmd = "npm run test "
        vim.cmd("vsplit")
        vim.cmd("term " .. testCmd .. currentFile)
      end

      function _RUN_LAST_TASK()
        local vstask_ok, vstask = pcall(require, "vstask")
        if not vstask_ok then
          return
        end
        local cmd = vstask.get_last()
        vim.cmd("vsplit")
        vim.cmd("term " .. cmd)
      end
    end,
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-t>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true, -- false could be interesting with a good size function?
      direction = "float", -- 'vertical' | 'horizontal' | 'window' | 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell

      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- width = <value>,
        -- height = <value>,
        winblend = 0, -- 3
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
