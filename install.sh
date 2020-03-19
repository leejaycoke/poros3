#!/bin/bash

LINK_PATH="/usr/local/bin"

if [ ! -d "$LINK_PATH" ]; then
    echo "Not exists folder $LINK_PATH" >&2
    exit 1
fi

BASEDIR=$(dirname "$0")

sh_path=$(which postrotate_s3)
if [ ! -z "$sh_path" ]; then
    ln -f $BASEDIR/postrotate_s3 $LINK_PATH/postrotate_s3
fi

echo -e "Installation completed: $LINK_PATH/postrotate_s3\n"

postrotate_s3 --help
