--
-- Start Java Language Server (based on nvim-jdtls)
--

local basedir = os.getenv('HOME') .. '/.local'

local config = {
  -- The command that starts the language server
  cmd = {
    'java',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
	  '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-noverify',
    '-Xmx1G',
    '-jar', basedir..'/jdtls/plugins/org.eclipse.equinox.launcher_1.6.300.v20210813-1054.jar',
    '-configuration', basedir..'/jdtls/config_mac',
    '-data', basedir..'/jdtls-data/',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED'
    -- ADD REMAINING OPTIONS FROM https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line !
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require('jdtls').start_or_attach(config)

