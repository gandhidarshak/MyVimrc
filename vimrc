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
" 15. List of some other vim how-to and commands.
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" 1. Opening vim, navigating, text, tab and indent settings
"-------------------------------------------------------------------------------

set nocompatible               " Turn off vim compatibility with Vi.
set history=100                " How many lines of command history VIM has to remember?
set showmatch                  " Show matching brackets when text indicator is over them.
set matchtime=2                " How many tenths of a second to blink when matching brackets?
set textwidth=80               " Zero value will disable text-width's impact
set scrolloff=8                " Show 8 lines before and after
set cmdheight=2                " Command line window hight
set virtualedit=block          " Put cursor anywhere in file not limited by the text limit
set undolevels=200             " Very high number may slow down vim
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
set tabstop=3                  " 1 tab = 3 spaces
set softtabstop=3              " 1 tab = 3 spaces
set shiftwidth=3               " 1 tab = 3 spaces
set formatoptions+=rqo         " How auto-formatting will work
set foldmethod=syntax          " Use syntax fold method by default 

" use very magic searches
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

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
au FileType python,yml,yaml,cfg,config set foldmethod=indent

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
Plug 'vim-scripts/DoxygenToolkit.vim'   " Doxygen tool kit for Vim to provide comment templates
Plug 'ciaranm/detectindent'             " Automatically adjust shiftwidth based on current file
Plug 'easymotion/vim-easymotion'        " Easy navigation in vim
Plug 'godlygeek/tabular'                " Tabularize/Align using any string
Plug 'vim-scripts/taglist.vim'          " Tag List Explorer
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy file search
Plug 'vim-scripts/Gundo'                " visualize your Vim undo tree
Plug 'vim-scripts/OmniCppComplete'      " Omni Complete for C++ Auto complete
Plug 'Yggdroot/indentLine'              " Indent lines
Plug 'octol/vim-cpp-enhanced-highlight' " C++ 11/14/17 based syntax highlighting
Plug 'stephpy/vim-yaml'                 " Yaml syntax
Plug 'altercation/vim-colors-solarized' " Solarized theme
Plug 'tomasr/molokai'                   " Molokai theme
Plug 'jdkanani/vim-material-theme'      " Material theme
Plug 'raimondi/delimitmate'             " Auto closing of quotes, brackets, etc.
Plug 'takac/vim-fontmanager'            " Font manager for quick font changes
Plug 'airblade/vim-gitgutter'           " To show a git diff in the 'gutter'

" TODO: Configure YouCompleteMe and move on from OmniCppComplete when possible
" Plug 'Valloric/YouCompleteMe' 

" Uncomment below if you use fugitive, nerdcommenter or nerdtree
" At one point I used to use them, but now I don't anymore
" Plug 'scrooloose/nerdcommenter'        
" Plug 'scrooloose/nerdtree'              
" Plug 'tpope/vim-fugitive'     
" Plug 'bling/vim-airline'                " Status tab line for vim
" Plug 'vim-airline/vim-airline-themes'   " Themes for airline

call plug#end()

" Run :PlugInstall first if not already installed. Only for initial set up.
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
nmap ghp <Plug>GitGutterPreviewHunk
nmap ghs <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" explandtab
" Limit for number of lines that will be analysed set
let g:detectindent_max_lines_to_analyse = 10000

" Airline
:let g:airline_theme='base16_solarized' 
silent! call airline#extensions#whitespace#disable()

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
let g:ctrlp_root_markers        = ['cscope.files']
let g:ctrlp_max_files           = ""
let g:ctrlp_map                 = '<c-p>'
let g:ctrlp_cmd                 = 'CtrlP'
let g:ctrlp_user_command        = ['cscope.files', 'cat %s/cscope.files']
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
if has('win32')    
   let g:fontman_font = "Courier New"
else
   let g:fontman_font = "DejaVu Sans Mono"
endif
let g:fontman_size = 15

let s:minfontsize = 6
let s:maxfontsize = 24
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
   silent!  colorscheme molokai
else
   colorscheme desert  " for vim/vi terminal
endif

"-------------------------------------------------------------------------------
" 6. Iterate over color schemes
"-------------------------------------------------------------------------------
set background=dark
" colorscheme names that I like to toggle between
let s:mycolors = ['solarized',  'molokai' , 'desert', 'material-theme']

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
vnoremap <silent> gr :call VisualSelection('replace')<CR>
" When you press gv you can search using vimgrep
vnoremap <silent> gv :call VisualSelection('gv')<CR> 
" When you press go current selection will be searched on opengrok
vnoremap <silent> go :call VisualSelection('go')<CR> 
" When you press g: "word:" will be searched - useful for class/yaml definition
vnoremap <silent> g: :call VisualSelection('g:')<CR> 

function! CmdLine(str)
   exe "menu Foo.Bar :" . a:str
   emenu Foo.Bar
   unmenu Foo
endfunction

function! VisualSelection(direction) range
   let l:saved_reg = @"
   execute "normal! vgvy"

   let l:pattern = escape(@", '\\/.*$^~[]')
   let l:pattern = substitute(l:pattern, "\n$", "", "")

   if a:direction == 'b'
      execute "normal ?" . l:pattern . "^M"
   elseif a:direction == 'gv'
      " $power1/2/3/4... are envvar pointing to sandbox dir where my team's code is present. 
      call CmdLine("vimgrep " . '/'. l:pattern . '/gj' . ' % $power1/** $power2/** $power3/** $power4/** <CR>')
      :tabnew
      :copen 10
   elseif a:direction == 'replace'
      call CmdLine("%s" . '/'. l:pattern . '/')
   elseif a:direction == 'g:'
      call CmdLine('/\v'. l:pattern . '\s*:<CR>')
   elseif a:direction == 'go'
      call CmdLine('silent !firefox "https://opengrok/source/search?q=' .  l:pattern .  '&project=src" & <CR>')
   elseif a:direction == 'f'
      execute "normal /" . l:pattern . "^M"
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction

"-------------------------------------------------------------------------------
" 11. Leader key driven key-maps  
"-------------------------------------------------------------------------------

" Set your leader key per your convenience.
let mapleader=";"

" Next and previous errors in quick fix list during vimgrep/make
map <silent> <leader>n :cn<CR>
map <silent> <leader>p :cp<CR>

" Close entire tab 
map <silent> <leader>q :tabclose<CR>

" Toggle Tag list explorer
map <silent> <leader>e :TlistToggle<CR>

" open current file in opengrok at current line
map <silent> <leader>o :call OpenGrokAtCurrentLine()<CR>

" Operations on "* buffer works with mouse middle click
" Copy current file path to clipboard if in normal mode,
" in visual mode, copy content instead
nmap  <leader>c :let @*=expand("%:p")<CR> :echo @* <CR>
vmap  <leader>c "*y<CR>

"-------------------------------------------------------------------------------
" 12. Ctrl key driven key-maps   
"-------------------------------------------------------------------------------
" Default and useful vim ctrl maps:
" ctrl-d : down fast
" ctrl-u : up fast
" ctrl-e : down slow - overriding below to open undo explorer
" ctrl-y : up slow
" ctrl-w : window movements 
" ctrl-r : redo

" ctrl-e Gundo explorer
map <silent> <C-e> :GundoToggle<CR>

" ctrl-g to add doxygen comment template using DoxygenToolkit plug-in 
map <silent> <C-g> :Dox<CR>

" ctrl-n for copying 'b filename:linenumber' for debugging in gbd and pdb
map <silent> <C-n> :let @*="b ".expand("%").":".line(".")<CR>

" ctrl-b for binding all the windows for synchronus scrolling
map <silent> <C-b> :windo set scb!<CR>


" ctrl-m to maximize and balance split files. Simple and elegant.
let fullSizeFlag = 0
map <silent> <expr> <C-m> (fullSizeFlag==0)?':res<CR>:vertical res<CR> 
         \:let fullSizeFlag=1<CR>' : ':wincmd =<CR> :let fullSizeFlag=0<CR>'

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

" Perforce bind-keys , TODO: Write a P4 plug-in for vim when convenient

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
map <F11> :source $MYVIMRC <CR> :PlugUpgrade <CR> :PlugUpdate <CR>

" Automatically detectindent for given file
map <F12> :DetectIndent <CR> :IndentLinesReset <CR> :set shiftwidth? <CR>

"-------------------------------------------------------------------------------
" 14. Spell check functions  
"-------------------------------------------------------------------------------
if exists('/usr/share/dict/words')
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
   :1,$s#\s*:\s*#:#
   :1,$g#:\[# Tabularize /:\zs[
   :1,$g#:\s*\[# Tabularize /,
   :1,$g#:\s*\[# Tabularize /]
   :1,$s#:# : #
endfunction
command! BeautifyYaml call BeautifyYaml()

"-------------------------------------------------------------------------------
" 15. List of some other vim how-to and commands.
"-------------------------------------------------------------------------------

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

