#!/bin/bash
# Resize all training photos to 1024x1024
cd ~/Desktop/training-photos
mkdir resized
for f in *.jpg; do
  magick "$f" -gravity center -resize 1024x1024^ -extent 1024x1024 "resized/$f"
done
