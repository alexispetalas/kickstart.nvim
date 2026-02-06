-- Enhanced LSP configurations and additional tools

return {
  -- SchemaStore for JSON/YAML schemas
  {
    'b0o/schemastore.nvim',
    ft = { 'json', 'jsonc', 'yaml' },
  },

  -- LSP signature help
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {
      bind = true,
      handler_opts = {
        border = 'rounded',
      },
      hint_enable = true,
      hint_prefix = '🐼 ',
      hint_scheme = 'String',
      hi_parameter = 'LspSignatureActiveParameter',
      max_height = 12,
      max_width = 80,
      noice = false,
      wrap = true,
      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 1,
      floating_window_off_y = 0,
      close_timeout = 4000,
      fix_pos = false,
      always_trigger = true,
      auto_close_after = nil,
      extra_trigger_chars = {},
      zindex = 200,
      padding = '',
      transparency = nil,
      shadow_blend = 36,
      shadow_guibg = 'Black',
      timer_interval = 200,
      toggle_key = nil,
      select_signature_key = nil,
      move_cursor_key = nil,
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },

  -- Trouble for better diagnostics
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      modes = {
        lsp = {
          win = { position = 'right' },
        },
      },
    },
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cS',
        '<cmd>Trouble lsp toggle<cr>',
        desc = 'LSP references/definitions/... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  -- Better code outline
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>oo', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
    },
    opts = {
      outline_window = {
        position = 'right',
        width = 25,
        relative_width = true,
        auto_close = false,
        auto_jump = true,
        jump_highlight_duration = 300,
        center_on_jump = true,
        show_numbers = false,
        show_relative_numbers = false,
        wrap = false,
        focus_on_open = true,
        winhl = '',
      },
      outline_items = {
        show_symbol_details = true,
        show_symbol_lineno = false,
        highlight_hovered_item = true,
        auto_set_cursor = true,
        auto_update_events = {
          follow = { 'CursorMoved' },
          items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
        },
      },
      guides = {
        enabled = true,
        markers = {
          bottom = '└',
          middle = '├',
          vertical = '│',
          horizontal = '─',
        },
      },
      symbol_folding = {
        autofold_depth = 5,
        auto_unfold = {
          hovered = true,
          only = true,
        },
        markers = { '', '' },
      },
      preview_window = {
        auto_preview = false,
        open_hover_on_preview = false,
        width = 50,
        min_width = 50,
        relative_width = true,
        border = 'rounded',
        winhl = 'NormalFloat:',
        live = false,
      },
      keymaps = {
        show_help = '?',
        close = { '<Esc>', 'q' },
        goto_location = '<Cr>',
        peek_location = 'o',
        goto_and_close = '<S-Cr>',
        restore_location = '<C-g>',
        hover_symbol = '<C-space>',
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        fold = 'h',
        unfold = 'l',
        fold_toggle = '<Tab>',
        fold_toggle_all = '<S-Tab>',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
        down_and_jump = '<C-j>',
        up_and_jump = '<C-k>',
      },
      providers = {
        priority = { 'lsp', 'coc', 'markdown', 'norg' },
        lsp = {
          blacklist_clients = {},
        },
      },
      symbols = {
        filter = {
          default = { 'String', 'Number', 'Boolean', 'Array', 'Object', 'Key', 'Null' },
          markdown = false,
        },
        icon_fetcher = function(kind, bufnr)
          return require('mini.icons').get('lsp', kind)
        end,
      },
    },
  },

  -- Incremental LSP renaming
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    keys = {
      {
        '<leader>rn',
        function()
          return ':IncRename ' .. vim.fn.expand '<cword>'
        end,
        desc = 'Incremental rename',
        expr = true,
      },
    },
    config = true,
  },

  -- LSP progress indicator
  {
    'j-hui/fidget.nvim',
    opts = {
      progress = {
        poll_rate = 0,
        suppress_on_insert = false,
        ignore_done_already = false,
        ignore_empty_message = false,
        clear_on_detach = function(client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end,
        notification_group = function(msg)
          return msg.lsp_client.name
        end,
        ignore = {},
        lsp = {
          progress_ringbuf_size = 0,
          log_handler = false,
        },
        display = {
          render_limit = 16,
          done_ttl = 3,
          done_icon = '✔',
          done_style = 'Constant',
          progress_ttl = math.huge,
          progress_icon = { pattern = 'dots', period = 1 },
          progress_style = 'WarningMsg',
          group_style = 'Title',
          icon_style = 'Question',
          priority = 30,
          skip_history = true,
          format_message = require('fidget.progress.display').default_format_message,
          format_annote = function(msg)
            return msg.title
          end,
          format_group_name = function(group)
            return tostring(group)
          end,
          overrides = {
            rust_analyzer = { name = 'rust-analyzer' },
          },
        },
      },
      notification = {
        poll_rate = 10,
        filter = vim.log.levels.INFO,
        history_size = 128,
        override_vim_notify = false,
        configs = { default = require('fidget.notification').default_config },
        redirect = function(msg, level, opts)
          if opts and opts.on_open then
            return require('fidget.integration.nvim-notify').delegate(msg, level, opts)
          end
        end,
        view = {
          stack_upwards = true,
          icon_separator = ' ',
          group_separator = '---',
          group_separator_hl = 'Comment',
          render_message = function(msg, cnt)
            return cnt == 1 and msg or string.format('(%dx) %s', cnt, msg)
          end,
        },
        window = {
          normal_hl = 'Comment',
          winblend = 100,
          border = 'none',
          zindex = 45,
          max_width = 0,
          max_height = 0,
          x_padding = 1,
          y_padding = 0,
          align = 'bottom',
          relative = 'editor',
        },
      },
      integration = {
        ['nvim-tree'] = {
          enable = true,
        },
      },
      logger = {
        level = vim.log.levels.WARN,
        max_size = 10000,
        float_precision = 0.01,
        path = string.format('%s/fidget.nvim.log', vim.fn.stdpath 'cache'),
      },
    },
  },
}
