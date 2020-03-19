#!/bin/bash

LINK_PATH="/usr/local/bin"

if [ ! -d "$LINK_PATH" ]; then
    echo "Not exists folder $LINK_PATH" >&2
    exit 1
fi

BASEDIR=$(dirname "$0")
ln -f $BASEDIR/poros3 $LINK_PATH/poros3

echo -e "Installation completed: $LINK_PATH/poros3\n"

poros3 --help
