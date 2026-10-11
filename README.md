# NanoKVM-USB cheap alternative
MS2130 USB3.0视频采集卡 (RMB17.1) + CH9329F+CH340UART/TTL串口转USB HID全键盘鼠标 (RMB17)
比 NanoKVM-USB 便宜很多，缺點是，
1. CH9329F 的 baud rate 固定為 9600 8N1 比 NanoKVM-USB 的 57600 慢，mouse 移動可能比較不順，官方 sipeed usbkvm 軟體使用 57600 baud rate，所以不能直接使用 官方 sipeed usbkvm 軟體。
2. HOST 需要兩個 USB A port 或使用 hub

# NanoKVM-USB 9600 單一 HTML 版本

此分支將瀏覽器 KVM 用戶端整合為單一原生 HTML 檔案。原本使用 React、
Vite、TypeScript、Tailwind CSS、Ant Design 與 Jotai 的前端，已改寫為
`index.html` 內的原生 HTML、CSS 與 JavaScript。

本版本沒有套件相依性、外部執行階段資源、CDN 資源或建置步驟，可直接透過
任何靜態網頁伺服器提供服務。

## 功能

- USB 視訊與音訊裝置的權限請求、偵測、選擇及重新連線
- 解析度、自訂解析度、縮放與旋轉控制
- 使用既有 HID 封包格式，可選擇 9600 或 57600 baud 透過 Web Serial 通訊
- 實體鍵盤、剪貼簿輸入、快捷鍵與虛擬鍵盤
- 絕對與相對滑鼠模式、Pointer Lock、觸控手勢、滾輪、游標樣式與滑鼠防休眠
- 使用 File System Access API 儲存 WebM 錄影
- 全螢幕、鍵盤鎖定、可拖曳工具列與響應式版面
- 十種介面語言
- 透過 `localStorage` 延續既有偏好設定與自訂快捷鍵

## 系統需求

- 支援 Web Serial 的桌面版 Chrome 或其他 Chromium 核心瀏覽器
- 安全來源：正式環境使用 HTTPS，開發環境可使用 `localhost`
- USB 視訊擷取裝置及相容的 9600 或 57600 baud 序列 HID 裝置

不支援 Web Serial 的瀏覽器仍可顯示視訊，但無法轉送鍵盤與滑鼠輸入。
File System Access 與鍵盤鎖定功能是否可用，也取決於瀏覽器支援程度。

## 傳輸速率選擇

選擇序列埠裝置前，可在連線視窗中選擇 `9600` 或 `57600` baud：

- CH9329F 搭配 CH340 的 USB HID 裝置請選擇 `9600`。
- 原版 NanoKVM-USB 或其他使用 57600 baud 的相容裝置請選擇 `57600`。

應用程式預設使用 `9600`，並會透過 `localStorage` 保存最後一次選擇。序列埠
連線後如需切換速率，請點擊工具列上的序列埠圖示，選擇新的速率，再按下
「重新連接序列埠裝置」。設定值必須與硬體的實際 baud rate 相同，否則鍵盤與
滑鼠資料將無法正常傳送。

## 本機執行

在儲存庫根目錄啟動任一靜態 HTTP 伺服器，例如：

```shell
python3 -m http.server 8080
```

接著使用桌面版 Chrome 或 Chromium 開啟
[http://localhost:8080](http://localhost:8080)，並允許相機存取權限。完成授權後
會自動連接視訊裝置，再依提示選擇序列埠裝置。

或是使用 `file://` 網址直接開啟 `index.html`，建議使用 Chrome。注意 相機、麥克風、剪貼簿、
File System Access、全螢幕及 Web Serial 功能都需要安全的瀏覽器執行環境。

## GitHub Pages

此單一 HTML 版本會從 `html-version` 分支的根目錄部署至 GitHub Pages：

[https://sabgkang.github.io/NanoKVM-USB9600/](https://sabgkang.github.io/NanoKVM-USB9600/)

GitHub Pages 預設使用 HTTPS，符合相機、麥克風與 Web Serial 所需的安全來源
條件。請使用桌面版 Chrome 或 Chromium 開啟頁面。

## 部署

將 `index.html` 上傳至任一靜態網站主機，並透過 HTTPS 提供服務。不需要安裝
Node.js，也不需要執行前端建置。正式環境的入口維持為 `/index.html`。

Nginx 設定範例：

```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;
}
```

## 從 Vite 版本遷移

應用程式狀態與瀏覽器整合已改用原生 DOM 事件及集中式 JavaScript 狀態物件。
樣式、圖示、翻譯資料與應用程式邏輯皆內嵌於 `index.html`。

本版本不再使用 `pnpm install`、`pnpm dev` 或 `pnpm build`。如需修改應用程式，
直接編輯 `index.html`，再重新載入靜態頁面即可。
