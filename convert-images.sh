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

  sed "s/var CACHE_NAME = \"pwa1\";/var CACHE_NAME = \"pwa$i\";/g" "$PWA_DIR/worker.js" > "$PWA_DIR/worker2.js"
  rm "$PWA_DIR/worker.js"
  mv "$PWA_DIR/worker2.js" "$PWA_DIR/worker.js"

  sed "s/\/pwa1\/worker.js/\/pwa$i\/worker.js/g" "$PWA_DIR/index.html" > "$PWA_DIR/index2.html"
  rm "$PWA_DIR/index.html"
  mv "$PWA_DIR/index2.html" "$PWA_DIR/index.html"

  echo """{
  \"name\": \"Ben Test PWA ${i}\",
  \"short_name\": \"Ben Test PWA ${i}\",
  \"start_url\": \"https://benjaminreich.github.io/pwa${i}/\",
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
  \"url\": \"https://benjaminreich.github.io/pwa${i}/\",
  \"lang\": \"\",
  \"scope\": \"/pwa${i}/\",
  \"screenshots\": [],
  \"orientation\": \"portrait\"
}""" > "$PWA_DIR/manifest.webmanifest"
done
