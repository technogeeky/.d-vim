"    ---------------------------------------------------------------------------------------------------------------------
"                                                                                                                   HEADER:
"    ---------------------------------------------------------------------------------------------------------------------
     " Vim Marker: --|>
     " vim: set foldmarker=--|>,--|| foldlevel=2 foldmethod=marker spell:
     " --||
     " Mandatory Settings: --|>
     " These are mandatory, and order matters. These must be at the top!
     "
     set                           nocompatible
     filetype                      off
     filetype plugin indent        on
     " --||
"    ---------------------------------------------------------------------------------------------------------------------
"                                                                                                                FUNCTIONS:
"    ---------------------------------------------------------------------------------------------------------------------
          " --|>paths, directories
                         function! Make_Paths()

                              let s:current_file = fnamemodify(resolve(expand("<sfile>")), ":p:h")
                              if   has('win32') || has('win64')
                                let s:v_dir  ="$HOME/.vim/bundle/vundle"   " This is where vundle is.
                                let s:os_dir ="$HOME/.vim"           " You must set the %HOME% environment
                              endif                                        "    variable in Windows to the fake-
                                                                           "    home-directory in MSYS.
                                                                           " ex:
                                                                           "    C:\mingw\home\[username][]
                              let &runtimepath   =     s:v_dir . ',' . 
                                   \    s:os_dir       . ',' . 
                                   \    s:current_file . ',' . 
                                   \    s:current_file . "/after," . 
                                   \    &runtimepath
                         endfunction
          " --||
          call Make_Paths() 
          " --|>pathogen
                         function! Using_Pathogen()
                              runtime! autoload/pathogen.vim               " Requires [//.vim/autoload/pathogen.vim][].
                              call pathogen#helptags()                     " use pathogen's helptags!
                              call pathogen#runtime_append_all_bundles()   " use pathogen to handle bundles/
                         endfunction 
          " --||
          call Using_Pathogen()
          " --|>vundle
                         function! Using_Vundle()
                              call vundle#rc()
                              Bundle 'gmarik/vundle'
                         endfunction
          " --||
          call Using_Vundle()
          " --|> NTreeInit
                         function! NTreeInit()
                              redir => bufoutput
                              buffers!
                              redir END
                              let idx = stridx(bufoutput, "NERD_tree")
                              if idx > -1
                                        NERDTreeMirror
                                        NERDTreeFind
                                        wincmd l
                              endif
                         endfunction
          " --|| 
     "    ----------------------------------------------------------------------------------------------------------------
     "                                                                                                   Filetype SETTINGS:
     "    ----------------------------------------------------------------------------------------------------------------
     " File: vimrcEx --|>

     augroup vimrcEx
     au!

     autocmd BufRead *\.txt setlocal formatoptions=l
     autocmd BufRead *\.txt setlocal lbr
     autocmd BufRead *\.txt map j gj
     autocmd BufRead *\.txt map k gk
     autocmd BufRead *\.txt setlocal smartindent
     autocmd BufRead *\.txt setlocal spell spelllang=en_us

     augroup END
     " --||
     " File: markdown --|>

     augroup mkd
          autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>
     augroup END
     " --||
     " File: vim --|>

     augroup vim_files
          au!
          autocmd filetype vim set expandtab      " disallow <tab> in Vim files
     augroup end

     " --||
     "    ----------------------------------------------------------------------------------------------------------------
     "                                                                                                             PLUGINS:
     "    ----------------------------------------------------------------------------------------------------------------
     " Use Bundle:            neocomplcache --|>
                              Bundle 'Shougo/neocomplcache'
                              let g:neocomplcache_enable_at_startup = 0    " Enable at startup.

                              "Other things to play with:

                              let g:neocomplcache_enable_smart_case             = 1
                              let g:neocomplcache_enable_camel_case_completion  = 1
                              let g:neocomplcache_enable_underbar_completion    = 1
                              let g:neocomplcache_min_syntax_length             = 3
                              "let g:neocomplcache_dictionary_filetype_lists = {
                              "    \ 'default' : '',
                              "    \ 'vimshell' : $HOME.'/.vimshell_hist',
                              "    \ 'scheme' : $HOME.'/.gosh_completions'
                              "    \ }

                              if !exists('g:neocomplcache_keyword_patterns')
                                   let g:neocomplcache_keyword_patterns = {}
                              endif
                              let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

                              " Plugin key-mappings.
                              imap <C-k>     <Plug>(neocomplcache_snippets_expand)
                              smap <C-k>     <Plug>(neocomplcache_snippets_expand)
                              inoremap <expr><C-g>     neocomplcache#undo_completion()
                              inoremap <expr><C-l>     neocomplcache#complete_common_string()

                              " SuperTab like snippets behavior.
                              "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

                              " Recommended key-mappings.
                              " <CR>: close popup and save indent.
                              "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
                              " <TAB>: completion.
                              inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
                              " <C-h>, <BS>: close popup and delete backword char.
                              inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
                              inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                              inoremap <expr><C-y>  neocomplcache#close_popup()
                              inoremap <expr><C-e>  neocomplcache#cancel_popup()


                              " Enable omni completion.
                              autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
                              autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
                              autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
                              autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
                              autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

                              " Enable heavy omni completion.
                              if !exists('g:neocomplcache_omni_patterns')
                                   let g:neocomplcache_omni_patterns = {}
                              endif
                              let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
                              "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
                              let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
                              let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
                              let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


     "  --||
     " Use Bundle:            repl.vim --|> 
                              
                              " This stuff doesn't work yet on MSYS.
                              "Bundle 'ujihisa/repl.vim'
     "  --||
     " Require Bundles:       quickrun, vimshell, vimproc --|>
                                   
                                   Bundle 'Shougo/vimshell'
                                   Bundle 'technogeeky/vimproc'
                                   Bundle 'thinca/vim-quickrun'
                                   
                                   " --||
     " Use Bundle:            vim-indent-guides --|>
                              
                              Bundle 'nathanaelkane/vim-indent-guides'
                              let g:indent_guides_enable_on_vim_startup    =1
                              let g:indent_guides_start_level              =2
                              let g:indent_guides_guide_size               =3
     " --||
     " Use Bundle:            vim-solarized --|>
                                                  Bundle 'altercation/vim-colors-solarized'
                                                  
                                                  colorscheme                   solarized
                                                  set background                =dark
                                                  let g:solarized_italic        =0
                                                  let g:solarized_bold          =1
                                                  let g:solarized_underline     =1
                                                  let g:solarized_visibility    ='normal'
     " --||
     " Use Bundles:            tpope's --|>
                              "                             Bundle 'tpope/vim-markdown'
                              Bundle 'tpope/vim-endwise'
                              Bundle 'tpope/vim-repeat'
     " --||
     " Use Bundle:            mine!!
                              Bundle 'technogeeky/vim-markdown'
     " --||
                              
     " --|> Plug:        TODO: SuperTab

     " --||
     " --|> Plug:        TODO: ShowMarks
     " --||
     " --|> Plug:        TODO: Command-T
     " --||
     " --|> Plug:        TODO: OmniComplete
     " --||
     " --|> Plug:        TODO: Ctags
     " --||
     " --|> Plug:        TODO: SnipMate
     " --||
     " --|> Plug:        TODO: NerdTree
     " --||
     " --|> Plug:        TODO: NerdCommenter
     " --||
     " --|> Plug:        TODO: Tabularize
     " --||
     " --|> Plug:        TODO:
     " --||
" Terminal: Fonts, Encoding --|>

     " use utf-8 encoding, please!
     " set termencoding    =utf-8
     " set encoding        =utf-8
" --||
" Syntax: color, lines, cursors --|>
syntax enable

     " Color
     colorscheme default

      if has("gui_win32")
          behave mswin
          set enc=utf-8
          set guifont=Consolas:h11
          colorscheme solarized
     endif

     " Lines
     set nowrap!                                       " default: set nowrap
     set textwidth =123                                " default: set textwidth=79

     " Cursor
     set backspace =indent,eol,start                   " backspace jumps these characters
     set showmatch                                     " show matching bracket

     " EOLWS: End Of Line WhiteSpace --|>
     autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
     autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
     highlight EOLWS ctermbg=red guibg=red

     function! <SID>StripTrailingWhitespace()
          " Preparation: save last search, and cursor position.
          let _s=@/
          let l = line(".")
          let c = col(".")
          " Do the business:
          %s/\s\+$//e
          " Clean up: restore previous search history, and cursor position
          let @/=_s
          call cursor(l, c)
     endfunction

     " --||
"--||
" Windows --|>

set showmode
set visualbell
set title
set showcmd
set ttyfast
set ruler
set background      =dark

" set list
set listchars=tab:▸\ ,eol:¬

set relativenumber
   if has("gui_win32")
     set cursorline
"     set colorcolumn     =1,2,3,4,30,45,60,75,90,105,120,121,122,123
     set colorcolumn =123
     highlight ColorColumn    guibg=#073642
     highlight OverLength     guibg=#d33682
     match     OverLength     /\%124v.\+/
     set cmdheight       =2
     set sidescroll      =2
     set scrolloff       =3
     set sidescrolloff   =2
endif

" --||
" Sessions --|>

     " --- syntax        | ------ thing to remember
     " 'n                 marks from previous <n> files
     " "n                 <n> lines in each register
     " :n                 <n> lines of command-line history
     " %                  the buffer list
     " n<filepath>        the filepath to save viminfo

     set viminfo    ='10,\"100,:20,%,n~/.viminfo
     set history    =20
     set undolevels =1000
" --||
" StatusBar  --|>
set laststatus =2
set statusline      =
set statusline     +=%-3.3n\                      " buffer number
set statusline     +=%f\                          " filename
set statusline     +=%h%m%r%w                     " status flags
set statusline     +=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=\ %{fugitive#statusline()}     " fugitive
set statusline     +=%=                           " right align remainder
set statusline     +=0x%-8B                       " character value
set statusline     +=%-14(%l,%c%V%)               " line, character
set statusline     +=%<%P                         " file position
"--||
"    ---------------------------------------------------------------------------------------------------------------------
"                                                                                                                    INPUT:
"    ---------------------------------------------------------------------------------------------------------------------
" INPUT General Settings:--|>
set lazyredraw      " skip redraw when running macros
set nojoinspaces    " don't insert two spaces when joining, after punctuation

" Global Shortcuts:
"
" <;> and <,>       -- are normally used for repitition with <f>, <F>, <t>, <T>.
noremap ; ,
"       ^^^         -- <:> -> <;>         -- remapped to Command mode
let mapleader =","
"               ^   -- <\> -> <,>      -- remap 'mapleader' to <,>
" --||
     " INPUT: Key Mappings --|>

     " WARNING:
     " Niether comments, tabs, or spaces, are allowed after map-style commands.
     " This means you must comment on seperate lines.
     " The suggest syntax is as follows:

     "    mode     src  dest
     "    -------- ---- -----
          inoremap <F1> <ESC>
     "    ^ insert ^^^^^^^^^^ -- make help do nothing
          nnoremap <F1> <ESC>
     "    ^ normal ^^^^^^^^^^ -- make help do nothing
          vnoremap <F1> <ESC>
     "    ^ visual ^^^^^^^^^^ -- make help do nothing

     "     nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>
     "    ^normal        ^ <,>< >       ^^^^ -- strips all trailing whitespace
     
          nmap <leader><space> :noh<CR>
     "    ^ normal  ^ <,>< >   ^^^^          -- cancel the search highlighting

          noremap <silent> <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>
     "    ^ all   ^no echo ------- ^ hush, exe in normal
     "                     ^^^^^^^ <space>   toggles fold under cursor (from <z><a>)
     "                             <z><i>    toggles all folds
     "                             <z><M>    closes all folds
     "
          call togglebg#map("<F5>")
          map  <F10> :set paste!<Bar>set paste?<CR>
     "    ^ all      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    -- toggle 'set paste'
     "     nmap <Tab> I<Tab><ESC>
     "    ^ normal   ^^^^^^^^^^^                       -- [I]nsert mode, press <tab>, <ESC> to Normal mode.
     "     nmap <S-Tab> ^I<backspace><ESC>
     "    ^ normal     ^^^^^^^^^^^^^^^^^^              -- [^] go to first non-blank, [I]nsert mode, type <bs>, <ESC> to Normal.
          vmap <Tab> >gv
     "    ^ visual   ^^^                               -- shift selected visual block right
          vmap <S-Tab> <gv
     "    ^ visual     ^^^                             -- shift selected visual block left

          nmap <silent> ,ev :e $MYVIMRC<CR>
     "    ^ normal      ^<,><e><v> ^^^^^^^^^^^^ -- edit my vimrc
          nmap <silent> ,rv :so $MYVIMRC<CR>
     "    ^ normal      ^<,><e><v> ^^^^^^^^^^^^ -- reload my vimrc

          " XXX: train myself to do vim -- the right way --
"          nnoremap <up> <nop>
"          nnoremap <down> <nop>
"          nnoremap <left> <nop>
"          nnoremap <right> <nop>
"          inoremap <up> <nop>
"          inoremap <down> <nop>
"          inoremap <left> <nop>
"          inoremap <right> <nop>

          " TODO: trying out <w> <a> <s> <d> stype
          "nnoremap w gk
          "nnoremap s gj
          "nnoremap a h
          "nnoremap d l
          "nnoremap k d
     " --||
          " INPUT: AutoCompletion --|>

     "          set wildmenu
     "          set wildmode   =longest:full,list:full
     "          set wildignore =*.swp,*.bak,*.pyc,*.class

          "Specifies how keyword completion works"
          "http://vimdoc.sourceforge.net/htmldoc/options.html#%27complete%27"

          " --- syntax         -- description
          " .                  scan the current buffer for matchs
          " w                  scan the buffers of other windows
          " b                  scan other loaded buffers that are in the buffer list
          " i                  scan current and included files
          " t                  tag completion
          " u                  scan the unloaded buffers that are in the buffer list
          "     set complete =.,w,b,i,t,u
               "--||
     " INPUT: Tabs, Spaces, Indents --|>

          "   --- value                --- alias        --- description
          set autoindent                   "set ai          <enter> keeps you at current indent
          set expandtab                    "set et          use <Space> instead of <Tab>
          set smarttab                     "set sta         assist <backspace> over expandtab <Space>s

          set tabstop         =5           "set ts          number of spaces <Tab> counts for
          set softtabstop     =5           "set sts         number of <Space>s that <Tab> counts for
          set shiftwidth      =5           "set sw          number of <Space>s to use for 'autoindent'
          set shiftround                   "set sr          round indents to multiples of 'sw'

     " --||
     " INPUT: Search and Replace --|>

     " Automatically insert a \v before any string you search for.
     " -- REF http://stevelosh.com/blog/2010/09/coming-home-to-vim/
     nnoremap / /\v
     vnoremap / /\v
     noremap <F4> :set hls!<CR>

     set incsearch                           "set is        jump to results as you type
     set ignorecase                          "set ic        ignore case in patterns
     set smartcase                           "set scs       -- unless, your pattern contains spaces
     set hlsearch                            "set hls       highlight search results
     set gdefault                            "set gd        use /g (match all) by default


     " --||
" --|> Folding: <space> toggles

if has("gui_win32")
     set foldenable                     "set fen       enable folding

     set foldmethod =marker             "set fdm       look for patterns of triple-braces in files
     set foldcolumn =3                  "set fdc       create a left-hand <gutter> fir displaying fold info
     set foldclose  =                   "set foldc     fold close range is undefined

     set foldopen   =                   "set foldo     commands which trigger automatic unfolding
     set foldopen  +=hor,tag
     set foldopen  +=jump,mark,undo
     set foldopen  +=block
     set foldopen  +=insert,search
     set foldopen  +=percent,quickfix

endif
" --||
" FILES: swap, backup, dotfiles --|>

     " swap files
     set noswapfile                          " don't use a swap file...
     set directory =~/.vim-annex/swap        " but if we did, put it here.

     " backup files
     set nobackup                            " don't always use a backup file
     set writebackup                         " but do use one when writing
     set backupdir  =~/.vim-annex/backup     " and put it here.

     if version >= 703
          set undofile                       " use an undo file
          set undodir =~/.vim-annex/undo     " and put it here.
     endif

" --||
" --|> diff
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


" }}
