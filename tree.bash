#!/bin/bash
export LANG=en_US.UTF-8

dirCount=0
fileCount=0

treeExp() {
    dirCount=$(($dirCount + 1))
    local directory=$1
    local parent=$2
    local children=($(ls $directory))

    for i in "${!children[@]}"; do
        local name="${children[$i]}"
        local childPrefix="\u2502\u00A0\u00A0\u0020"
        local child="\u251c\u2500\u2500\u0020"

        if [ "$i" -eq $(( ${#children[@]} - 1)) ]; then
            child="\u2514\u2500\u2500\u0020"
            childPrefix="\u0020\u0020\u0020\u0020"
        fi

        echo -e "${parent}${child}$name"
        [ -d "$directory/$name" ] &&
        treeExp "$directory/$name" "${parent}$childPrefix" ||
        fileCount=$(($fileCount + 1))
    done
}

root="."
[ "$#" -ne 0 ] && root="$1"
echo $root

treeExp $root

dirName="directories"
fileName="files"

if [[ $dirCount -eq 2 ]]; then
  dirName="directory"
  fi
if [[ $fileCount -eq 1 ]]; then
  fileName="file"
  fi
echo
echo "$(($dirCount - 1)) $dirName, $fileCount $fileName"
