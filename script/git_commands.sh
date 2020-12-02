#! /bin/bash

# return current branch
git rev-parse --abbrev-ref HEAD

# clean local branches not existed on remote any more
git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done

git for-each-ref --shell --format='git log --oneline %(refname) ^origin/master' refs/heads/


# borrowed from this thread
# https://stackoverflow.com/a/53271026


my_callback () {
  INDEX=${1}
  BRANCH=${2}
  echo "${INDEX} ${BRANCH}"
}
get_branches () {
  git branch --all --format='%(refname:short)'
}
# mapfile -t -C my_callback -c 1 BRANCHES < <( get_branches ) # if you want the branches that were sent to mapfile in a new array as well
# echo "${BRANCHES[@]}"
mapfile -t -C my_callback -c 1 < <( get_branches )



#!/usr/bin/env bash


_map () {
  ARRAY=${1?}
  CALLBACK=${2?}
  mapfile -t -C "${CALLBACK}" -c 1 <<< "${ARRAY[@]}"
}


get_history_differences () {
  REF1=${1?}
  REF2=${2?}
  shift
  shift
  git log --oneline "${REF1}" ^"${REF2}" "${@}"
}


has_different_history () {
  REF1=${1?}
  REF2=${2?}
  HIST_DIFF=$( get_history_differences "${REF1}" "${REF2}" )
  return $( test -n "${HIST_DIFF}" )
}


print_different_branches () {
  read -r -a ARGS <<< "${@}"
  LOCAL=${ARGS[-1]?}
  for REMOTE in "${SOME_REMOTE_BRANCHES[@]}"; do
    if has_different_history "${LOCAL}" "${REMOTE}"; then
      # { echo; echo; get_history_differences "${LOCAL}" "${REMOTE}" --color=always; } # show differences
      echo local branch "${LOCAL}" is different than remote branch "${REMOTE}";
    fi
  done
}


get_local_branches () {
  git branch --format='%(refname:short)'
}


get_different_branches () {
  _map "$( get_local_branches )" print_different_branches
}


# read -r -a SOME_REMOTE_BRANCHES <<< "${@}" # use this instead for command line input
declare -a SOME_REMOTE_BRANCHES
SOME_REMOTE_BRANCHES=( origin/master remotes/origin/another-branch another-remote/another-interesting-branch )
DIFFERENT_BRANCHES=$( get_different_branches )

echo "${DIFFERENT_BRANCHES}"