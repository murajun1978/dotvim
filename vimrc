" Basic settings {{{
let mapleader = "\<Space>"
let g:yankround_max_history = 50

set bs=start,indent,eol
set whichwrap+=h,l,<,>,[,],b,s

" encode
set encoding=utf-8

" clipbord
set clipboard+=unnamed

" save
nnoremap <Leader>w :w<CR>
" save and close
nnoremap <Leader>x :x<CR>
" quick not save
nnoremap <Leader>q :q<CR>
" search highlight clear
nnoremap <Esc><Esc> :noh<CR>

" search
set incsearch
set ignorecase
set smartcase
set wrapscan

" }}}

" Edit settings {{{
" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//ge
" }}}

" Display settings {{{
syntax enable

" folding
set foldmethod=marker
set foldcolumn=2
set foldlevel=0

" tabline
set expandtab
set laststatus=2
set tabstop=2
set shiftwidth=2
set softtabstop=2

" listchars
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<

" linenumber
set number

" cursorline line
set cursorline

" search highlight
set hlsearch

" title
set title

" color {{{
set background=dark
colorscheme solarized

if &term =~ "xterm-256color" || "screen-256color"
  let g:solarized_termcolors=256
  set t_Co=256
else
  let g:solarized_termcolors=16
  set t_Co=16
endif
" }}}

" }}}

" NeoBundle {{{
if has("vim_starting")
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" color scheme
NeoBundle "altercation/vim-colors-solarized"

" unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'basyura/unite-rails'

" ctag
NeoBundle 'szw/vim-tags'
NeoBundle 'tsukkee/unite-tag'

" syntax
NeoBundle 'mxw/vim-jsx'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'

" git
NeoBundle 'cohama/agit.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" development
NeoBundle 'tpope/vim-rbenv'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 't9md/vim-ruby-xmpfilter'

" operation
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'matze/vim-move'
NeoBundle 'kana/vim-submode'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'ervandew/supertab'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-pathogen'
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

" Setting for plugin {{{
" unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
nnoremap [unite] <Nop>
nmap <Leader>f [unite]
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]h :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]d :<C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]m :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')

" unite-grep
nnoremap <silent> [unite]r   :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [unite]g   :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]cg  :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" unite-tag
nnoremap t <Nop>
autocmd BufEnter *
  \   if empty(&buftype)
  \|    nnoremap <buffer> tt :<C-u>UniteWithCursorWord -immediately tag<CR>
  \|    nnoremap <buffer> tk :<C-u>Unite jump<CR>
  \|  endif

" vim-tags
let g:vim_tags_auto_generate = 0
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', '*.js']

" over-vim
nnoremap <silent> <Leader>e :OverCommandLine %s/<CR>
vnoremap <silent> <Leader>e :OverCommandLine s/<CR>

" nerdcommenter
let NERDSpaceDelims = 1
vmap <C-o> <Plug>NERDCommenterToggle

" vim-move
let g:move_key_modifier = 'C'

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" bundle
noremap <leader>bi :<C-u>Dispatch bundle install<CR>

" vim-ruby-xmpfilter
autocmd FileType ruby nmap <buffer> <F3> <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <F3> <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <F3> <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <F4> <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <F4> <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <F4> <Plug>(xmpfilter-run)

" vim-gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

" vim-fugitive
nnoremap [git] <Nop>
nmap <Leader>g [git]
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]s :<C-u>Gstatus<CR>
nnoremap [git]d :<C-u>Gdiff<CR>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]C :<C-u>Gcommit -v<CR>

" light-line
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'mode_map': { 'c': 'NORMAL' },
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['fugitive', 'gitgutter', 'filename'],
  \   ]
  \ },
  \ 'component_function': {
  \   'modified': 'MyModified',
  \   'readonly': 'MyReadonly',
  \   'fugitive': 'MyFugitive',
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'gitgutter': 'MyGitGutter',
  \   'mode': 'MyMode',
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
  \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" }}}

" Window settings {{{
" split
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" move
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" size
nnoremap s= <C-w>=
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')

" }}}
