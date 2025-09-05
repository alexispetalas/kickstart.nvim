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
      lint.linters_by_ft = {}
      
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
      
      -- Markdown (disabled due to noisy warnings)
      -- if vim.fn.executable('markdownlint') == 1 or vim.fn.executable('markdownlint-cli') == 1 then
      --   lint.linters_by_ft.markdown = { 'markdownlint' }
      -- end
      
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
      -- Enhanced pylint configuration with virtual environment support
      local function get_python_info()
        -- Function to find Python virtual environment (similar to pyright config)
        local function find_venv()
          -- Check for regular venv in current directory or subdirectories
          local venv_patterns = { 'venv', 'app/venv', '.venv', 'env', '.env' }
          for _, pattern in ipairs(venv_patterns) do
            local venv_path = vim.fn.getcwd() .. '/' .. pattern
            if vim.fn.isdirectory(venv_path .. '/bin') == 1 then
              return venv_path
            end
          end

          -- Check for Poetry environment
          local poetry_venv = vim.fn.system('poetry env info -p 2>/dev/null'):gsub('\n', '')
          if vim.fn.isdirectory(poetry_venv) == 1 then
            return poetry_venv
          end

          -- Check for pipenv environment
          local pipenv_venv = vim.fn.system('pipenv --venv 2>/dev/null'):gsub('\n', '')
          if vim.fn.isdirectory(pipenv_venv) == 1 then
            return pipenv_venv
          end

          -- Check for conda environment
          local conda_prefix = os.getenv 'CONDA_PREFIX'
          if conda_prefix and vim.fn.isdirectory(conda_prefix .. '/bin') == 1 then
            return conda_prefix
          end
          
          -- Check VIRTUAL_ENV environment variable
          local venv = os.getenv("VIRTUAL_ENV")
          if venv and vim.fn.isdirectory(venv) == 1 then
            return venv
          end

          return nil
        end

        local venv_path = find_venv()
        if venv_path then
          local pylint_cmd = venv_path .. '/bin/pylint'
          local python_path = venv_path .. '/bin/python'
          -- Check if venv pylint exists, otherwise use system pylint with venv python
          if vim.fn.executable(pylint_cmd) == 1 then
            return {
              cmd = pylint_cmd,
              python_path = python_path,
              venv_path = venv_path
            }
          else
            return {
              cmd = "pylint",
              python_path = python_path,
              venv_path = venv_path
            }
          end
        end
        
        -- Fallback to system python
        return {
          cmd = "pylint",
          python_path = "python",
          venv_path = nil
        }
      end
      
      -- Configure pylint with virtual environment support
      local python_info = get_python_info()
      lint.linters.pylint.cmd = python_info.cmd
      
      -- Enhanced pylint arguments with dynamic virtual environment support
      lint.linters.pylint.args = function()
        local args = {
          '-f',
          'json',
          '--from-stdin',
        }
        
        local python_info = get_python_info()
        if python_info.venv_path then
          -- Use the virtual environment's Python interpreter
          table.insert(args, '--init-hook=import sys; sys.path.insert(0, "' .. python_info.venv_path .. '/lib/python*/site-packages")')
        end
        
        -- Add the filename
        table.insert(args, vim.api.nvim_buf_get_name(0))
        
        return args
      end
      
      -- Enhanced pylint environment setup
      lint.linters.pylint.env = function()
        local python_info = get_python_info()
        local env = {}
        
        if python_info.venv_path then
          env.VIRTUAL_ENV = python_info.venv_path
          env.PATH = python_info.venv_path .. '/bin:' .. (os.getenv('PATH') or '')
          
          -- Find the correct site-packages directory
          local site_packages = vim.fn.glob(python_info.venv_path .. '/lib/python*/site-packages')
          if site_packages ~= '' then
            env.PYTHONPATH = site_packages .. ':' .. (os.getenv('PYTHONPATH') or '')
          end
        end
        
        return env
      end
      
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
      
      -- Debug pylint configuration
      vim.keymap.set('n', '<leader>ld', function()
        local python_info = get_python_info()
        print("Pylint Debug Info:")
        print("  Command:", python_info.cmd)
        print("  Python Path:", python_info.python_path)
        print("  Venv Path:", python_info.venv_path or "None")
        print("  VIRTUAL_ENV:", vim.env.VIRTUAL_ENV or "None")
        print("  PYTHONPATH:", vim.env.PYTHONPATH or "None")
        
        if python_info.venv_path then
          local site_packages = vim.fn.glob(python_info.venv_path .. '/lib/python*/site-packages')
          print("  Site Packages:", site_packages ~= '' and site_packages or "Not found")
        end
      end, { desc = 'Debug pylint configuration' })

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
