" =========================
" Core Vim settings
" =========================
syntax on                       " Enables syntax highlighting
filetype plugin indent on       " Detect filetype, load plugins, enable indent

set lazyredraw
set ttyfast
"set termguicolors
 
set so=7                        " Keep 7 lines visible around cursor
set encoding=UTF-8
set backspace=indent,eol,start  " Proper backspace behavior

set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent

set cmdheight=1
set nu
set relativenumber
set nowrap
set smartcase
set mouse=a
set splitbelow
set splitright

set nobackup
set nowb
set noswapfile


if !isdirectory(expand("~/.config/nvim/undo"))
    call mkdir(expand("~/.config/nvim/undo"), "p")
endif
set undodir=~/.config/nvim/undo
set undofile

set runtimepath+=~/.local/share/nvim/site
set runtimepath+=~/.local/share/nvim/site/pack/*/start/*

set incsearch
set cb=unnamedplus

highlight ColorColumn ctermbg=0 guibg=lightgrey


" =========================
" Plugins (vim-plug)
" =========================
"call plug#begin('~/.vim/plugged/')
call plug#begin('~/.local/share/nvim/plugged')
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/goyo.vim'
Plug 'flazz/vim-colorschemes'
Plug 'romgrk/winteract.vim'
Plug 'anotherproksy/ez-window'
Plug 'felixhummel/setcolors.vim'
Plug 'vim-scripts/Conque-Shell'
Plug 'gko/vim-coloresque'
Plug 'lambdalisue/vim-fullscreen'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
"Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'gabrielelana/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Window Management Essentials
Plug 'simeji/winresizer'            " The best way to resize: press Ctrl+e to enter resize mode
Plug 'dhruvasagar/vim-zoom'         " Zoom in/out of a split (like Tmux's 'z')
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation (even if you don't use Tmux yet)

"few more
Plug 'itchyny/lightline.vim'           " Professional status bar

" =========================================================
" =============== EXTRA PRODUCTIVITY PLUGINS ==============
" =========================================================

" Better syntax highlighting engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Commenting utility (gcc, gc)
Plug 'tpope/vim-commentary'

" Git signs in gutter
Plug 'lewis6991/gitsigns.nvim'

" Indent guides
Plug 'lukas-reineke/indent-blankline.nvim'

" Better quickfix/location list UI
Plug 'kevinhwang91/nvim-bqf'

" Surround text editing (quotes, tags etc.)
Plug 'tpope/vim-surround'

" Session management
Plug 'rmagatti/auto-session'

" Better search UI
Plug 'junegunn/vim-peekaboo'

" Better marks navigation
Plug 'kshenoy/vim-signature'

" Easy motion navigation
Plug 'easymotion/vim-easymotion'

" Git diff viewer
Plug 'sindrets/diffview.nvim'

" Which-key style keybinding helper
Plug 'liuchengxu/vim-which-key'

" Better org-mode experience
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()


" =========================
" Colors & Fonts
" =========================

set background=dark
"colorscheme whitebox
"colorscheme gruvbox
"colorscheme wildcharm
"colorscheme vexorian
"colorscheme Tomorrow-Night-Bright
colorscheme mushroom

set guifont=DejaVuSansM\ Nerd\ Font\ Mono\ Regular\ 16


" =========================
" Error bell
" =========================
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif


" =========================
" netrw / ctrlp
" =========================
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25

"nnoremap <c-f> :CtrlP ~/<CR>
"let g:ctrlp_use_caching = 0
"let g:ctrlp_custom_ignore = {
"            \ 'dir':  '\v[\/](\.git|node_modules|build|dist|\.cache)$',
"            \ 'file': '\v\.(o|obj|bin|exe|class)$',
"            \ }


" =========================
" Leader & Keybindings
" =========================
let mapleader = " "

nnoremap <leader>c :colorscheme
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <leader>g gg=G<CR>

" Ctrl-Backspace (clean, single mapping)
inoremap <C-BS> <C-\><C-o>db


"map <TAB> %


nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>x :x<CR>


map <F5>  :!zsh<CR>
map <F4>  :!cp %

"set guioptions=i


" =========================
" Interactive window
" =========================
nmap gw :InteractiveWindow<CR>


" =========================
" Restore cursor position
" =========================
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


" =========================
" Buffer navigation
" =========================
map J :bn<CR>
map K :bp<CR>


" =========================
" Cursor appearance (GUI)
" =========================
highlight Cursor guifg=black guibg=orangered
highlight iCursor guifg=black guibg=greenyellow
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor


" =========================================================
" =============== C / C++ COMPILER SETTINGS ===============
" =========================================================

"for Windows
"Here -O2 will optimize your code to level 2
"nnoremap <F9> :!g++ -std=c++11 % -Wall -g -o %< && %< <CR>
"nnoremap <F2> :!g++  -std=c++14  % -Wall -Wextra -Wshadow -g -o %< && %< <CR>
"inoremap <F2> :!g++  -std=c++14  % -Wall -Wextra -Wshadow -g -o %< && %< <CR>

"for windows including input file
"nnoremap <F3> :!g++ -std=c++14 % -Wall -Wextra -Wshadow -g -o %< && %< < input <CR>

"Compiler settings for C for linux
noremap <F6> <ESC> :w <CR> :!gcc  -g  % -Wall -Wextra -Wshadow -O2 <CR>
inoremap <F6> <ESC> :w <CR> :!gcc  -g  % -Wall -Wextra -Wshadow -O2 <CR>

"Compiler settings for C++
noremap <F3> <ESC> :w <CR> :!g++ -std=c++14 -g  % -Wall -Wextra -Wshadow  -O2 && ./a.out < input <CR>
inoremap <F3> <ESC> :w <CR> :!g++ -std=c++14 -g  % -Wall -Wextra -Wshadow  -O2 && ./a.out < input <CR>
"noremap <F3> <ESC> :w <CR> :!clisp main.lisp<CR>
"inoremap <F3> <ESC> :w <CR> :!clisp main.lisp<CR>

"Compiler settings for C++ for linux
"noremap <F3> <ESC> :w <CR> :!g++  -g  % -Wall -Wextra -Wshadow -O2 && ./a.out<CR>
"noremap <F3> <ESC> :w <CR> :!g++  -g  % -Wall -Wextra -Wshadow -O2 && echo "================================================" && ./a.out<CR>
"inoremap <F3> <ESC> :w <CR> :!g++  -g  % -Wall -Wextra -Wshadow -O2 && echo "================================================" && ./a.out<CR>

" =========================
" NERDTree Git icons
" =========================

let NERDTreeDirArrowExpandable=""
let NERDTreeDirArrowCollapsible=""
let g:NERDTreeMinimalUI=1

let g:NERDTreeGitStatusUseNerdFonts = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  :'✹',
            \ 'Staged'    :'✚',
            \ 'Untracked' :'✭',
            \ 'Renamed'   :'➜',
            \ 'Unmerged'  :'═',
            \ 'Deleted'   :'✖',
            \ 'Dirty'     :'✗',
            \ 'Ignored'   :'☒',
            \ 'Clean'     :'✔︎',
            \ 'Unknown'   :'?',
            \ }


" =========================
" Rainbow brackets
" =========================
let g:rainbow_active = 1
let g:rainbow_load_separately = [
            \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
            \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
            \ ]


" =========================
" ASCII ART 
" =========================
let g:ascii = [
            \'',
            \'    ██████╗██╗███████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ███╗ ██████╗ ███╗   ██╗',
            \'   ██╔════╝██║██╔════╝██╔════╝██╔═══██╗    ██╔══██╗██╔══██╗████╗ ████║██╔═══██╗████╗  ██║',
            \'   ██║     ██║███████╗██║     ██║   ██║    ██████╔╝███████║██╔████╔██║██║   ██║██╔██╗ ██║',
            \'   ██║     ██║╚════██║██║     ██║   ██║    ██╔══██╗██╔══██║██║╚██╔╝██║██║   ██║██║╚██╗██║',
            \'   ╚██████╗██║███████║╚██████╗╚██████╔╝    ██║  ██║██║  ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║',
            \'    ╚═════╝╚═╝╚══════╝ ╚═════╝ ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝',
            \'',
            \]


" =========================
" Startify
" =========================
nnoremap <leader>S :Startify<CR>
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU'] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
            \ { 'type': 'commands',  'header': ['   Commands'] },
            \ ]

let g:startify_change_to_dir = 1
let g:startify_fortune_use_unicode = 1
let g:startify_custom_header = g:ascii + startify#fortune#boxed()
let g:startify_files_number = 11
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_update_oldfiles = 1

" =========================
" UltiSnips
" =========================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<leader>n"
let g:UltiSnipsJumpBackwardTrigger="<leader>b"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsEnableSnipMate = 0

" =========================
" Goyo
" =========================
nnoremap <leader>f :Goyo<CR>
let g:goyo_width = 90
let g:goyo_height = '85%'

" =========================
" Nerd Tree
" =========================
nnoremap <leader>. :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

" =========================
" Undo Tree
" =========================
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" =========================
" FZF Settings & Mappings
" =========================

" 1. Replace your Ctrl-F (CtrlP) with FZF Files
" Your old: nnoremap <c-f> :CtrlP ~/<CR>
nnoremap <C-f> :Files ~/<CR>

" 2. Search currently open buffers (Safe mapping)
nnoremap <leader>b :Buffers<CR>

" 3. Search lines in the current file (Fuzzy search inside file)
nnoremap <leader>l :Lines<CR>

" 4. Search lines in ALL open buffers
nnoremap <leader>L :BLines<CR>

" 6. Advanced: Search for text inside files (requires Ripgrep 'rg' installed)
nnoremap <leader>rg :Rg<CR>

" Customize the FZF window to be a floating layout (Modern look)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Use these to avoid your existing <leader>h/j/k/l window moves:
nnoremap <leader>ff :Files<CR>
"nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>tt :Tags<CR>
nnoremap <leader>hh :History<CR>

" Use FZF with a preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" =========================
" Window Management
" =========================

" 1. Fast Movement (Replacing your current leader mappings with Ctrl for speed)
" This allows you to jump windows without hitting space first
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 2. Smart Splitting (Intuitive keys)
" <leader>v for vertical, <leader>s for horizontal
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" 3. Zooming (Focus mode)
" Press <leader>z to make the current window full screen, then <leader>z to go back
nmap <leader>z <Plug>(zoom-toggle)

" 4. WinResizer (The 'Everything' tool)
" Press Ctrl + e. Now h,j,k,l will resize the window. Press Enter to finish.
let g:winresizer_start_key = '<C-e>'

" 5. Close and Balance
nnoremap <leader>q :q<CR>    " Close current window
nnoremap <leader>= <C-w>=    " Make all windows equal size (Great after closing one)

" 6. Rotate Windows
" Use <leader>r to swap the position of your current splits
nnoremap <leader>r <C-w>r

" =========================================================
" =============== VISUAL POLISH & STATUSLINE ==============
" =========================================================

" 1. Interface Cleanup
"set laststatus=2        " Always show status line
set noshowmode          " Hide default --INSERT-- (Lightline shows it)
set cmdheight=1         " Keep command area small
"set guioptions-=e       " Remove heavy GUI tabs
set fillchars+=vert:\   " Use a space for the vertical separator

" 2. Lightline Theme & Settings
" We use 'jellybeans' because it is dark and blends with black/red themes
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" 3. The "Invisibles" - Making bars blend with the background
" 'guibg=NONE' or matching it to a dark hex makes the white bars disappear
augroup CustomColors
    autocmd!
    " Vertical Split (The line between side-by-side windows)
    highlight VertSplit gui=NONE guifg=#121212 guibg=NONE ctermfg=234 ctermbg=NONE

    " StatusLine (The bar at the bottom of the active window)
    highlight StatusLine gui=NONE guifg=#808080 guibg=#121212 ctermfg=244 ctermbg=234

    " StatusLineNC (The bar at the bottom of INACTIVE windows)
    highlight StatusLineNC gui=NONE guifg=#303030 guibg=#121212 ctermfg=236 ctermbg=234
augroup END

" =========================
" Treesitter
" =========================
"lua << EOF
"require'nvim-treesitter.configs'.setup {
"  highlight = { enable = true },
"  indent = { enable = true },
"}
"EOF
lua << EOF
local ok, configs = pcall(require, "nvim-treesitter.configs")
if ok then
  configs.setup({
    ensure_installed = { "c", "cpp", "lua", "python", "bash", "markdown" },
    highlight = { enable = true },
  })
end
EOF
" =========================
" Commentary
" =========================
" gcc -> comment line
" gc  -> comment selection

" =========================
" GitSigns
" =========================
lua << EOF
require('gitsigns').setup()
EOF

nnoremap <leader>gn :Gitsigns next_hunk<CR>
nnoremap <leader>gp :Gitsigns prev_hunk<CR>
nnoremap <leader>gs :Gitsigns stage_hunk<CR>
nnoremap <leader>gr :Gitsigns reset_hunk<CR>

" =========================
" Indent Blankline
" =========================
lua << EOF
require("ibl").setup()
EOF

nnoremap <leader>ti :IBLToggle<CR>

" =========================
" Better Quickfix
" =========================
let g:bqf_auto_enable = 1

" =========================
" Surround
" =========================
" cs"'  -> change " to '
" ds"   -> delete "
" ysiw" -> surround word with "

" =========================
" Auto Session
" =========================
lua << EOF
require("auto-session").setup({
  auto_restore_enabled = true,
})
EOF
let g:auto_session_enabled = v:true

nnoremap <leader>ss :SessionSave<CR>
nnoremap <leader>sr :SessionRestore<CR>

" =========================
" Peekaboo
" =========================
let g:peekaboo_delay = 300

" =========================
" Signature (Marks)
" =========================
let g:SignatureMap = {
      \ 'Leader':  "m",
      \ 'GotoNextSpotByPos': ']m',
      \ 'GotoPrevSpotByPos': '[m'
      \ }

" =========================
" EasyMotion
" =========================
nmap <leader><leader>w <Plug>(easymotion-w)
nmap <leader><leader>b <Plug>(easymotion-b)
nmap <leader><leader>l <Plug>(easymotion-lineforward)
nmap <leader><leader>h <Plug>(easymotion-linebackward)

" =========================
" DiffView
" =========================
nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gq :DiffviewClose<CR>

" =========================
" Which Key
" =========================
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" =========================
" Table Mode
" =========================
nnoremap <leader>tm :TableModeToggle<CR>
let g:table_mode_corner = '|'

" =========================
" VimWiki
" =========================
let g:vimwiki_list = [{
      \ 'path': '~/wiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

nnoremap <leader>ww :VimwikiIndex<CR>
nnoremap <leader>wt :VimwikiTabIndex<CR>


set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions
