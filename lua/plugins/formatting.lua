return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      go = { 'goimports', 'gofumpt' },
      rust = { 'rustfmt' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      vue = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      less = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      handlebars = { 'prettier' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      fish = { 'fish_indent' },
      toml = { 'taplo' },
      xml = { 'xmlformat' },
      sql = { 'sqlformat' },
    },
    formatters = {
      black = {
        prepend_args = { '--fast', '--line-length', '88' },
      },
      isort = {
        prepend_args = { '--profile', 'black' },
      },
      prettier = {
        prepend_args = { '--tab-width', '2' },
      },
      shfmt = {
        prepend_args = { '-i', '2', '-ci' },
      },
    },
  },
}