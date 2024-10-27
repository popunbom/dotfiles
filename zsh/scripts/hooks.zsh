#!/bin/zsh

# Hook on chpwd
function chpwd() {
  emulate -L zsh

  # Set alias make='task' if Taskfile.yml exists in the current directory
  function __make_task() {
    tput setaf 3; tput bold; echo "Found Taskfile.yml in the current directory -- aliasing to 'task'"; tput sgr0
    task $@
  }
  if [[ -f $(pwd)/Taskfile.yml ]]; then
    compdef make='task'
    alias make='__make_task'
  else
    compdef make='make'
    unalias make 2>/dev/null
  fi
}
chpwd
