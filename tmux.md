# tmux

Default command key is ```Ctrl-b``` (represented as ```C-``` in follwing guide)

- [Sessions](#sessions)
- [Windows](#windows)
- [Panes](#panes)
- [Scrolling](#scrolling)
- [Copy,Paste,Search](#copypastesearch)
- [Mouse Support](#mouse-support)
- [Other Useful Commands](#other-useful-commands)

## Sessions
*Create session:* ```tmux new -s <session-name>``` OR ``:new`` (you can name session with ```C-$```)  
*Detach session:* ```C-d```  
*List sessions:* ```tmux ls``` OR ```C-s```  
*Attach to session:* ```tmux attach -t <session-name>``` OR ```tmux attach #<session-number```  
*Delete session:* ```tmux kill-session -t <session-name>``` OR ```tmux kill-session #<session-number```  

## Windows

*Open new window:* ```C-c```  
*List windows:* ```C-w```    
*Cycle through windows:* ```C-n|C-p``` (n=next, p=previous)  
*Quickly switch window:* ```C-<window numbern>```  
*Rename current window:* ```C-,```  
*Find window:* ```C-f```  
*Close current window:* ```C-&```

## Panes

*Split pane horizontally:* ```C-%```  
*Split pane vertically:* ```C-"```  
*Cycle through panes:* ```C-o```  
*Toggle between current and previous pane:* ```C-;```  
*Quickly switch pane:* ```C-q``` (will show pane numbers, quickly type pane number to switch to that pane)  
*Zoom in/out pane:* ```C-z```  
*Close current pane:* ```C-x```  

*Autolayout Panes:* ```C-<space>``` (if you do it multiple times it will cycle through various pre-defined layouts)  
*Chose one of five pre-defined layouts:* ```C-Alt-<1|2|3|4|5>``` 1=Even horizontal, 2=Event vertical, 3=Main horizontal, 4=Main vertical, 5=Tiled (same number of rows and columns)  
*Resizing panes:* ```C-<arrow-key>``` (small increments) OR ```C-Alt-<arrow-key>``` (large increments)  

## Scrolling

Scroll in window/pane: ```C-[```, press ```q``` or ```ESC``` to exit scroll mode

## Copy,Paste,Search

- To copy enter copy mode ```C-[```, hit ```Ctrl-Space``` and start highlighting text with arrow keys (hit ```Ctrl-Space``` to cancel), press ```Alt-w``` to copy text into tmux clipboard

- To paste press ```C-]```

- To search enter copy mode ```C-[```, hit ```Ctrl-s``` then type the string to search for and press ```Enter```. Press ```n``` to search for the same string again (press ```Shift-n``` for reverse search). Press ```ESC``` twice to exit copy mode.

## Mouse Support
Enable mouse: ```set -g mouse on```  

## Other Useful Commands

*Display key bindings:* ```C-?```  
*Broadcast command to all panes in current window (use with caution):* ```set -g synchronize-panes on|off```  
*Clear history:* ```clear-history```

## Resources

- https://nickjanetakis.com/blog/who-else-wants-to-boost-their-productivity-with-tmux
