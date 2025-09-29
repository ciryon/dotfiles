" Plugin Section
" Install using nvim +PlugInstall 
call plug#begin("~/.vim/plugged")
" color themes
Plug 'dracula/vim'
Plug 'ulwlu/abyss.vim'
Plug 'sainnhe/sonokai'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'akinsho/bufferline.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuezk/vim-js'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'b3nj5m1n/kommentary'
Plug 'OmniSharp/omnisharp-vim' " for c#
Plug 'alvan/vim-closetag'
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-omnisharp']
call plug#end()

" Config Section

" General
syntax on
" set cursorline
set encoding=utf-8
set updatetime=300
set cmdheight=2
set mouse=a

" Whitespace
set nolist " No list characters
set wrap
set linebreak 
set showbreak=¬
set tabstop=2
set softtabstop=2
set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabpagemax=15               " only show 15 tabs
set nocursorline " No cursor line, thanks
set nonumber " No need for line numbers
set showmode                    " display the current mode
set colorcolumn=0

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"Leader

"let mapleader=","
nnoremap <SPACE> <Nop>
let mapleader=" "


" Color scheme

if (has("termguicolors"))
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
 set termguicolors
endif
color slate
" colorscheme abyss
" colorscheme dracula
" colorscheme onehalfdark
" let g:sonokai_style = 'maia'
"colorscheme onehalfdark

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Completion settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" start coc-snippet tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" end coc-snippet tab


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"



" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <a>f  <Plug>(coc-format-selected)
nmap <a>f  <Plug>(coc-format-selected)

" move with alt-arrow
nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>


" NERDTree
" let g:NERDTreeShowHidden = 1
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeIgnore = []
" let g:NERDTreeStatusline = ''
" " Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Toggle
" nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
" nnoremap <silent> <Leader>j :NERDTreeFind<CR>

" nvim-tree

nnoremap <Leader>n :NvimTreeToggle<CR>
nnoremap <Leader>j :NvimTreeFindFile<CR>
" let g:nvim_tree_hide_dotfiles = 1
" let g:nvim_tree_ignore = [ 'node_modules' ]
" let g:nvim_tree_auto_open = 1

lua <<EOF
require'nvim-tree'.setup {
}
EOF

" Integrated terminal
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>


" Fuzzy finder
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>f :Ag 
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" Kommentary
lua <<EOF
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})
EOF

" Bufferline
nnoremap <silent>    <A-[> :BufferPrevious<CR>
nnoremap <silent>    <A-]> :BufferNext<CR>
nnoremap <silent>    <A-w> :BufferClose<CR>

" Close tag config
let g:closetag_filenames = '*.html,*.xhtml,*.vue'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx, *.vue'
let g:closetag_filetypes = 'html,xhtml,vue'

"
" lua << EOF
" require("bufferline").setup{
" 	options = {
" offsets = {
"   {
"     filetype = "NvimTree",
"     text = "File Explorer",
"     highlight = "Directory",
"     text_align = "left"
"   }
" }
" 	   }
"    }
" EOF

" Tabline
"
"
" not working :(
" autocmd User NvimTreeOpen lua require'bufferline.state'.set_offset(30, 'FileTree')
" autocmd User NvimTreeClose lua require'bufferline.state'.set_offset(0) 
" autocmd User NvimTreeToggle lua require'bufferline.state'.set_offset(30) 

