-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders

local ls = require("luasnip")
-- local extras = require("luasnip.extras")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

ls.add_snippets("java", {

   s("sout", {
      t("System.out.println("),
      i(1),
      t(");"),
   }),

   s("souf", {
      t("System.out.printf(\""),
      i(1),
      t("\", "),
      i(2),
      t(");")
   }),

   s("soup", {
      t("System.out.print("),
      i(1),
      t(");"),
   }),

})

ls.add_snippets("lua", {

   s("keymap", fmt('{func}("{arg1}", "{arg2}", "{arg3}")', {
      func = c(1, {
         t("vim.keymap.set"),
         t("setkeymap")
      }),
      arg1 = i(2, "mode"),
      arg2 = i(3, "trigger"),
      arg3 = i(0, "action")
   }))

})
