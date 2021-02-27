"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: jinxin.ashin@outlook.com
"
" Sections:
"   -> General
"   -> Vim user interface
"   -> Colors and Fonts
"   -> Files and backups
"   -> Text, tab and indent related
"   -> Visual mode related
"   -> Operations related to windows, buffers and tabs
"   -> Status line
"   -> Editing mappings
"   -> Vimgrep searching and cope displaying
"   -> Spell checking
"   -> Misc
"   -> Helper functions
"   -> Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines of history Vim has to remember"
set history=500

" Enable filetype plugins"
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside"
set autoread
au FocusGained,BufEnter * checktime

" With a map leader, it's possible to do extra key combinations"
let mapleader = ";"

" Fast save the changes in current buffer"
nmap <leader>ss :w!<cr>

" Fast save the buffer opened in current window, and then close the window"
nmap <leader>sc :w!<cr>:q<cr>

" :W sudo saves the file (useful for handling the permission-denied error)"
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Fast edit and source .vimrc"
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :w<CR>:source $MYVIMRC<CR>

" List all buffers"
map <leader>ls :ls<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k"
set so=7

" Avoid garbled characters in Chinese language Windows OS"
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Display line number.
set nu 

" Highlight current line"
set cursorline

" Turn on the wild menu"
set wildmenu

" Ignore complied files"
set wildignore=*.o,*~,*pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/DS_Store
endif

" Always show current position"
set ruler

" Height of the command bar"
set cmdheight=1

" A buffer becomes hidden when it is abandoned"
set hid

" Configure backspace, so it can act as it should act"
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching"
set ignorecase

" Highlight search results"
set hlsearch

" Make search act like search in modern browsers"
set incsearch

" Don't redraw while executing macros (good performance config)"
set lazyredraw

" For regular expressions turn magic on"
set magic

" Show matching brackets when text indicator is over them"
set showmatch
" How many tenths of a second to blink when matching brackets"
set mat=2

" No annoying sound on errors"
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting"
syntax enable

" Enable 256 colors palette in Gnome Terminal"
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme darkblue
catch
endtry

set background=dark

" Set extra options when running in GUI mode"
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language"
set encoding=utf8

" Use Unix as the standard file type"
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git, etc."
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs"
set expandtab

" Be smart when using tabs"
set smarttab

" 1 tab == 4 spaces"
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters"
set lbr
set tw=500

set ai "Auto indent"
set si "Smart indent"
set wrap "Wrap lines"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual model pressing * or # searches for the current selection"
" Super useful!
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Operations related to windows, buffers, and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <space> to / (search) and <C-space> to ? (backwards search)"
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed"
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows"
map <leader>wj <C-w>j
map <leader>wk <C-w>k
map <leader>wh <C-w>h
map <leader>wl <C-w>l
map <leader>ww <C-w>w
map <leader>wp <C-w>p

" Close current window"
map <leader>wc :q<cr>

" Close all the windows"
map <leader>wa :qa<cr>

" Keep only current window"
map <leader>wo :only<cr>

" Split windows"
map <leader>ws <C-w>s
map <leader>wv <C-w>v

" Smart way to switch between buffers
map <leader>bl :bnext<cr>
map <leader>bh :bprevious<cr>

" Close the current buffer"
map <leader>bc :Bclose<cr>

" Close all the buffers"
map <leader>ba :bufdo bd<cr>


" Useful mappings for managing tabs"
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

" Let 'tp' toggle between this and the last "
let g:lasttab = 1
nmap <leader>tp :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Open a new tab with current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer"
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers"
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to the last editing position when opening files (You want this!)"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line"
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character"
map 0 ^

" Remap for insert mode
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap jk <ESC>

" Remap for visual mode"
vnoremap <C-e> <ESC>

" Delete trailing white space on save, useful for some filetypes"
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>sp will toggle and untoggle spell checking"
map <leader>sp :setlocal spell!<cr>

" Shortcuts for spell checking using <leader>"
map <leader>sl ]s
map <leader>sh [s
map <leader>sa zg
map <leader>s? z=

hi clear SpellBad
hi SpellBad cterm=underline
hi SpellBad ctermfg=red
hi SpellBad gui=undercurl


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encoding gets messed up"
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble"
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble"
" map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off"
map <leader>pp :setlocal paste!<cr>

" Default complete
setglobal complete-=i

" Use system clipboard
set clipboard=unnamed

" Fast runing"
nnoremap <F5> :call CompileRunGcc()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return true if paste mode is enabled"
function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer"
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Fast runing
func! CompileRunGcc()
    exec "w"
    if &filetype == "c"
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == "cpp"
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == "java"
        exec "!javac %"
        exec "!time java%<"
    elseif &filetype == "sh"
        :!time bash %
    elseif &filetype == "python"
        exec "!time python %"
    elseif &filetype == "html"
        exec "!firefox % &"
    elseif &filetype == "go"
        exec "!go build %<"
        exec "!time go run %"
    endif
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'ycm-core/YouCompleteMe', {'commit':'d98f896', 'on': []}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>rr :NERDTreeToggle<CR><C-w>=
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyAlign config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. gaip)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tags config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./.tags;,.tags
set tags+=~/anaconda3/lib/python3.7/.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }
let g:ycm_python_interpreter_path = "/home/starrysky/anaconda3/bin/python3"
let g:ycm_python_sys_path = ["/home/starrysky/anaconda3/lib/python3.7/site-packages/"]
let g:ycm_extra_conf_vim_data = [
            \ "g:ycm_python_interpreter_path",
            \ "g:ycm_python_sys_path"
            \]
let g:ycm_global_ycm_extra_conf = "~/.global_extra_conf.py"
augroup load_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
augroup END

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => snippets config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plz don't set the following directories with absolute paths
let g:UltiSnipsSnippetDirectories=[
            \ "UltiSnips",
            \ "mysnippets"
            \]
let g:my_python_snip_file = "~/.vim/plugged/vim-snippets/mysnippets/python.snippets"

" Key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrgger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:ultisnips_python_style="google"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gitgutter config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
let g:airline_theme='powerlineish'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
nnoremap <leader>aa :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-tex config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
