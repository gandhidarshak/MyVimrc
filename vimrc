"-------------------------------------------------------------------------------
" vimrc file downloaded from https://github.com/gandhidarshak/myVimrc.git
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Sections:
"
" 1.  Opening vim, navigating, text, tab and indent settings.
" 2.  Vim-plug plug-in manager set-up, install plug-ins.
" 3.  Plug-in set-ups/flags for customization 
" 4.  Fonts setting and customization
" 5.  GUI Specific settings
" 6.  Iterate over color schemes
" 7.  File type dependent commenting 
" 8.  Open current file in p4v Time-lapse view 
" 9.  Open Current file in OpenGrok at current line
" 10. Visual mode selection and replace
" 11. Leader key driven key-maps  
" 12. Ctrl key driven key-maps   
" 13. Func key driven key-maps 
" 14. Spell check functions  
" 15. VimWiki and markdown Set up.
" 16. FZF setup
" 17. List of some other vim how-to and commands.
"-------------------------------------------------------------------------------



"-------------------------------------------------------------------------------
" 1. Opening/Saving vim, navigating, text, tab and indent settings
"-------------------------------------------------------------------------------

" Auto source vimrc upon every save! Disabling due to slowness.
" autocmd BufWritePost vimrc,.bashrc source %

set noautowrite                " Turn off auto write in general
set nocompatible               " Turn off vim compatibility with Vi.
set history=50                " How many lines of command history VIM has to remember?
set showmatch                  " Show matching brackets when text indicator is over them.
set matchtime=2                " How many tenths of a second to blink when matching brackets?
set textwidth=80               " Zero value will disable text-width's impact
set scrolloff=8                " Show 8 lines before and after
set cmdheight=2                " Command line window hight
set virtualedit=block          " Put cursor anywhere in file not limited by the text limit
set undolevels=50             " Very high number may slow down vim
set nobackup                   " To switch off automatic creation of backup files
set noswapfile                 " Don't use a swap file for the buffer.
set hlsearch                   " Highlight all matches
set incsearch                  " Show incremental search while typing
set ruler                      " Show the line and column number of the cursor
set ignorecase                 " Ignore case in search patterns.
set backspace=indent,eol,start " User friendly backspace,
set showcmd                    " Show (partial) command in the last line of the screen.
set wildmenu                   " Show all matches for a file name completion while using Tab
set number                     " Precede each line with its line number
set autoindent                 " Auto indent next line using current line
set smartindent                " Smart indentation
set cindent                    " More smart/strict indentation
set cino+=(0                   " Better indentation for function arguments
set expandtab                  " Convert Tab into spaces
set tabstop=4                  " 1 tab = 4 spaces
set softtabstop=4              " 1 tab = 4 spaces
set shiftwidth=4               " 1 tab = 4 spaces
set formatoptions+=rqo         " How auto-formatting will work
set foldmethod=syntax          " Use syntax fold method by default 
" use very magic searches
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
autocmd VimEnter * WipeReg

" File type commands
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plug-ins
syntax   enable    " Enable syntax highlighting

" Set the title to the filename to avoid long titles
au BufEnter * let &titlestring = expand("%p") 

" Change current directory to current file 
au BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" open vim at last position of file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Consider config file as yaml file (specific to my team's project)
au BufNewFile,BufRead *.config set syntax=yaml

" Use indent fold-method for a few file types
au FileType json,python,yml,yaml,cfg,config,xml setlocal foldmethod=indent

" Use c++ make setup of your organization
set makeprg=make

" Use for folder specific make rules.
" au BufEnter */Cpp*/** set makeprg=make
" au BufEnter *.dot set makeprg=dot\ -Tpng\ -o\ %.png\ %


" ls style :E command. NOTE: you may also use NerdTree instead.
let g:netrw_liststyle=2

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

"-------------------------------------------------------------------------------
" 2. Vim-plug plug-in manager set-up, install plug-ins.
" Note: Use commands PlugUpdate, PlugDiff, PlugClean for changes
"-------------------------------------------------------------------------------

let $VIMPLUGDIRECTORY = expand('<sfile>:p:h')."/vim_plug_downloads"

" plug-ins will be downloaded under the specified directory.
call plug#begin($VIMPLUGDIRECTORY)

" Declare the list of plug-ins - can be any valid github url
" Shorthand notation; fetches https://github.com/...
Plug 'vimwiki/vimwiki'                  " Note taking setup in vim
Plug 'mattn/calendar-vim'               " calendar app to work with vimwiki
Plug 'tools-life/taskwiki'              " Connects vimwiki with taskwarrior
Plug 'ferrine/md-img-paste.vim'         " Paste images directly in markdown
Plug 'vim-scripts/DoxygenToolkit.vim'   " Doxygen tool kit for Vim to provide comment templates
Plug 'ciaranm/detectindent'             " Automatically adjust shiftwidth based on current file
Plug 'easymotion/vim-easymotion'        " Easy navigation in vim
Plug 'godlygeek/tabular'                " Tabularize/Align using any string
Plug 'vim-scripts/taglist.vim'          " Tag List Explorer
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy file search
Plug 'junegunn/fzf'                     " FZF 
Plug 'junegunn/fzf.vim'                 " FZF wrapper for vim
Plug 'vim-scripts/OmniCppComplete'      " Omni Complete for C++ Auto complete
Plug 'Yggdroot/indentLine'              " Indent lines
Plug 'stephpy/vim-yaml'                 " Yaml syntax
Plug 'altercation/vim-colors-solarized' " Solarized theme
Plug 'tomasr/molokai'                   " Molokai theme
Plug 'jdkanani/vim-material-theme'      " Material theme
Plug 'raimondi/delimitmate'             " Auto closing of quotes, brackets, etc.
Plug 'takac/vim-fontmanager'            " Font manager for quick font changes
Plug 'dracula/vim'                      " Dracula theme for vim
Plug 'rickhowe/diffchar.vim'            " Highlight the exact differences, based on characters and words
Plug 'terryma/vim-expand-region'        " visually select increasingly larger regions of text using the same key combination
Plug 'tpope/vim-dispatch'               " Run :make and other tasks (grep etc) async from vim


" Plug 'sheerun/vim-polyglot'             " A collection of language packs for all main languages. This seem to give errors for json for vim 7.4 or below so commenting it for now.
" Plug 'preservim/vim-markdown'         " For markdown formatting, plasticboy migrated it here
" Plug 'Valloric/YouCompleteMe'           " TODO: Configure YouCompleteMe and move on from OmniCppComplete when possible
" Plug 'scrooloose/nerdcommenter'         " At one point I used to use them, but now I don't anymore
" Plug 'scrooloose/nerdtree'              " At one point I used to use them, but now I don't anymore
" Plug 'tpope/vim-fugitive'               " Too much for my limited git usage as of now.
" Plug 'airblade/vim-gitgutter'           " To show a git diff in the 'gutter'
" Plug 'bling/vim-airline'                " Status tab line for vim
" Plug 'vim-airline/vim-airline-themes'   " Themes for airline

call plug#end()

" Run :PlugInstall first if not already installed. Only for initial set up.[Productivity Setup with Vimwiki, Taskwarrior and MDwiki: Part 1 - YouTube](http://go/ytcom/A1YgbAp5YRc)
if empty(glob($VIMPLUGDIRECTORY))
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"-------------------------------------------------------------------------------
" 3. Plug-in set-ups/flags for customization 
"-------------------------------------------------------------------------------

" Justify text per textwidth. This is pre-installed in recent vim installs
runtime macros/justify.vim
nmap <c-j> :%call Justify('tw',4)<CR>
vmap <c-j> :call Justify('tw',4)<CR>

" Installing easy motion creates conflict in abbreviation :E for explorer
cabbrev E Explore


" tag files, search from current to HOME directory
set tags=./tags;

" DoxygenToolkit
let g:DoxygenToolkit_authorName=expand($USER)
let g:DoxygenToolkit_versionString="1.0"

" Git gutter
" nmap ghp <Plug>(GitGutterPreviewHunk)
" nmap ghs <Plug>(GitGutterStageHunk)
" nmap ghu <Plug>(GitGutterUndoHunk)
" nmap [c <Plug>(GitGutterPrevHunk)
" nmap ]c <Plug>(GitGutterNextHunk)

" explandtab
" Limit for number of lines that will be analysed set
let g:detectindent_max_lines_to_analyse = 10000

" Airline
:let g:airline_theme='base16_solarized' 
silent! call airline#extensions#whitespace#disable()

" diffchar
let g:DiffColors = 100

" OmniCppComplete
let OmniCpp_NamespaceSearch     = 0
let OmniCpp_GlobalScopeSearch   = 0
let OmniCpp_ShowAccess          = 1
let OmniCpp_ShowPrototypeInAbbr = 1  " show function parameters
let OmniCpp_MayCompleteDot      = 1  " auto complete after .
let OmniCpp_MayCompleteArrow    = 1  " auto complete after ->
let OmniCpp_MayCompleteScope    = 1  " auto complete after ::
let OmniCpp_DefaultNamespaces   = []
let OmniCpp_LocalSearchDecl     = 0  " use local search function
let OmniCpp_SelectFirstItem     = 0  " select first item in pop-up
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Solarized
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal

" Taglist
let Tlist_WinWidth = 40

" ctrlp  (I have a nightly cscope.files creater in crontabs as our code base is huge)
let g:ctrlp_max_files           = ""
let g:ctrlp_map                 = '<c-p>'
let g:ctrlp_cmd                 = 'CtrlP'
" Use if the list needs to be created with specific files 
let g:ctrlp_root_markers        = ['cscope.files', 'index.md']
" let g:ctrlp_user_command        = ['cscope.files', 'cat %s/cscope.files']
let g:ctrlp_max_height          = 20
let g:ctrlp_mruf_default_order  = 0
let g_ctrlp_mruf_max            = 100
let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_lazy_update         = 1 "show results after 250ms of no typing
let g:ctrlp_match_window        = 'bottom,order:ttb'
let g:ctrlp_by_filename         = 1 "set this to 1 to set searching by filename (as opposed to full path) as the default:
"
" Notes:
" Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
" Press <c-f> and <c-b> to cycle between modes.
" Press <c-d> to switch to filename only search instead of full path.
" Press <c-r> to switch to reg exp mode.
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
" Use <c-y> to create a new file and its parent directories.
" Use <c-z> to mark/unmark multiple files and <c-o> to open them.

"-------------------------------------------------------------------------------
" 4. Fonts setting and customization
"-------------------------------------------------------------------------------

" Use if the OS doesn't support some fonts
" if has('win32')    
"    let g:fontman_font = "Courier New"
" elseif has('unix')   
"    let g:fontman_font = "DejaVu Sans Mono"
" else
"    let g:fontman_font = "Courier New"
" endif

let g:fontman_font = "Courier New"
let g:fontman_size = 20
let s:minfontsize = 6
let s:maxfontsize = 34
function! AdjustFontSize(amount)
   if has("gui_running")
      let fontsize = g:fontman_size + a:amount
      if (fontsize >= s:minfontsize) && (fontsize <= s:maxfontsize)
         let g:fontman_size = fontsize
         :FontSize fontsize
      endif
   endif
endfunction

function! LargerFont()
   call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
   call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

" ctrl-up/down to increase or decrease font size
nmap <C-Up> :LargerFont<CR>
nmap <C-Down> :SmallerFont<CR>

"-------------------------------------------------------------------------------
" 5. GUI Specific settings
"-------------------------------------------------------------------------------
if has("gui_running")
   set mouse=a
   set guioptions-=T  " Hide toolbar
   set guioptions+=e  " to handle tabs better
   set guitablabel=%M\ %t
   set t_Co=256    " colors - use them all 
   set cursorline  " highlight current line
   silent!  colorscheme desert
else
   colorscheme desert  " for vim/vi terminal
endif

"-------------------------------------------------------------------------------
" 6. Iterate over color schemes
"-------------------------------------------------------------------------------
set background=dark
" colorscheme names that I like to toggle between
let s:mycolors = ['molokai' , 'solarized', 'dracula', 'desert', 'material-theme']

function! NextColor(how, echo_color)
   if exists('g:colors_name')
      let current = index(s:mycolors, g:colors_name)
   else
      let current = -1
   endif
   let missing = []
   let how = a:how
   for i in range(len(s:mycolors))
      let current += how
      " Wrapping at the end of list
      if !(0 <= current && current < len(s:mycolors))
         let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
      try
         execute 'colorscheme '.s:mycolors[current]
         break
      catch /E185:/
         call add(missing, s:mycolors[current])
      endtry
   endfor
   redraw
   if len(missing) > 0
      echo 'Error: colorscheme not found:' join(missing)
   endif
   if (a:echo_color)
      echo "Switching to colorscheme: " . g:colors_name
   endif
endfunction



"-------------------------------------------------------------------------------
" 7. File type dependent commenting 
"-------------------------------------------------------------------------------

au FileType c,cpp,cxx,h setlocal comments+=sl:/*,mb:*,elx:*/
au FileType tcl,python,csh setlocal comments+=:# 
function! CLine()
   normal 80A-d80|o80A-d80|O 
endfunction

" Note-  :set filetype? to know a filetype
au FileType c,cpp,cxx,h    imap     <buffer> <C-l> //<ESC>:call CLine()<CR>A
au FileType c,cpp,cxx,h    inoremap <buffer> <C-l> //<ESC>:call CLine()<CR>A
au FileType python,tcl,csh imap     <buffer> <C-l> #<ESC>:call  CLine()<CR>A
au FileType python,tcl,csh inoremap <buffer> <C-l> #<ESC>:call  CLine()<CR>A
au FileType vim            imap     <buffer> <C-l> "<ESC>:call  CLine()<CR>A
au FileType vim            inoremap <buffer> <C-l> "<ESC>:call  CLine()<CR>A
" I always use *.bas file for Visual Basic, not for Basic
au FileType basic,bas      set filetype=vb 
au FileType basic,ba       set filetype=vb 
au FileType vb             imap     <buffer> <C-l> '<ESC>:call  CLine()<CR>A
au FileType vb             inoremap <buffer> <C-l> '<ESC>:call  CLine()<CR>A

" Move cursor to before hash for markdown files with taskwiki
" TODO
" au FileType markdown nmap <buffer> A /\v( #\S+)*?$/
" au FileType markdown nmap <buffer> A /\v( #\S+)*$/s<CR> <ESC>:nohl <CR> i

" Beautify the comments using Ctrl-y
au FileType c,cpp,cxx,h nnoremap <buffer> <c-y> /\v\/\/\-<CR><UP>vN<DOWN>    
         \:s/\/\/.*\zs \+\ze/ /gi<CR>
         \/\v\/\/\-<CR><UP>N<DOWN>=                    
         \/\v\/\/\-<CR><UP>vN<DOWN>     
         \gq<UP>vN<DOWN>:Justify<CR><ESC>          
         \n==N==:nohl<CR>
au FileType tcl,python,csh nnoremap <buffer> <c-y> /\v#\-<CR><UP>vN<DOWN>    
         \:s/#.*\zs \+\ze/ /gi<CR>
         \/\v#\-<CR><UP>N<DOWN>=                    
         \/\v#\-<CR><UP>vN<DOWN>     
         \gq<UP>vN<DOWN>:Justify<CR><ESC>          
         \n==N==:nohl<CR>

"-------------------------------------------------------------------------------
" 8. Open current file in p4v Time-lapse view 
"-------------------------------------------------------------------------------
function! OpenP4VAnnotate()
   let  l:fullFileName = expand('%:p')
   " echo l:fullFileName
   let l:cmd ='!p4v -p $P4PORT -u darshakk -c $CUR_ENV -cmd "annotate ' .  l:fullFileName . '"'
   " echo l:cmd
   call CmdLine('silent ' . l:cmd . ' & <CR>')
endfunction


" Show annoutate for current line in current file
function! P4AnnotateTheLine()
   execute '!p4 annotate -cq "%" | sed "' . line(".") . 'q;d" | cut -f1 -d: | xargs p4 describe -s | sed -e ''/Affected files/,$d'' | sed -e ''/Wall Data/,$d'''
endfunction

"-------------------------------------------------------------------------------
" 9. Open Current file in OpenGrok at current line
"-------------------------------------------------------------------------------
function! OpenGrokAtCurrentLine()
   let  l:fullFileName = expand('%:p')
   " echo l:fullFileName
   let l:hyperlink = substitute(l:fullFileName, "^.*/src", "https://opengrok/source/xref/src", "")
   " echo l:hyperlink
   let l:lineNo = line('.') 
   " let l:lineNo -= 5
   " let l:lineNo = (l:lineNo > 0 ? l:lineNo : 1)
   let l:hyperlink = l:hyperlink . '\\#' . l:lineNo
   " echo l:hyperlink
   call CmdLine('silent !firefox ' . l:hyperlink . ' & <CR>')
endfunction

"-------------------------------------------------------------------------------
" 10. Visual mode selection and replace
"-------------------------------------------------------------------------------
" Visual mode pressing * searches for the current selection instead of 1 word
vnoremap <silent> * :call VisualSelection('f')<CR>
" visual mode # will search first occurance, come back to last occuracne, and put count in line
noremap # #:%s///gn <CR>
" When you press gr you can search and replace the selected text
vnoremap gr :call VisualSelection('replace')<CR>
" When you press gv you can search using vimgrep
vnoremap <silent> gv :call VisualSelection('gv')<CR> 
" When you press go current selection will be searched on opengrok
vnoremap <silent> go :call VisualSelection('go')<CR> 
" When you press g: "word:" will be searched - useful for class/yaml definition
vnoremap <silent> g: :call VisualSelection('g:')<CR> 

function! CmdLine(str)
   exe "menu Foo.Bar :" . a:str
   emenu Foo.Bar
   " Debug: Keep the Foo menu to debug what's up. Comment below line.
   unmenu Foo
endfunction

" https://github.com/alexeyr/vimfiles/blob/master/plugin/visualsearch.vim
" let l:pattern = substitute(l:pattern, "\n$", "", "")
function! VisualSelection(direction) range
   let l:saved_reg = @"
   execute "normal! gvy"
" For linux: execute "normal! vgvy"

   let l:pattern = escape(@", '\\/.*$^~[]')

   if a:direction == 'b'
      execute "normal ?" . l:pattern . "^M"
   elseif a:direction == 'gv'
      let l:searchList = '~/VimWiki/*'
      call CmdLine("vimgrep " . '/'. l:pattern . '/gj' . l:searchList . ' <CR>')
      :tabnew
      :copen 10
   elseif a:direction == 'replace'
      " This is not working for some reason but we can use ⌘+f in macVim
      call CmdLine("%smagic" . '/'. l:pattern . '/' . l:pattern )
   elseif a:direction == 'g:'
      call CmdLine('/\v'. l:pattern . '\s*:<CR>')
   elseif a:direction == 'go'
      call CmdLine('silent !firefox "https://opengrok/source/search?q=' .  l:pattern .  '&project=src" & <CR>')
   elseif a:direction == 'f'
      execute "normal /" . l:pattern . "^M"
   elseif a:direction == 'VWS'
      call CmdLine("VimwikiSearch ". l:pattern . "<CR>")
      :tabnew
      :lopen 
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction

"-------------------------------------------------------------------------------
" 11. Leader key driven key-maps  
"-------------------------------------------------------------------------------

" The most important shortcut in easy motion! 
" Over the window find across all visible windows
" Everything else is still ;;<char>
map <Leader>s <Plug>(easymotion-overwin-f)

" Set your leader key per your convenience.
let mapleader=";"

" leader-mm to maximize and balance split files. Simple and elegant.
let fullSizeFlag=0
map <silent> <expr> 
   \<leader>mm (fullSizeFlag==0)?':res<CR>:vertical res<CR> 
   \:let fullSizeFlag=1<CR>' : ':wincmd =<CR> :let fullSizeFlag=0<CR>'

" leader-ll to wrap/unwrap content
let wrapFlag=0
map <silent> <expr> 
   \<leader>ll (wrapFlag==0)?':verbose set nowrap<CR> :let wrapFlag=1<CR>' 
   \ : ':verbose set wrap<CR> :let wrapFlag=0<CR>'

" 
map <leader>j <Plug>(expand_region_expand)
map <leader>k <Plug>(expand_region_shrink)

" Open new split panes to right and bottom, 
" which feels more natural than Vim's default:
set splitbelow
set splitright

" P4 Annotate the Current line
map <leader>p :call P4AnnotateTheLine()<CR>

" Beautify Yaml 
map <leader>y :call BeautifyYaml()<CR>


" Default from diffchar plugin is leader-g for get, but I want similar to diff obtain
map  <leader>o <Plug>(GetDiffCharPair)
map  <leader>d :windo diffthis<CR>   :windo set wrap<CR>

" Next and previous errors in quick fix list during vimgrep/make
" TODO also do this for :ln, :lp
" https://vi.stackexchange.com/questions/25965/how-can-i-have-lnext-lprev-fallback-to-cnext-cprev-when-appropriate
1

function! s:qfnext(next) abort
    " find all 'quickfix'-type windows on the current tab
    let qfwin = filter(getwininfo(), {_, v -> v.quickfix && v.tabnr == tabpagenr()})
    if !empty(qfwin)
        " using the first one found
        if qfwin[0].winid == getqflist({'nr': 0, 'winid': 0}).winid
            " it's quickfix
            execute a:next ? 'cnext' : 'cprev'
        else
            " assume it's loclist
            " must execute it in the host window or in loclist itself
            call win_execute(qfwin[0].winid, a:next ? 'lnext' : 'lprev', '')
        endif
    else
        execute a:next ? 'lnext' : 'lprev'
    endif
endfunction
map <silent> <leader>m :Make<CR>
" map <silent> <leader>n :cn<CR>
" map <silent> <leader>b :cp<CR> 
nnoremap <silent> <leader>b :call <SID>qfnext(v:false)<CR>
nnoremap <silent> <leader>n :call <SID>qfnext(v:true)<CR>


" Close entire tab 
map <silent> <leader>q :tabclose<CR>

" Toggle Tag list explorer
map <silent> <leader>e :TlistToggle<CR>

" open current file in opengrok at current line
map <silent> <leader>g :call OpenGrokAtCurrentLine()<CR>

" Operations on "* buffer works with mouse middle click
" Copy current file path to clipboard if in normal mode,
" in visual mode, copy content instead
nmap  <leader>c :let @*=expand("%:p")<CR> :echo @* <CR>
vmap  <leader>c "*y<CR>

"-------------------------------------------------------------------------------
" 12. Ctrl key driven key-maps   
"-------------------------------------------------------------------------------
" Default and useful vim ctrl maps:
" ctrl-d : down fast in normal mode, indent left in insert mode
" ctrl-t : indent right in insert mode
" ctrl-u : up fast
" ctrl-e : down slow - overriding below to open undo explorer
" ctrl-y : up slow
" ctrl-w : window movements 
" ctrl-r : redo

" ctrl-g to add doxygen comment template using DoxygenToolkit plug-in 
map <silent> <C-g> :Dox<CR>

" ctrl-n for copying 'b filename:linenumber' for debugging in gbd and pdb
map <silent> <C-n> :let @*="b ".expand("%").":".line(".")<CR>

" ctrl-b for binding all the windows for synchronus scrolling
map <silent> <C-b> :windo set scb!<CR>



" ctrl-h to switch between header and cxx file in same directory
nmap <C-h> :e %:p:s,.h$,.X123X,:s,.cxx$,.h,:s,.X123X$,.cxx,<CR>

" ctrl-k to break Function arguments in new lines
nmap <C-k> :s/[^\<.*,.*\>]\zs,\ze/,\r/g <CR>v?(<CR>= :nohl<CR>

" Align variable definition using tabularize
map  <silent><C-i> :Tabularize /^\s*\(typedef\s*\)*\(virtual\s*\)*\(static\s*\)*\(const\s*\)*\(unsigned\s*\)*\([^(]*>\)*\S*\zs /l0c0l0<CR> :nohl <CR>

" Remove extra space without changing indent
vmap  <C-s> :s#\S\+\zs\s\+\ze# #g<CR> :nohl <CR>
nmap  <C-s> :s#\S\+\zs\s\+\ze# #g<CR> :nohl <CR>

" windows style copy paste. This works if you want to send data to windows also
" For linux, this is Shift Insert
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
nmap <C-v> <ESC>"+p

"-------------------------------------------------------------------------------
" 13. Func key driven key-maps 
"-------------------------------------------------------------------------------

" Perforce bind-keys 

" open p4v timelapse view in current line
map <F2> :call OpenP4VAnnotate()<CR>

" Add a new file / Edit an existing file
map <F3> :!p4 add %<CR>:w!<CR>
map <F4> :!p4 edit %<CR>:w!<CR>

" Diff current file with 'have' revision and open a new gvimdiff window to show
" Note: Enter in your cshrc file:  setenv P4DIFF "gvimdiff -f"
" Note: vim diff movements
" diffthis on two windows to enter diff mode
" do - Get changes from other window into the current window. DIFF OBTAIN
" dp - Put the changes from current window into the other window. DIFF PUT
" ]c - Jump to the next change.
" [c - Jump to the previous change.
" diffupdate to update the changes after making small modification
map <F6> :silent !p4 diff %<CR>
map <F7> :if confirm('Revert to original?', "&Yes\n&No", 1)==1 
         \<Bar> exec "!p4 revert " . expand("%:p") <Bar> edit <Bar> endif<CR><CR>
" Diff - Ignore white space while diff
set diffopt+=iwhite
set diffexpr=""

" Next (F9) or Previous (Ctrl-F9) Colorscheme
nnoremap <F9> :call NextColor(1,1)<CR>
nnoremap <C-F9> :call NextColor(-1,1)<CR>

" load vimrc, Update plug-ins
" TODO : Fix the errors in this
" map <F11> :source $MYVIMRC <CR> :PlugUpgrade <CR> :PlugUpdate <CR> :PlugClean <CR>
map <F11> :source $MYVIMRC <CR> 


" Automatically detectindent for given file
map <F12> :DetectIndent <CR> :IndentLinesReset <CR> :verbose set shiftwidth? <CR>

"-------------------------------------------------------------------------------
" 14. Spell check functions  
"-------------------------------------------------------------------------------
if filereadable("/usr/share/dict/words")
   :set dictionary=/usr/share/dict/words
endif 


" vim dict completion
" ctrl-n, ctrl-p - next/previous word completion 
" ctrl-x ctrl-l  - line completion
" ctrl-x ctrl-k  - dictionary completion
" visual > or <  - indent block by sw (repeat with . )
"
" Spell check toggle
:set nospell 
nmap <silent> <F10> :set spell! spelllang=en_us<CR>
inoremap <C-Space> <Esc>b[sve
inoremap <C-@> <C-Space>
nnoremap <C-Space> <Esc>b[sve
nnoremap <C-@> <C-Space>
vnoremap <C-Space> <Esc>b[sve
vnoremap <C-@> <C-Space>
snoremap <C-Space> <Esc>b[sve
snoremap <C-@> <C-Space>
" once on the spelling mistake word, 
" replace first suggestion for it 1z
" or open drop list and select 1st
vnoremap <Space> <Esc>i<C-X><C-s>

:nohl 

" This will beautify yaml by making sure : is paded with exactly 1 space on each
" side and Lists are tabularized
function! BeautifyYaml()
   if( &ft=="yaml" || &ft=="yml" || &ft=="config") 
      :1,$s#\s*:\s*#:#
      :1,$g#:\[# Tabularize /:\zs[
      :1,$g#:\s*\[# Tabularize /,
      :1,$g#:\s*\[# Tabularize /]
      :1,$s#:# : #
   endif
endfunction


"-------------------------------------------------------------------------------
" 15. VimWiki and markdown Set up
"-------------------------------------------------------------------------------
" Auto Commands
au! BufWritePre Generated\ Tags.md  call VimWikiTags()
au! BufLeave *.md :write!
au! BufWinEnter,BufEnter *.md call SwitchToMdBuffer()
au! BufAdd,BufRead,BufNewFile *.md call OpenMdBuffer()

" Paste image from clipboard to a file. TODO: Move this to raycast.
nmap <leader>a :call mdip#MarkdownClipboardImage()<CR>
command! PasteImageMD call mdip#MarkdownClipboardImage()

" Shortcuts
nnoremap <Leader>we :tab drop ~/VimWiki/Empty\ Me.md <CR>
nnoremap <Leader>wg :tab drop ~/VimWiki/Generated\ Tags.md <CR> :call VimWikiTags() <CR>
nnoremap <Leader>wl :call CopySectionLink()<CR>
nnoremap <Leader>wk :call GoToHyperlinks()<CR>
nnoremap <Leader>wj :call GoToPendingTasks()<CR>
" Vim Wiki Global Variables
let g:vimwiki_list = [{'path': '~/VimWiki/',
                        \ 'syntax': 'markdown', 
                        \ 'ext': '.md', 
                        \ 'auto_diary_index': 1,
                        \ }]

" \ 'diary_caption_level': 2,

let g:vimwiki_ext2syntax = {'.md' : 'markdown', '.markdown' : 'markdown', '.mdown' : 'markdown'}
let g:vimwiki_links_header_level = 4
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_folding = 'custom'
let g:vimwiki_auto_chdir = 1
" let g:vimwiki_conceallevel = 2

" Use space to toggle folds in normal mode
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR> 



function! GoToPendingTasks()
    execute 'normal! /## Pending TasksjO* [ ] '
endfunction
command! GoToPendingTasks call GoToPendingTasks()


function! GoToHyperlinks()
    execute 'normal! /^## Hyperlinkso'
endfunction

function! CopySectionLink()
    let l:origL = @l
    execute 'normal! ?^#wv$"ly'
    let @l = substitute(@l, '\n\+$', '', '')
    let @" = "[[" . expand("%:t:r") . "#" . @l . "]]"
    echo @"
    let @l = l:origL
endfunction


function! VimWikiTags()
    :VimwikiRebuildTags!
    :VimwikiGenerateTagLinks
    " This will do two things. For files which are my creation, it will high
    " light those as it will have two tags. And other, it will flag duplicates.
    " TODO: This doesn't highlight if two tags stay in different files. Fix it.
    " ":exec '1,$ call HighlightRepeats()'
endfunction

" Created using : http://vimcasts.org/episodes/writing-a-custom-fold-expression/
" extensions like vim markdown were failing for some reason so wrote a custom one.
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction
function! FoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction

setlocal foldtext=FoldText()

" vimwiki maps tab and s-tab to do things in table. 
" That is incorrect as it changes behavior in md file for every tab press
" during insert mode. I will disable it through a global variable here 
" and map it for table rows separately.
" 
" 
"
" From /Users/darshakg/.vim/vim_plug_downloads/vimwiki/ftplugin/vimwiki.vim
"
" if str2nr(vimwiki#vars#get_global('key_mappings').table_mappings)
"   inoremap <expr><buffer> <Tab> vimwiki#tbl#kbd_tab()
"   inoremap <expr><buffer> <S-Tab> vimwiki#tbl#kbd_shift_tab()
" endif
"  if maparg('<CR>', 'i') !~# '.*VimwikiReturn*.'
"    if has('patch-7.3.489')
"      " expand iabbrev on enter
"      inoremap <silent><buffer> <CR> <C-]><Esc>:VimwikiReturn 1 5<CR>
"    else
"      inoremap <silent><buffer> <CR> <Esc>:VimwikiReturn 1 5<CR>
"    endif
"  endif

let g:cur_buf_name=''
let g:vimwiki_table_mappings = 0
function! OpenMdBuffer()
    inoremap <expr><buffer> <CR> getline('.') =~# '^\s*\*' ? 
            \ '<Space><Esc>g_lD<Esc>:VimwikiReturn 1 5<CR> '
            \ : getline('.') =~# '^\s*\|' ? vimwiki#tbl#kbd_cr() 
            \ : '<CR>'
    inoremap <expr><buffer> <S-Tab> getline('.') =~# '^\s*\*' ? '<c-d>' 
            \ : getline('.') =~# '^\s*\|' ? vimwiki#tbl#kbd_shift_tab() 
            \ : '<S-Tab>'
    inoremap <expr><buffer> <tab> getline('.') =~# '^\s*\*' ? '<c-t>' 
            \ : getline('.') =~# '^\s*\|' ? vimwiki#tbl#kbd_tab() 
            \ : '<tab>'

    if(g:cur_buf_name != expand('%:p'))
        setlocal foldmethod=expr  
        setlocal foldexpr=MarkdownLevel()  
        setlocal foldenable
        setlocal textwidth=0
        setlocal linebreak
        let g:prev_buf_name = g:cur_buf_name
        let g:cur_buf_name=expand('%:p')
        " echo g:prev_buf_name . "=>" . g:cur_buf_name
    endif
endfunction
function! SwitchToMdBuffer()
    if(g:cur_buf_name != expand('%:p'))
        let g:prev_buf_name = g:cur_buf_name
        let g:cur_buf_name=expand('%:p')
        " echo g:prev_buf_name . "=>" . g:cur_buf_name
    endif
endfunction

au! FileType markdown setlocal foldlevel=1

function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

function! VimWikiNoteTemplate()
    call SwitchToMdBuffer()
    if (expand('%:p:h:t') != 'diary')
         silent execute '!~/.vim/templates/vimwiki_note_template.py ~/.vimwikitemplate' fnameescape(g:cur_buf_name) fnameescape(g:prev_buf_name) 
        silent 0r ~/.vimwikitemplate 
    endif
endfunction

" Create template for non diary vimwiki files
au! BufNewFile *.md call VimWikiNoteTemplate()
command! VimWikiNoteTemplate call VimWikiNoteTemplate()

let g:taskwiki_sort_order='status-,priority+,due-,project+'
let g:taskwiki_dont_fold = 'yes'
let g:taskwiki_markup_syntax = 'markdown'


" Indent line conceal was interfearing with vimwiki
let g:indentLine_setConceal = 0


function! PasteMdHyperlink()
    redir @"
    silent execute '!~/Library/Preferences/espanso/user/pastelink.sh'
    redir END
    # execute 'normal! "@p'
endfunction
command! PasteMdHyperlink call PasteMdHyperlink()

" Visual mode pressing ;w* searches for the current selection in VimWiki
vnoremap <silent> <Leader>wf :call VisualSelection('VWS')<CR>
nnoremap <silent> <Leader>wf :call VimWikiBackLinksMine()<CR>
nmap <Leader>tf A<ESC>vbb<Leader>wf
command! VimWikiBackLinksMine call VimWikiBackLinksMine()


function! VimWikiBackLinksMine()
    let l:pattern = expand('%:r')
    let l:pattern = escape(l:pattern, '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    echo l:pattern
    call CmdLine("VimwikiSearch ". l:pattern . "<CR>")
    :tabnew
    :lopen 
endfunction

map <leader>wc :Calendar<CR>

function! CopyProject()
  let l:original_cursor_position = getpos('.')
  execute '/\v^# \zs.*\S\ze\s*$'
  call CopyMatches()
  let l:p = 'project:"' . @+ . '"'
  :let @+ = l:p
  call setpos('.',l:original_cursor_position)
  echo @+
endfunction

function! CopyMatches()
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  execute 'let @+ = join(hits, "\n")'
endfunction
command! CopyMatches call CopyMatches()

nmap <silent> <Leader>wy :call CopyProject()<CR>
command!  CopyProject call CopyProject()

"-------------------------------------------------------------------------------
" 16. FZF setup
" Note: FZF preview works with bat. I am using TwoDark theme for bat as it works
" OK for both light and dark background.
"-------------------------------------------------------------------------------

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Smart case means it will be case insensitive if input is all lower case, if
" you put one upper case, it will switch to sensitive.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --no-ignore 
  \  --color=always --ignore-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" In the default implementation of `Rg`, ripgrep process starts only once with
" the initial query (e.g. `:Rg foo`) and fzf filters the output of the process.
" 
" This is okay in most cases because fzf is quite performant even with millions
" of lines, but we can make fzf completely delegate its search responsibliity to
" ripgrep process by making it restart ripgrep whenever the query string is
" updated. In this scenario, fzf becomes a simple selector interface rather than
" a "fuzzy finder".
" 
"  - We will name the new command all-uppercase `RG` so we can still access the
"    default version.
"  - `--bind 'change:reload:rg ... {q}'` will make fzf restart ripgrep process
"    whenever the query string, denoted by `{q}`, is changed.
"  - With `--phony` option, fzf will no longer perform search. The query string you
"    type on fzf prompt is only used for restarting ripgrep process.
"  - Also note that we enabled previewer with `fzf#vim#with_preview`.

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --ignore-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Mapping selecting mappings

" list files recusrively, but better
nmap <leader>ff :Files<CR>
" git status, but better"
nmap <leader>fg :GFiles?<CR>
" RipGrep, better than VimGrep. Using the function version 
nmap <leader>fr :RG<CR>
" Lines in loaded buffers
nmap <leader>fl :Lines<CR>
" Lines in current buffer
nmap <leader>f/ :BLines<CR>
" Marks
nmap <leader>f' :Marks<CR>
" Buffer history
nmap <leader>fb :History<CR>
" Command history
nmap <leader>fc :History:<CR>
" Search history
nmap <leader>fs :History/<CR>
" Mappings

nmap <leader>fm <plug>(fzf-maps-n)
xmap <leader>fm <plug>(fzf-maps-x)
omap <leader>fm <plug>(fzf-maps-o)
" Help Tags
nmap <leader>fh :Helptags<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" Using rg for file completion
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
imap <c-x><c-l> <plug>(fzf-complete-line)


"-------------------------------------------------------------------------------
" 17. List of some other vim how-to and commands.
"-------------------------------------------------------------------------------

" How to store a macro in a function?
" Look at CopySectionLink function above. Use q1 to record macro and "*1 to paste it.


" How to sort row alphabatically?
" Visually select the rows and do :sort


" convert the document to how it was some 15 minutes back
" :earlier 15m

" to view command history press : then press ctrl-f
" to view search history press / then press ctrl-f

"press the word under curosr in command line
": ctrl r ctrl w

"remove unwanted empty lines
":g/^$/d

" Put your cursor on a word in text and press viw to select it

" To select current paragraph till blank line vip

" To convert m_VBRAM_PXY to m_VbramPxy
":'<,'>s#\(_.\)\([^_]*\)#\u\1\L\2#g

" use gq in visual mode for justifying text comments; use gqip to optimize inner paragraph.

" to remove highlight :nohl

" command for selecting line with a pattern and copying them
" :g/pattern/normal "*yy

" command for deleting all Marks
" :delm! | delm A-Z0-9

" Now I use delimitmate so this is not needed anymore
" inoremap { {<CR>}<UP><CR>

" convert current file to unix format
" :!dos2unix %<CR> 

" Open current file in new tab
" :tab split

" Goto Nth tab
" Ngt

" To copy code into windows applications. 
" 1. :TOHtml, 2. Save htmls, 3 open in "browswer. 
" More: "http://vim.wikia.com/wiki/Pasting_code_with_syntax_coloring_in_emails

":windo to do something on all open windows

" use :map to list allmapping

" use z + direction keys jklh to go to up or down folds

" o in visual mode changes which at end of a visual selection you are  changing

" Using marks Each file has a set of marks identified by lowercase letters
" (a-z). In addition there is a global set of marks  identified  by  uppercase
" letters  (A-Z)  that identify a position within a particular file.

" To find out ascii, hex and octal value of a character, press g->a in vmode

" To find out how the key mapping is set:
" :verbose map <c-p> -> This will show you where it was set last

" Multi-line search: Use \_.* instead of .* to indicate to include any character
" including new line one: e.g /This\_.*Text/
 
" Mapping in vim - Some info
" map is the "root" of all recursive mapping commands. The root form applies to
" "normal", "visual+select", and "operator-pending" modes.
" noremap is the "root" of all non-recursive mapping commands. The root form
" applies to the same modes as map.
" Mode Letters
" n: normal only
" v: visual and select
" o: operator-pending
" x: visual only
" s: select only
" i: insert
" c: command-line
" l: insert, command-line, regexp-search


" How to know which plugins are sourced?
" :scriptnames

" to redirect/save the output of :map:
" ":redir >> ~/mymaps.txt
: ":map
: ":redir END

" list system fonts on terminal:
" xlsfonts | grep adobe 

" Fold shortcuts
" zM Close all folds
" zm Fold more at buffer level
" zR Open all folds
" zr Open more at buffer level
" zo Open current fold
" zc Close current fold
" za alternate <toggle> current fold
" <space> mapped to za for normal mode

" :reg command to scoop all registers
