return {
  "bloznelis/before.nvim",
  config = function()
    local before = require("before")
    before.setup({ history_size = 20 })
    vim.keymap.set("n", "<C-e>", before.jump_to_last_edit, {})
    vim.keymap.set("n", "<C-w>", before.jump_to_next_edit, {})
    vim.keymap.set("n", "<leader>fe", before.show_edits_in_telescope, {})
  end,
}
