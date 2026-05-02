#!/bin/bash
set -e

# 清理舊編譯檔案
rm -rf out
mkdir -p out/classes

# 編譯 Java 類
javac -d out/classes gui/ui/App.java gui/ui/itheima/*.java

# 複製資源檔案到 jar 內
mkdir -p out/classes/gui/ui/images
cp -r gui/ui/images/* out/classes/gui/ui/images/

# 建立可執行 JAR
cat > out/manifest.txt <<EOF
Main-Class: gui.ui.App
EOF
jar cfm PuzzleGame.jar out/manifest.txt -C out/classes .

echo "打包完成: PuzzleGame.jar"