# Puzzle Game 拼圖遊戲

Java Swing 製作的 4x4 拼圖小遊戲，包含登入、註冊、圖片分類切換、步數統計、勝利判定與完整圖片預覽。

## 遊戲功能

- 登入與註冊畫面
- 4x4 拼圖玩法
- 隨機產生可解的拼圖盤面
- 支援 WASD 與方向鍵操作
- 支援更換圖片分類：
  - 動物
  - 動漫
  - 車
- 按住 `Tab` 可暫時查看完整圖片
- 按 `V` 可直接完成拼圖，方便測試
- 完成拼圖後顯示勝利畫面

## 預設帳號

```text
帳號：admin
密碼：123
```

也可以在登入頁點「註冊」新增帳號。註冊資料目前只存在程式記憶體中，關閉程式後不會保存。

## 下載遊玩

到 GitHub 的 **Releases** 下載對應平台的檔案：

- macOS：下載 `PuzzleGame-1.0.dmg`
- Windows：下載 `PuzzleGame-windows.zip`，解壓縮後執行 `PuzzleGame.exe`

如果專案有建立 `v` 開頭的 tag，例如 `v1.0.0`，GitHub Actions 會自動建立 Release 並附上 Mac/Windows 下載檔。

## 本機執行

需要 JDK 21，或至少 JDK 14 以上。

```bash
javac -encoding UTF-8 -d build/classes $(find gui -name "*.java")
cp -r gui/ui/images build/classes/gui/ui/
java -cp build/classes gui.ui.App
```

## 本機打包

### macOS

```bash
chmod +x build-mac.sh
./build-mac.sh
```

輸出位置：

```text
build/package/PuzzleGame-1.0.dmg
```

### Windows

在 Windows 的 cmd 執行：

```bat
build-windows.bat
```

輸出位置：

```text
build\package\PuzzleGame\PuzzleGame.exe
```

可以把整個 `build\package\PuzzleGame` 資料夾壓縮成 zip 分享。

## GitHub 自動打包

本專案已加入 GitHub Actions：

```text
.github/workflows/package-puzzle-game.yml
```

觸發方式：

- push 到 `主要` 或 `main`
- 手動在 GitHub Actions 頁面點 `Run workflow`
- push `v*` tag，例如 `v1.0.0`

一般 push 會產生 Actions Artifacts；push tag 則會額外建立 GitHub Release。

建立 Release 的常用指令：

```bash
git tag v1.0.0
git push origin v1.0.0
```

## 專案結構

```text
gui/ui/
├── App.java                  # 程式進入點
├── itheima/
│   ├── LoginJFrame.java      # 登入畫面
│   ├── RegisterJFrame.java   # 註冊畫面
│   ├── GameJFrame.java       # 拼圖主畫面與遊戲邏輯
│   └── User.java             # 使用者資料物件
└── images/                   # 背景圖、拼圖素材、勝利圖
```

## 備註

圖片資源使用 classpath 載入，因此在 IDE、JAR、jpackage 打包後都能正常顯示。
