# Omniscient Xiaomi Mimo 2.5 Pro

這是一個以靜態 HTML 為核心的網站樣板展示庫，提供多產業網站範本、樣板詳情頁、篩選式樣板列表，以及對應的 Prompt 與資料索引，方便設計師或開發者快速預覽、挑選、延伸修改並交付客戶。

> 註記：本專案內容整理 為使用 `Xiaomi Mimo 2.5 Pro` 撰寫。

> [線上展示](https://donma.github.io/Omniscient-Xiaomi-Mimo2.5-pro)

## 專案特色

- 靜態展示站，不依賴後端即可瀏覽樣板清單
- 首頁支援依產業、色系、版型、功能標籤進行篩選
- 提供樣板詳情頁，集中呈現頁面清單、標籤、SEO 結構與圖片策略
- `data/templates.json` 作為主要樣板資料來源
- `assets/js/data.js` 提供本地 `file://` 瀏覽時的 fallback 資料
- 每套樣板獨立存放於 `templates/` 下，便於單獨修改與交付
- 內含 PowerShell 產生腳本，可批次生成或整理樣板資料

## 目前內容

- 根目錄入口頁：`index.html`
- 樣板詳情頁：`template-detail.html`
- 樣板資料：`data/templates.json`
- 前端互動程式：`assets/js/gallery.js`
- 本地 fallback 資料：`assets/js/data.js`
- 樣板主目錄：`templates/`
- 下載輸出目錄：`downloads/`

從目前資料與目錄可看出，這個專案主要用途是作為多套企業形象站與品牌官網樣板的展示與管理介面，適合用於：

- 樣板選品與內部展示
- 客戶提案前的快速預覽
- 下載樣板後進行客製化修改
- 搭配 Prompt 進行 AI 輔助內容或版型延伸

## 目錄結構

```text
.
|-- index.html
|-- template-detail.html
|-- README.md
|-- assets/
|   |-- css/
|   |-- img/
|   `-- js/
|-- data/
|   `-- templates.json
|-- downloads/
`-- templates/
    |-- _gen-data.ps1
    |-- _generate-all.ps1
    |-- _generate-templates.ps1
    `-- template-xxx-*/
```

## 使用方式

### 1. 直接本機開啟

可直接開啟 `index.html` 瀏覽樣板列表。

若瀏覽器對本地 `fetch()` 有限制，前端會退回使用 `assets/js/data.js` 內嵌資料，確保畫面仍可展示。

### 2. 使用本機靜態伺服器

若要完整測試 `data/templates.json` 的讀取行為，建議使用任一靜態伺服器啟動專案根目錄，例如：

```powershell
python -m http.server 8000
```

啟動後開啟 `http://localhost:8000/`。

## 資料來源與運作方式

### 樣板列表頁

- `index.html` 載入畫面骨架與篩選 UI
- `assets/js/gallery.js` 負責讀取資料、建立篩選條件、切換 Grid/List 檢視、渲染樣板卡片
- 優先讀取 `data/templates.json`
- 若讀取失敗，退回 `assets/js/data.js` 的 `TEMPLATES_DATA`

### 樣板詳情頁

- `template-detail.html?id=template-001` 以查詢字串決定要顯示的樣板
- 依據樣板資料渲染預覽圖、頁面清單、標籤、Prompt 連結與 ZIP 狀態

### 樣板資料格式

每筆資料大致包含下列欄位：

- `id`
- `name`
- `industry`
- `industryCategory`
- `colorTheme`
- `previewImage`
- `demoUrl`
- `promptUrl`
- `tags`
- `layoutType`
- `pageCount`
- `pages`
- `description`
- `imagePolicy`

## 樣板維護

新增或更新樣板時，通常需要同步調整以下內容：

1. 在 `templates/` 下建立或更新對應樣板資料夾。
2. 更新 `data/templates.json` 中的樣板描述資料。
3. 視需要重新產出 `assets/js/data.js`，確保本地 fallback 資料同步。
4. 確認 `previewImage`、`demoUrl`、`promptUrl` 路徑正確。
5. 檢查 `template-detail.html` 是否能正確讀取與呈現該筆資料。

## 產生腳本

`templates/` 目錄內包含多個 PowerShell 腳本，用於批次產生樣板檔案與整理資料，例如：

- `templates/_gen-data.ps1`
- `templates/_generate-all.ps1`
- `templates/_generate-templates.ps1`

這些腳本顯示本專案不只是單純展示頁，也具備一定程度的樣板生產流程。

## 注意事項

- 樣板圖片多為示意用途，正式交付前應替換為自有或合法授權圖片
- `downloads/` 目前可作為 ZIP 或輸出檔案放置位置
- 部分樣板資料夾內含 `README.md`、`prompt.md`、`tags.json`、`template.json` 等輔助檔案
- 若要對外部署，可直接部署為靜態網站

## 授權與使用建議

若此專案將用於商業提案、客戶交付或公開販售，建議另外補充：

- 樣板授權範圍
- 圖片與字型授權說明
- 第三方資源來源
- 客製化交付流程

## 備註

專案頁面目前已有 `Powered by Mimo 2.5 Pro` 字樣；本次新增的根層 `README.md` 也已明確註記本文件為使用 `Xiaomi Mimo 2.5 Pro` 撰寫。
