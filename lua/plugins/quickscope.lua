return {
  'unblevable/quick-scope',
  init = function(_, opts)
    vim.cmd[[
      augroup qs_colors
        autocmd!
        autocmd ColorScheme * highlight QuickScopePrimary guifg='#FFE900' gui=underline ctermfg=155 cterm=underline
        autocmd ColorScheme * highlight QuickScopeSecondary guifg='#FFE900' gui=underline ctermfg=81 cterm=underline
      augroup END
      let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    ]]
  end
}
