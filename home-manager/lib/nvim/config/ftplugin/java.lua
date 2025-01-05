local root_markers = {
  'gradlew',
  'mvnw',
  '.git',
  '.gitignore',
}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local bin_path = my_utils.process.subprocess_get_stdout("which jdtls")
local jdtls_path = bin_path:match('(.+)/bin/jdtls')
local cache_path = '/Users/wforman/.cache/jdtls'

local launcher_path = jdtls_path .. '/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
-- local config_path = path .. '/share/java/jdtls/config_mac'
-- /nix/store/95fqm36gn4pm0kw85wbw357phxbdpdd5-jdt-language-server-1.43.0/share/java/jdtls/config_mac/
local config_path = cache_path .. '/config'
local data_path = cache_path .. '/' .. project_name

local config = {
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
  },

  root_dir = vim.fs.root(0, root_markers)
}

require('jdtls').start_or_attach(config)
