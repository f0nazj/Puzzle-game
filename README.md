# Puzzle Game

這是一個簡單的 Java Swing 拼圖遊戲專案，包含登入、註冊以及 4x4 拼圖玩法。這個專案適合用來練習 GUI、事件處理與資源載入。

## 從 GitHub 遊玩方式

1. 在自己的電腦上安裝 Java JDK（建議 JDK 11 以上）。
2. 從 GitHub 下載或複製倉庫：
   ```bash
   git clone https://github.com/f0nazj/Puzzle-game.git
   cd Puzzle-game
   ```
3. 編譯並執行遊戲：
   ```bash
   javac gui/ui/App.java gui/ui/itheima/*.java
   java gui.ui.App
   ```

> 注意：這是一個 Swing 桌面應用程式，需要有圖形介面環境才能開啟。如果在命令列環境出現 `HeadlessException`，表示目前環境沒有顯示器（例如某些遠端伺服器或 container）。


## 功能介紹

- 登入／註冊介面
- 4x4 拼圖遊戲
- 支援 WASD 與方向鍵操控
- 支援重新遊戲、重新登入、關閉遊戲
- 支援更換圖片分類（動物、動漫、車）
- 按住 `Tab` 可查看完整拼圖

## 遊戲規則

- 移動空白格可將拼圖塊推動到正確位置
- 步數會在畫面左上角顯示
- 拼圖完成後會顯示勝利畫面

## 執行方式

1. 編譯 Java 檔案：
   ```bash
   javac gui/ui/App.java gui/ui/itheima/*.java
   ```
2. 執行遊戲：
   ```bash
   java gui.ui.App
   ```

## 打包成單一 JAR

如果你想讓別人直接用一個檔案執行，請在專案目錄下執行：

```bash
chmod +x build.sh run.sh
./build.sh
```

打包完成後會產生 `PuzzleGame.jar`，然後執行：

```bash
java -jar PuzzleGame.jar
```

也可以使用 `run.sh` 直接執行：

```bash
./run.sh
```

> 注意：JAR 仍然是桌面應用程式，需要圖形介面環境才能顯示畫面。

## 快捷鍵

- `W` / `↑`: 向上
- `S` / `↓`: 向下
- `A` / `←`: 向左
- `D` / `→`: 向右
- `Tab`: 查看完整拼圖
- `V`: 直接完成拼圖（測試專用）

## 注意

請確認圖片資源已正確存在於 `gui/ui/images/` 目錄下，否則遊戲可能無法正常載入圖片。
