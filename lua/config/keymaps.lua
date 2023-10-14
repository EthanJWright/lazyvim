-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>fn")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del({ "n", "x" }, "j")
vim.keymap.del({ "n", "x" }, "k")
-- vim.keymap.del("n", "<leader>f")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>ww")

vim.keymap.del("n", "<leader>qq")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

--Cant live without
map("i", "jk", "<esc>", { desc = "jk to escape" })

-- JK to insert normal mode
map("t", "JK", "<C-\\><C-n>", { desc = "Terminal JK to Nvim escape" })

-- better up/down
vim.cmd([[
  " remap j k and to treat 'false' new lines as new line, also keep center
  nnoremap j gjzz
  nnoremap k gkzz

  " Also do it for all the other stuff
  nnoremap } }zz
  nnoremap { {zz
  nnoremap G Gzz
  nnoremap gd gdzz
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz
  nnoremap <C-O> <C-O>zz
  nnoremap <C-I> <C-I>zz
  nnoremap <C-]> <C-]>zz
]])

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Top level keymaps
map("n", "<leader>T", "<cmd>NvimTreeFindFile<cr><cmd>set rnu<cr>", { desc = "NvimTree" })
map("n", "<leader>M", "<cmd>MinimapToggle<cr>", { desc = "Minimap" })
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show line diagnostics" })
map("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>/", "<cmd>CommentToggle<CR>", { desc = "Comment" })
map("n", "<leader>ff", "<cmd>Telescope find_files theme=get_dropdown<CR>", { desc = "Find File" })
map("n", "<leader>nn", "<cmd>noh<CR>", { desc = "No Highlight" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>F", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })
map("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "ZenMode" })
map("n", "<leader>O", "<cmd>MaximizerToggle<cr>", { desc = "Focus Window" })
map("n", "<leader>I", "<cmd>e ~/.config/nvim/init.vim<CR>", { desc = "Open VimRC" })
map("n", "<leader>D", "<cmd>TroubleToggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>N", "<cmd>TodoTrouble<cr>", { desc = "Todo" })
map("n", "<leader>S", "<cmd>call WindowSwap#EasyWindowSwap()<CR>", { desc = "Swap Windows" })

-- a keymaps (All)
map("n", "<leader>aw", "<cmd>wa<CR>", { desc = "Save" })
map("n", "<leader>aq", "<cmd>qa<CR>", { desc = "Quit" })
map("n", "<leader>af", "<cmd>qa!<CR>", { desc = "Force Quit" })

-- A keymaps (Attempt)
map("n", "<leader>An", "<cmd>lua require('attempt').new_select()<CR>", { desc = "New" })
map("n", "<leader>Ad", "<cmd>lua require('attempt').delete_buf()<CR>", { desc = "Delete" })
map("n", "<leader>Ar", "<cmd>lua require('attempt').run()<CR>", { desc = "Run" })
map("n", "<leader>As", "<cmd>Telescope attempt<CR>", { desc = "Search" })

-- m keymaps (Marks)
map("n", "<leader>mm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Harpoon" })
map("n", "<leader>ms", "<cmd>Telescope marks theme=get_dropdown<CR>", { desc = "Search" })
map("n", "<leader>md", "<cmd>lua require('harpoon.mark').clear_all()<CR>", { desc = "Delete All" })
map("n", "<leader>mt", "<cmd>lua require('harpoon.mark').toggle_file()<CR>", { desc = "Toggle Mark" })

-- c keymaps (cmdheight)
map("n", "<leader>cc", "<cmd>set cmdheight=1<CR>", { desc = "Show" })
map("n", "<leader>ch", "<cmd>set cmdheight=0<CR>", { desc = "Hide" })

-- o keymaps (OpenAI)
map("n", "<leader>oo", "<cmd>lua require('gpt.lua').send_to_gpt()<CR>", { desc = "Send Visual" })

-- b keymaps (Buffers)
map(
  "n",
  "<leader>bc",
  "<cmd>lua require('bufclean.clean').close_hidden_outside_visible_context(2, true)<CR>",
  { desc = "Clean Outside Context" }
)
map("n", "<leader>bj", "<cmd>BufferPick<cr>", { desc = "Jump to buffer" })
map("n", "<leader>bw", "<cmd>BufferWipeout<cr>", { desc = "Wipeout buffer" })
map("n", "<leader>bn", "<cmd>BufferNext<CR>", { desc = "Next" })
map("n", "<leader>bp", "<cmd>BufferPrevious<CR>", { desc = "Previous" })
map("n", "<leader>bs", "<cmd>BufferPin<CR><cmd>lua require('harpoon.mark').toggle_file()<CR>", { desc = "Pin Buffer" })
map("n", "<leader>bd", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "Close unstarred buffers" })
map(
  "n",
  "<leader>bb",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown())<cr>",
  { desc = "Buffers" }
)
map("n", "<leader>be", "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close all but current buffer" })
map("n", "<leader>bh", "<cmd>BufferCloseBuffersLeft<cr>", { desc = "Close all buffers to the left" })
map("n", "<leader>bD", "<cmd>BufferOrderByDirectory<cr>", { desc = "Sort BufferLines automatically by directory" })
map("n", "<leader>bl", "<cmd>bd #<CR>", { desc = "Close last buffer" })
map("n", "<leader>bL", "<cmd>BufferOrderByLanguage<cr>", { desc = "Sort BufferLines automatically by language" })
map("n", "<leader>bq", "<cmd>BufferClose<cr>", { desc = "Quit buffer" })

-- p keymaps (Pick)
map("n", "<leader>pb", "<cmd>ReachOpen buffers<cr>", { desc = "Buffers" })
map("n", "<leader>pm", "<cmd>ReachOpen marks<cr>", { desc = "Marks" })

-- g keymaps (Git)
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { desc = "Next Hunk" })
map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { desc = "Prev Hunk" })
map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = "Blame" })
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = "Preview Hunk" })
map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = "Reset Hunk" })
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = "Reset Buffer" })
map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = "Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })
map("n", "<leader>go", "<cmd>Telescope git_status<cr>", { desc = "Open changed file" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Checkout commit" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Diff" })
map(
  "n",
  "<leader>gn",
  "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
  { desc = "Create Worktree" }
)
map(
  "n",
  "<leader>gw",
  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { desc = "Git Worktree" }
)

-- d keymaps (debug)
map("n", "<leader>dc", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear all breakpoints" })
map("n", "<leader>dd", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", { desc = "Toggle UI" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Breakpoint" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step Into" })
map("n", "<leader>dt", "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>", { desc = "Debug Test" })

-- i keymaps (Info)
map("n", "<leader>is", "<cmd>SymbolsOutline<CR>", { desc = "Symbols" })

-- l keymaps (lsp)
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
map("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show line diagnostics" })
map("n", "<leader>lg", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Goto Definition" })
map("n", "<leader>lh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", { desc = "Hover" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "Installer Info" })
map("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
map("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
map("n", "<leader>ll", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", { desc = "Preview Definition" })
map("n", "<leader>LL", "<cmd>lua vim.lsp.codelens()<cr>", { desc = "Preview Definition" })
map("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", { desc = "Quickfix" })
map("n", "<leader>lr", ":%s/\\<<C-r><C-w>\\>//g<left><left>", { desc = "Rename" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>LS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>lt", "<cmd>TroubleToggle<CR>", { desc = "Toggle Diagnostics Window" })

-- r keymaps (Runner)
map(
  "n",
  "<leader>rt",
  "<cmd>lua require('telescope').extensions.vstask.tasks(require('telescope.themes').get_dropdown())<cr>",
  { desc = "Tasks" }
)
map(
  "n",
  "<leader>ri",
  "<cmd>lua require('telescope').extensions.vstask.inputs(require('telescope.themes').get_dropdown())<cr>",
  { desc = "Inputs" }
)
map(
  "n",
  "<leader>rh",
  "<cmd>lua require('telescope').extensions.vstask.history(require('telescope.themes').get_dropdown())<cr>",
  { desc = "History" }
)
map(
  "n",
  "<leader>rl",
  "<cmd>lua require('telescope').extensions.vstask.launch(require('telescope.themes').get_dropdown())<cr>",
  { desc = "Launch" }
)

-- y keymaps (Copy)
map("n", "<leader>yp", "<cmd>let @+ = expand('%')<cr>", { desc = "Copy file path" })

-- s keymaps (Search)
map(
  "n",
  "<leader>sd",
  "<cmd>lua require('telescope.builtin').live_grep({ cwd = require('telescope.utils').buffer_dir() })<cr>",
  { desc = "Grep from current dir" }
)
map("n", "<leader>sb", "<cmd>Telescope git_branches theme=get_dropdown<cr>", { desc = "Checkout branch" })
map("n", "<leader>sc", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy find current" })
map("n", "<leader>sC", "<cmd>Telescope commands theme=get_dropdown<cr>", { desc = "Commands" })
map("n", "<leader>sg", "<cmd>Telescope git_status theme=get_dropdown<cr>", { desc = "Git Status" })
map("n", "<leader>sh", "<cmd>Telescope command_history theme=get_dropdown<cr>", { desc = "Command history" })
map("n", "<leader>sl", "<cmd>Telescope diagnostics theme=get_dropdown<cr>", { desc = "Diagnostics" })
map(
  "n",
  "<leader>sf",
  "<cmd>lua require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir() })<cr>",
  { desc = "Find files relative to current" }
)
map("n", "<leader>sL", "<cmd>Telescope lsp_dynamic_workspace_symbols theme=get_dropdown<cr>", { desc = "Repo Symbols" })
map("n", "<leader>sj", "<cmd>Telescope jumplist theme=get_dropdown<cr>", { desc = "Jump list" })
map("n", "<leader>sm", "<cmd>Telescope changed_files theme=get_dropdown<cr>", { desc = "Modified Files" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>so", "<cmd>Telescope oldfiles theme=get_dropdown<cr>", { desc = "Old files" })
map(
  "n",
  "<leader>sO",
  "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",
  { desc = "Grep open files" }
)
map("n", "<leader>sr", "<cmd>Telescope lsp_references<cr>", { desc = "Goto References" })
map("n", "<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>st", "<cmd>Telescope live_grep theme=get_dropdown<cr>", { desc = "Text" })
map("n", "<leader>sT", "<cmd>Telescope<cr>", { desc = "Telescope" })
map("n", "<leader>su", "<cmd>Telescope grep_string theme=ivy<CR>", { desc = "Text under cursor" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map(
  "n",
  "sp",
  "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
  { desc = "Colorscheme with Preview" }
)
map(
  "n",
  "<leader>sw",
  "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>",
  { desc = "Specific string" }
)

-- t keymaps (Terminal)
map("n", "<leader>tb", "<cmd>lua _BOTTOM_TOGGLE()<cr>", { desc = "Bottom" })
map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node" })
map("n", "<leader>td", "<cmd>lua _DUST_TOGGLE()<cr>", { desc = "Dust" })
map("n", "<leader>tr", "<cmd>lua _RUN_TEST()<cr>", { desc = "Run & watch test" })
map("n", "<leader>tl", "<cmd>lua _RUN_LAST_TASK()<cr>", { desc = "Run last task" })
map("n", "<leader>tm", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "System Monitor" })
map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Floating" })
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>vsplit <cr>|<cmd> term<cr>i", { desc = "Vertical" })
map("n", "<leader>tw", "<cmd>lua _WTTR_TOGGLE()<cr>", { desc = "Weather" })

-- j keymaps (Jump)
map("n", "<leader>ja", "<cmd>A<CR>", { desc = "Jump to alternative" })
map("n", "<leader>jv", "<cmd>AV<CR>", { desc = "Jump to alternative in vertical split" })

-- Visual Mappings
map("v", "<leader>o", ":<C-u>lua require('gpt.chat').send_to_gpt_refactor()<cr>", { desc = "OpenAI Refactor" })
map("v", "<leader>oc", ":<C-u>lua require('gpt.chat').send_to_gpt_custom()<cr>", { desc = "OpenAI Custom" })
map("v", "<leader>oC", ":<C-u>lua require('gpt.chat').send_to_gpt_comment()<cr>", { desc = "OpenAI Comment" })
map("v", "<leader>oD", ":<C-u>lua require('gpt.chat').send_to_gpt_document()<cr>", { desc = "OpenAI Document" })
map("v", "<leader>ot", ":<C-u>lua require('gpt.chat').send_to_gpt_test()<cr>", { desc = "OpenAI Test" })
map("v", "<leader>od", ":<C-u>lua require('gpt.chat').send_to_gpt_debug()<cr>", { desc = "OpenAI Debug" })
map("v", "<leader>oe", ":<C-u>lua require('gpt.chat').send_to_gpt_explain()<cr>", { desc = "OpenAI Explain" })
map("v", "<leader>oE", ":<C-u>lua require('gpt.chat').send_to_gpt_example()<cr>", { desc = "OpenAI Example" })
map("v", "<leader>of", ":<C-u>lua require('gpt.chat').flush()<cr>", { desc = "OpenAI Flush" })

vim.cmd([[
" General
inoremap ;; <Esc>/<..><Enter>"_c4l
inoremap ;k "<..>" : <..>,<esc>0f>ca<
inoremap ;M :vnew \| 0read !

" Node & Javascript
autocmd BufNewFile,BufRead * if match(getline(1),"node") >= 0 | set filetype=javascript | endif
autocmd FileType javascript,typescript inoremap ;a (<..>) => {<..>}<esc>F(f<ca<
autocmd FileType javascript,typescript inoremap ;A async (<..>) => {<..>}<esc>F(f<ca<
autocmd FileType javascript,typescript inoremap ;f function <..>(<..>) {<Enter><..><Enter>}<esc>kkt>ca<
autocmd FileType javascript,typescript inoremap ;p console.log(`<..>`);<esc>0/<..><Enter>ca<
autocmd FileType javascript,typescript inoremap ;t <esc>A.then( (<..>) => {<Enter><..><Enter>});<esc>kkt>ca<
autocmd FileType javascript,typescript inoremap ;c <esc>$xA.catch( (err) => {<Enter><..><Enter>});<esc>kt>ca<
autocmd FileType javascript,typescript inoremap ;J JSON.stringify(<..>, null, 2)<esc>FJf>ca<
autocmd FileType javascript,typescript inoremap ;l log.<..>(`<..>`)<esc>0f>ca<

" PYTHON
autocmd FileType python inoremap ;c class <..>:<Enter>def __init__(self, <..>):<Enter>self.<..> = <..><esc>ggi
autocmd FileType python inoremap ;f def <..>(<..>):<Enter><..><esc>0kt>ca<
autocmd FileType python inoremap ;l for i in range(0, <..>):<Enter><..><esc>kt>ca<
autocmd FileType python inoremap ;p print(f'<..>')<esc>0t>ca<
autocmd FileType python inoremap ;m def main():<Enter><..><Enter>pass<Enter><esc>I<Enter><Enter>if __name__ == "__main__":<Enter>main()<esc>5k0f>ca<

" C and Cpp
autocmd BufNewFile,BufRead * if match(getline(1),"*.hpp") >= 0 | set filetype=cpp | endif
autocmd BufNewFile,BufRead * if match(getline(1),"*.h") >= 0 | set filetype=c | endif
autocmd FileType c,cpp inoremap ;c #ifndef _<..>_H_<Enter>#define _<..>_H_<Enter><Enter>using namespace std;<Enter><Enter>class <..>:<Enter>{<Enter>public:<Enter><..>()<Enter>private:<Enter>};<Enter>#endif<esc>ggi
autocmd FileType c,cpp inoremap ;f  <..> <..>(<..>)<Enter>{<Enter><..><Enter>}<esc>kkkcw
autocmd FileType c,cpp inoremap ;m  int main(int argc, char *argv[])<Enter>{<Enter><..><Enter>}<esc>kwcw
autocmd FileType c,cpp inoremap ;l  for ( int i = 0; i < <..>; i++ )<Enter>{<Enter><..><Enter>}<esc>kkkt>ca<
autocmd FileType c,cpp inoremap ;i  #include ""<esc>i
autocmd FileType c,cpp inoremap ;I  #include <><esc>i
autocmd FileType cpp inoremap ;p  cout << "<..>" << endl;<esc>0t>ca<
autocmd FileType c inoremap ;p  printf("<..>\n");<esc>0t>ca<

" Markdown
autocmd BufNewFile,BufRead * if match(getline(1),"*.md") >= 0 | set filetype=md | endif
autocmd FileType md inoremap ;e  <esc>:-1read $HOME/.vim/skeletons/skeleton.expand.md<CR>gg/<..><Enter>ca<

" Skeleton Builders
autocmd FileType c inoremap ;t  <esc>:-1read $HOME/.vim/skeletons/.skeleton.c<CR>gg/<..><Enter>ca<
autocmd FileType cpp inoremap ;t  <esc>:-1read $HOME/.vim/skeletons/.skeleton.cpp<CR>gg/<..><Enter>ca<
autocmd FileType cpp inoremap ;ht  <esc>:-1read $HOME/.vim/skeletons/.skeleton.hpp<CR>gg/<..><Enter>ca<
autocmd FileType html inoremap ;t  <esc>:-1read $HOME/.vim/skeletons/.skeleton.html<CR>gg/<..><Enter>ca<

autocmd BufNewFile,BufRead *.rs set filetype=rust
autocmd FileType rust inoremap ;p println!("<..>");<esc>0/<..><Enter>ca<
]])
