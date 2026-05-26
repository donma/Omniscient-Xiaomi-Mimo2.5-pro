# Master Template Generator - T061-T075
$ErrorActionPreference = "Continue"
$basePath = "D:\AI_PROJECTS\OmniscientPublic\fullsite-template-gallery\templates"

function Write-File($path, $content) {
    $dir = Split-Path $path -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
}

function Get-Nav($active, $brand, $slug) {
    $pages = @(
        @{file="index.html";label="首頁"},
        @{file="about.html";label="關於"},
        @{file="services.html";label="服務"},
        @{file="portfolio.html";label="作品"},
        @{file="reviews.html";label="評價"},
        @{file="blog.html";label="部落格"},
        @{file="contact.html";label="聯絡"}
    )
    $links = ""
    foreach ($p in $pages) {
        $cls = if($p.file -eq $active){' active'}else{''}
        $links += "          <li class=`"nav-item`"><a class=`"nav-link$cls`" href=`"$($p.file)`">$($p.label)</a></li>`n"
    }
    return $links
}

function Get-Footer($t) {
    return @"
  <footer class="footer">
    <div class="container">
      <div class="row g-4">
        <div class="col-lg-4">
          <div class="footer-brand">$($t.brand)</div>
          <p class="footer-text">$($t.desc)</p>
          <div class="d-flex gap-3 mt-3">
            <a href="#" class="text-gold fs-5"><i class="bi bi-instagram"></i></a>
            <a href="#" class="text-gold fs-5"><i class="bi bi-facebook"></i></a>
            <a href="#" class="text-gold fs-5"><i class="bi bi-line"></i></a>
          </div>
        </div>
        <div class="col-lg-2 col-md-4">
          <h4 class="footer-title">導覽</h4>
          <a href="about.html" class="footer-link">關於我們</a>
          <a href="services.html" class="footer-link">服務</a>
          <a href="portfolio.html" class="footer-link">作品</a>
          <a href="blog.html" class="footer-link">部落格</a>
        </div>
        <div class="col-lg-3 col-md-4">
          <h4 class="footer-title">服務</h4>
          <a href="booking.html" class="footer-link">線上預約</a>
          <a href="faq.html" class="footer-link">常見問題</a>
          <a href="process.html" class="footer-link">服務流程</a>
        </div>
        <div class="col-lg-3 col-md-4">
          <h4 class="footer-title">聯絡</h4>
          <p class="footer-text"><i class="bi bi-geo-alt text-gold me-2"></i>$($t.address)</p>
          <p class="footer-text"><i class="bi bi-telephone text-gold me-2"></i>$($t.phone)</p>
          <p class="footer-text"><i class="bi bi-envelope text-gold me-2"></i>$($t.email)</p>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 $($t.brand). All Rights Reserved.</p>
      </div>
    </div>
  </footer>
"@
}

function Get-Head($title, $desc, $ogImg, $t) {
    $fontFamily = $t.fonts[0] -replace ' ','+'
    $fontUrl = "https://fonts.googleapis.com/css2?family=$fontFamily:wght@400;700&family=Inter:wght@300;400;600&display=swap"
    return @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title | $($t.brand)</title>
  <meta name="description" content="$desc">
  <meta property="og:title" content="$title | $($t.brand)">
  <meta property="og:description" content="$desc">
  <meta property="og:type" content="website">
  <meta property="og:image" content="https://images.unsplash.com/$ogImg?w=1200">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
  <link href="$fontUrl" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
  <link href="assets/css/responsive.css" rel="stylesheet">
</head>
"@
}

function Get-Navbar($active, $t) {
    $nav = Get-Nav $active $t.brand $t.slug
    return @"
  <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.html">$($t.brand)</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
$nav          <li class="nav-item"><a class="btn btn-gold btn-sm ms-3" href="booking.html">預約</a></li>
        </ul>
      </div>
    </div>
  </nav>
"@
}

function Get-PageHeader($title, $subtitle, $parent, $parentLabel) {
    $breadcrumb = ""
    if ($parent) {
        $breadcrumb = @"
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">首頁</a></li>
          <li class="breadcrumb-item"><a href="$parent">$parentLabel</a></li>
          <li class="breadcrumb-item active">$title</li>
        </ol>
"@
    } else {
        $breadcrumb = @"
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">首頁</a></li>
          <li class="breadcrumb-item active">$title</li>
        </ol>
"@
    }
    return @"
  <section class="page-header">
    <div class="container">
      <nav aria-label="breadcrumb">$breadcrumb</nav>
      <h1>$title</h1>
      <p class="text-muted">$subtitle</p>
    </div>
  </section>
"@
}

function Get-Schema($t) {
    return @"
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "$($t.schemaType)",
    "name": "$($t.brand)",
    "description": "$($t.desc)",
    "image": "https://images.unsplash.com/$($t.ogImg)?w=1200",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "$($t.address)"
    },
    "telephone": "$($t.phone)",
    "email": "$($t.email)"
  }
  </script>
"@
}

function Get-Scripts() {
    return @"
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="assets/js/main.js"></script>
</body>
</html>
"@
}

# ============================================================
# GENERATE ALL FILES FOR EACH TEMPLATE
# ============================================================

$templateList = @(
  @{
    slug="template-061-bar-lounge"; id="T061"; name="Bar & Lounge"; brand="NOIR LOUNGE"
    cat="restaurant"; desc="Dark moody bar with gold accents"
    colors=@{primary="#0a0a0a";secondary="#d4af37";accent="#1a1a1a";text="#f5f5f5";bg="#0a0a0a"}
    fonts=@("Playfair Display","Inter")
    tags=@("bar","lounge","cocktails","nightlife","restaurant","dark-theme","gold","luxury")
    industry=@("food-beverage","hospitality"); style=@("dark","moody","luxury","elegant")
    heroImg="photo-1470337458703-46ad1756a187"; ogImg="photo-1470337458703-46ad1756a187"
    heroTitle="夜晚的<br>奢華饗宴"; heroSub="在昏黃燈光下，品味經典與創新交融的調酒藝術"
    heroCta1="立即訂位"; heroCta2="瀏覽酒單"
    phone="+886 2 2771 2345"; address="台北市大安區忠孝東路四段200號"
    email="hello@noirlounge.com"; hours="週二至週日 18:00 - 02:00"
    schemaType="BarOrPub"; priceRange="$$$$"
    sectionIds=@("cocktails","events","reservation","gallery")
    sectionTitles=@("招牌雞尾酒","近期活動","預約您的夜晚","空間氛圍")
    heroCta1Link="booking.html"; heroCta2Link="portfolio.html"
  },
  @{
    slug="template-062-brunch-cafe"; id="T062"; name="Brunch Cafe"; brand="晨光咖啡"
    cat="restaurant"; desc="Bright cream brunch cafe"
    colors=@{primary="#fdf6ec";secondary="#e8a87c";accent="#fff9f0";text="#3d2c1e";bg="#fdf6ec"}
    fonts=@("Lora","Inter")
    tags=@("brunch","cafe","coffee","breakfast","restaurant","warm","cozy")
    industry=@("food-beverage","hospitality"); style=@("bright","warm","cozy","natural")
    heroImg="photo-1495474472287-4d71bcdd2085"; ogImg="photo-1495474472287-4d71bcdd2085"
    heroTitle="晨光中的<br>美味時光"; heroSub="用一份豐盛的早午餐，開啟美好的一天"
    heroCta1="查看菜單"; heroCta2="預約座位"
    phone="+886 2 2345 6789"; address="台北市信義區松仁路100號"
    email="hello@morninglight.cafe"; hours="每日 08:00 - 17:00"
    schemaType="CafeOrCoffeeShop"; priceRange="$$"
    sectionIds=@("menu","space","story","reservation")
    sectionTitles=@("精選菜單","舒適空間","我們的故事","預約座位")
    heroCta1Link="services.html"; heroCta2Link="booking.html"
  },
  @{
    slug="template-063-japanese-restaurant"; id="T063"; name="Japanese Restaurant"; brand="侘寂"
    cat="restaurant"; desc="Zen minimal Japanese restaurant"
    colors=@{primary="#1a1a1a";secondary="#8b0000";accent="#f5f0e8";text="#f5f0e8";bg="#1a1a1a"}
    fonts=@("Noto Serif TC","Inter")
    tags=@("japanese","restaurant","omakase","sushi","zen","minimal","elegant")
    industry=@("food-beverage","hospitality"); style=@("zen","minimal","elegant","traditional")
    heroImg="photo-1579871494447-9811cf80d66c"; ogImg="photo-1579871494447-9811cf80d66c"
    heroTitle="一期一會<br>的料理哲學"; heroSub="以當季食材，演繹日本料理的精髓"
    heroCta1="預約體驗"; heroCta2="了解主廚"
    phone="+886 2 2567 8901"; address="台北市中山區中山北路二段50號"
    email="info@wabisabi.jp"; hours="週二至週日 12:00-14:30, 18:00-21:30"
    schemaType="Restaurant"; priceRange="$$$$"
    sectionIds=@("omakase","chef","sake","reservation")
    sectionTitles=@("Omakase 體驗","主廚介紹","日本酒搭配","預約席位")
    heroCta1Link="booking.html"; heroCta2Link="about.html"
  },
  @{
    slug="template-064-hotpot-restaurant"; id="T064"; name="Hotpot Restaurant"; brand="鼎鍋"
    cat="restaurant"; desc="Warm red hotpot restaurant"
    colors=@{primary="#c0392b";secondary="#f39c12";accent="#fff5f5";text="#2c2c2c";bg="#fff5f5"}
    fonts=@("Noto Sans TC","Inter")
    tags=@("hotpot","restaurant","chinese","fire-pot","warm","family")
    industry=@("food-beverage","hospitality"); style=@("warm","vibrant","family","traditional")
    heroImg="photo-1569718212165-3a8278d5f624"; ogImg="photo-1569718212165-3a8278d5f624"
    heroTitle="暖心暖胃<br>火鍋饗宴"; heroSub="嚴選頂級食材，熬煮濃郁湯底，圍爐共享美好時光"
    heroCta1="瀏覽菜單"; heroCta2="立即訂位"
    phone="+886 2 2789 0123"; address="台北市大安區敦化南路一段200號"
    email="order@dingpot.com"; hours="每日 11:30 - 23:00"
    schemaType="Restaurant"; priceRange="$$"
    sectionIds=@("soup-bases","sets","combo","reservation")
    sectionTitles=@("湯底選擇","套餐推薦","加購優惠","線上訂位")
    heroCta1Link="services.html"; heroCta2Link="booking.html"
  },
  @{
    slug="template-065-dessert-studio"; id="T065"; name="Dessert Studio"; brand="甜蜜工坊"
    cat="retail"; desc="Sweet pink dessert studio"
    colors=@{primary="#fce4ec";secondary="#f48fb1";accent="#fff0f5";text="#4a2040";bg="#fce4ec"}
    fonts=@("Playfair Display","Inter")
    tags=@("dessert","bakery","cake","pastry","sweets","studio","pink")
    industry=@("food-beverage","retail"); style=@("sweet","elegant","feminine","playful")
    heroImg="photo-1488477181946-6428a0291777"; ogImg="photo-1488477181946-6428a0291777"
    heroTitle="每一口<br>都是甜蜜"; heroSub="手工製作的精緻甜點，為生活增添一抹幸福色彩"
    heroCta1="瀏覽甜點"; heroCta2="客製訂購"
    phone="+886 2 2345 6789"; address="台北市信義區松壽路10號"
    email="order@sweetstudio.com"; hours="每日 10:00 - 21:00"
    schemaType="Bakery"; priceRange="$$"
    sectionIds=@("desserts","custom","wedding","reservation")
    sectionTitles=@("招牌甜點","客製訂購","婚禮蛋糕","預約到店")
    heroCta1Link="portfolio.html"; heroCta2Link="booking.html"
  },
  @{
    slug="template-066-fragrance-brand"; id="T066"; name="Fragrance Brand"; brand="MOUSSE"
    cat="retail"; desc="Luxe minimal fragrance brand"
    colors=@{primary="#ffffff";secondary="#d4af37";accent="#fafafa";text="#1a1a1a";bg="#ffffff"}
    fonts=@("Cormorant","Inter")
    tags=@("fragrance","perfume","luxury","scent","beauty","minimal")
    industry=@("beauty","retail"); style=@("luxury","minimal","elegant","sophisticated")
    heroImg="photo-1541643600914-78b084683601"; ogImg="photo-1541643600914-78b084683601"
    heroTitle="捕捉<br>無形之美"; heroSub="每一款香氛，都是一段嗅覺的詩篇"
    heroCta1="探索系列"; heroCta2="品牌理念"
    phone="+886 2 2567 8901"; address="台北市信義區信義路五段7號"
    email="hello@mousse.parfum"; hours="週一至週六 11:00 - 20:00"
    schemaType="Organization"; priceRange="$$$$"
    sectionIds=@("collections","notes","philosophy","contact")
    sectionTitles=@("香氛系列","香調結構","品牌哲學","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="about.html"
  },
  @{
    slug="template-067-furniture-brand"; id="T067"; name="Furniture Brand"; brand="木研"
    cat="retail"; desc="Architectural furniture brand"
    colors=@{primary="#f5f5f5";secondary="#8b7355";accent="#ebe6df";text="#2c2c2c";bg="#f5f5f5"}
    fonts=@("Montserrat","Inter")
    tags=@("furniture","design","interior","wood","modern","architectural")
    industry=@("home","retail"); style=@("architectural","modern","clean","natural")
    heroImg="photo-1555041469-a586c61ea9bc"; ogImg="photo-1555041469-a586c61ea9bc"
    heroTitle="為生活<br>打造質感"; heroSub="每一件家具，都是空間與生活的完美對話"
    heroCta1="瀏覽系列"; heroCta2="到店體驗"
    phone="+886 2 2876 5432"; address="台北市內湖區行愛路100號"
    email="info@muyan.design"; hours="週一至週日 10:00 - 19:00"
    schemaType="Organization"; priceRange="$$$"
    sectionIds=@("collections","inspiration","materials","contact")
    sectionTitles=@("精選系列","空間靈感","材料工藝","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="contact.html"
  },
  @{
    slug="template-068-home-decor-select"; id="T068"; name="Home Decor Select"; brand="拾光"
    cat="retail"; desc="Magazine-style home decor select shop"
    colors=@{primary="#faf8f5";secondary="#6b5b4a";accent="#f0ebe3";text="#2c2c2c";bg="#faf8f5"}
    fonts=@("Playfair Display","Inter")
    tags=@("home-decor","interior","lifestyle","curated","magazine","select-shop")
    industry=@("home","retail"); style=@("magazine","editorial","curated","warm")
    heroImg="photo-1586023492125-27b2c045efd7"; ogImg="photo-1586023492125-27b2c045efd7"
    heroTitle="拾起<br>生活的美好"; heroSub="精選來自世界各地的生活美學物件"
    heroCta1="新品上市"; heroCta2="風格指南"
    phone="+886 2 2345 6789"; address="台北市大安區永康街15號"
    email="hello@shiguang.life"; hours="每日 11:00 - 20:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("picks","new-arrivals","style-guides","contact")
    sectionTitles=@("編輯精選","新品上市","風格指南","聯絡我們")
    heroCta1Link="portfolio.html"; heroCta2Link="blog.html"
  },
  @{
    slug="template-069-garden-plants"; id="T069"; name="Garden & Plants"; brand="綠意"
    cat="retail"; desc="Natural green garden and plants"
    colors=@{primary="#e8f5e9";secondary="#4caf50";accent="#f1f8e9";text="#1b3a1b";bg="#e8f5e9"}
    fonts=@("Noto Serif TC","Inter")
    tags=@("garden","plants","botanical","green","nursery","ecological")
    industry=@("garden","retail"); style=@("natural","fresh","botanical","eco")
    heroImg="photo-1416879595882-3373a0480b5b"; ogImg="photo-1416879595882-3373a0480b5b"
    heroTitle="讓綠意<br>走進生活"; heroSub="從一株植物開始，打造屬於你的城市花園"
    heroCta1="植物分類"; heroCta2="養護指南"
    phone="+886 2 2876 5432"; address="台北市士林區至善路二段280號"
    email="hello@greenlife.garden"; hours="每日 09:00 - 18:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("categories","care","workshops","contact")
    sectionTitles=@("植物分類","養護指南","工作坊","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="process.html"
  },
  @{
    slug="template-070-pet-supplies"; id="T070"; name="Pet Supplies"; brand="毛孩樂園"
    cat="retail"; desc="Playful pet supplies"
    colors=@{primary="#fff3e0";secondary="#ff9800";accent="#fff8e1";text="#4a3520";bg="#fff3e0"}
    fonts=@("Nunito","Inter")
    tags=@("pet","supplies","dog","cat","animals","pet-shop","playful")
    industry=@("pet","retail"); style=@("playful","warm","friendly","fun")
    heroImg="photo-1587300003388-59208cc962cb"; ogImg="photo-1587300003388-59208cc962cb"
    heroTitle="毛孩的<br>快樂天堂"; heroSub="精選優質寵物用品，給毛孩最好的呵護"
    heroCta1="熱銷商品"; heroCta2="寵物照護"
    phone="+886 2 2345 6789"; address="台北市松山区八德路四段100號"
    email="woof@petparadise.com"; hours="每日 10:00 - 21:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("categories","bestsellers","tips","contact")
    sectionTitles=@("商品分類","熱銷排行","寵物照護","聯絡我們")
    heroCta1Link="portfolio.html"; heroCta2Link="blog.html"
  },
  @{
    slug="template-071-parent-child-space"; id="T071"; name="Parent-Child Space"; brand="親子星球"
    cat="education"; desc="Soft pastel parent-child space"
    colors=@{primary="#fce4ec";secondary="#e1bee7";accent="#f3e5f5";text="#4a2040";bg="#fce4ec"}
    fonts=@("Nunito","Inter")
    tags=@("parent-child","kids","family","education","play","activities")
    industry=@("education","family"); style=@("soft","pastel","playful","friendly")
    heroImg="photo-1503454537195-1dcabb73ffb9"; ogImg="photo-1503454537195-1dcabb73ffb9"
    heroTitle="親子共創<br>美好時光"; heroSub="安全有趣的空間，讓孩子在遊戲中學習成長"
    heroCta1="活動方案"; heroCta2="場地預約"
    phone="+886 2 2567 8901"; address="台北市信義區松仁路50號"
    email="hello@parentchild.space"; hours="週二至週日 09:00 - 18:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("programs","facilities","birthday","contact")
    sectionTitles=@("活動方案","場地設施","生日派對","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="booking.html"
  },
  @{
    slug="template-072-toy-store"; id="T072"; name="Toy Store"; brand="玩具王國"
    cat="retail"; desc="Vibrant colorful toy store"
    colors=@{primary="#ff6b6b";secondary="#ffd93d";accent="#fff5f5";text="#2c2c2c";bg="#ffffff"}
    fonts=@("Fredoka One","Inter")
    tags=@("toys","kids","children","play","store","colorful","fun")
    industry=@("retail","children"); style=@("vibrant","colorful","playful","fun")
    heroImg="photo-1566576912321-d58ddd7a6088"; ogImg="photo-1566576912321-d58ddd7a6088"
    heroTitle="歡迎來到<br>玩具王國"; heroSub="精選全球優質玩具，點燃孩子的想像力"
    heroCta1="年齡分類"; heroCta2="禮物推薦"
    phone="+886 2 2789 0123"; address="台北市中正區公園路10號"
    email="play@toyskingdom.com"; hours="每日 10:00 - 21:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("age-groups","bestsellers","gifts","contact")
    sectionTitles=@("年齡分類","暢銷排行","禮物推薦","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="portfolio.html"
  },
  @{
    slug="template-073-stationery-store"; id="T073"; name="Stationery Store"; brand="紙上風景"
    cat="retail"; desc="Paper clean stationery store"
    colors=@{primary="#faf8f5";secondary="#7c6f5a";accent="#f0ebe3";text="#2c2c2c";bg="#faf8f5"}
    fonts=@("Noto Serif TC","Inter")
    tags=@("stationery","paper","notebook","pen","journal","office")
    industry=@("retail","office"); style=@("clean","paper","editorial","warm")
    heroImg="photo-1586281380349-632531db7ed4"; ogImg="photo-1586281380349-632531db7ed4"
    heroTitle="書寫<br>生活的美好"; heroSub="精選質感文具，讓書寫成為一種享受"
    heroCta1="商品分類"; heroCta2="店員推薦"
    phone="+886 2 2345 6789"; address="台北市大安區師大路50號"
    email="hello@paperscape.com"; hours="每日 10:30 - 21:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("categories","picks","brands","contact")
    sectionTitles=@("商品分類","店員推薦","品牌專區","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="portfolio.html"
  },
  @{
    slug="template-074-bookstore"; id="T074"; name="Bookstore"; brand="書店時光"
    cat="retail"; desc="Warm literary bookstore"
    colors=@{primary="#f4e9d9";secondary="#6f4e37";accent="#faf3e8";text="#2c1810";bg="#f4e9d9"}
    fonts=@("Lora","Inter")
    tags=@("bookstore","books","literature","reading","library","culture")
    industry=@("retail","culture"); style=@("warm","literary","editorial","cozy")
    heroImg="photo-1507842217343-583bb7270b66"; ogImg="photo-1507842217343-583bb7270b66"
    heroTitle="在書頁中<br>遇見世界"; heroSub="每一本書都是一扇窗，帶你看見不同的風景"
    heroCta1="新書推薦"; heroCta2="讀書會"
    phone="+886 2 2567 8901"; address="台北市大安區青田街5號"
    email="read@booktime.com"; hours="每日 10:00 - 22:00"
    schemaType="Organization"; priceRange="$$"
    sectionIds=@("staff-picks","new-arrivals","book-club","contact")
    sectionTitles=@("店員推薦","新書上市","讀書會","聯絡我們")
    heroCta1Link="portfolio.html"; heroCta2Link="services.html"
  },
  @{
    slug="template-075-camping-brand"; id="T075"; name="Camping Brand"; brand="山野"
    cat="retail"; desc="Outdoor earth camping brand"
    colors=@{primary="#1b4332";secondary="#40916c";accent="#d8f3dc";text="#d8f3dc";bg="#1b4332"}
    fonts=@("Oswald","Inter")
    tags=@("camping","outdoor","hiking","adventure","gear","nature")
    industry=@("outdoor","retail"); style=@("outdoor","earthy","adventure","rugged")
    heroImg="photo-1504280390367-361c6d9f38f4"; ogImg="photo-1504280390367-361c6d9f38f4"
    heroTitle="走向山野<br>擁抱自然"; heroSub="專業戶外裝備，陪你征服每一座山峰"
    heroCta1="裝備系列"; heroCta2="露營指南"
    phone="+886 2 2876 5432"; address="台北市信義區松德路100號"
    email="hello@shanwild.com"; hours="週一至週六 11:00 - 20:00"
    schemaType="Organization"; priceRange="$$$"
    sectionIds=@("gear","guides","destinations","contact")
    sectionTitles=@("裝備系列","露營指南","推薦營地","聯絡我們")
    heroCta1Link="services.html"; heroCta2Link="process.html"
  }
)

Write-Output "Starting generation of $($templateList.Count) templates..."
