" used with neovim. Mostly compatible with vim, notable exceptions include autocompletion and plugin manager. To see regular vim/gvim config, see my old file at https://github.com/DovidM/dotfiles/blob/99a721d9e9951d965972e19380155cc3b323a246/.vimrc

" todo: find markdown linter
if &compatible
    set nocompatible
endif


"""""""""""""""""""""""""""
"	Key Mappings		  "
"""""""""""""""""""""""""""
    " These are intentionally above plugins since some keymaps (at least the pumvisible one) doesn't seem to load if put after

" j and k go by screen lines not file lines
nnoremap j gj
nnoremap k gk
nnoremap <Leader> ,

inoremap jk <Esc>l
cnoremap jk <Esc>l

nnoremap ; :
nnoremap : ;

" Q for formatting, don't use ex mode
nnoremap Q gq

" buffer jumping
nnoremap <Space>j :bprev<CR>
nnoremap <Space>k :bnext<CR>
nnoremap <Space><Space> :b#<CR>
nnoremap <Space>l :BuffergatorToggle<CR>

let g:EasyMotion_leader_key = ',,' " if just do ',' it takes away too many potential shortcuts
" example: ul>li<CTRL-E>,
let g:user_emmet_leader_key='C-E>'

nnoremap <c-f> <Plug>(ale_fix)
nnoremap <C-j> :ALENextWrap<CR>
nnoremap <C-k> :ALEPreviousWrap<CR>

" use tab for autocompletion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" LangClient mappings
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" approximate functionality of the above LangClient mappings (a little worse,
" but LangClient messes up autocomplete too much to enable for now
nnoremap <silent> K :TSType<CR>
nnoremap <silent> gd :TSDoc<CR>


"""""""""""""""""""""""""""
"       Plugin config     "
"""""""""""""""""""""""""""

" set the runtime path to include package manager
set runtimepath+=~/.vim/dein//repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein/')
    call dein#begin('~/.vim/dein/')

    " Let dein manage dein.
    " required:
    call dein#add('~/.vim/dein//repos/github.com/Shougo/dein.vim')

    " needed for some reason to stop neovim from breaking
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

    call dein#add('haya14busa/dein-command.vim') " easier dein interface

    " looks {{{
        call dein#add('mhinz/vim-startify') " useful startscreen (shows recently opened stuff and more)
        call dein#add('vim-airline/vim-airline') " pretty statusline
        call dein#add('tomasiser/vim-code-dark') " vscode dark+ like colorscheme
        call dein#add('morhetz/gruvbox')
    " }}}

    " git {{{
        call dein#add('tpope/vim-fugitive')   " git helper, easy add (:Gw) and commit (:Gco) among many other features
        call dein#add('airblade/vim-gitgutter') " shows which lines were changed
    " }}}

    " useful for everything {{{
        call dein#add('easymotion/vim-easymotion') " almost all vim motions on steroids
        call dein#add('ntpeters/vim-better-whitespace') " highlights and removes extra space
        call dein#add('haya14busa/is.vim') " stop highlighting searches after move cursor
        " call dein#add('907th/vim-auto-save') " no more :w
        call dein#add('jeetsukumaran/vim-buffergator') " easy viewing and moving between buffers
        call dein#add('tpope/vim-obsession') " easy session management
        call dein#add('tpope/vim-vinegar') " better netrw defaults
    " }}}

    " language specific things {{{

        " typescript {{{
            call dein#add('herringtondarkholme/yats.vim') " typescript syntax file, has syntax highlighting and sets filetype (which allows for autocompletion)
            call dein#add('mhartington/nvim-typescript') " good for detailed completions, has many other utilities like autoimports, see variable type/signature etc
        " }}}

        " html {{{
            call dein#add('gregsexton/matchtag') " highlight matching html tag
            call dein#add('alvan/vim-closetag') " auto inserts match html tag
            call dein#add('mattn/emmet-vim') " table>thead -> <table><thead></thead></table> (with proper formatting)
        " }}}

        " markdown {{{
            call dein#add('godlygeek/tabular')
            call dein#add('plasticboy/vim-markdown') " requires tabular to be installed. Does a bunch of useful markdown stuff
        " }}}

        " english {{{
            call dein#add('reedes/vim-pencil') " for plain text
        " }}}

        " csv {{{
            call dein#add('chrisbra/csv.vim')
        " }}}
    " }}}

    " useful for all programming languages {{{

        " movements {{{
            call dein#add('tpope/vim-commentary') " auto toggle comments
            call dein#add('jeetsukumaran/vim-indentwise') " easy moving to other lines by indentation
            call dein#add('tpope/vim-surround') " adds useful motions - cs(' replaces surrounding () with ', for example
            call dein#add('pseewald/vim-anyfold') " easy folding (can just za at start of function and it'll fold the entire thing
        " }}}

        " looks {{{
            call dein#add('Yggdroot/indentLine') " vertical indentation lines
            call dein#add('sheerun/vim-polyglot') " basic syntax support for tons of languages
            call dein#add('tpope/vim-sleuth')
        " }}}

        " completion {{{

            call dein#add('raimondi/delimitmate') " auto insert matching [,{,' etc
            call dein#add('SirVer/ultisnips') " snippet support
            call dein#add('honza/vim-snippets') " some actual snippets

            " Doesn't seem to work
            call dein#add('roxma/LanguageServer-php-neovim',  {'build': 'composer install && composer run-script parse-stubs'})
            call dein#add('autozimu/LanguageClient-neovim', { 'rev': 'next', 'build': 'bash install.sh' })

            if !has('nvim')
                call dein#add('roxma/vim-hug-neovim-rpc')
            endif

            " if there's an error along the lines of "Failed to load python3 host" or "nvim-completion-manager core dumped" run `pacman -S python-neovim --force`
            call dein#add('roxma/nvim-completion-manager') " autocompletion
        " }}}

        call dein#add('Shougo/EchoDoc') " can see function signature while calling it
        call dein#add('w0rp/ale') " linter with support for basically every language out there

    " }}}


    " required:
    call dein#end()
    call dein#save_state()
endif

" install uninstalled plugins on startup
if dein#check_install()
  call dein#install()
endif


""" Plugin settings """

" gitgutter {{{
    set updatetime=200 " for git-gutter
" }}}

" vim-better-whitespace {{{
    autocmd BufEnter * EnableStripWhitespaceOnSave
" }}}

" airline {{{
    let g:airline#extensions#tabline#enabled = 1 " better display of tabs
    let g:airline#extensions#tabline#formatter = "unique_tail_improved"
" }}}

" vim-code-dark {{{
    " colorscheme codedark
    " let g:airline_theme = 'codedark'
    set background=dark

    let g:gruvbox_italic=1
    colorscheme gruvbox
" }}}

" anyfold {{{
    let anyfold_activate=1
    let g:anyfold_identify_comments = 1
    set foldlevelstart=99
    set foldnestmax=5
" }}}

" indentLine {{{
    let g:indentLine_enabled = 1
    let g:indentLine_color_term=239
    let g:indentLine_color_gui = '#4e4e4e'
    let g:indentLine_char='¦'
" }}}

" vim-markdown {{{
    let g:vim_markdown_follow_anchor = 1
" }}}

" vim-auto-save {{{
    let g:auto_save = 0 " messes up ALE, so default is off
" }}}

" ALE {{{
    let g:ale_enabled=1

    augroup Ale
      autocmd!
      autocmd FileType markdown let b:ale_enabled=0
    augroup END


    let g:ale_fixers = {
                \  'javascript': ['eslint'],
                \   'typescript': ['tslint']
                \ }

    let g:ale_completion_enabled = 0 " must be off, otherwise interferes with nvim-typescript by making the completion menu flash for a second then disappear every time it appears - rendering completion completely unfunctional. BUG: Even with this off, still get weird bugs in completion menu, such as duplicate items and part of the list juts out (perhaps suggesting it still creates a list underneath nvim-completion-manager's
    let g:ale_fix_on_save = 0 " messes too much up
    let g:ale_open_list = 'on_save' " distracting to pop open while typing

    " close locationlist when buffer is closed
    augroup CloseLoclistWindowGroup
      autocmd!
      autocmd QuitPre * if empty(&buftype) | lclose | endif
    augroup END

    " makes ale's window dynamic
    let g:ale_list_window_size_max = 5
    autocmd User ALELint call s:ale_loclist_limit()
    function! s:ale_loclist_limit()
        if exists("b:ale_list_window_size_max")
            let b:ale_list_window_size = min([len(ale#engine#GetLoclist(bufnr('%'))), b:ale_list_window_size_max])
        elseif exists("g:ale_list_window_size_max")
            let b:ale_list_window_size = min([len(ale#engine#GetLoclist(bufnr('%'))), g:ale_list_window_size_max])
        endif
    endfunction
" }}}

" LanguageClient {{{

    let g:LanguageClient_autoStart = 0 " produces duplicate, subpar completions (doesn't show function signature like nvim-typescript does). Has useful commands though
    let g:LanguageClient_diagnosticsList="Location"
    let g:LanguageClient_diagnosticsEnable=1
    autocmd FileType php LanguageClientStart

    " If enable this, get useless and duplicate info (seems like the useless part is because of shortmess+=c) compared to nvim_typescript.
    " Also seems to glitch the completion menu by having part of of it jut out -
    " might be making a second menu underneath. Check if that's the case
    if executable('javascript-typescript-stdio')

        let g:LanguageClient_serverCommands = {
                    \ 'javascript': ['javascript-typescript-stdio'],
                    \ 'typescript': ['javascript-typescript-stdio'],
                    \ 'javascript.jsx': ['javascript-typescript-stdio'],
                    \ 'typescript.tsx': ['javascript-typescript-stdio']
                    \ }
    else
        echo "Run npm install -g javascript-typescript-langserver to enable\n"
    endif
" }}}


" nvim-typescript {{{
    let g:nvim_typescript#javascript_support=1
    let g:nvim_typescript#type_info_on_hold=0

    let g:nvim_typescript#tsimport#template='import %s from ''%s'';'
 " }}}

" EchoDoc {{{
    let g:echodoc#enable_at_startup = 1
" }}}
"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"


" vim-pencil {{{
    augroup pencil
      autocmd!
      autocmd FileType text         call pencil#init({'wrap': 'soft'})
    augroup END
" }}}

" netrw {{{
    let g:netrw_winsize = 18
    " autocmd FileType php,javascript,typescript,css,html autocmd VimEnter * :Vexplore " auto file explorer on those languages
" }}}


""""""""""""""""""""""""""
"      Built in stuff    "
""""""""""""""""""""""""""

syntax enable
filetype plugin indent on " detects, loads plugins, and does indentation for specific filetypes

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set completeopt=preview,menu,menuone
set shortmess=filmx
set backup		" keep a backup file (restore to previous version)
set backupdir=~/vim-tmp,.
set directory=~/vim-tmp,.
set undofile		" keep an undo file (undo changes after closing)
set undodir=~/vim-tmp " where to save undo histories
set backupdir=~/vim-tmp
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set nojoinspaces " for J
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set autoread " if a file is changed outside of vim, reload it
set hidden " can flip though buffers without saving them
set noshowmode

set mouse=a " enable mouse

set equalprg=

" spellcheck
set spelllang=en_us
set complete+=kspell
if filereadable('/usr/share/dict/words')
    set dictionary+=/usr/share/dict/words
endif

augroup spell
    autocmd FileType text,markdown set spell
augroup END


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

    " augroup Emmet
    "     au FileType html,gohtmltmpl imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
    " augroup END

	" Auto-save folds
	augroup SaveFolds
	  au BufWrite,VimLeave *.txt mkview
	  au BufRead           *.txt silent loadview
	augroup END
else
  set autoindent		" always set autoindenting on
endif

set tabstop=4
set expandtab
set shiftwidth=4
set linebreak
set conceallevel=2 " so markdown *this* look italicized without showing the asterisks when cursor's on a different line

" File searching "
""""""""""""""""""
set wildmenu
set wildmode=longest:full,full
set path-=/usr/include " seems to be included by default. If anything breaks, this might be the cause
set path+=** " Allows :find to search all subdirectories from current file. @author https://youtu.be/XA2WjJbmmoM?t=7m4s. Use :b with partial name to open previously opened file
set wildignore+=**/node_modules/**,build,lib " don't look in this
set wildignore+=.git/
set wildignorecase " case insensitive search

set ignorecase smartcase " case-insensitive text searching

" default show numbers
set number
set relativenumber

set scrolloff=9999 " keep cursor at the center of the screen
set termguicolors " enable True color

" saved macros {{{
  let @q = 'i- *Q*: '
  let @a = 'i*A*: '
" }}}
