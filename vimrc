filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab
" " Map leader key to spacebar
let mapleader=" "

" Wrap for markdown
" v to select and gq to reformat
au BufNewFile,BufFilePre,BufRead *.md,*.markdown set filetype=markdown tw=80 fo+=t colorcolumn=80
au BufNewFile,BufRead,BufEnter *.md,*.markdown :syn match markdownIgnore "\$.*_.*\$"

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Format JSON
map <leader>jf <ESC>:%!python -m json.tool<CR>

" " Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Easy Align
Plug 'junegunn/vim-easy-align'

" JS syntax
Plug 'pangloss/vim-javascript'

" JSX syntax
Plug 'mxw/vim-jsx'

" Markdown composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Initialize plugin system
call plug#end()
