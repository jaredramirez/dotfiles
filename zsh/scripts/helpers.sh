#!/bin/zsh

mkcd () {
  if [ -z "$1" ]; then
    echo "usage: mkcd directory ..."
  else
    mkdir $1 && cd $_
  fi
}

java_run () {
  if [ -z "$1" ]; then
    echo "usage: java_run source_file_name_without_extension ..."
  else
    java_file="$1.java"
    javac $java_file && java $1
  fi
}

ghc_run() {
  if [ -z "$1" ]; then
    echo "usage: haskell_run source_file_name_without_extension ..."
  else
    if [ -e $1 ]
      then rm $1;
    fi
    if [ -e $1.hi ]
      then rm $1.hi;
    fi
    if [ -e $1.o ]
      then rm $1.o;
    fi

    ghc --make $1 && echo -e "\n" && ./$1
  fi
}

git_rm_local_branches () {
  git remote prune origin && git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
}

fromhex () {
  hex=$1
  if [[ $hex == "#"* ]]; then
    hex=$(echo $1 | awk '{print substr($0,2)}')
  fi
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}
