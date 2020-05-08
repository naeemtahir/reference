# RegEx

A regular expression is comprised of normal characters, character classes (sets of characters), wildcard characters, and quantifiers

## Rules

1. Normal Character  
    Match as is, e.g., "Java" matches only "Java"

2. Character Classes
    - Specifies characters in the class between brackets ```[]```, e.g., class [wxyz] matches w, x, y or z
    - To specify inverted class precede the characters with a ```^```. For example, [^wxyz] matches any character except w, x, y, or z. When used without character class ```^``` anchors following expression to start of string
    - You can specify a range of characters using a hyphen ```-```, e.g., a character class that matches positive digits 1 to 9 can be specified as [1-9]
    - Pre-defined character classes  
           ```\w``` Any alphanumric character, shortcut for ```[A-Za-z0-9_]```. Capital form negates it, e.g.,```\W``` any non-alphanumeric character.  
           ```\d``` Any digit, short cut for ```[0-9]```. Capital form negates it, e.g.,```\D``` any non-numeric character.    
           ```\s``` Any whitespace. Capital form negates it, e.g.,```\S``` any non-whitespace character.  
           ```\b``` does not itself match any character but "anchors" the pattern to a word boundary. Similarly, ```\B``` matches any non-word-boundary.  

3. Wildcard Character  
    The wildcard character is the dot ```.```, it matches any single character. Thus, a pattern that consists of "." will match these (and other) input sequences: "A", "a", "x", and so on.

4. Quantifiers  
    A quantifier determines how many times an expression is matched. The basic quantifiers are:

     - ```+``` Match one or more (e.g., the pattern "W+" will match "W", "WW", and "WWW", among others.)  
     - ```*``` Match 0 or more  
     - ```?``` Match 0 or 1

5. Other special/meta characters  

    - ```|```           Logical OR
    - ```()```        Groupings
    - ```{m},{m,n}```   {m} match m copies, {m,n} matches m to n copies
    - ```^```  ```$```  Start and end of the line. Anchors regex to beginning or end of line. ```^``` is also used to inverse meaning of a character class, e.g., [^0-9] will match only non-digit characters.
    - ```\```           Escape special character
    - ```\t \n \r```    Tab, new line, carriage return  

## Examples

  1. 'Java' matches 'Java'  
  2. 'Java' matches 'Java' in 'Java SE'  
  3. 'test' matches 'testing' and 'test' in 'testing 1 2 3 test'  
  4. 'W+' matches 'W', 'WW', and 'WWW' in 'W WW YYYY WWW'  
  5. 'e.+d' matches 'extend cup end' in 'extend cup end table'.  
     You expected it would match 'extend' and 'end' ;) No. it is a matching longest sequencee (called _**greedy behavior**_). You can specify **_reluctant behavior_** by adding ? to the pattern, it causes the shortest matching pattern to match; see next example.  
  6. 'e.+?d' matches 'extend' and 'end' in 'extend cup end table' (Reluctant Matching)  
  7. '[a-z]+' matches 'this', 'is', and 'test' in 'this is A test 123'  
  8. '^.+$' matches an entire non-empty line.

## Reference

- http://math.hws.edu/eck/cs229/f15/regular_expressions.html
- https://regexone.com/
- https://regexr.com/
- http://regexlib.com/
