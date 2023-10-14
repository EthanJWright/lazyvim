return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  init = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vscode-snippets" } })
    local ls = require("luasnip")
    -- some shorthands...
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    -- local i = ls.insert_node
    -- local f = ls.function_node
    -- local c = ls.choice_node
    local d = ls.dynamic_node
    -- local r = ls.restore_node
    -- local l = require("luasnip.extras").lambda
    -- local rep = require("luasnip.extras").rep
    -- local p = require("luasnip.extras").partial
    -- local m = require("luasnip.extras").match
    -- local n = require("luasnip.extras").nonempty
    -- local dl = require("luasnip.extras").dynamic_lambda
    -- local fmt = require("luasnip.extras.fmt").fmt
    -- local fmta = require("luasnip.extras.fmt").fmta
    -- local types = require("luasnip.util.types")
    -- local conds = require("luasnip.extras.conditions")
    -- local conds_expand = require("luasnip.extras.conditions.expand")

    local random_name = require("../custom/random_name")
    local uuid = require("../custom/uuid")

    -- local function copy(args)
    --   return args[1]
    -- end

    -- examples found at https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L190
    -- docs found https://github.com/L3MON4D3/LuaSnip/tree/master
    ls.add_snippets("all", {
      s({
        trig = "uuid",
        name = "UUID",
        dscr = "Generate a unique UUID",
      }, {
        d(1, function()
          return sn(nil, t(uuid()))
        end),
      }),
      s({
        trig = "randomname",
        name = "Random Name",
        dscr = "Generate a docker friendly random name.",
      }, {
        d(1, function()
          return sn(nil, t(random_name()))
        end),
      }),
    })
  end,
}
