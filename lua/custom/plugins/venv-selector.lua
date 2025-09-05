return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python', --optional
    'mfussenegger/nvim-lint', -- Add lint as dependency
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  lazy = false,
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select virtual environment' },
    { '<leader>ve', '<cmd>VenvSelectCached<cr>', desc = 'Select cached venv' },
  },
  config = function()
    require('venv-selector').setup({
      -- Auto select virtual environment when opening Python files
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      
      -- Hook into venv selection to update linting configuration
      changed_venv_hooks = {
        -- Update pylint configuration when venv changes
        function(venv_path, venv_python)
          -- Get the lint module if available
          local lint_ok, lint = pcall(require, 'lint')
          if lint_ok and venv_path then
            -- Update environment variables for current session
            vim.env.VIRTUAL_ENV = venv_path
            local site_packages = vim.fn.glob(venv_path .. '/lib/python*/site-packages')
            if site_packages ~= '' then
              vim.env.PYTHONPATH = site_packages .. ':' .. (vim.env.PYTHONPATH or '')
            end
            
            -- Update pylint command to use the virtual environment
            local pylint_cmd = venv_path .. '/bin/pylint'
            if vim.fn.executable(pylint_cmd) == 1 then
              lint.linters.pylint.cmd = pylint_cmd
            else
              lint.linters.pylint.cmd = "pylint"
            end
            
            -- Re-run linting for all Python buffers
            vim.defer_fn(function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == 'python' then
                  lint.try_lint(nil, { buf = buf })
                end
              end
            end, 100)
          end
          
          -- Notify user of venv change
          if venv_path then
            vim.notify('Virtual environment changed to: ' .. venv_path, vim.log.levels.INFO)
          end
        end,
      },
    })
  end,
}
