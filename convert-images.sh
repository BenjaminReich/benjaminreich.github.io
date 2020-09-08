#!/bin/sh

CURRENT_DIR=$(pwd)
ORIGINAL_DIR="$CURRENT_DIR/pwa1"

START=2
END=50
for i in $(seq $START $END); do
  PWA_DIR="$CURRENT_DIR/pwa$i"
  mkdir "$PWA_DIR"
  cp -R "$ORIGINAL_DIR/." "$PWA_DIR"
  cd "$PWA_DIR"

  convert icon-512_original.png -background none -pointsize 500 -gravity Center -fill white -annotate 0 "$i" icon-512.png
  convert icon-144_original.png -background none -pointsize 100 -gravity Center -fill white -annotate 0 "$i" icon-144.png
  convert icon_original.jpg -background none -pointsize 250 -gravity Center -fill white -annotate 0 "$i" icon.jpg
done


# for x in pwa*; do
#   num=$(echo "$x" | sed -nr 's/.*([0-9]+)$/\1/p');
#   cd "$CURRENT_DIR/$x"
  
#   convert icon-512.png -background none -pointsize 550 -gravity Center -fill white -annotate 0 '1' icon-512_text.png
# done