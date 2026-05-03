#!/bin/bash
# =============================================================================
#  build-mac.sh  ─  拼圖遊戲 macOS 打包腳本
# =============================================================================
#
#  執行結果：
#    build/package/PuzzleGame-1.0.dmg
#
#  這個 DMG 由 jpackage 產生，會把 Java runtime 一起包進 App，
#  使用者不用另外安裝 JDK 或 JRE。
#
#  前置需求：
#    - macOS
#    - JDK 14 或更新版本，且 PATH 中能找到 javac、jar、jpackage
#
# =============================================================================

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$PROJECT_DIR/gui"
BUILD_DIR="$PROJECT_DIR/build"
CLASSES_DIR="$BUILD_DIR/classes"
DIST_DIR="$BUILD_DIR/dist"
PACKAGE_DIR="$BUILD_DIR/package"

echo "========================================"
echo "  拼圖遊戲 macOS 打包腳本"
echo "========================================"
echo ""

echo "[1/5] 清理輸出目錄..."
rm -rf "$BUILD_DIR"
mkdir -p "$CLASSES_DIR" "$DIST_DIR" "$PACKAGE_DIR"
echo "      完成"

echo "[2/5] 編譯 Java 原始碼..."
find "$SRC_DIR" -name "*.java" > "$BUILD_DIR/sources.txt"
javac -encoding UTF-8 -d "$CLASSES_DIR" @"$BUILD_DIR/sources.txt"
rm "$BUILD_DIR/sources.txt"
echo "      完成"

echo "[3/5] 複製圖片資源..."
mkdir -p "$CLASSES_DIR/gui/ui"
cp -R "$SRC_DIR/ui/images" "$CLASSES_DIR/gui/ui/"
echo "      完成"

echo "[4/5] 建立可執行 JAR..."
cat > "$BUILD_DIR/MANIFEST.MF" << 'EOF'
Manifest-Version: 1.0
Main-Class: gui.ui.App
EOF
jar cfm "$DIST_DIR/PuzzleGame.jar" "$BUILD_DIR/MANIFEST.MF" -C "$CLASSES_DIR" .
echo "      完成（$DIST_DIR/PuzzleGame.jar）"

echo "[5/5] 使用 jpackage 建立 DMG..."
jpackage \
    --input        "$DIST_DIR"          \
    --dest         "$PACKAGE_DIR"       \
    --name         "PuzzleGame"         \
    --main-jar     "PuzzleGame.jar"     \
    --main-class   "gui.ui.App"         \
    --type         dmg                  \
    --app-version  "1.0"                \
    --vendor       "Student Project"

echo ""
echo "========================================"
echo "  打包完成！"
echo "  DMG 路徑：$PACKAGE_DIR/PuzzleGame-1.0.dmg"
echo "========================================"
