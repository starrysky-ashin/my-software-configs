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

" inoremap
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap jk <ESC>

" fast runing
map <F10> :call CompileRunGcc()<CR>
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
    elseif &filetype == "mkd"
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

" plugins
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'junegunn/vim-easy-align'
Plug 'skywind3000/quickmenu.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" NERDTree config
let NERDTreeShowHidden=1
" autocmd vimenter * NERDTree
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" EasyAlign config
" Start interactive EasyAlign in visual mode (e.g. gaip)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
