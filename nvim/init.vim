" Register external plugins.
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'simeji/winresizer'
Plug 'neovim/nvim-lspconfig'
call plug#end()

" Enable file type based indent configuration and syntax highlighting.
" Note that when code is pasted via the terminal, vim by default does not detect
" that the code is pasted (as opposed to when using vim's paste mappings), which
" leads to incorrect indentation when indent mode is on.
" To work around this, use ":set paste" / ":set nopaste" to toggle paste mode.
" You can also use a plugin to:
" - enter insert mode with paste (https://github.com/tpope/vim-unimpaired)
" - auto-detect pasting (https://github.com/ConradIrwin/vim-bracketed-paste)
filetype plugin indent on
syntax on

" General settings
set nowrap  " don't wrap lines
set formatoptions=rqnj  " how text should be formatted, see :help fo-table
set showmatch  " show matching brackets
set splitbelow splitright  " splits go either below or to right of current pane
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=4
set ignorecase smartcase  " searching doesn't care about case unless I do
set gdefault  " use global replace by default
set hidden  " don't require saving of buffers when I switch between them
set wildmenu wildmode=longest,list,full  " make completion behave more like bash
let mapleader = "\<Space>"  " change leader to space
set background=light  " use light background by default
colorscheme plain  " https://github.com/andreypopp/vim-colors-plain
hi statusline ctermbg=7  " set background color for status line and horizontal split
hi statuslinenc ctermbg=7  " ""
hi Comment ctermfg=black " set comments to black
set signcolumn=no  " don't show things in sign col

" genereal bindings
inoremap jk <Esc>
nnoremap ; :
vnoremap ; :
nnoremap <Leader>c :nohlsearch<Cr>
nnoremap <Leader>s :&<Cr>
nnoremap <Leader>p a <Esc>p
nnoremap <Leader>f mf <Bar> gg <Bar> gqG <Bar> `f

" underline current line in insert mode
hi clear CursorLine
hi CursorLine cterm=underline
augroup insertfmt
	autocmd!
	autocmd InsertEnter * set cursorline
	autocmd InsertLeave * set nocursorline
augroup END

" Buffer management.
nnoremap <Leader>x :bprevious\|bdelete #<Cr>
nnoremap <Leader>b :Buffers<Cr>
nnoremap <Leader>o :Files<Cr>
nnoremap <Leader>r :WinResizerStartResize<Cr>

" Diagnostics management.
nnoremap <Leader>dn :lua vim.diagnostic.goto_next()<Cr>
nnoremap <Leader>dp :lua vim.diagnostic.goto_prev()<Cr>
nnoremap <Leader>dd :lua vim.diagnostic.open_float()<Cr>

lua << EOF
vim.diagnostic.config({
	virtual_text = {
		source = 'if_many',
		prefix = '|',
	},
})
EOF
