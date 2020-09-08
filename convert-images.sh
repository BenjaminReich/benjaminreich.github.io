#!/bin/sh

CURRENT_DIR=$(pwd)
ORIGINAL_DIR="$CURRENT_DIR/pwa1"

START=2
END=2
for i in $(seq $START $END); do
  PWA_DIR="$CURRENT_DIR/pwa$i"
  mkdir "$PWA_DIR"
  cp -R "$ORIGINAL_DIR/." "$PWA_DIR"
  cd "$PWA_DIR"

  convert icon-512_original.png -background none -pointsize 500 -gravity Center -fill white -annotate 0 "$i" icon-512.png
  convert icon-144_original.png -background none -pointsize 100 -gravity Center -fill white -annotate 0 "$i" icon-144.png
  convert icon_original.jpg -background none -pointsize 250 -gravity Center -fill white -annotate 0 "$i" icon.jpg

  sed '1s/^/var CACHE_NAME = "pwa1";\n/' "$PWA_DIR/worker.js" > "$PWA_DIR/worker2.js"
  rm "$PWA_DIR/worker.js"
  mv "$PWA_DIR/worker2.js" "$PWA_DIR/worker.js"

  echo """{
  \"name\": \"Ben Test PWA ${i}\",
  \"short_name\": \"Ben Test PWA ${i}\",
  \"start_url\": \"https://benjaminreich.github.io/pwa${i}\",
  \"display\": \"standalone\",
  \"theme_color\": \"#ffffff\",
  \"background_color\": \"#ffffff\",
  \"icons\": [
      {
          \"src\": \"icon.jpg\",
          \"sizes\": \"240x240\",
          \"type\": \"image/jpg\"
      },
      {
          \"src\": \"icon-144.png\",
          \"sizes\": \"144x144\",
          \"type\": \"image/png\"
      },
      {
        \"src\": \"icon-512.png\",
        \"sizes\": \"512x512\",
        \"type\": \"image/png\"
    }
  ],
  \"url\": \"https://benjaminreich.github.io/pwa${i}\",
  \"lang\": \"\",
  \"scope\": \"/pwa${i}/\",
  \"screenshots\": [],
  \"orientation\": \"portrait\"
}""" > manifest.webmanifest
done


# for x in pwa*; do
#   num=$(echo "$x" | sed -nr 's/.*([0-9]+)$/\1/p');
#   cd "$CURRENT_DIR/$x"
  
#   convert icon-512.png -background none -pointsize 550 -gravity Center -fill white -annotate 0 '1' icon-512_text.png
# done