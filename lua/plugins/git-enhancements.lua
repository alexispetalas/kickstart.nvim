-- Enhanced Git integration tools

return {
  -- Advanced git interface
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
      { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Git commit' },
      { '<leader>gp', '<cmd>Neogit push<cr>', desc = 'Git push' },
      { '<leader>gP', '<cmd>Neogit pull<cr>', desc = 'Git pull' },
    },
    opts = {
      graph_style = 'ascii',
      git_services = {
        ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
        ['bitbucket.org'] = 'https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1',
        ['gitlab.com'] = 'https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}',
      },
      disable_hint = false,
      disable_context_highlighting = false,
      disable_signs = false,
      telescope_sorter = function()
        return require('telescope').extensions.fzf.native_fzf_sorter()
      end,
      remember_settings = true,
      use_per_project_settings = true,
      ignored_settings = {
        'NeogitPushPopup--force-with-lease',
        'NeogitPushPopup--force',
        'NeogitPullPopup--rebase',
        'NeogitCommitPopup--allow-empty',
        'NeogitRevertPopup--no-edit',
      },
      auto_refresh = true,
      sort_branches = '-committerdate',
      kind = 'tab',
      disable_line_numbers = true,
      console_timeout = 2000,
      auto_show_console = true,
      status = {
        recent_commit_count = 10,
      },
      commit_editor = {
        kind = 'tab',
      },
      commit_select_view = {
        kind = 'tab',
      },
      commit_view = {
        kind = 'vsplit',
        verify_commit = vim.fn.executable 'gpg' == 1,
      },
      log_view = {
        kind = 'tab',
      },
      rebase_editor = {
        kind = 'tab',
      },
      reflog_view = {
        kind = 'tab',
      },
      merge_editor = {
        kind = 'tab',
      },
      tag_editor = {
        kind = 'tab',
      },
      preview_buffer = {
        kind = 'split',
      },
      popup = {
        kind = 'split',
      },
      signs = {
        hunk = { '', '' },
        item = { '>', 'v' },
        section = { '>', 'v' },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
      sections = {
        sequencer = {
          folded = false,
          hidden = false,
        },
        untracked = {
          folded = false,
          hidden = false,
        },
        unstaged = {
          folded = false,
          hidden = false,
        },
        staged = {
          folded = false,
          hidden = false,
        },
        stashes = {
          folded = true,
          hidden = false,
        },
        unpulled_upstream = {
          folded = true,
          hidden = false,
        },
        unmerged_upstream = {
          folded = false,
          hidden = false,
        },
        unpulled_pushRemote = {
          folded = true,
          hidden = false,
        },
        unmerged_pushRemote = {
          folded = false,
          hidden = false,
        },
        recent = {
          folded = true,
          hidden = false,
        },
        rebase = {
          folded = true,
          hidden = false,
        },
      },
      mappings = {
        commit_editor = {
          ['q'] = 'Close',
          ['<c-c><c-c>'] = 'Submit',
          ['<c-c><c-k>'] = 'Abort',
        },
        rebase_editor = {
          ['p'] = 'Pick',
          ['r'] = 'Reword',
          ['e'] = 'Edit',
          ['s'] = 'Squash',
          ['f'] = 'Fixup',
          ['x'] = 'Execute',
          ['d'] = 'Drop',
          ['b'] = 'Break',
          ['q'] = 'Close',
          ['<cr>'] = 'OpenCommit',
          ['gk'] = 'MoveUp',
          ['gj'] = 'MoveDown',
          ['<c-c><c-c>'] = 'Submit',
          ['<c-c><c-k>'] = 'Abort',
          ['[c'] = 'OpenOrScrollUp',
          [']c'] = 'OpenOrScrollDown',
        },
        finder = {
          ['<cr>'] = 'Select',
          ['<c-c>'] = 'Close',
          ['<esc>'] = 'Close',
          ['<c-n>'] = 'Next',
          ['<c-p>'] = 'Previous',
          ['<down>'] = 'Next',
          ['<up>'] = 'Previous',
          ['<tab>'] = 'MultiselectToggleNext',
          ['<s-tab>'] = 'MultiselectTogglePrevious',
          ['<c-j>'] = 'NOP',
        },
        popup = {
          ['?'] = 'HelpPopup',
          ['A'] = 'CherryPickPopup',
          ['D'] = 'DiffPopup',
          ['M'] = 'RemotePopup',
          ['P'] = 'PushPopup',
          ['X'] = 'ResetPopup',
          ['Z'] = 'StashPopup',
          ['b'] = 'BranchPopup',
          ['c'] = 'CommitPopup',
          ['f'] = 'FetchPopup',
          ['l'] = 'LogPopup',
          ['m'] = 'MergePopup',
          ['p'] = 'PullPopup',
          ['r'] = 'RebasePopup',
          ['v'] = 'RevertPopup',
          ['w'] = 'WorktreePopup',
        },
        status = {
          ['q'] = 'Close',
          ['I'] = 'InitRepo',
          ['1'] = 'Depth1',
          ['2'] = 'Depth2',
          ['3'] = 'Depth3',
          ['4'] = 'Depth4',
          ['<tab>'] = 'Toggle',
          ['x'] = 'Discard',
          ['s'] = 'Stage',
          ['S'] = 'StageUnstaged',
          ['<c-s>'] = 'StageAll',
          ['u'] = 'Unstage',
          ['U'] = 'UnstageStaged',
          ['$'] = 'CommandHistory',
          ['Y'] = 'YankSelected',
          ['<c-r>'] = 'RefreshBuffer',
          ['<enter>'] = 'GoToFile',
          ['<c-v>'] = 'VSplitOpen',
          ['<c-x>'] = 'SplitOpen',
          ['<c-t>'] = 'TabOpen',
          ['{'] = 'GoToPreviousHunkHeader',
          ['}'] = 'GoToNextHunkHeader',
          ['[c'] = 'OpenOrScrollUp',
          [']c'] = 'OpenOrScrollDown',
        },
      },
    },
  },

  -- Enhanced diff viewing
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'File History' },
      { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = 'Current File History' },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = false,
      git_cmd = { 'git' },
      hg_cmd = { 'hg' },
      use_icons = true,
      show_help_hints = true,
      watch_index = true,
      icons = {
        folder_closed = '',
        folder_open = '',
      },
      signs = {
        fold_closed = '',
        fold_open = '',
        done = '✓',
      },
      view = {
        default = {
          layout = 'diff2_horizontal',
          disable_diagnostics = true,
          winbar_info = false,
        },
        merge_tool = {
          layout = 'diff3_horizontal',
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = 'diff2_horizontal',
          disable_diagnostics = true,
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = 'tree',
        tree_options = {
          flatten_dirs = true,
          folder_statuses = 'only_folded',
        },
        win_config = {
          position = 'left',
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = 'combined',
            },
            multi_file = {
              diff_merges = 'first-parent',
            },
          },
          hg = {
            single_file = {},
            multi_file = {},
          },
        },
        win_config = {
          position = 'bottom',
          height = 16,
          win_opts = {},
        },
      },
      commit_log_panel = {
        win_config = {
          win_opts = {},
        },
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
        view = {
          { 'n', '<tab>', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Toggle the file panel.' } },
          { 'n', 'gf', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Toggle the file panel' } },
          { 'n', '<leader>e', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Toggle the file panel' } },
          { 'n', '<leader>co', '<cmd>DiffviewConflictChooseOurs<cr>', { desc = 'Choose the OURS version of a conflict' } },
          { 'n', '<leader>ct', '<cmd>DiffviewConflictChooseTheirs<cr>', { desc = 'Choose the THEIRS version of a conflict' } },
          { 'n', '<leader>cb', '<cmd>DiffviewConflictChooseBase<cr>', { desc = 'Choose the BASE version of a conflict' } },
          { 'n', '<leader>ca', '<cmd>DiffviewConflictChooseAll<cr>', { desc = 'Choose all the versions of a conflict' } },
          { 'n', 'dx', '<cmd>DiffviewConflictChooseNone<cr>', { desc = 'Delete the conflict region' } },
        },
        diff1 = {
          { 'n', 'g?', '<cmd>h diffview-maps-diff1<cr>', { desc = 'Open the help panel' } },
        },
        diff2 = {
          { 'n', 'g?', '<cmd>h diffview-maps-diff2<cr>', { desc = 'Open the help panel' } },
        },
        diff3 = {
          { 'n', 'g?', '<cmd>h diffview-maps-diff3<cr>', { desc = 'Open the help panel' } },
        },
        diff4 = {
          { 'n', 'g?', '<cmd>h diffview-maps-diff4<cr>', { desc = 'Open the help panel' } },
        },
        file_panel = {
          { 'n', 'j', '<cmd>lua require"diffview.actions".next_entry()<cr>', { desc = 'Bring the cursor to the next file entry' } },
          { 'n', '<down>', '<cmd>lua require"diffview.actions".next_entry()<cr>', { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', '<cmd>lua require"diffview.actions".prev_entry()<cr>', { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<up>', '<cmd>lua require"diffview.actions".prev_entry()<cr>', { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<cr>', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', 'o', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', 'l', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', '<2-LeftMouse>', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', '-', '<cmd>lua require"diffview.actions".toggle_stage_entry()<cr>', { desc = 'Stage / unstage the selected entry' } },
          { 'n', 'S', '<cmd>lua require"diffview.actions".stage_all()<cr>', { desc = 'Stage all entries' } },
          { 'n', 'U', '<cmd>lua require"diffview.actions".unstage_all()<cr>', { desc = 'Unstage all entries' } },
          { 'n', 'X', '<cmd>lua require"diffview.actions".restore_entry()<cr>', { desc = 'Restore entry to the state on the left side' } },
          { 'n', 'L', '<cmd>lua require"diffview.actions".open_commit_log()<cr>', { desc = 'Open the commit log panel' } },
          { 'n', 'zo', '<cmd>lua require"diffview.actions".open_fold()<cr>', { desc = 'Expand fold' } },
          { 'n', 'h', '<cmd>lua require"diffview.actions".close_fold()<cr>', { desc = 'Collapse fold' } },
          { 'n', 'zc', '<cmd>lua require"diffview.actions".close_fold()<cr>', { desc = 'Collapse fold' } },
          { 'n', 'za', '<cmd>lua require"diffview.actions".toggle_fold()<cr>', { desc = 'Toggle fold' } },
          { 'n', 'zR', '<cmd>lua require"diffview.actions".open_all_folds()<cr>', { desc = 'Expand all folds' } },
          { 'n', 'zM', '<cmd>lua require"diffview.actions".close_all_folds()<cr>', { desc = 'Collapse all folds' } },
          { 'n', '<c-b>', '<cmd>lua require"diffview.actions".scroll_view(-0.25)<cr>', { desc = 'Scroll the view up' } },
          { 'n', '<c-f>', '<cmd>lua require"diffview.actions".scroll_view(0.25)<cr>', { desc = 'Scroll the view down' } },
          { 'n', '<tab>', '<cmd>lua require"diffview.actions".select_next_entry()<cr>', { desc = 'Open the diff for the next file' } },
          { 'n', '<s-tab>', '<cmd>lua require"diffview.actions".select_prev_entry()<cr>', { desc = 'Open the diff for the previous file' } },
          { 'n', 'gf', '<cmd>lua require"diffview.actions".goto_file()<cr>', { desc = 'Open the file in the previous tabpage' } },
          { 'n', '<C-w><C-f>', '<cmd>lua require"diffview.actions".goto_file_split()<cr>', { desc = 'Open the file in a new split' } },
          { 'n', '<C-w>gf', '<cmd>lua require"diffview.actions".goto_file_tab()<cr>', { desc = 'Open the file in a new tabpage' } },
          { 'n', 'i', '<cmd>lua require"diffview.actions".listing_style()<cr>', { desc = 'Toggle between "list" and "tree" views' } },
          { 'n', 'f', '<cmd>lua require"diffview.actions".toggle_flatten_dirs()<cr>', { desc = 'Flatten empty subdirectories in tree listing style' } },
          { 'n', 'R', '<cmd>lua require"diffview.actions".refresh_files()<cr>', { desc = 'Update stats and entries in the file list' } },
          { 'n', '<leader>e', '<cmd>lua require"diffview.actions".focus_files()<cr>', { desc = 'Bring focus to the file panel' } },
          { 'n', '<leader>b', '<cmd>lua require"diffview.actions".toggle_files()<cr>', { desc = 'Toggle the file panel' } },
          { 'n', 'g<C-x>', '<cmd>lua require"diffview.actions".cycle_layout()<cr>', { desc = 'Cycle available layouts' } },
          { 'n', '[x', '<cmd>lua require"diffview.actions".prev_conflict()<cr>', { desc = 'Go to the previous conflict' } },
          { 'n', ']x', '<cmd>lua require"diffview.actions".next_conflict()<cr>', { desc = 'Go to the next conflict' } },
          { 'n', 'g?', '<cmd>h diffview-maps-file-panel<cr>', { desc = 'Open the help panel' } },
        },
        file_history_panel = {
          { 'n', 'g!', '<cmd>lua require"diffview.actions".options()<cr>', { desc = 'Open the option panel' } },
          { 'n', '<C-A-d>', '<cmd>lua require"diffview.actions".open_in_diffview()<cr>', { desc = 'Open the entry under the cursor in a diffview' } },
          { 'n', 'y', '<cmd>lua require"diffview.actions".copy_hash()<cr>', { desc = 'Copy the commit hash of the entry under the cursor' } },
          { 'n', 'L', '<cmd>lua require"diffview.actions".open_commit_log()<cr>', { desc = 'Show commit details' } },
          { 'n', 'zR', '<cmd>lua require"diffview.actions".open_all_folds()<cr>', { desc = 'Expand all folds' } },
          { 'n', 'zM', '<cmd>lua require"diffview.actions".close_all_folds()<cr>', { desc = 'Collapse all folds' } },
          { 'n', 'j', '<cmd>lua require"diffview.actions".next_entry()<cr>', { desc = 'Bring the cursor to the next file entry' } },
          { 'n', '<down>', '<cmd>lua require"diffview.actions".next_entry()<cr>', { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', '<cmd>lua require"diffview.actions".prev_entry()<cr>', { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<up>', '<cmd>lua require"diffview.actions".prev_entry()<cr>', { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<cr>', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', 'o', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', '<2-LeftMouse>', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Open the diff for the selected entry' } },
          { 'n', '<c-b>', '<cmd>lua require"diffview.actions".scroll_view(-0.25)<cr>', { desc = 'Scroll the view up' } },
          { 'n', '<c-f>', '<cmd>lua require"diffview.actions".scroll_view(0.25)<cr>', { desc = 'Scroll the view down' } },
          { 'n', '<tab>', '<cmd>lua require"diffview.actions".select_next_entry()<cr>', { desc = 'Open the diff for the next file' } },
          { 'n', '<s-tab>', '<cmd>lua require"diffview.actions".select_prev_entry()<cr>', { desc = 'Open the diff for the previous file' } },
          { 'n', 'gf', '<cmd>lua require"diffview.actions".goto_file()<cr>', { desc = 'Open the file in the previous tabpage' } },
          { 'n', '<C-w><C-f>', '<cmd>lua require"diffview.actions".goto_file_split()<cr>', { desc = 'Open the file in a new split' } },
          { 'n', '<C-w>gf', '<cmd>lua require"diffview.actions".goto_file_tab()<cr>', { desc = 'Open the file in a new tabpage' } },
          { 'n', '<leader>e', '<cmd>lua require"diffview.actions".focus_files()<cr>', { desc = 'Bring focus to the file panel' } },
          { 'n', '<leader>b', '<cmd>lua require"diffview.actions".toggle_files()<cr>', { desc = 'Toggle the file panel' } },
          { 'n', 'g<C-x>', '<cmd>lua require"diffview.actions".cycle_layout()<cr>', { desc = 'Cycle available layouts' } },
          { 'n', 'g?', '<cmd>h diffview-maps-file-history-panel<cr>', { desc = 'Open the help panel' } },
        },
        option_panel = {
          { 'n', '<tab>', '<cmd>lua require"diffview.actions".select_entry()<cr>', { desc = 'Change the current option' } },
          { 'n', 'q', '<cmd>lua require"diffview.actions".close()<cr>', { desc = 'Close the panel' } },
          { 'n', 'g?', '<cmd>h diffview-maps-option-panel<cr>', { desc = 'Open the help panel' } },
        },
        help_panel = {
          { 'n', 'q', '<cmd>lua require"diffview.actions".close()<cr>', { desc = 'Close help menu' } },
          { 'n', '<esc>', '<cmd>lua require"diffview.actions".close()<cr>', { desc = 'Close help menu' } },
        },
      },
    },
  },

  -- Git worktree management
  {
    'ThePrimeagen/git-worktree.nvim',
    keys = {
      {
        '<leader>gww',
        function()
          require('telescope').extensions.git_worktree.git_worktrees()
        end,
        desc = 'Git worktrees',
      },
      {
        '<leader>gwc',
        function()
          require('telescope').extensions.git_worktree.create_git_worktree()
        end,
        desc = 'Create git worktree',
      },
    },
    config = function()
      require('git-worktree').setup {}
      require('telescope').load_extension 'git_worktree'
    end,
  },

  -- Git blame annotations
  {
    'f-person/git-blame.nvim',
    event = 'BufRead',
    opts = {
      enabled = false, -- disabled by default, toggle with :GitBlameToggle
      message_template = ' <summary> • <date> • <author>',
      date_format = '%m-%d-%Y %H:%M:%S',
      virtual_text_column = nil,
      highlight_group = 'Comment',
      set_extmark_options = {},
      display_virtual_text = true,
      ignored_filetypes = {},
      delay = 1000,
      virtual_text_column = nil,
      use_blame_commit_file_urls = false,
    },
    keys = {
      { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = 'Toggle Git Blame' },
      { '<leader>gB', '<cmd>GitBlameOpenCommitURL<cr>', desc = 'Open Commit URL' },
    },
  },
}