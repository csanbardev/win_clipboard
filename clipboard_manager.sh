#!/bin/bash

CLIPBOARD_DIR=~/.clipboard_history
mkdir -p $CLIPBOARD_DIR

CURRENT_CLIPBOARD=$CLIPBOARD_DIR/current_clipboard.txt
PREVIOUS_CLIPBOARD=$CLIPBOARD_DIR/previous_clipboard.txt

xclip -o > $CURRENT_CLIPBOARD

if ! cmp -s $CURRENT_CLIPBOARD $PREVIOUS_CLIPBOARD; then
    cp $CURRENT_CLIPBOARD $PREVIOUS_CLIPBOARD
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "$TIMESTAMP\n$(cat $CURRENT_CLIPBOARD)\n---" >> $CLIPBOARD_DIR/history.txt
fi

yad --text-info --filename=$CLIPBOARD_DIR/history.txt --title="Historial del Portapapeles" --width=400 --height=600

