#!/usr/bin/env osh

(
  pstree -w -p "$$"
  echo "$@"
) | base64 | logger -t snoopy

exec @target@ "$@"
