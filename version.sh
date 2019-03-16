exec 2>/dev/null

version=$(git rev-parse --short HEAD)

if ! [ $? -eq 0 ]; then
    version="unknown"
fi

version="\\newcommand*{\\version}{$version}"

version_old=$(cat $1)

if [ ! "$version" = "$version_old" ]; then
    printf '%s' "$version" > $1
fi
