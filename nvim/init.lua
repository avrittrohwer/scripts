-- Plugins
local plugins = {
    'https://github.com/junegunn/fzf.vim',
    'https://github.com/simeji/winresizer', -- manually patched to remove ctrl-E binding
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-rhubarb',
}
vim.api.nvim_create_user_command('PluginInstall',
    function()
        local buf = 'PluginInstall'
        vim.cmd('vsplit '..buf)
        local base = vim.fs.abspath('~/.config/nvim/pack/github/start')
        vim.fn.appendbufline(buf, 0, '# Installing in '..base)

        for _, link in ipairs(plugins) do
            local name = vim.fs.basename(link)
            local dir = base..'/'..name
            if vim.uv.fs_stat(dir) then
                vim.fn.appendbufline(buf, '$', '## '..name..': already exists')
            else
                vim.fn.appendbufline(buf, '$', '## '..name..': downloading')
                out = vim.fn.system('git clone --depth=1 '..link..'.git'..' '..dir)
                vim.fn.appendbufline(buf, '$', out)
            end
        end
    end,
    {
        nargs = 0,
        desc = 'Downloads plugins'
    }
)

-- Fzf (installed outside of this config)
vim.cmd('set rtp+=~/.fzf')

-- LSP
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})
vim.lsp.enable('pyright')
vim.lsp.enable('bashls')
vim.lsp.enable('tofu_ls')
vim.filetype.add({
    -- If filetype is left as terraform, tofu_ls server will respond with errors because it only know about tofu files.
    extension = {
        tf = 'opentofu',
        tfvars = 'opentofu-vars',
    }
})


-- Cmp completion
local cmp = require('cmp')
tab_mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(
        function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end
    ),
    ["<S-Tab>"] = cmp.mapping(
        function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end
    ),
}
cmp.setup({
    view = {                                                        
        entries = {name = 'custom', selection_order = 'near_cursor' } 
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = tab_mapping,
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    })
})
cmp.setup.cmdline(':', {
    mapping = tab_mapping,
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' },
    })
})

-- Conform formatting
local conform = require('conform')
conform.setup({
  log_level = vim.log.levels.DEBUG,
  formatters = {
    tofu = {
        command = 'tofu',
        args = {
            'fmt', '-'
        }
    },
    pyjson = {
        command = 'python3',
        args = {
            '-m', 'json.tool'
        }
    },
    shfmt = {
        command = 'shfmt',
        args = {
            '-bn', '-ci', '-i', '2', '-'
        }
    },
    yapf = {
        args = {
          '--style', '{based_on_style: google, SPLIT_BEFORE_FIRST_ARGUMENT:true}',
        },
        -- I didn't get this to work
        -- range_args = function(self, ctx)
        --     return { '--lines', ctx.range['start'][1] .. '-' .. ctx.range['end'][1] }
        -- end,
    }
  },
  formatters_by_ft = {
      python = { "yapf" },
      json = { "pyjson" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      opentofu = { "tofu" },
      ['opentofu-vars'] = { "tofu" },
  }
})


-- Visuals
--
-- The acutal loading of the colorscheme file occurs after the commands in this init file run. So highlighting needs to
-- occur after the colorscheme file loads.
vim.cmd.colorscheme('plain')
vim.api.nvim_create_autocmd({'ColorScheme'}, {
    callback = function(args)
        if args.match == 'plain' then
            vim.opt.termguicolors = false
            vim.opt.background = 'light'
            vim.cmd([[
                highlight StatusLine ctermfg=15 ctermbg=0
                highlight StatusLineNC ctermbg=7
                highlight Comment ctermfg=black
                highlight ColorColumn ctermbg=7
                highlight CursorLine cterm=underline ctermbg=15
                highlight CursorColumn ctermbg=254
                highlight MatchParen ctermbg=153
            ]])
        end
    end,
    desc = "Overrides some plain colorscheme settings"
})

vim.cmd([[
" aim cursor while in insert mode
augroup insertfmt
	autocmd!
	autocmd InsertEnter * set cursorline
	autocmd InsertLeave * set nocursorline
	autocmd InsertEnter * set cursorcolumn
	autocmd InsertLeave * set nocursorcolumn
augroup END
]])

vim.diagnostic.config({
    signs = false,
	virtual_text = {
        source = "if_many", -- display diagnostic source if many sources in buffer
        prefix = "|",
    }
})
vim.opt.winborder = 'rounded'

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end
})



-- Behavior
vim.opt.wrap = false
vim.opt.textwidth = 120
vim.opt.formatoptions:remove('o')
vim.opt.formatoptions:append('1')
vim.opt.scrolloff = 7
vim.opt.mouse = 'nv'

vim.opt.expandtab = true -- insert spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- use tabstop value

vim.g.netrw_liststyle = 3 -- tree style listing
vim.g.netrw_fastbrowse = 0 -- removes netrw buffer from buffer list when deleted

vim.opt.ignorecase = true
vim.opt.smartcase = true -- case-sensitive search if I search with caps
vim.opt.gdefault = true -- replace all occurrences on line

vim.opt.wildmenu = true
vim.opt.wildmode='longest,list,full'  -- make completion behave more like bash

-- Default status line + git
vim.opt.statusline = ("%{FugitiveStatusline()} %<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}")

vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true


-- Keybinds
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set({'n', 'v'}, ';', ':')
vim.keymap.set({'n', 'i'}, '<C-k>',
    function() 
        vim.lsp.buf.signature_help()
    end,
    {desc = 'Show signature help'}
)

vim.g.mapleader = vim.keycode('<Space>')

vim.keymap.set('n', '<Leader><esc>',
    function()
        vim.cmd([[
            write
            source
        ]])
    end,
    {desc = 'Write and source current buffer'}
)
vim.keymap.set('n', '<Leader>c',
    function()
        vim.cmd([[
            nohlsearch
        ]])
    end,
    {desc = 'Clear search highlight'}
)
vim.keymap.set('n', '<Leader>x',
    function()
        vim.cmd([[
            bprevious
            bdelete #
        ]])
    end,
    {desc = 'Delete buffer while keeping existing pane open if possible'}
)

-- Fzf.vim
vim.keymap.set('n', '<Leader>b',
    function()
        vim.cmd([[
            Buffers
        ]])
    end,
    {desc = 'Select buffers'}
)
vim.keymap.set('n', '<Leader>o',
    function()
        vim.cmd([[
            Files
        ]])
    end,
    {desc = 'Open a file'}
)
vim.keymap.set('n', '<Leader>l',
    function()
        vim.cmd([[
            :Lines
        ]])
    end,
    {desc = 'Search lines in buffers'}
)
vim.keymap.set('n', '<Leader>g',
    function()
        vim.cmd([[
            :RG
        ]])
    end,
    {desc = 'Ripgrep lines in filesytem'}
)

-- WinResizer
vim.keymap.set('n', '<Leader>r',
    function()
        vim.cmd([[
            WinResizerStartResize
        ]])
    end,
    {desc = 'Enter resize mode' }
)
vim.keymap.set('n', '<Leader>m',
    function()
        vim.cmd([[
            WinResizerStartMove
        ]])
    end,
    {desc = 'Enter move mode' }
)

-- Conform
vim.keymap.set({'n', 'v'}, '<Leader>f',
    function()
        conform.format()
    end,
    {desc = 'Format code' }
)
