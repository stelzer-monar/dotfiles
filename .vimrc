execute pathogen#infect()
call pathogen#helptags()

colorscheme badwolf
set autochdir
set autoindent
set autowrite
set backup " tell vim to keep a backup file
set backupdir=~/.vim/backup//
set clipboard=unnamedplus
set confirm
set cursorline
set directory=~/.vim/swap//
set expandtab
set hlsearch
set incsearch
set laststatus=2
set number
set ruler         " show the cursor position all the time
set shiftwidth=2
set showcmd
set showmatch
set showmode " show the editing mode on the last line
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set title
set undodir=~/.vim/undo//
set wildmenu
set wildmode=list:longest,full
set writebackup

filetype indent on

" enable syntax highlighting
syntax on

" comment selected line(s)
nmap <leader>c <c-_><c-_>

" correct identation and format of a file
noremap <F3> :Autoformat<CR><CR> 

" Quicker window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <leader>t :TagbarToggle<CR>
nmap <leader>n :NERDTree<CR>

noremap <F4> :TagsGenerate!<CR><CR>
let g:vim_tags_auto_generate = 1

" Vim airline (?)
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme = 'badwolf'

let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cmd = 'CtrlP'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Change 'tabs' using numbers
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" function! ToggleQuickFix()
"   if exists("g:qwindow")
"     lclose
"     unlet g:qwindow
"   else
"     try
"       lopen 5
"       let g:qwindow = 1
"     catch 
"       echo "No Errors found!"
"     endtry
"   endif
" endfunction
"
" nmap <script> <silent> <F2> :call ToggleQuickFix()<CR>

function! ToggleErrors()
  let old_last_winnr = winnr('$')
  lclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    Errors
  endif
endfunction
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
nnoremap <silent> <F2> :SyntasticCheck<CR>
nmap <leader>s :SyntasticToggleMode<CR>
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python'
let g:syntastic_python_checkers = ['flake8']



" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
