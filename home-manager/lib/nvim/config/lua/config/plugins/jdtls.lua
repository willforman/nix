local M = {
  'mfussenegger/nvim-jdlts',
  ft = { 'java' },
}
local process_utils = require('utils.process')

function M.config()
  local jdtls = require('jdtls')

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

  local bin_path = process_utils.subprocess_get_stdout("which jdt-language-server")
  local path = bin_path:match('(.+)/bin/jdt%-language%-server')

  local launcher_path = path .. '/share/java/plugins/org.eclipse.equinox.luancher_1.6.500.v20230717-2134.jar'
  local config_path = '/Users/wforman/.cache/jdtls/config_mac'
  local data_path = '/Users/wforman/.cache/jdtls/' .. process_name

  jdlts.start_or_attach({
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

      '-jar', launcher_path,
      '-configuration', config_path,
      '-data', data_path,
    }
  })
end

return M
