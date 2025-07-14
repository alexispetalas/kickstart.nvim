return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      --      lint.linters_by_ft = {
      --        markdown = { 'markdownlint' },
      --      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- Configure linters by filetype
      lint.linters_by_ft = lint.linters_by_ft or {}
      
      -- Enable specific linters for languages we use (only if available)
      -- Python
      if vim.fn.executable('pylint') == 1 then
        lint.linters_by_ft.python = lint.linters_by_ft.python or {}
        table.insert(lint.linters_by_ft.python, 'pylint')
      end
      if vim.fn.executable('mypy') == 1 then
        lint.linters_by_ft.python = lint.linters_by_ft.python or {}
        table.insert(lint.linters_by_ft.python, 'mypy')
      end
      
      -- JavaScript/TypeScript
      if vim.fn.executable('eslint_d') == 1 or vim.fn.executable('eslint') == 1 then
        lint.linters_by_ft.javascript = { 'eslint_d' }
        lint.linters_by_ft.typescript = { 'eslint_d' }
        lint.linters_by_ft.javascriptreact = { 'eslint_d' }
        lint.linters_by_ft.typescriptreact = { 'eslint_d' }
        lint.linters_by_ft.vue = { 'eslint_d' }
      end
      
      -- Go
      if vim.fn.executable('golangci-lint') == 1 then
        lint.linters_by_ft.go = { 'golangci-lint' }
      end
      
      -- Shell
      if vim.fn.executable('shellcheck') == 1 then
        lint.linters_by_ft.sh = { 'shellcheck' }
        lint.linters_by_ft.bash = { 'shellcheck' }
        lint.linters_by_ft.zsh = { 'shellcheck' }
      end
      
      -- Docker
      if vim.fn.executable('hadolint') == 1 then
        lint.linters_by_ft.dockerfile = { 'hadolint' }
      end
      
      -- YAML (remove yamllint as it's causing issues)
      -- lint.linters_by_ft.yaml = { 'yamllint' }
      
      -- JSON
      if vim.fn.executable('jsonlint') == 1 then
        lint.linters_by_ft.json = { 'jsonlint' }
      end
      
      -- Markdown
      if vim.fn.executable('markdownlint') == 1 or vim.fn.executable('markdownlint-cli') == 1 then
        lint.linters_by_ft.markdown = { 'markdownlint' }
      end
      
      -- SQL
      if vim.fn.executable('sqlfluff') == 1 then
        lint.linters_by_ft.sql = { 'sqlfluff' }
      end
      
      -- Vim
      if vim.fn.executable('vint') == 1 then
        lint.linters_by_ft.vim = { 'vint' }
      end
      
      -- Lua
      if vim.fn.executable('luacheck') == 1 then
        lint.linters_by_ft.lua = { 'luacheck' }
      end
      
      -- Disable default linters for unused languages
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['rst'] = nil
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil

      -- Configure specific linters
      lint.linters.pylint.args = {
        '-f',
        'json',
        '--from-stdin',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      
      lint.linters.mypy.args = {
        '--show-column-numbers',
        '--show-error-end',
        '--hide-error-codes',
        '--hide-error-context',
        '--no-color-output',
        '--no-error-summary',
        '--no-pretty',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      
      lint.linters['golangci-lint'] = {
        cmd = 'golangci-lint',
        stdin = false,
        append_fname = false,
        args = {
          'run',
          '--out-format',
          'json',
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
          end,
        },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local decoded = vim.json.decode(output)
          if decoded and decoded.Issues then
            for _, issue in ipairs(decoded.Issues) do
              table.insert(diagnostics, {
                lnum = (issue.Pos.Line or 1) - 1,
                col = (issue.Pos.Column or 1) - 1,
                end_lnum = (issue.Pos.Line or 1) - 1,
                end_col = (issue.Pos.Column or 1) - 1,
                severity = vim.diagnostic.severity.WARN,
                message = issue.Text,
                source = 'golangci-lint',
                code = issue.FromLinter,
              })
            end
          end
          return diagnostics
        end,
      }

      -- Manual linting keymap
      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
      
      -- Additional autocmd for specific events
      vim.api.nvim_create_autocmd('TextChanged', {
        group = lint_augroup,
        callback = function()
          -- Debounced linting on text change
          vim.defer_fn(function()
            if vim.bo.modifiable then
              lint.try_lint()
            end
          end, 500)
        end,
      })
    end,
  },
}
