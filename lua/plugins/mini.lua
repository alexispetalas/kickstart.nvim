return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
          local git = statusline.section_git { trunc_width = 40 }
          local diff = statusline.section_diff { trunc_width = 75 }
          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
          local lsp = statusline.section_lsp { trunc_width = 75 }
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location { trunc_width = 75 }
          local search = statusline.section_searchcount { trunc_width = 75 }

          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
        inactive = function()
          local filename = statusline.section_filename { trunc_width = 140 }
          return statusline.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { filename } },
            '%=', -- End left alignment
          }
        end,
      },
      set_vim_settings = false,
    }

    -- Enhanced sections with more information
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v %3p%%'
    end

    -- Add custom section for recording macro
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_mode = function(args)
      local mode_info = statusline.is_truncated(args.trunc_width) and { mode = 'N', hl = 'MiniStatuslineModeNormal' }
        or {
          mode = vim.fn.mode(),
          hl = ({
            ['n'] = 'MiniStatuslineModeNormal',
            ['v'] = 'MiniStatuslineModeVisual',
            ['V'] = 'MiniStatuslineModeVisual',
            ['\22'] = 'MiniStatuslineModeVisual',
            ['s'] = 'MiniStatuslineModeVisual',
            ['S'] = 'MiniStatuslineModeVisual',
            ['\19'] = 'MiniStatuslineModeVisual',
            ['i'] = 'MiniStatuslineModeInsert',
            ['ic'] = 'MiniStatuslineModeInsert',
            ['R'] = 'MiniStatuslineModeReplace',
            ['Rv'] = 'MiniStatuslineModeReplace',
            ['c'] = 'MiniStatuslineModeCommand',
            ['cv'] = 'MiniStatuslineModeCommand',
            ['ce'] = 'MiniStatuslineModeCommand',
            ['r'] = 'MiniStatuslineModeCommand',
            ['rm'] = 'MiniStatuslineModeCommand',
            ['r?'] = 'MiniStatuslineModeCommand',
            ['!'] = 'MiniStatuslineModeCommand',
            ['t'] = 'MiniStatuslineModeOther',
          })[vim.fn.mode()] or 'MiniStatuslineModeOther',
        }

      local mode_string = ({
        ['n'] = 'NORMAL',
        ['no'] = 'OP',
        ['nov'] = 'OP',
        ['noV'] = 'OP',
        ['no\22'] = 'OP',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL LINE',
        ['Vs'] = 'VISUAL LINE',
        ['\22'] = 'VISUAL BLOCK',
        ['\22s'] = 'VISUAL BLOCK',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT LINE',
        ['\19'] = 'SELECT BLOCK',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
      })[mode_info.mode] or mode_info.mode

      -- Add macro recording indicator
      local recording = vim.fn.reg_recording()
      if recording ~= '' then
        mode_string = mode_string .. ' @' .. recording
      end

      return mode_string, mode_info.hl
    end

    -- Enhanced git section
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_git = function(args)
      if statusline.is_truncated(args.trunc_width) then
        return ''
      end

      local head = vim.b.gitsigns_head or vim.g.gitsigns_head
      if not head or head == '' then
        return ''
      end

      local status = vim.b.gitsigns_status_dict or {}
      local added = status.added and status.added > 0 and ('+' .. status.added) or ''
      local changed = status.changed and status.changed > 0 and ('~' .. status.changed) or ''
      local removed = status.removed and status.removed > 0 and ('-' .. status.removed) or ''

      local git_info = head
      if added ~= '' or changed ~= '' or removed ~= '' then
        git_info = git_info .. '[' .. added .. changed .. removed .. ']'
      end

      return (vim.g.have_nerd_font and ' ' or 'Git:') .. git_info
    end

    -- Enhanced diagnostics section
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_diagnostics = function(args)
      if statusline.is_truncated(args.trunc_width) then
        return ''
      end

      local count = vim.diagnostic.count(0)
      local errors = count[vim.diagnostic.severity.ERROR] or 0
      local warnings = count[vim.diagnostic.severity.WARN] or 0
      local info = count[vim.diagnostic.severity.INFO] or 0
      local hints = count[vim.diagnostic.severity.HINT] or 0

      if errors + warnings + info + hints == 0 then
        return ''
      end

      local parts = {}
      if errors > 0 then
        table.insert(parts, (vim.g.have_nerd_font and '󰅚 ' or 'E:') .. errors)
      end
      if warnings > 0 then
        table.insert(parts, (vim.g.have_nerd_font and '󰀪 ' or 'W:') .. warnings)
      end
      if info > 0 then
        table.insert(parts, (vim.g.have_nerd_font and '󰋽 ' or 'I:') .. info)
      end
      if hints > 0 then
        table.insert(parts, (vim.g.have_nerd_font and '󰌶 ' or 'H:') .. hints)
      end

      return table.concat(parts, ' ')
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}