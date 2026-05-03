@echo off
REM =============================================================================
REM  build-windows.bat  ─  拼圖遊戲 Windows 打包腳本
REM =============================================================================
REM
REM  執行結果：
REM    build\package\PuzzleGame\PuzzleGame.exe
REM
REM  jpackage 會產生一個 app-image 資料夾，裡面包含 exe 與 Java runtime。
REM  使用者不需要另外安裝 Java，只要解壓縮整個資料夾並執行 PuzzleGame.exe。
REM
REM  前置需求：
REM    - Windows 10 或更新版本
REM    - JDK 14 或更新版本，且 JDK\bin 已加入 PATH
REM
REM =============================================================================

SET PROJECT_DIR=%~dp0
SET SRC_DIR=%PROJECT_DIR%gui
SET BUILD_DIR=%PROJECT_DIR%build
SET CLASSES_DIR=%BUILD_DIR%\classes
SET DIST_DIR=%BUILD_DIR%\dist
SET PACKAGE_DIR=%BUILD_DIR%\package

echo ========================================
echo   拼圖遊戲 Windows 打包腳本
echo ========================================
echo.

echo [1/6] 檢查環境...
where javac >nul 2>&1
IF ERRORLEVEL 1 (
    echo   錯誤：找不到 javac，請安裝 JDK 並加入 PATH。
    pause
    exit /b 1
)
where jpackage >nul 2>&1
IF ERRORLEVEL 1 (
    echo   錯誤：找不到 jpackage，需要 JDK 14 或更新版本。
    pause
    exit /b 1
)
echo   完成

echo [2/6] 清理輸出目錄...
IF EXIST "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%CLASSES_DIR%"
mkdir "%DIST_DIR%"
mkdir "%PACKAGE_DIR%"
echo   完成

echo [3/6] 編譯 Java 原始碼...
dir /s /b "%SRC_DIR%\*.java" > "%BUILD_DIR%\sources.txt"
javac -encoding UTF-8 -d "%CLASSES_DIR%" @"%BUILD_DIR%\sources.txt"
IF ERRORLEVEL 1 (
    echo   錯誤：編譯失敗。
    pause
    exit /b 1
)
del "%BUILD_DIR%\sources.txt"
echo   完成

echo [4/6] 複製圖片資源...
mkdir "%CLASSES_DIR%\gui\ui"
xcopy /s /i /q "%SRC_DIR%\ui\images" "%CLASSES_DIR%\gui\ui\images"
echo   完成

echo [5/6] 建立可執行 JAR...
(
    echo Manifest-Version: 1.0
    echo Main-Class: gui.ui.App
) > "%BUILD_DIR%\MANIFEST.MF"
jar cfm "%DIST_DIR%\PuzzleGame.jar" "%BUILD_DIR%\MANIFEST.MF" -C "%CLASSES_DIR%" .
echo   完成

echo [6/6] 使用 jpackage 建立 Windows App...
jpackage ^
    --input       "%DIST_DIR%"       ^
    --dest        "%PACKAGE_DIR%"    ^
    --name        "PuzzleGame"       ^
    --main-jar    "PuzzleGame.jar"   ^
    --main-class  "gui.ui.App"       ^
    --type        app-image          ^
    --app-version "1.0"              ^
    --vendor      "Student Project"  ^
    --win-console

IF ERRORLEVEL 1 (
    echo   錯誤：jpackage 失敗。
    pause
    exit /b 1
)

echo.
echo ========================================
echo   打包完成！
echo   App 路徑：%PACKAGE_DIR%\PuzzleGame\
echo   請將整個 PuzzleGame 資料夾壓縮成 zip 分享。
echo ========================================
pause
