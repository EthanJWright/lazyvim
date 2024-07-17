return {
  "L3MON4D3/LuaSnip",

  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- How to load snippets from a custom path
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })

      local luaSnip = require("luasnip")

      -- some shorthands...
      local snippet = luaSnip.snippet
      local snippetNode = luaSnip.snippet_node
      local textNode = luaSnip.text_node
      local dynamicNode = luaSnip.dynamic_node
      -- local insertNode = luaSnip.insert_node
      -- local functionNode = luaSnip.function_node
      -- local choiceNode = ls.choice_node
      -- local restoreNode = ls.restore_node
      -- local lambda = require("luasnip.extras").lambda
      -- local rep = require("luasnip.extras").rep
      -- local partial = require("luasnip.extras").partial
      -- local match = require("luasnip.extras").match
      -- local nonEmpty = require("luasnip.extras").nonempty
      -- local dynamicLambda = require("luasnip.extras").dynamic_lambda
      -- local fmt = require("luasnip.extras.fmt").fmt
      -- local fmta = require("luasnip.extras.fmt").fmta
      -- local types = require("luasnip.util.types")
      -- local conds = require("luasnip.extras.conditions")
      -- local conds_expand = require("luasnip.extras.conditions.expand")

      local random_name = require("../snip-functions/random_name")

      -- examples found at https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L190
      -- docs found https://github.com/L3MON4D3/LuaSnip/tree/master
      luaSnip.add_snippets("all", {
        snippet({
          trig = "randomname",
          name = "Random Name",
          dscr = "Generate a docker friendly random name.",
          filetype = "all",
        }, {
          dynamicNode(1, function()
            return snippetNode(nil, textNode(random_name()))
          end),
        }),
      })
    end,
  },
}
