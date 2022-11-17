""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: jinxin.ashin@outlook.com
"
" Sections:
"   -> Usage
"   -> General
"   -> Vim user interface
"   -> Colors and Fonts
"   -> Files and backups
"   -> Text, tab and indent related
"   -> Visual mode related
"   -> Command mode related
"   -> Operations related to windows, buffers and tabs
"   -> Status line
"   -> Editing mappings
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

" Remap <leader>; to ; in normal and visual mode, for jumping to the next
" matched character in the line
nnoremap <leader>; ;
vnoremap <leader>; ;

" Fast save the changes in current buffer"
nmap <leader>s :w!<cr>

" Fast save the buffer opened in current window, and then close the window"
" nmap <leader>sc :w!<cr>:q<cr>

" :W sudo saves the file (useful for handling the permission-denied error)"
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Fast edit and source .vimrc"
" nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>rc :w<CR>:source $MYVIMRC<CR>

" Show absolute path of current buffer
map <leader>ab :echo expand("%:p")<cr>

" Copy the content of current file and prepare to edit the content in anthor
" file
map <leader>cw ggVGy:<C-u>call CopyPath()<cr>:e <C-r><C-o>p

" Disable preview window for complete
set completeopt=menu,menuone
set completeopt-=preview


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

" Display hybrid (relative and abs) line number.
set nu rnu

" Highlight current line"
set cursorline

" Turn on the wild menu"
set wildmenu

" Always show the status line
set laststatus=2

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

" Linebreak on 80 characters"
set lbr
set tw=80

set ai "Auto indent"
set si "Smart indent"
set wrap "Wrap lines"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual model pressing * or # searches for the current selection"
" Super useful!
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>N
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line"
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Operations related to windows, buffers, and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <space> to / (search)"
map <space> /

" Let the cursor stay in current searching word
nnoremap * *N

" Disable highlight when <leader><cr> is pressed"
map <silent> <leader><cr> :noh<cr>

" Remap the prefix key of window operations"
" Move windows"
map <leader>wm <C-w>r

" Close current window"
map <leader>wc :q<cr>

" Close all the windows"
map <leader>wa :qa<cr>

" Keep only current window"
map <leader>wo :only<cr>

" Switch to the buffer previously opened in current window"
map <leader>bp :b#<cr>

" Close the current buffer"
map <leader>bc :Bclose<cr>

" Close all the buffers"
map <leader>ba :bufdo bd<cr>

" Del current file in buffers
map <leader>d. :NERDTreeFind<cr><c-w>=md

" Rename/move current opened file
map <leader>m. :NERDTreeFind<cr><c-w>=mm

" Useful mappings for managing tabs"
map <leader>tN :tabnew<cr>:tabmove -1<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove +1<cr>
map <leader>tM :tabmove -1<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Let 'tp' toggle between this and the last "
let g:lasttab = 1
nmap <leader>tp :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" " Open a new tab with current buffer's path
" " Super useful when editing files in the same directory
" map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" " Switch CWD to the directory of the open buffer"
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers"
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to the last editing position when opening files (You want this!)"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal!  g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character"
map 0 ^

" Remap for insert mode
inoremap () ()<Left>
inoremap [] []<Left>
inoremap {} {}<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>
inoremap jk <ESC>
inoremap <c-d> <Del>
inoremap <c-k> <C-o>D
inoremap <c-f> <Right>
inoremap <c-b> <Left>

" Remap for normal mode"
" nnoremap <c-j> o<ESC>
nnoremap <Enter> o<ESC>
nnoremap <c-e> //e<CR>
nnoremap <c-g> ggVG<CR>

" Remap for visual mode"
vnoremap <c-e> <ESC>
vnoremap <c-g> ggVG<CR>

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
map <F10> :setlocal spell!<cr>

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
map <leader>qb :call EnsureDirExists($HOME . "/.buffer")<cr>:tabnew ~/.buffer/buffer<cr>

" Quickly open a python buffer for scribble"
map <leader>qp :call EnsureDirExists($HOME . "/.buffer")<cr>:tabnew ~/.buffer/buffer.py<cr>

" Quickly open a markdown buffer for scribble"
map <leader>qm :call EnsureDirExists($HOME . "/.buffer")<cr>:tabnew ~/.buffer/buffer.md<cr>

" Toggle paste mode on and off"
nnoremap <F9> :set invpaste paste?<CR>
set pastetoggle=<F9>
set showmode

" Default complete
setglobal complete-=i

" Use system clipboard
set clipboard=unnamed

" Fast running"
nnoremap <F5> :call CompileRunGcc()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ensure dir
function! EnsureDirExists(dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo"Created directory:" . a:dir
    else
      echo"Please create directory:" . a:dir
    endif
  endif
endfunction

" Return true if paste mode is enabled"
function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction

function! CopyPath()
    let path = expand("%:p")
    call setreg("p", path)
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

" Fast running
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

func! ToggleCC()
  if &cc == ''
    set cc=80
  else
    set cc=
  endif
endfunc

function! ToggleExtTags(ext_tagfile)
    let $ext_tagfile = a:ext_tagfile
    if stridx(&tags, $ext_tagfile) == -1
        set tags+=$ext_tagfile
    else
        set tags-=$ext_tagfile
    endif
    echo "tags: " . &tags
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Super plugins related to workflow
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', {'on': [], 'commit':'d98f896'}
Plug 'SirVer/ultisnips'
Plug 'starrysky-ashin/vim-snippets'
Plug 'skywind3000/asyncrun.vim'
" Interface
Plug 'flazz/vim-colorschemes'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
" Tag
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
" Fast editing
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
" Git
Plug 'airblade/vim-gitgutter'
" Python
Plug 'vim-python/python-syntax'
" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'
" Latex
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdtree
nnoremap <F2> :NERDTreeToggle<CR><C-w>=
nnoremap <leader>nf :NERDTreeFind<CR><C-w>=
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize= 50
let NERDTreeShowHidden=1
autocmd vimenter * NERDTree :NERDTreeToggle
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easyalign
" Start interactive EasyAlign in visual mode (e.g. gaip)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gutentags
set tags=./.tags;,.tags
" gutentags plugin searches for the tag file by recursively traversing the
" folders in the project root.  The project root dir is determined by the
" following sub dir names.
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" tag file name
let g:gutentags_ctags_tagfile = '.tags'

" dir of generated tag files. Don't put tag files under the project root dir.
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" ensure the dir for tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" extra args for ctags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ycm
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

augroup load_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
augroup END

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_extra_conf_vim_data = [
            \ "g:ycm_python_interpreter_path",
            \ "g:ycm_python_sys_path"
            \]
let g:SuperTabDefaultCompletionType = '<C-n>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => snippets
" Plz don't set the following directories with absolute paths
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" Key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrgger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:ultisnips_python_style="google"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gitgutter
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline
let g:airline_theme='powerlineish'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-tex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" => vim-latex-live-preview
let g:livepreview_previewer = 'okular'
let g:livepreview_engine = 'xelatex'
let g:livepreview_use_biber = 1
map <F6> :LLPStartPreview<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python-syntax
let g:python_highlight_all = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf.vim
map <leader>bf :Buffers<cr>
map <leader>tg :Tags<cr>
map <leader>bg :BTags<cr>
map <leader>gf :GFiles<cr>
map <leader>co :Commits<cr>
map <leader>ag :Ag<cr>
map <leader>rg :Rg<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
nmap <F3> :TagbarToggle f<CR><C-w>=
