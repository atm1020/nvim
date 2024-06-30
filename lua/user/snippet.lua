local M = {
 'L3MON4D3/LuaSnip',
 -- follow latest release.
 version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
 -- install jsregexp (optional!).
 build = 'make install_jsregexp',
}

function M.config()
 local ls = require 'luasnip'
 local s = ls.snippet
 local t = ls.text_node
 local i = ls.insert_node
 local fmt = require('luasnip.extras.fmt').fmt
 local c = ls.choice_node
 vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.choice_active() then
   ls.change_choice(1)
  end
 end)
 vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.choice_active() then
   ls.change_choice(-1)
  end
 end)

 local function predef_var(key, name)
  return s(
   key,
   fmt('{}', {
    c(1, {
     t("variables['" .. name .. "']"),
     t("$('" .. name .. "')"),
    }),
   })
  )
 end

 ls.add_snippets('yaml', {
  predef_var('BuildId', 'Build.BuildId'),
  s(
   'forv',
   fmt([[${} each value in variables['{}'] {}:]], {
    t '{{',
    i(1),
    t '}}',
   })
  ),
  s(
   'forp',
   fmt([[${} each value in parameters.{} {}:]], {
    t '{{',
    i(1),
    t '}}',
   })
  ),
  s(
   'if',
   fmt([[${} if eq({}, {}) {}:]], {
    t '{{',
    i(1),
    i(2),
    t '}}',
   })
  ),
 })
end

return M
