set nocompatible              " be iMproved, required
filetype off                  " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'		        " let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'jistr/vim-nerdtree-tabs'        " Допиливаем NERDTree
Plugin 'majutsushi/tagbar'          	" Class/module browser
Plugin 'bling/vim-airline'              " Statusline
Plugin 'Lokaltog/vim-easymotion'        " Easy Motion
Plugin 'Yggdroot/indentLine'            " show indent lines
Plugin 'puremourning/vimspector'        " Python debugging


"---------------=== Languages support ===-------------
" --- General ---
Plugin 'scrooloose/syntastic'           " Syntax check for everything
Plugin 'Valloric/YouCompleteMe'         " Code Completion
Plugin 's3rvac/AutoFenc'         " Encoding detection
" --- Python ---
"Plugin 'klen/python-mode'	            " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
"Plugin 'davidhalter/jedi-vim'          " Code Completion
Plugin 'tpope/vim-markdown'             " Markdown support
" --- Puppet ---
Plugin 'puppetlabs/puppet-syntax-vim'   " Puppet manifests highlight
" --- ansible ---
Plugin 'pearofducks/ansible-vim'
" --- PowerShell ---
Plugin 'PProvost/vim-ps1'

"---------------=== Miscellaneous ===-------------
Plugin 'altercation/vim-colors-solarized'   " Colorscheme
Plugin 'mbbill/undotree'                    " Visual Undo Tree

call vundle#end()            		" required

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" YCM
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>g :YcmCompleter GoToDefinition<CR>

" NERDTree
" autocmd VimEnter * NERDTree
" autocmd BufWinEnter * NERDTreeMirror
" Go to previous (last accessed) window.
" убираем фокус с NERDTree
" autocmd VimEnter * wincmd p
let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_console_startup = 1     " enable in console mode
" let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_meaningful_tab_names = 1

" TagBar
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

" python-mode
let g:pymode_folding = 0                " фолдинг не нужен
" python-mode code completion
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime', 'os.path']

" Encoding detection
let g:autofenc_enable = 1
let g:autofenc_emit_messages = 1
let g:autofenc_ext_prog_path = '/usr/bin/enca'
let g:autofenc_autodetect_html = 0

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" ZPL II encoding
:autocmd BufNewFile,BufRead *.zpl edit ++enc=cp1251
" RDP file encoding
:autocmd BufNewFile,BufRead *.RDP edit ++enc=utf16le
:autocmd BufNewFile,BufRead *.edp edit ++enc=utf16le
" windows bat encoding
":autocmd BufNewFile,BufRead *.bat,*.cmd edit ++enc=cp1251
":autocmd BufWrite *.bat,*.cmd write ++enc=cp1251
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=light

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set mousemodel=popup    " Menu on right click

set ttyfast

" Sane copy-paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Backspace
set backspace=indent,eol,start

" Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе

"Автоотступ
"set autoindent
"
""Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
set number

" Автокомплит команд вима
set wildmode=longest,list,full
set wildmenu
set backspace=indent,eol,start

" sudo hack
command W w !sudo tee % > /dev/null
cmap w!! w !sudo tee > /dev/null %

" change cwd to opened file cwd
autocmd BufEnter * lcd %:p:h

" =========== Highlight search terms =============
set hlsearch
set incsearch " as they are typed
" Фолдим каменты в конфигах
"autocmd FileType config,conf,cfg,ini,configuration
"      \ set foldmethod=expr |
"      \ set foldexpr=getline(v:lnum)=~'^\\s*#'

if has("gui_running")
  "Включаем 256 цветов в терминале, мы ведь работаем из иксов?
  "Нужно во многих терминалах, например в gnome-terminal
  set t_Co=256
  set cursorline
  colorscheme desert
  set guifont=Liberation\ Mono\ 11
  " colorscheme solarized
endif

" if has("statusline")
"     set statusline=[%{&fileencoding?&fileencoding:&encoding}]\ [%F]
" endif

" cmap W w
cmap Q q
map <F5> <Esc>:w<CR>:!%:p<CR>
" comment/uncomment line hotkeys
map <C-S> :s:^:#<CR>
map <C-T> :s:^#<CR>
