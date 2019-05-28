## My Vim Set-up
This git-repository is created to share my vim set-up with my colleagues for a 'how-to-vim' presentation. It is culmination of my experiments with gvim during past ~10 years of working with spice net-lists and C++/Python codes. 

## How to install?
### Pre-requiste:
This vimrc is tested to work mainly for a Linux or Windows based gvim (v7.4). It should work with later versions of vim/gvim without any issues, however may require some tweaks to adept for mac. Also, it assumes that user has git and etags installed and working as a pre-requisite.

Installation is quite simple, clone the repository and open vim/gvim. It will auto install/set-up all plugins and bind-keys and will be ready to use in no time.

### Linux:
      cd ~
      rm -rf .vim (This deletes your old vim configurations. If you want to keep it, use mv instead of rm.)
      git clone --depth=1 https://github.com/gandhidarshak/myVimrc.git .vim

### Windows:
      cd C:\Users\<username>
      rm /s vimfiles (This deletes your old vim configurations. If you want to keep it, use move instead of rmdir.)
      git clone --depth=1 https://github.com/gandhidarshak/myVimrc.git vimfiles

### Windows with a network HOME drive:
If you work in a company where IT set-up is such that a remote network directory is set as your HOME drive in windows then the above steps may not work. You may chose to clone vimfiles folder in your network home but in my experiance, that make vim a bit sluggish and also makes the set-up unavailable when you are not connected with network. 

Alternatively and preferrably, you may want to create/edit system vimrc file and add below two lines to it. then the steps in previous windows section should work as is for you.

      Create/Edit file C:\Program Files (x86)\Vim\vimrc and add below lines.
      let $HOME = expand('C:\Users\' . $USERNAME)
      exe 'set rtp+=' . expand( $HOME . '\vimfiles')

## Bind-keys: 
Below bind-keys will be readily available once you install the vimrc.

      F1  : Vim help
      F2  : Open p4v timelapse view in current line (aka p4-annotate)
      F3  : P4 add current file
      F4  : P4 edit current file
      F5  : Purge in CtrlP mode
      F6  : P4 diff current file with have revision
      F7  : P4 revert current file after a warning dialog box
      F8  : gvim setting window
      F9  : Iterate forward in themes (ctrl-F9 to iterate backwards)
      F10 : Toggle spell-check
      F11 : Source .vimrc file, update plug-ins
      F12 : Set shiftwidth and tabstop automatically by analyzing current file
      
      ctrl-a : Increment number under cursor
      ctrl-b : Bind all windows for synchronous scrolling
      ctrl-c : Windows style copy
      ctrl-d : Scroll down
      ctrl-e : Gundo explorer 
      ctrl-f : Page down, similar to scroll down for single page file
      ctrl-g : DoxygenToolkit comment template for function under the cursor
      ctrl-h : Switch between cxx and h file 
      ctrl-i : Align variable definition using Tabularize
      ctrl-j : Justify selected lines
      ctrl-k : Break function arguments in new lines 
      ctrl-l : File type dependent comment template 
      ctrl-m : Maximize and balance split files. Simple and elegant.
      ctrl-n : Copy 'b filename:linenumber' for debugging in gbd and pdb
      ctrl-o : Jump to previously visited location
      ctrl-p : CtrlP fuzzy file search
      ctrl-q : Column block select
      ctrl-r : Redo
               In Command mode, Use <C-R>" to paste content to command.
      ctrl-s : Remove extra spaces without impacting indentation
      ctrl-t : <Insert Mode> tab ++
      ctrl-u : Scroll Up
      ctrl-v : Windows style paste
      ctrl-w : Window commands
             : ctrl-w gf open file in new tab
             : ctrl-w j/k/l/m move to file in split windows in given direction
             : ctrl-w J/K/L/M move current file to  given split window location
      ctrl-x : <Visual Mode> Windows style cut
      ctrl-x : <Insert Mode> Auto completion mode start
             : ctrl-x ctrl-f  file complete
             : ctrl-x ctrl-k  word complete
             : ctrl-x ctrl-l  line complete
             : ctrl-x ctrl-o  omni complete
             : ctrl-x ctrl-s  spell suggestion when spell check is on (F10)
      ctrl-y : Beautify comment
      ctrl-z : Suspend vim like :stop or ctrl-z of terminal
      
      ctrl-up    : Increase font size while maintaining window size
      ctrl-down  : Decrease font size while maintaining window size
      ctrl-space : Go to previous spell check error
      ctrl-F9    : Iterate backwards in themes
      
      ]c  : Next difference
      [c  : Previous difference
      do  : Diff obtain
      dp  : Diff put
      zo  : Open folded text
      zc  : Close folded text
      gg  : Go to top of the file
      gG  : Go to bottom of the file
      gf  : Go to file mentioned under cursor
      gx  : Go to website mentioned under cursor
      ga  : Show character encoding
      gr  : replace all words selected in vmode
      go  : open opengrok and search the word selected
      gH  : Select line mode
      gv  : Select previous selction in normal mode, run vimgrep in visual mode
      g~  : To change fooBAr to FOObaR
      gU  : To change fooBAr to FOOBAR
      gu  : To change fooBAr to foobar
      ghp : GitGutterPreviewHunk
      ghs : GitGutterStageHunk
      ghu : GitGutterUndoHunk
      [c  : GitGutterPrevHunk
      ]c  : GitGutterNextHunk
      
      *    : search for all words selected in vmode
      #    : Count occurrence of word under cursor
      ;    : leader key (aka prefix key) - change if prefered
      ;m   : Make from dispatch plugin (:make async)
      ;n   : Next error in quick fix list during vimgrep/make
      ;b   : Previous (back) error in quick fix list during vimgrep/make
      ;q   : Close entire tab
      ;e   : Toggle Tag list explorer
      ;g   : Open current file in opengrok at current line
      ;o   : Diff-obtain but for diffchar
      ;p   : Diff-put but for diffchar
      ;d   " diff this and wrap on all open windows
      ;j   " Expand regions - smart expand
      ;k   " Expand regiones - smart shrink
      ;c   : <Visual Mode> Copy selected content to buffer *
      ;c   : <Normal Mode> Copy to full path to file in buffer *
      ;y   : Beautify Yaml file
      ;a   : P4 Annotate On the current line 
      ;;s  : Find(Search) {char} forward and backward. Awesome!
      ;;f  : Find {char} to the right.
      ;;F  : Find {char} to the left. 
      ;;w  : Beginning of word forward. 
      ;;b  : Beginning of word backward. 
      ;;e  : End of word forward. 
      ;;j  : Line downward. 
      ;;k  : Line upward. 
      ;;n  : Jump to latest "/" or "?" forward.
      ;;N  : Jump to latest "/" or "?" backward.

## Default Plug-ins: 
Below is the list of plug-ins which will be automatically installed up-on
opening vim/gvim for the first time after git clone.

A *shout-out* to all the awesome creators!!

      vim-plug                   : A minimalist Vim plugin manager
      DoxygenToolkit             : Doxygen tool kit for Vim to provide comment templates
      detectindent               : Automatically adjust shiftwidth based on current file
      vim-easymotion             : Easy navigation in vim
      tabular                    : Tabularize / Align using any string
      taglist                    : Tag List Explorer using etags
      ctrlp                      : Fuzzy file search
      Gundo                      : Visualize your Vim undo tree
      OmniCppComplete            : Omni Complete for C++ Auto complete
      indentLine                 : Indent lines visulizer
      vim-polyglot               : A collection of language packs for all main languages
      vim-yaml                   : Yaml syntax file
      vim-colors-solarized       : Solarized theme
      molokai                    : Molokai theme
      vim-material-theme         : Material theme
      delimitmate                : Auto closing of quotes, brackets, etc.
      vim-fontmanager            : Font manager for vim
      vim-gitgutter              : To show a git diff in the 'gutter'
      dracula                    : Dracula theme for vim
      diffchar                   : Highlight the exact differences, based on characters and words
      vim-expand-region          : Visually select increasingly larger regions of text using the same key combination
      vim-dispatch               : Run :make and other tasks (grep etc) async from vim

## Sharing is caring!

I am always looking to improve my vim efficiency by trying new ideas/plugins. And since you are on this page and reached till this point, I am guessing you are a vim enthusiast too. Please feel free to take an idea or two from my vim setup. Or please ping me back with your awesome ideas which might change my viming forever!

