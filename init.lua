-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Learn more about Neovim lua api
-- https://neovim.io/doc/user/lua-guide.html
-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/

vim.o.number = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.signcolumn = 'yes'
vim.o.winborder = 'rounded'

-- Space as leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

-- NOTE: To install a plugin you just need to add the URL to the repository.
-- But as soon as you need to add more information, like the git branch or 
-- commit, use the "plugin spec" form. See :help vim.pack

-- Treesitter setup
-- See: https://github.com/VonHeikemen/ts-enable.nvim#usage
vim.g.ts_enable = {
  auto_init = true,
  auto_install = true,
  highlights = true,
  parser_info = vim.fn.stdpath('config') .. '/treesitter-parsers.json',
}

vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  {src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x'},
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  {src = 'https://github.com/s1n7ax/nvim-window-picker', version = 'v2.4.0'},
  {src = 'https://github.com/nvim-mini/mini.nvim', version = 'main'},
  {src = 'https://github.com/VonHeikemen/ts-enable.nvim', version = 'v2.x'},
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/folke/flash.nvim',
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

vim.cmd.colorscheme('tokyonight')
vim.api.nvim_set_hl(0, 'CursorLine', {bg = '#292e42'})

-- See :help MiniIcons.config
-- Change style to 'glyph' if you have a font with fancy icons
require('mini.icons').setup({style = 'ascii'})

-- See :help MiniSurround.config
require('mini.surround').setup({})

-- See :help MiniNotify.config
require('mini.notify').setup({
  lsp_progress = {enable = false},
})

-- See: https://github.com/s1n7ax/nvim-window-picker#configuration
require('window-picker').setup({})

-- See :help MiniBufremove.config
require('mini.bufremove').setup({})

-- Close buffer and preserve window layout
vim.keymap.set('n', '<leader>bc', '<cmd>lua pcall(MiniBufremove.delete)<cr>', {desc = 'Close buffer'})

-- See :help MiniFiles.config
local mini_files = require('mini.files')
mini_files.setup({})

-- Keep Mini Files available as a lightweight directory editor.
vim.keymap.set('n', '<leader>fm', function()
  if mini_files.close() then
    return
  end

  mini_files.open()
end, {desc = 'Open Mini Files'})

-- See :help neo-tree
require('neo-tree').setup({
  close_if_last_window = true,
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  window = {
    position = 'left',
    width = 32,
  },
})

-- Toggle the VS Code-style file explorer sidebar.
-- See :help MiniFiles-navigation
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('Neotree filesystem reveal left toggle')
end, {desc = 'Toggle file explorer sidebar'})

-- See :help MiniPick.config
require('mini.pick').setup({})

-- See available pickers
-- :help MiniPick.builtin
-- :help MiniExtra.pickers
vim.keymap.set('n', '<leader>?', '<cmd>Pick oldfiles<cr>', {desc = 'Search file history'})
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', {desc = 'Search in project'})
vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<cr>', {desc = 'Search diagnostics'})
vim.keymap.set('n', '<leader>fs', '<cmd>Pick buf_lines<cr>', {desc = 'Buffer local search'})

-- See :help MiniStatusline.config
require('mini.statusline').setup({})

-- See :help MiniExtra
require('mini.extra').setup({})

-- See :help MiniSnippets.config
require('mini.snippets').setup({})

-- See :help MiniCompletion.config
require('mini.completion').setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false,
  },
})

-- Render Markdown inside Neovim.
-- See: https://github.com/MeanderingProgrammer/render-markdown.nvim
require('render-markdown').setup({})

-- See :help which-key.nvim-which-key-setup
require('which-key').setup({
  preset = 'helix',
  delay = 0,
  icons = {
    mappings = false,
    keys = {
      Space = 'Space',
      Esc = 'Esc',
      BS = 'Backspace',
      C = 'Ctrl-',
    },
  },
})

require('which-key').add({
  {'<leader>f', group = 'Fuzzy Find'},
  {'<leader>b', group = 'Buffer'},
  {'<leader>h', group = 'Git Hunk'},
})

-- Navigation aliases also show the native keys as a reminder.
do
  local function counted_motion(prompt, motion)
    return function()
      vim.ui.input({prompt = prompt}, function(value)
        if value == nil then
          return
        end
        local count = tonumber(value)
        if not value:match('^%d+$') or not count or count < 1 or count > 2147483647 then
          vim.notify('Enter a positive whole number.', vim.log.levels.WARN)
          return
        end
        vim.cmd.normal({args = {tostring(count) .. motion}, bang = true})
      end)
    end
  end

  require('which-key').add({
    {'<leader>n', group = 'Navigation', mode = 'n'},
    {
      mode = 'n',
      {'<leader>nw', group = 'Words'},
      {'<leader>nww', 'w', desc = 'Next word (w)'},
      {'<leader>nwb', 'b', desc = 'Previous word (b)'},
      {'<leader>nwe', 'e', desc = 'End of word (e)'},
      {'<leader>nl', group = 'Lines'},
      {'<leader>nl0', '0', desc = 'Start of line (0)'},
      {'<leader>nl^', '^', desc = 'First text on line (^)'},
      {'<leader>nl$', '$', desc = 'End of line ($)'},
      {'<leader>nlj', '5j', desc = 'Down 5 lines (5j)'},
      {'<leader>nlk', '5k', desc = 'Up 5 lines (5k)'},
      {'<leader>nlJ', counted_motion('Lines down: ', 'j'), desc = 'Down N lines (Nj)'},
      {'<leader>nlK', counted_motion('Lines up: ', 'k'), desc = 'Up N lines (Nk)'},
      {'<leader>ng', group = 'File position'},
      {'<leader>ngg', 'gg', desc = 'Start of file (gg)'},
      {'<leader>ngG', 'G', desc = 'End of file (G)'},
      {'<leader>ngl', counted_motion('Go to line: ', 'G'), desc = 'Go to line (42G or :42)'},
      {'<leader>np', group = 'Pages'},
      {'<leader>npd', '<C-d>', desc = 'Half page down (Ctrl+d)'},
      {'<leader>npu', '<C-u>', desc = 'Half page up (Ctrl+u)'},
      {'<leader>npf', '<C-f>', desc = 'Full page down (Ctrl+f)'},
      {'<leader>npb', '<C-b>', desc = 'Full page up (Ctrl+b)'},
      {'<leader>nv', group = 'Screen position'},
      {'<leader>nvH', 'H', desc = 'Top of screen (H)'},
      {'<leader>nvM', 'M', desc = 'Middle of screen (M)'},
      {'<leader>nvL', 'L', desc = 'Bottom of screen (L)'},
      {'<leader>n}', '}', desc = 'Next paragraph (})'},
      {'<leader>n{', '{', desc = 'Previous paragraph ({)'},
      {'<leader>n%', '%', desc = 'Matching bracket (%)'},
      {'<leader>nz', 'zz', desc = 'Center current line (zz)'},
      {'<leader>n/', group = 'Search'},
      {'<leader>n//', '/', desc = 'Search forward (/)'},
      {'<leader>n/?', '?', desc = 'Search backward (?)'},
      {'<leader>n/n', 'n', desc = 'Next search match (n)'},
      {'<leader>n/N', 'N', desc = 'Previous search match (N)'},
      {'<leader>no', '<C-o>', desc = 'Previous jump (Ctrl+o)'},
      {'<leader>ni', '<C-i>', desc = 'Next jump (Ctrl+i)'},
      {'<leader>ns', function() require('flash').jump() end, desc = 'Flash jump (s)'},
      {'<leader>nS', function() require('flash').treesitter() end, desc = 'Flash syntax selection (S)'},
    },
  })
end

-- See :help gitsigns.nvim
require('gitsigns').setup({})

-- See :help flash.nvim
require('flash').setup({})

-- NOTE: flash.nvim does not map these keys by default; see flash README.
vim.keymap.set({'n', 'x', 'o'}, 's', function() require('flash').jump() end, {desc = 'Flash search'})
vim.keymap.set({'n', 'x', 'o'}, 'S', function() require('flash').treesitter() end, {desc = 'Flash treesitter'})

vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', {desc = 'Preview git hunk'})
vim.keymap.set('n', '<leader>hb', '<cmd>Gitsigns blame_line<cr>', {desc = 'Blame current line'})
vim.keymap.set('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', {desc = 'Reset git hunk'})
vim.keymap.set('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', {desc = 'Stage git hunk'})

-- LSP setup
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)

    if client and client:supports_method('textDocument/completion') then
      vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
  end,
})

-- Python LSP setup
vim.lsp.enable({'pyright', 'ruff'})
