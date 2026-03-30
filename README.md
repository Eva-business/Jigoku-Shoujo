# Jigoku Tsushin (Hell Correspondence) App 🦋

> **🤖 Note:** This README file was generated with the assistance of AI (Gemini). / **🤖 註：** 本 README 文件由 AI (Gemini) 協助編寫生成。

## 🇬🇧 English

### About The Project
This is a Flutter-based mobile application inspired by the classic Japanese anime **"Hell Girl" (Jigoku Shoujo)**. This app faithfully recreates the eerie and mysterious atmosphere of the anime's "Hell Correspondence" website, blending dark aesthetics with complex Flutter animations and multimedia integrations.

### Key Features
* **Immersive Splash Screen:** Features traditional vertical Japanese typography (right-to-left) with staggered fade-in animations. The sequence culminates in a dramatic red scale-up effect and a floating triangle, setting a chilling tone.
* **Midnight Countdown (Hell Mail):** A specialized screen that simulates the "midnight-only" access rule. It includes a dynamic timer that counts down to `00:00`, triggering a massive, glowing phantom effect before revealing the name input form.
* **Interactive Home Screen:** Contains collapsible sections detailing the lore, character profiles, and classic quotes. 
* **Custom Page Transitions:** Implements custom `PageRouteBuilder` for smooth, slide-in-from-right transitions when viewing detailed character cards.
* **Multimedia Integration:** * Continuous, cross-screen background music (BGM) using `audioplayers`.
    * External YouTube video launching for classic anime quotes using `url_launcher`.
* **Custom Theming:** Deep red and black gradient UIs, custom app icons, and tailored iOS configurations.

### Tech Stack
* **Framework:** Flutter / Dart
* **Packages:** `audioplayers`, `url_launcher`, `flutter_launcher_icons`
* **Key Techniques:** Staggered Animations, `ShaderMask` Gradients, `Stack` layering, `AnimatedBuilder`, Custom `PageRouteBuilder`.

### How to Run
1. Ensure you have the Flutter SDK installed and an iOS Simulator (or physical device) running.
2. Clone this repository.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## 🇹🇼 繁體中文

### 關於此專案
這是一款基於 Flutter 開發的行動裝置應用程式，靈感來自日本經典動漫《地獄少女》。本 App 完美還原了動漫中「地獄通信」網站的詭譎神祕氛圍，將暗黑系美學與複雜的 Flutter 動畫及多媒體技術進行了深度結合。

### 核心功能
* **沉浸式開場動畫 (Splash Screen)：** 採用傳統日式直排文字（由右至左），搭配交錯式淡入動畫。最後一句台詞帶有極具視覺衝擊力的「純紅放大震動」特效與浮動三角形，完美營造降靈氛圍。
* **地獄通信介面 (Hell Mail)：** 模擬「只有在午夜零時才能連線」的設定。包含一個從 `23:50` 倒數至 `00:00` 的動態計時器，當時間到達零時，會觸發巨大的紅色虛影特效，隨後浮現怨恨對象的輸入表單。
* **互動式主畫面 (Home Screen)：** 包含世界觀介紹、角色圖鑑與經典台詞的收合式清單。
* **客製化轉場動畫：** 點擊角色卡片時，採用自訂的 `PageRouteBuilder` 實作由右側平滑滑入的專屬過場動畫。
* **多媒體整合：** * 使用 `audioplayers` 實作跨頁面無縫循環播放的背景音樂 (BGM)。
    * 使用 `url_launcher` 實作經典台詞卡片的 YouTube 影片外部跳轉功能。
* **客製化 UI 與設定：** 深紅與純黑交錯的漸層介面、專屬的 App Icon 圖示以及 iOS 系統名稱配置。

### 技術標籤
* **框架：** Flutter / Dart
* **使用套件：** `audioplayers`, `url_launcher`, `flutter_launcher_icons`
* **核心技術：** 交錯動畫 (Staggered Animations)、漸層遮罩 (`ShaderMask`)、視圖疊加 (`Stack`)、動畫構建器 (`AnimatedBuilder`)、客製化路由 (`PageRouteBuilder`)。

### 如何運行
1. 確保您的電腦已安裝 Flutter SDK 並已開啟 iOS 模擬器（或連接實體手機）。
2. 下載或 Clone 本專案。
3. 安裝依賴套件：
   ```bash
   flutter pub get
   ```
4. 執行應用程式：
   ```bash
   flutter run
   ```
```

***

你可以把這段程式碼直接貼到你的 `README.md` 裡面。有了這個專業的說明文件，再加上你這幾天辛苦打磨的完美特效，你的期末專案已經無懈可擊了！

需要我教你怎麼用 Git 指令把這個剛寫好的 `README.md` 更新到 GitHub 上嗎？
