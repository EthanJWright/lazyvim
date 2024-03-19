-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua
-- reuse_win changed to false for all cmds
local defaultKeys = {
  {
    "<leader>cl",
    "<cmd>LspInfo<cr>",
    desc = "Lsp Info",
  },
  {
    "gd",
    function()
      require("telescope.builtin").lsp_definitions({ reuse_win = false })
    end,
    desc = "Goto Definition",
    has = "definition",
  },
  {
    "gr",
    "<cmd>Telescope lsp_references<cr>",
    desc = "References",
  },
  {
    "gD",
    vim.lsp.buf.declaration,
    desc = "Goto Declaration",
  },
  {
    "gI",
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = false })
    end,
    desc = "Goto Implementation",
  },
  {
    "gy",
    function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = false })
    end,
    desc = "Goto T[y]pe Definition",
  },
  { "K", vim.lsp.buf.hover, desc = "Hover" },
  {
    "gK",
    vim.lsp.buf.signature_help,
    desc = "Signature Help",
    has = "signatureHelp",
  },
  {
    "<c-k>",
    vim.lsp.buf.signature_help,
    mode = "i",
    desc = "Signature Help",
    has = "signatureHelp",
  },
  {
    "<leader>ca",
    vim.lsp.buf.code_action,
    desc = "Code Action",
    mode = {
      "n",
      "v",
    },
    has = "codeAction",
  },
  {
    "<leader>cA",
    function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source",
          },
          diagnostics = {},
        },
      })
    end,
    desc = "Source Action",
    has = "codeAction",
  },
}
-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      sourcekit = {
        cmd = { "/usr/bin/sourcekit-lsp" },
      },
    },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- for each value in defaultKeys, set keys to that value
    for _, v in ipairs(defaultKeys) do
      keys[#keys + 1] = v
    end
  end,
}
