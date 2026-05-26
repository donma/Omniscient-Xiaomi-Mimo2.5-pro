# T002 Modern Restaurant 模板使用說明

## 模板簡介
御膳坊是一個專為餐飲業設計的網站模板，採用溫暖食慾風格設計，適合中式料理、西式餐廳、美食餐廳等使用。

## 檔案結構
```
T002-ModernRestaurant/
├── index.html          # 首頁
├── about.html          # 關於我們
├── services.html       # 菜單
├── service-detail.html # 料理詳情
├── portfolio.html      # 美食相簿
├── reviews.html        # 食客評價
├── faq.html            # 常見問題
├── booking.html        # 線上訂位
├── process.html        # 出餐流程
├── blog.html           # 美食部落格
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
1. 下載整個資料夾
2. 用瀏覽器開啟 `index.html` 即可預覽
3. 根據需求修改文字、圖片、連結

## 自訂顏色
修改 `assets/css/style.css` 頂部的CSS變數：
```css
:root {
    --primary: #c0392b;      /* 主色紅 */
    --secondary: #2c3e50;    /* 次色深藍 */
    --gold: #d4a843;         /* 金色 */
    --bg-dark: #1a1a1a;      /* 深色背景 */
}
```

## 功能特色
- ✅ Bootstrap 5 響應式框架
- ✅ 視差滾動效果
- ✅ SEO優化 (Schema標記)
- ✅ 手機版漢堡選單
- ✅ 表單驗證
- ✅ 滾動動畫效果

## 注意事項
- 圖片使用Unsplash URL，請替換為您自己的圖片
- 表單提交目前使用JavaScript alert，實際使用請接後端API
- 地圖使用佔位符，請嵌入Google Maps