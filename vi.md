# vi

- [Movement](#movement)
- [Selection (aka Visual Mode)](#selection-aka-visual-mode)
- [Editing](#editing)
- [Search/Replace](#searchreplace)
- [Files](#files)
- [Editor Commands](#editor-commands)
- [Counts and Modifiers](#counts-and-modifiers)
- [Windows](#windows)
- [Tabs](#tabs)

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

Copy: ```y<motion>``` (e.g., ```yw``` copy word, ```y$``` copy to the end of line), ```yy``` copies whole line  
Paste after/before position/line: ```p, P```

Toggle case: ```~```  
Repeate last text-changing command: ```.```  
Join lines: ```J```  

## Search/Replace

Search forward/backward: ```/<string>, ?<string>```, repeat search in same direction ```n, N```  
Replace all/confirm on current line: ```:s/string/replacement/[g,c]```  
Replace all/confirm in all lines: ```:%s/string/replacement/[g,c]```  

## Files

Write file: ```:w [filename]```, current file if no name given  
Read file after line: ```:r <filename>```  
Read program output: ```:r !<program>```  
Edit file: ```:e <filename>```  
Next/previous file: ```:n, :p```  

## Editor Commands

Exit saving changes: ```:x```  
Exit (unless changes): ```:q```  
Exit discarding change: ```!q```  

Show line numbers: ```:set number```  
Turn on/off Hex mode: ```:%!xxd```, ```:%!xxd -r```  

## Counts and Modifiers

You can combine nouns and verbs with a count, which will perform a given action a number of times. e.g., ```3w``` move 3 words forward, ```5j``` move 5 lines down, ```7dw``` delete 7 words.  

You can use modifiers to change the meaning of a noun. Some modifiers are ```i```, which means _“inner”_ or _“inside”_, and ```a```, which means _“around”_. For example,

       ```ci(``` change the contents inside the current pair of parentheses 
       ```ci[``` change the contents inside the current pair of square brackets  
       ```da'``` delete a single-quoted string, including the surrounding single quotes  

## Windows

Split window horizontally/vertically: ```:split/vsplit [filename]```, if no filename specified it will open current file  

Once you have multiple windows open, there are many window commands available all starting with the ```<C-w>``` key:  

```<C-w>n```- :new horizontal split (editing a new empty buffer)  
```<C-w>s``` - :split window horizontally (editing current buffer)  
```<C-w>v``` - :vsplit window vertically (editing current buffer)  
```<C-w>c``` - :close window  
```<C-w>o``` - close all windows, leaving :only the current window open  
```<C-w>w``` - go to next window  
```<C-w>p``` - go to previous window  
```<C-w><Up>``` - go to window above  
```<C-w><Down>``` - go to window below  
```<C-w><Left>``` - go to window on left  
```<C-w><Right>``` - go to window on right  

## Tabs

New Tab: ```:tabnew```  
Open file in new tab: ```:tabedit <filename>```  
Close current tab: ```:tabc```  
Close all tabs except current: ```:tabo```  
Next/previous tab: ```:tabn/:tabp```  
