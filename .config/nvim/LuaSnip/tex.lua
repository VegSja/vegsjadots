local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("beg", {
    t({ "\\begin{" }),
    i(1, "environment"),
    t({ "}", "\t" }),
    i(2),
    t({ "", "\\end{" }),
    i(1),
    t({ "}" }),
  }),

  s("fig", {
    t({
      "\\begin{figure}[h!]",
      "\t\\centering",
      "\t\\includegraphics[width=\\textwidth]{",
    }),
    i(1, "path/to/image"),
    t({ "}", "\n\t\\caption{" }),
    i(2, "Your caption here"),
    t({ "}", "\n\t\\label{fig:" }),
    i(3, "label"),
    t({ "}", "\n\\end{figure}" }),
  }),
  s("ti", {
    t({ "\\todo[inline]{" }),
    i(1, "Your todo note"),
    t("}"),
  }),
}
