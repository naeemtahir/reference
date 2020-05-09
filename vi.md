# vi

- [Movement](#movement)
- [Selection (aka Visual Mode)](#selection-aka-visual-mode)
- [Editing](#editing)
- [Search/Replace](#searchreplace)
- [Files](#files)
- [Windows/Tabs](#windowstabs)
- [Counts and Modifiers](#counts-and-modifiers)
- [Editor Commands](#editor-commands)

## Movement

Left, Down, Up, Right - ```h,j,k,l```  
Next word, Beginning of word, End of Word: ```w/W, b/W, e/E```  
Beginning of Line, First non-blank character, End of Line: ```0, ^, $```  
Beginnig/End of Sentence: ```(,)```  
Beginning/End of Paragraph:  ```{,}```  
Go to line number: ```:<n>, <n>G```  
Jump forward/back to character: ```f<c>/F<c>```, use ```;``` to jump to next match  
Jump forward/back before character: ```t<c>/T<c>```, use ```,``` to jump to next match  

Top, Middle, Bottom of screen: ```H, M, L```  
Beginning/end of File: ```gg, G```  
Scroll up/down: ```C-u, C-d```  

Set mark at current cursor location: ```m<key>```  
Jump to line of mark (first non-blank character in line): ```'<key>```  
Jump to position (line and column) of mark: ``` `a ```   
Navigate between marks: ```]'```, ```]` ```, ```['```, ``` [` ```  
Special Marks:  
``` `. ``` Jump to position where last change occurred in current buffer  
``` `" ``` Jump to position where last exited current buffer  
``` `0 ``` Jump to position in last file edited (when exited Vim)  
``` `1 ``` Like ``` `0 ``` but the previous file (also ``` `2 ``` etc)  
``` '' ``` Jump back (to line in current buffer where jumped from)  
``` `` ``` Jump back (to position in current buffer where jumped from)  

## Selection (aka Visual Mode)

Start selection by character: ```v```  
Start selection by line: ```V```  
Start selection by Block: ```C-v``  

## Editing

Insert before cursor/line: ```i, I```  
Append after cursor/line: ```a, A```  
Insert line after/before: ```o, O```  
Replace single/multiple characters: ```r, R```  
Change text: ```c<motion>```, e.g. ```cw``` is change word like ```d<motion>``` followed by ```i```  

Delete before/after cursor: ```x, X```  
Delete to end of line: ```D```  
Delete current line: ```dd```  

Undo last text change/all changes on line: ```u/U```  
Redo: ```C-r```  

Copy/cut: ```y<motion>``` (e.g., ```yw``` copy word, ```y$``` copy to the end of line), ```yy``` copies whole line. Replace ```y``` with ```d``` for cutting.    
Paste after/before position/line: ```p, P```

Toggle case: ```~```  
Repeate last text-changing command: ```.```  
Join lines: ```J```  

## Search/Replace

Search forward/backward: ```/<string>, ?<string>```, repeat search in same direction ```n, N```  
Replace all/confirm on current line: ```:s/string/replacement/[g,c]```  
Replace all/confirm in all lines: ```:%s/string/replacement/[g,c]```  

## Files

Save file (as): ```:w [filename]```, current file if no name given  
Read file after line: ```:r <filename>```  
Read program output: ```:r !<program>```  
Edit file: ```:e <filename>```  
Next/previous file: ```:n, :p```  
Close file: ```:bd```  

## Windows/Tabs

New empty window: ```<C-w>n :new```  
Split window horizontally/vertically (editing current buffer, if you want to open a different file specify it as parameters to ```:split :vsplit``` command): ```<C-w>s,v``` or ```:split,:vsplit```  
Close current/other window(s): ```<C-w>c,o```  
Go to next/previous window: ```<C-w>w,p```   
Go to window left/down/above/right: ```<C-w> <movement>```  

New empty Tab: ```:tabnew```  
Open file in new tab: ```:tabedit <filename>```  
Close current tab: ```:tabc```  
Close all tabs except current: ```:tabo```  
Next/previous tab: ```:tabn/:tabp``` 
 
## Counts and Modifiers

You can combine nouns and verbs with a count, which will perform a given action a number of times. e.g., ```3w``` move 3 words forward, ```5j``` move 5 lines down, ```7dw``` delete 7 words.  

You can use modifiers to change the meaning of a noun. Some modifiers are ```i```, which means _“inner”_ or _“inside”_, and ```a```, which means _“around”_. For example,

       ```ci(``` change the contents inside the current pair of parentheses 
       ```ci[``` change the contents inside the current pair of square brackets  
       ```da'``` delete a single-quoted string, including the surrounding single quotes  

## Editor Commands

Exit saving changes: ```:x```  
Exit (unless changes): ```:q```  
Exit discarding change: ```!q```  

Show line numbers: ```:set number```  
Turn on/off Hex mode: ```:%!xxd```, ```:%!xxd -r```  
