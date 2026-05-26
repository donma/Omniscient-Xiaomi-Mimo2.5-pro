# 夜幕酒廊 Nightfall Lounge

高級調酒與現場音樂酒吧網站模板

## 模板特色

- 深色系設計搭配金色點綴，營造奢華夜晚氛圍
- 沉浸式Hero區，展示酒吧氛圍
- 完整的酒單服務展示
- 線上預約系統
- 賓客評價展示
- 品味專欄部落格

## 色彩方案

| 顏色 | 色碼 | 用途 |
|------|------|------|
| 主色調 | #0a0a0a | 背景、導航列 |
| 輔助色 | #d4af37 | 按鈕、標題裝飾 |
| 強調色 | #b8960f | Hover狀態 |
| 文字色 | #ffffff | 主要文字 |

## 字體

- **標題**: Playfair Display
- **內文**: Playfair Display

## 頁面列表

1. 首頁 (index.html)
2. 關於我們 (about.html)
3. 酒單服務 (services.html)
4. 服務詳情 (service-detail.html)
5. 空間實景 (portfolio.html)
6. 賓客評價 (reviews.html)
7. 常見問題 (faq.html)
8. 預約訂位 (booking.html)
9. 服務流程 (process.html)
10. 品味專欄 (blog.html)
11. 文章詳情 (blog-detail.html)
12. 聯絡我們 (contact.html)

## 技術架構

- **CSS框架**: Bootstrap 5.3.0
- **圖示庫**: Bootstrap Icons 1.11.0
- **字體**: Google Fonts
- **圖片**: Unsplash
- **JavaScript**: Vanilla JS

## 檔案結構

```
template-061-bar-lounge/
├── index.html
├── about.html
├── services.html
├── service-detail.html
├── portfolio.html
├── reviews.html
├── faq.html
├── booking.html
├── process.html
├── blog.html
├── blog-detail.html
├── contact.html
├── template.json
├── tags.json
├── prompt.md
├── README.md
└── assets/
    ├── css/
    │   ├── style.css
    │   └── responsive.css
    ├── js/
    │   └── main.js
    └── img/
        └── image-sources.md
```

## 使用方式

1. 下載模板檔案
2. 使用瀏覽器開啟 `index.html` 即可預覽
3. 根據需求修改內容與圖片
4. 上傳至您的網站伺服器

## 自訂修改

### 修改顏色

在 `assets/css/style.css` 的 `:root` 變數中修改：

```css
:root {
    --primary-dark: #0a0a0a;
    --primary-gold: #d4af37;
    --primary-gold-hover: #b8960f;
}
```

### 修改圖片

替換 `assets/img/` 目錄中的圖片，或修改HTML中的圖片URL。

### 修改內容

直接編輯HTML檔案中的文字內容即可。

## 注意事項

- 所有圖片來源為Unsplash，僅供展示使用
- 建議使用HTTPS協議載入外部資源
- 表單送出後顯示「感謝您的詢問」提示

## 授權條款

MIT License