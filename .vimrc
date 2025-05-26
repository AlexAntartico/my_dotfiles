" Custom VIM settings
" -------------------
" -------------------
" May 2025
" Leader key is a prefix for custom shortcuts. Here it's set to comma (,).
" Example: If you map <leader>w to save, you'd press ,w.
let mapleader = ","

" Vim-markdown plugin settings
" ----------------------------
" Disable concealing of markdown syntax (e.g., *, _, etc.)
let g:vim_markdown_conceal = 0
" Disable concealing of markdown code blocks
let g:vim_markdown_conceal_code_blocks = 0

" General settings
" ---------------
" Display line numbers on the left side of the window.
set number

" Set the width of a hard tabstop to 4 spaces.
set tabstop=4
" Set the width for automatic indentation to 4 spaces.
set shiftwidth=4
" Number of spaces that a <Tab> counts for while editing (e.g. when hitting backspace).
" When 'expandtab' is off, this makes <Tab> insert a mix of tabs and spaces.
" When 'expandtab' is on, this influences how <Tab> behaves with existing indentation.
set softtabstop=4

" Enable wrapping of long lines so they are visible without horizontal scrolling.
set wrap

" Search settings
"-----------------
" Highlight all occurrences of a search pattern.
set hlsearch
" Ignore case when searching, unless the search pattern contains an uppercase letter.
set ignorecase
" Show matching brackets or parentheses when the cursor is on one.
set showmatch
" Enable incremental search: show matches as you type the search pattern.
set incsearch

" Indentation settings
" --------------------
" Use spaces instead of actual tab characters when Tab key is pressed.
set expandtab
" Enable smart auto-indenting for C-like languages.
set smartindent
" Enable automatic indentation: new lines inherit indentation from the previous line.
set autoindent
" Enable smart tabbing: uses 'shiftwidth' for tabs at the beginning of a line,
" and 'tabstop' for tabs elsewhere.
set smarttab

" Backspace behavior
" ------------------
" Allow backspace to delete over autoindent, end-of-line, and start of insert.
set backspace=indent,eol,start

" Syntax highlighting
" -------------------
" Enable syntax highlighting for different file types.
syntax on

" Mouse support
" -------------
" Enable mouse support in all modes (normal, visual, insert, command-line).
set mouse=a

" Cursor and current line
" -----------------------
" Highlight the current line where the cursor is located.
set cursorline

" File encoding
" -------------
" Set the default file encoding to UTF-8.
set encoding=utf-8

" Command-line completion
" -----------------------
" Enable a menu for command-line completion.
set wildmenu
" Define behavior for command-line completion:
" 'longest:full' completes to the longest common string, then lists all matches.
" 'full' completes the first match fully.
set wildmode=longest:full,full

" ------------------------
" Plugins (using vim-plug)
" ------------------------
" Follow instructions at https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Begin vim-plug plugin manager section. Plugins are installed in '~/.vim/plugged'.
call plug#begin('~/.vim/plugged')

" Plugin manager itself
Plug 'junegunn/vim-plug'

" Python development
" Provides Jedi-based autocompletion and other features for Python.
Plug 'davidhalter/jedi-vim'

" File explorer
" tree-like file system explorer.
Plug 'preservim/nerdtree'

" GitHub Copilot
" open vim, then run :Copilot setup
Plug 'github/copilot.vim'

" Markdown support
" Enhanced Markdown support (syntax highlighting, commands, etc.).
Plug 'plasticboy/vim-markdown'
" Live Markdown preview in a browser.
Plug 'shime/vim-livedown'

" Fuzzy finder (FZF)
" command-line fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Installs FZF if not present.
" Vim integration for FZF.
Plug 'junegunn/fzf.vim'

" End vim-plug plugin manager section.
call plug#end()
" ---------------------
" End of Plugin Section
" ---------------------

" Key mappings
" ---------------
" Toggle NERDTree file explorer with Ctrl+n.
nnoremap <C-n> :NERDTreeToggle<CR>

" GitHub Copilot mappings
" Toggle GitHub Copilot off with <leader>cc (e.g., ,cc).
nnoremap <leader>cc :Copilot disable<CR>
" Toggle GitHub Copilot on with <leader>ce (e.g., ,ce).
nnoremap <leader>ce :Copilot enable<CR>

" Function to display Copilot status in the status line.
function! CopilotStatus() abort
    " Check if the Copilot enable function exists and if Copilot is enabled.
    return exists('*copilot#Enabled') && copilot#Enabled() ? 'enabled' : 'disabled'
endfunction

" Add Copilot status to the status line.
" %{CopilotStatus()} calls the function and inserts its return value.
set statusline+=%{CopilotStatus()}

" Use 'jj' as a convenient way to escape from Insert mode to Normal mode.
inoremap jj <Esc>

" Use Ctrl+p to open FZF fuzzy file finder.
nnoremap <C-p> :FZF<CR>

" Persistent undo
" ---------------
" This feature preserves undo history even after closing and reopening Vim.
if has('persistent_undo')
    " Enable persistent undo.
    set undofile
    " Set the directory where undo files will be stored.
    set undodir=~/.vim/undodir
endif

" Custom status line
" ---------------
" Always show the status line (0=never, 1=only if more than one window, 2=always).
set laststatus=2
" Define the content of the status line:
" %F: Full path to the file
" %m: Modified flag ('[+]' if modified)
" %r: Read-only flag ('[RO]')
" %h: Help buffer flag ('[HELP]')
" %w: Preview window flag ('[Preview]')
" %=: Separator, pushes items to the right
" %{&ff}: File format (e.g., unix, dos)
" %Y: File type (e.g., vim, python)
" %l: Current line number
" %L: Total line number
" %c: Current column number
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Spell checking
" ---------------
" Enable spell checking for text and markdown files, using US English dictionary.
autocmd FileType text,markdown setlocal spell spelllang=en_us

" Auto-commands
" ---------------
" Automatically remove trailing whitespace on save for specified file types.
" BufWritePre: Trigger before writing the buffer.
" <buffer>: Apply command only to the current buffer.
" %s/\s\+$//e: Substitute trailing whitespace with nothing.
"   \s\+: one or more whitespace characters
"   $: end of the line
"   e: suppress error if no match is found
autocmd FileType python,javascript,html,css,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" Window splitting behavior
" ---------------
" New horizontal splits will open below the current window.
set splitbelow
" New vertical splits will open to the right of the current window.
set splitright

" File-specific indentation
" ---------------
" For YAML, Markdown, HTML, CSS, and JavaScript files, set local indentation
" to 2 spaces for tabstop, softtabstop, and shiftwidth, and use spaces for tabs.
autocmd FileType yaml,markdown,html,css,javascript setlocal ts=2 sts=2 sw=2 expandtab

