#! /bin/zsh

test -n "$argv" \
  && eval -- test\ -x\ $(>&2 which $1 || echo /dev/null) \
  && eval -- sh -c "'$@'" \
  || exec termshark -i any "$@"
