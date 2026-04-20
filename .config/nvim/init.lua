require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- my stuff
  use 'plan9-for-vimspace/acme-colors'
  use 'viruslobster/justtxt'
  use 'tpope/vim-sleuth'

  -- auto completion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin    
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp    
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp    
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use 'nvim-lua/plenary.nvim'
  -- use 'nvim-treesitter/nvim-treesitter'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'ziglang/zig.vim'

  use 'nvim-telescope/telescope.nvim'
end)

vim.cmd([[    
set nocompatible              " be iMproved, required    
filetype off                  " required    
" set the runtime path to include Vundle and initialize    
filetype plugin indent on    " required    
    
" b/c I learned the wrong keyboard layout
nnoremap l o
vnoremap l o
nnoremap o l
vnoremap o l
nnoremap L O
nnoremap O L
nnoremap j n
vnoremap j n
nnoremap n j
vnoremap n j
nnoremap J N
nnoremap N J
nnoremap gn gj
nnoremap gj gn
nnoremap k e
vnoremap k e
nnoremap e k
vnoremap e k
nnoremap K E
nnoremap E <nop>
nnoremap gk ge
nnoremap ge gk
nnoremap h y
vnoremap h y
onoremap h y
nnoremap y h
vnoremap y h
nnoremap H Y
nnoremap Y H
nnoremap <C-y> <C-w>h
nnoremap <C-n> <C-w>j
nnoremap <C-e> <C-w>k
nnoremap <C-o> <C-w>l
nnoremap <C-u> <C-o>
nnoremap <C-d> <C-i>

" Higlight lines that are too long
"highlight OverLength ctermbg=red ctermfg=white guibg=#
"match OverLength /\%81v.\+/
"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength ctermbg=red guibg=darkgrey
"  autocmd BufEnter * match OverLength /\%81v.*/
"augroup END

" Eliminate tabs
" used `:retab` fix
" set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
syn match tab display "\t"
hi link tab Error

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

" Display line numbers
set nu

" syntax for weird fb file extenstions
au BufRead,BufNewFile *.cinc set filetype=python
au BufRead,BufNewFile *.cconf set filetype=python
au BufRead,BufNewFile *.mcconf set filetype=python
au BufRead,BufNewFile *.tw set filetype=python

" maybe i'll be able to see my code now, seems important
"colorscheme gruvbox
"set background=dark
"colorscheme acme

" lol, but why is this needed?
set backspace=indent,eol,start

syntax on
nnoremap <leader>r :JustTxtRun<CR>
nnoremap . :JustTxtRun<CR>
nnoremap <leader>c :JustTxtKill<CR>

nnoremap <leader>t :Telescope find_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>

" escape from terminal mode with escape
tnoremap <Esc> <C-\><C-n>

" Jump to next error
"nnoremap <C-e> :lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap = true} )<CR>
]])
vim.o.signcolumn = 'yes'            -- Enable the signcolumn

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local lspconfig = require('lspconfig')
vim.lsp.enable('pyright')
-- lspconfig.pyright.setup {
-- capabilities = capabilities,
-- }
vim.lsp.enable('rust_analyzer')
-- lspconfig.rust_analyzer.setup {
-- capabilities = capabilities,
-- }
vim.lsp.enable("gopls")
-- lspconfig.gopls.setup{
-- capabilities = capabilities,
-- }
vim.lsp.enable("zls")
-- lspconfig.zls.setup {
--}
-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0
-- enable  format-on-save from nvim-lspconfig + ZLS
--
-- Formatting with ZLS matches `zig fmt`.
-- The Zig FAQ answers some questions about `zig fmt`:
-- https://github.com/ziglang/zig/wiki/FAQ
vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    completion = {
        -- don't show autocomplete by default. Has to be triggered manually
        autocomplete = false
    },
    snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-e>"] = actions.move_selection_previous,
        ["C-n>"] = actions.move_selection_next,
      }
    }
  }
}
