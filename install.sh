#!/bin/bash

if [ ! -d "$HOME/bin" ]; then
   mkdir $HOME/bin
fi

# Ideally we should deduce DATA_DIR automatically, but $(pwd) doesn't resolve to current directory, need to troubleshoot this at some point, hardcoding it for now 
#sed 's/DATA_DIR=\./DATA_DIR=$(pwd)/' ./ref > $HOME/bin/ref
sed 's/DATA_DIR=\./DATA_DIR=\~\/mnt\/k\/MyProjects\/Reference/' ./ref > $HOME/bin/ref

chmod +x ~/bin/ref
echo "'ref' installed in ~/bin"

