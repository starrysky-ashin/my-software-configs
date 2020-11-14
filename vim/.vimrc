" set leader key
let g:mapleader=';'

" colorscheme
autocmd vimenter * colorscheme darkblue

" default complete
setglobal complete-=i

" no backup file
set nobackup
set nowritebackup
set noswapfile

" display 
set nu " display line number. Here nu is abbreviation for number. 'set nonu' will cancle displaying line number.
set cursorline " hightlight current line

" search
set incsearch
set hlsearch " hightlight the matched keys

" format 
set autoindent " set the indentation as the same as the last line
set ts=4 " set the tab key like pressing the space key four times continously
set expandtab
set shiftwidth=4 " set shift + > as four space keys

" use system clipboard
set clipboard=unnamed

" inoremap
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap jk <ESC>

" nnoremap
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :w<CR>:source $MYVIMRC<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>o :only<CR>
nnoremap <Leader>a  o<Esc>
nnoremap <leader>z :noh<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>b :call CompileRunGcc()<CR>
nnoremap <leader>1 :NERDTreeToggle<CR>
nnoremap <leader>2 :ls<CR>
nnoremap <leader>3 :b#<CR>

" fast runing
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

" plugins
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

" NERDTree config
let NERDTreeShowHidden=1
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" EasyAlign config
" Start interactive EasyAlign in visual mode (e.g. gaip)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ctags config
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

" YouCompleteMe config
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

" vim-snippets config
" plz don't set the following directories as absolute paths
let g:UltiSnipsSnippetDirectories=[
            \ "UltiSnips",
            \ "mysnippets"
            \]
let g:my_python_snip_file = "~/.vim/plugged/vim-snippets/mysnippets/python.snippets"
nnoremap <leader>es :exe 'vsp ' my_python_snip_file<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrgger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:ultisnips_python_style="google"
inoremap <c-x><c-k> <c-x><c-k>

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" airline
let g:airline_theme='powerlineish'

" tagbar
nnoremap <leader>` :TagbarToggle<CR>

" vim-tex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
