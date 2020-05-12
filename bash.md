# Bash

- [Command line editing](#command-line-editing)
- [History](#history)
- [Globbing](#globbing)
- [Special variabes](#special-variables)
- [Useful Snippets](#useful-snippets)
   - [Colorize Output](#colorize-output)
   - [Match RegEx](#match-regex)
   - [POSIX Style Command Line Processing](#posix-style-command-line-processing)
   - [Process lines in a file](#process-lines-in-a-file)
   - [Process list and dictionary](#process-list-and-dictionary)
   - [Prompt for yes-no](#prompt-for-yes-no)
   - [Script name and path](#script-name-and-path)

## Command line editing

Move to start/end of line: ```C-a, C-e```  
Move forward/backward a character: ```C-f, C-b```  
Move forward/backward a word: ```A-f, A-b```  
Delete the character under the cursor: ```C-d```  
Delete from current position to start/end of line: ```C-u, C-k```  
Delete word before/after: ```C-w, A-d```  
Clear screen, reprinting the current line at the top: ```C-l``` (same as ```clear``` command)  

## History

Fetch the previous/next command from the history list: ```C-p, C-n```  
Search backward/forward through history for a given string: ```A-p, A-n```  
Search backward/forward through history: ```C-r, C-s```  

## Globbing

```?```    matches single character   
```*```    matches multiple characters   
```{}```   matches list (e.g., ```convert image.{png,jpg}``` expands to ```convert image.png image.jpg```)   

## Special Variables

  Variable | Description
  -------- | -----------
  ```$0``` | Name of script
  ```$n``` | Positional arguments of script (or function) (where ```n>=1```)
  ```$#``` | Number of arguments
  ```$@``` | List of arguments, when used within double quotes each parameter expands to a separate word. That is, ```"$@"``` is equivalent to ```"$1"``` ```"$2"```  
  ```$*``` | List of arguments, when used within double quotes it expands to a single word with the value of each parameter separated by the first character of the ```IFS``` special variable. That is, ```"$*"``` is equivalent to ```"$1c$2c..."```, where ```c``` is the first character of the value of the ```IFS``` variable. If ```IFS``` is unset, the parameters are separated by spaces. If ```IFS``` is ```null```, the parameters are joined without intervening separators.  
  ```$?``` | Exit code/return code from last program/function call  
  ```$!``` | Process id of the most recently executed background process  
  ```$$``` | Process id of script  
  ```$-``` | Values of various shell's flags. See ```bash``` man pages for details  
  ```!!``` | Last shell command, e.g., re-run last 'Permission Denied` command with sudo: ```sudo !!```
  ```$_``` | Last argument of last command, e.g., ```$ mkdir /media/mydir/```, ```$ cd $_```
  ```IFS```| Internal Field Separator - is a special shell variable that is used for word splitting. It is commonly used with read command, parameter expansions and command substitution. The default value is ```<space><tab><newline>```, you can change its value as per your requirments.

## Useful Snippets

### Colorize Output
Ref: https://misc.flogisoft.com/bash/tip_colors_and_formatting  

```bash
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NO_COLOR='\e[0m'
LIGHT_CYAN='\e[96m'

echo -e "${RED}Environment variable 'MYVAR' is not set.${NO_COLOR}"
```

### Match RegEx
```bash
re='^[0-9]+$'

if [ "$#" -ge 1 ] && [[ $1 =~ $re ]]; then
   
else
   script_name=`basename "$0"`
   echo "  Usage: $script_name </path/to/dir> [options]"
   exit 1
fi
```

### POSIX Style Command Line Processing
Ref: https://github.com/apache/flink/blob/release-1.10/flink-container/docker/build.sh

```bash
#!/bin/sh

usage() {
  cat <<HERE
Usage:
  build.sh --job-jar <path-to-job-jar> --from-local-dist [--image-name <image>]
  build.sh --job-jar <path-to-job-jar> --from-archive <path-to-dist-archive> [--image-name <image>]
  build.sh --job-jar <path-to-job-jar> --from-release --flink-version <x.x.x> --scala-version <x.xx> [--hadoop-version <x.x>] [--image-name <image>]
  build.sh --help

  If the --image-name flag is not used the built image name will be 'flink-job'.
  Before Flink-1.8, the hadoop-version is required. And from Flink-1.8, the hadoop-version is optional and would download pre-bundled shaded Hadoop jar package if provided.
HERE
  exit 1
}

while [[ $# -ge 1 ]]
do
key="$1"
  case $key in
    --job-jar)
    JOB_JAR_PATH="$2"
    shift
    ;;
    --from-local-dist)
    FROM_LOCAL="true"
    ;;
    --from-archive)
    FROM_ARCHIVE="$2"
    shift
    ;;
    --from-release)
    FROM_RELEASE="true"
    ;;
    --image-name)
    IMAGE_NAME="$2"
    shift
    ;;
    --flink-version)
    FLINK_VERSION="$2"
    shift
    ;;
    --hadoop-version)
    HADOOP_VERSION="$2"
    HADOOP_MAJOR_VERSION="$(echo ${HADOOP_VERSION} | sed 's/\.//')"
    shift
    ;;
    --scala-version)
    SCALA_VERSION="$2"
    shift
    ;;
    --kubernetes-certificates)
    CERTIFICATES_DIR="$2"
    shift
    ;;
    --help)
    usage
    ;;
    *)
    # unknown option
    ;;
  esac
  shift
done
```

### Process lines in a file
```bash
#!/bin/sh

process() {
    local arg=$*

    # anything you want to do with line goes here
    echo $arg 
}

if [ "$#" -eq 1 ]; then
    while IFS= read -r line; 
    do
        process $line
    done < $1	
else
    script_name=`basename "$0"`
    echo "Usage: $script_name <file>"
    exit 1
fi
```

### Process list and dictionary
```bash
declare -a hist_files=("$HOME/.bash_history" "$HOME/.python_history" "$HOME/.lesshst" "$HOME/.local/share/recently-used.xbel")                                                                                

for i in "${hist_files[@]}"
do
   touch $i && cat /dev/null > $i && chmod 400 $i
done
```

```bash
declare -A lookuptbl=( ["key1"]="val1" ["key2"]="val2")

v=${lookuptbl['key1']}
k=lookuptbl['key1']='value5'
vlist="${lookuptbl[@]}"
klist="${!lookuptbl[@]}"

for k in "${!lookuptbl[@]}"
do
   echo "${lookuptbl[$k]}"
done
```

### Prompt for yes-no
```bash
prompt() {
    local msg="$*"

    yesno="null"

    shopt -s nocasematch
    while [[ ! ${yesno} =~ ^([yn]|yes|no)?$ ]]; do
       read -r -p "$msg" yesno
    done
    shopt -u nocasematch

    if [[ $yesno =~ ^[Yy].* ]]; then
       return 0
    else
       # [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
       return 1
    fi
}

prompt "Delete directory... (y/n)? "
if [ "$?" -eq "0" ]; then
    rmdir mydir
else
    echo "Skipping 'STEP 1/6: Deleting directory'"  
fi
```

### Script name and path
```bash
script_name=`basename "$0"`
script_dir="$( cd "$( dirname "$0" )" && pwd )"
```
