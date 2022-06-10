set tabstop=4
set shiftwidth=4
set encoding=utf-8
set path+=**
set wildmenu
filetype plugin indent on
syntax on
set rtp+=$HOME/.vim/bundle/Vundle.vim
set number
set relativenumber
set hidden
set autoindent
colorscheme zellner
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" Personal maps
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>k :bfirst<CR>
nnoremap <leader>j :blast<CR>
nnoremap <C-b> :ls<CR>:b<Space>
nnoremap <C-e> :ls<CR>:sb<Space>
nnoremap <leader>e :Ex<CR>

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>t<leader> :tabnext<Space>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>

nnoremap <C-c> :w<CR>: !cat % <bar> preconv <bar> tbl <bar> eqn -Tpdf <bar> groff -ms -Tpdf > %.pdf <CR><CR>

nmap <C-s> :w<CR>
nmap <leader>b :colorscheme blue<CR>
nmap <leader>m :colorscheme zellner<CR>
nmap <leader>d :colorscheme default<CR>

:ab try@ try {z<CR>} catch(e) {<CR>}<Esc>?z<CR>s<CR>
:ab fun@ function n (){<CR>}<Esc>?n<CR>xi
:ab clog console.log(c); //DEBUG<Esc>?c<CR>s
:ab li@ <li></li><ESC>4hi
:ab ul@ <ul></ul><ESC>4hi
:ab check@ <div><input type="checkbox"><label>s</labe></div><ESC>?s<CR>s

" NERDTree maps

" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>


" COC maps

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug><coc-fix-current)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

call vundle#begin()
Bundle 'zyedidia/literate.vim'
Bundle 'scrooloose/syntastic'
Bundle 'benekastah/neomake'
Bundle 'pangloss/vim-javascript'
"Plugin 'preservim/nerdtree'
call vundle#end()

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()
let g:coc_global_extensions = ['coc-tsserver']

hi FgCocErrorFloatBgCocFloating ctermbg=black ctermfg=white
hi Pmenu ctermbg=black ctermfg=white
