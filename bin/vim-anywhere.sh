#!/bin/bash

# allows one to edit something in vim, from anywhere

function setclip() {
  xclip -selection clipboard
}

function getclip() {
  xclip -selection clipboard -o
}

file=$(mktemp)
$TERM_APP $EDITOR "$file"

cat $file | setclip
rm $file

# xdotool key ctrl+v
