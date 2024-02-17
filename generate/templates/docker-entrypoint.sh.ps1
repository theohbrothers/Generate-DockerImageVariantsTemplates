@'
#!/bin/sh
set -eu

if [ $# -gt 0 ] && [ "${1#-}" != "$1" ]; then
    set -- webize "$@"
elif [ $# -gt 0 ] && webize "$1" --help > /dev/null 2>&1; then
    set -- webize "$@"
fi

exec "$@"
'@
