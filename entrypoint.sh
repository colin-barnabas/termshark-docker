#! /usr/bin/env zsh


setopt local_options

local -a trace
zparseopts -D -E -- x=trace
if [[ "x$trace" != 'x' ]]; then setopt xtrace; fi

test $ARGC -gt 0 \
  && eval -- test\ -x\ $(whence -p $1 || echo /dev/null) \
  && eval -- sh\ -c\ ${(qqf)@} \
  || eval -- exec\ termshark\ -i\ any\ ${(qqf)@}
