" vimrc
" (c) 2013 T.B. Hartman
"
" This vimrc file resides in the user vim directory (.vim, vimfiles, etc.).
" To get started, symlink to this file in the appropriate location:
"   ln -s ~/.vim/vimrc ~/.vimrc
"   mklink /h ~\_vimrc ~\vimfiles\vimrc

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

filetype on

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set completeopt=menuone,longest,preview

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" set vertical diffs
set diffopt=filler,context:4,vertical

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set scrolloff=5
imap <S-Tab> <Esc><<i " shift-tab for insert mode
set foldminlines=1
let g:LargeFile=25

"backup and swap settings
set backup
let g:VimHome=split(&rtp,',')[0]
let &backupdir=g:VimHome . '/.backup//,.'
let &directory=g:VimHome . '/swap//,.'

set number
set guifont=Inconsolata:h12:cANSI
set expandtab
set tabstop=4
set shiftwidth=4

set wildmenu
set wildmode=longest,list


"cd to current file directory
com! CD lcd %:p:h

"yank buffer to clipboard
map <leader>y :%y+<cr>

" Shortcut to rapidly toggle whitespace
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>-,eol:¬

" hide menu and toolbar in gui
set guioptions-=m
set guioptions-=T

set laststatus=2
set lines=50 columns=110
set fileformat=unix
set nowrapscan

let g:pydoc_cmd = 'python -m pydoc'
