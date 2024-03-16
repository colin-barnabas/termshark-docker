#! /usr/bin/env zsh


setopt local_options

local -A opts
local -a trace iface
zparseopts -A opts -D -E -- i:-=iface x=trace
if [[ "x$trace" != 'x' ]]; then setopt xtrace; fi

test $ARGC -gt 0 \
  && eval -- test\ -x\ $(whence -p -- $1 || echo /dev/null) \
  && eval -- sh\ -c\ ${(qqf)@} \
  || eval -- exec\ termshark\ -i\ ${(v)opts[-i]:-any} ${(qqf)@}
