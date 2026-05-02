#!/bin/bash
set -e

if [ ! -f PuzzleGame.jar ]; then
  echo "找不到 PuzzleGame.jar，請先執行 ./build.sh 來打包。"
  exit 1
fi

java -jar PuzzleGame.jar