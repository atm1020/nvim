require('neotest').setup {
 log_level = vim.log.levels.DEBUG,
 adapters = {
  require 'neotest-jdtls',
 },
 --  watch = {
 --    enabled = true,
 --    symbol_queries = {
 --      java = require('neotest-jdtls.utils').symbol_query,
 --   }
 --}
}
