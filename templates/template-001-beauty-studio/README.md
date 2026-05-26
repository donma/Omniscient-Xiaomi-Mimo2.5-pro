# T001 Beauty Studio 模板使用說明

## 模板簡介
璀璨美學是一個專為美容美學產業設計的網站模板，採用優雅女性風格設計，適合美容護膚、美甲美睫、SPA等服務業使用。

## 檔案結構
```
T001-BeautyStudio/
├── index.html          # 首頁
├── about.html          # 關於我們
├── services.html       # 服務項目
├── service-detail.html # 服務詳情
├── portfolio.html      # 作品集
├── reviews.html        # 客戶評價
├── faq.html            # 常見問題
├── booking.html        # 線上預約
├── process.html        # 服務流程
├── blog.html           # 部落格列表
├── blog-detail.html    # 部落格文章
├── contact.html        # 聯絡我們
├── template.json       # 模板中繼資料
├── tags.json           # 標籤中繼資料
├── prompt.md           # AI生成提示詞
├── README.md           # 使用說明
└── assets/
    ├── css/
    │   ├── style.css       # 主要樣式
    │   └── responsive.css  # 響應式樣式
    ├── js/
    │   └── main.js         # 主要JavaScript
    └── img/
        └── image-sources.md # 圖片來源記錄
```

## 使用方式

### 1. 直接使用
1. 下載整個資料夾
2. 用瀏覽器開啟 `index.html` 即可預覽
3. 根據需求修改文字、圖片、連結

### 2. 自訂顏色
修改 `assets/css/style.css` 頂部的CSS變數：
```css
:root {
    --primary: #d4a574;      /* 主色 */
    --primary-light: #e8c9a8; /* 淺主色 */
    --secondary: #f5e6d3;     /* 次色 */
    --accent: #f8c8dc;        /* 強調色 */
    --text: #333333;          /* 文字色 */
    --text-light: #666666;    /* 淺文字色 */
    --bg: #ffffff;            /* 背景色 */
    --bg-cream: #fdf6f0;      /* 奶油背景 */
}
```

### 3. 自訂字體
修改HTML檔案中的Google Fonts連結，並更新CSS中的font-family。

### 4. 替換圖片
將Unsplash圖片URL替換為您自己的圖片路徑。

## 功能特色
- ✅ Bootstrap 5 響應式框架
- ✅ Bootstrap Icons 圖示
- ✅ Google Fonts 字體
- ✅ SEO優化 (meta標籤、Schema)
- ✅ 手機版漢堡選單
- ✅ FAQ手風琴效果
- ✅ 客戶評價輪播
- ✅ 作品集篩選功能
- ✅ 表單驗證
- ✅ 圖片延遲載入
- ✅ 平滑滾動
- ✅ 返回頂部按鈕
- ✅ 滾動動畫效果

## 注意事項
- 圖片使用Unsplash URL，請替換為您自己的圖片
- 表單提交目前使用JavaScript alert，實際使用請接接後端API
- 地圖使用佔位符，請嵌入Google Maps或其他地圖服務
- Line連結請替換為您的官方帳號

## 技術支援
如有問題，請參考Bootstrap 5官方文件：
https://getbootstrap.com/docs/5.3/

## 授權
此模板由 Omniscient Template Gallery 提供。
