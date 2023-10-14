return {
  "ggandor/leap.nvim",
  opts = {
    case_sensitive = false,
  },
  init = function(_, opts)
    local leap = require('leap')
    leap.add_default_mappings()
  end
}
