# Generates high-quality prompt.md files for every template directory.

$ErrorActionPreference = "Stop"

$templatesRoot = $PSScriptRoot
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$regexOptions = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline

$standardPageOrder = @(
    "index.html",
    "about.html",
    "services.html",
    "service-detail.html",
    "portfolio.html",
    "reviews.html",
    "faq.html",
    "booking.html",
    "process.html",
    "blog.html",
    "blog-detail.html",
    "contact.html",
    "appointment.html",
    "treatments.html",
    "before-after.html",
    "doctors.html",
    "technology.html",
    "pricing.html",
    "consultation.html",
    "testimonials.html",
    "mission.html",
    "impact.html",
    "projects.html",
    "team.html",
    "donate.html",
    "volunteer.html",
    "schedule.html",
    "speakers.html",
    "venue.html",
    "sponsors.html",
    "tickets.html",
    "register.html",
    "map.html",
    "artists.html",
    "exhibition.html",
    "gallery.html",
    "press.html",
    "visitor-info.html",
    "cv.html",
    "commission.html",
    "statement.html",
    "episode-detail.html",
    "episodes.html",
    "guest.html",
    "hosts.html",
    "book-detail.html",
    "books.html",
    "resources.html",
    "newsletter.html",
    "topics.html",
    "coaching.html",
    "skills.html",
    "success-stories.html",
    "course-detail.html",
    "courses.html",
    "enroll.html",
    "instructors.html",
    "trial.html",
    "classes.html",
    "events.html",
    "philosophy.html",
    "herbs.html",
    "health-tips.html",
    "clients.html",
    "media.html",
    "membership.html",
    "style-guide.html",
    "methodology.html",
    "inquiry.html",
    "categories.html",
    "shop.html",
    "equipment.html"
)

$pagePurposeMap = @{
    "index.html" = "首頁：建立第一印象，包含 hero、核心賣點、代表性內容區塊、轉換 CTA 與完整 footer。"
    "about.html" = "關於頁：介紹品牌背景、理念、團隊、專業優勢與信任建立內容。"
    "services.html" = "服務總覽頁：整理主要服務、方案、功能或產品分類，方便比較與導流。"
    "service-detail.html" = "服務詳情頁：深度說明單一服務的價值、流程、對象、FAQ 與 CTA。"
    "portfolio.html" = "案例/作品頁：呈現精選案例、作品成果、情境照片或實績展示。"
    "reviews.html" = "評價頁：整理客戶見證、推薦內容、成果回饋與信任背書。"
    "faq.html" = "FAQ 頁：用手風琴或條列方式解答常見問題，降低諮詢門檻。"
    "booking.html" = "預約/諮詢頁：提供表單、預約流程、方案說明與行動呼籲。"
    "process.html" = "流程頁：清楚說明合作步驟、服務節點、時間安排與交付方式。"
    "blog.html" = "文章列表頁：整理內容分類、精選文章卡片與延伸閱讀 CTA。"
    "blog-detail.html" = "文章內頁：完整文章版型，含標題、摘要、內文、圖片、相關文章。"
    "contact.html" = "聯絡頁：提供表單、聯絡資訊、地圖、社群與聯絡 CTA。"
    "appointment.html" = "預約頁：提供服務預約表單、可選項目、注意事項與成功訊息。"
    "treatments.html" = "療程/項目頁：整理療程內容、功效、對象與比較資訊。"
    "before-after.html" = "成果對比頁：展示前後對照、案例說明與信任元素。"
    "doctors.html" = "醫師/專家頁：介紹專業人員、專長、經歷、證照與照片。"
    "technology.html" = "技術設備頁：介紹技術優勢、儀器特色、流程與安全性。"
    "pricing.html" = "價格頁：用清楚方案卡、比較表與 FAQ 呈現收費邏輯。"
    "consultation.html" = "諮詢頁：提供需求填寫、服務說明、預期流程與 CTA。"
    "testimonials.html" = "見證頁：展示推薦語、故事、成果與社會證明。"
    "mission.html" = "使命頁：說明品牌使命、願景、價值觀與行動方向。"
    "impact.html" = "影響力頁：用數據、故事、專案成果與圖表呈現影響力。"
    "projects.html" = "專案頁：展示進行中的重點計畫、成果與參與方式。"
    "team.html" = "團隊頁：完整介紹團隊成員、角色分工、背景與照片。"
    "donate.html" = "捐款頁：說明支持方式、用途、方案與捐款 CTA。"
    "volunteer.html" = "志工頁：介紹參與方式、角色內容、流程與報名 CTA。"
    "schedule.html" = "議程頁：清楚列出活動時程、場次主題、講者與時間資訊。"
    "speakers.html" = "講者頁：介紹講者陣容、主題、頭像與背景資料。"
    "venue.html" = "場地頁：說明會場資訊、交通、設施、動線與地圖。"
    "sponsors.html" = "贊助頁：介紹合作夥伴、贊助方案、Logo 展示與 CTA。"
    "tickets.html" = "票券頁：整理票種、價格、權益、購票流程與 FAQ。"
    "register.html" = "報名頁：提供完整報名表單、票券說明與注意事項。"
    "map.html" = "地圖頁：提供位置地圖、交通建議與周邊資訊。"
    "artists.html" = "藝術家頁：介紹創作者、作品風格與代表作。"
    "exhibition.html" = "展覽頁：說明展覽主題、亮點、展區與時間資訊。"
    "gallery.html" = "圖庫頁：以高質感圖片牆展示作品、空間或活動內容。"
    "press.html" = "媒體頁：整理新聞露出、媒體報導與下載素材。"
    "visitor-info.html" = "參觀資訊頁：提供時間、票價、交通、參觀須知。"
    "cv.html" = "履歷頁：以個人品牌風格呈現經歷、技能、服務與成果。"
    "commission.html" = "委託頁：說明委託流程、報價邏輯、交付內容與 CTA。"
    "statement.html" = "聲明/理念頁：說明創作觀點、立場、品牌理念或重要聲明。"
    "episode-detail.html" = "單集詳情頁：展示節目單集資訊、摘要、來賓與收聽 CTA。"
    "episodes.html" = "節目列表頁：整理單集卡片、主題分類與播放入口。"
    "guest.html" = "來賓頁：介紹受訪者、背景與精華內容。"
    "hosts.html" = "主持人頁：介紹主持人背景、風格與代表內容。"
    "book-detail.html" = "書籍詳情頁：介紹單一本書、重點內容、章節亮點與購買 CTA。"
    "books.html" = "書籍列表頁：展示出版作品、分類與推薦內容。"
    "resources.html" = "資源頁：整理可下載素材、工具、指南或延伸閱讀。"
    "newsletter.html" = "電子報頁：說明訂閱價值、內容類型與訂閱表單。"
    "topics.html" = "主題頁：整理主題分類、內容索引與延伸連結。"
    "coaching.html" = "教練服務頁：說明 coaching 方案、適合對象、流程與 CTA。"
    "skills.html" = "技能頁：整理能力項目、方法論、服務範圍與成果。"
    "success-stories.html" = "成功故事頁：展示客戶轉變、案例歷程與成果數據。"
    "course-detail.html" = "課程詳情頁：完整介紹課程內容、大綱、對象、講師與 CTA。"
    "courses.html" = "課程列表頁：整理課程分類、特色與報名導流。"
    "enroll.html" = "報名頁：提供課程報名表單、方案與注意事項。"
    "instructors.html" = "講師頁：展示講師背景、專長與授課風格。"
    "trial.html" = "試上/體驗頁：提供體驗方案、流程與報名 CTA。"
    "classes.html" = "班級/課表頁：整理時段、班別、課程內容與報名入口。"
    "events.html" = "活動頁：介紹活動類型、時程、亮點與報名 CTA。"
    "philosophy.html" = "理念頁：說明品牌哲學、價值觀與方法。"
    "herbs.html" = "草本/藥材頁：介紹品項、功效、使用方式與圖文內容。"
    "health-tips.html" = "健康知識頁：以文章型內容提供建議與實用資訊。"
    "clients.html" = "客戶頁：展示合作客戶、品牌案例與信任證明。"
    "media.html" = "媒體頁：整理影音、訪談、新聞或品牌素材。"
    "membership.html" = "會員頁：說明會員權益、方案與加入 CTA。"
    "style-guide.html" = "風格頁：整理品牌風格、選品方向或穿搭/設計指南。"
    "methodology.html" = "方法論頁：說明做法、流程、系統與核心邏輯。"
    "inquiry.html" = "詢價頁：提供需求表單、報價流程與聯繫說明。"
    "categories.html" = "分類頁：用導覽式版面整理主要分類內容。"
    "shop.html" = "商店頁：展示商品列表、分類與購買導向。"
    "equipment.html" = "設備頁：介紹器材、規格、優勢與應用情境。"
}

$slugLabelOverrides = @{
    "ai" = "AI"
    "saas" = "SaaS"
    "seo" = "SEO"
    "hr" = "HR"
    "bnb" = "BnB"
    "app" = "App"
    "qa" = "QA"
    "ui" = "UI"
    "ux" = "UX"
}

function Normalize-Text {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return ""
    }

    $text = [string]$Value
    $text = $text -replace "`r?`n", " "
    $text = $text -replace "\s+", " "
    return $text.Trim()
}

function Clean-HtmlText {
    param([AllowNull()][string]$Html)

    if ([string]::IsNullOrWhiteSpace($Html)) {
        return ""
    }

    $text = $Html -replace "(?i)<br\s*/?>", " / "
    $text = $text -replace "<[^>]+>", " "
    $text = [System.Net.WebUtility]::HtmlDecode($text)
    return Normalize-Text $text
}

function Get-FirstRegexValue {
    param(
        [string]$Content,
        [string]$Pattern
    )

    if ([string]::IsNullOrWhiteSpace($Content)) {
        return ""
    }

    $match = [System.Text.RegularExpressions.Regex]::Match($Content, $Pattern, $regexOptions)
    if (-not $match.Success) {
        return ""
    }

    return Clean-HtmlText $match.Groups[1].Value
}

function Get-UniqueOrderedStrings {
    param([object[]]$Items)

    $seen = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $result = [System.Collections.Generic.List[string]]::new()

    foreach ($item in $Items) {
        $text = Normalize-Text $item
        if ([string]::IsNullOrWhiteSpace($text)) {
            continue
        }

        if ($seen.Add($text)) {
            [void]$result.Add($text)
        }
    }

    return $result.ToArray()
}

function Get-TemplateId {
    param([string]$FolderName)

    if ($FolderName -match "template-(\d{3})") {
        return "T$($Matches[1])"
    }

    return $FolderName
}

function Normalize-TemplateId {
    param(
        [string]$RawId,
        [string]$FolderName
    )

    $raw = Normalize-Text $RawId
    if ($raw -match '^T\d{3}$') {
        return $raw
    }

    if ($raw -match '^template-(\d{3})$') {
        return "T$($Matches[1])"
    }

    return Get-TemplateId $FolderName
}

function Convert-SlugToTitle {
    param([string]$Slug)

    if ([string]::IsNullOrWhiteSpace($Slug)) {
        return ""
    }

    $words = $Slug -split "-"
    $parts = foreach ($word in $words) {
        $lower = $word.ToLowerInvariant()
        if ($slugLabelOverrides.ContainsKey($lower)) {
            $slugLabelOverrides[$lower]
            continue
        }

        if ($lower.Length -le 2) {
            $lower.ToUpperInvariant()
            continue
        }

        (Get-Culture).TextInfo.ToTitleCase($lower)
    }

    return ($parts -join " ")
}

function Get-Pages {
    param(
        [object]$TemplateData,
        [System.IO.DirectoryInfo]$Directory
    )

    $pages = @()

    if ($null -ne $TemplateData -and $TemplateData.PSObject.Properties.Name -contains "pages") {
        foreach ($page in @($TemplateData.pages)) {
            $pageText = Normalize-Text $page
            if (-not [string]::IsNullOrWhiteSpace($pageText)) {
                $pages += $pageText
            }
        }
    }

    $actualPages = Get-ChildItem -LiteralPath $Directory.FullName -Filter "*.html" | ForEach-Object { $_.Name }
    $pages += $actualPages

    $pages = Get-UniqueOrderedStrings $pages
    $orderLookup = @{}
    for ($i = 0; $i -lt $standardPageOrder.Count; $i++) {
        $orderLookup[$standardPageOrder[$i]] = $i
    }

    return $pages | Sort-Object {
        if ($orderLookup.ContainsKey($_)) { $orderLookup[$_] } else { 1000 }
    }, {
        $_
    }
}

function Get-Fonts {
    param(
        [object]$TemplateData,
        [string]$IndexHtml
    )

    $fonts = @()

    if ($null -ne $TemplateData -and $TemplateData.PSObject.Properties.Name -contains "fonts") {
        $fontValue = $TemplateData.fonts

        if ($fontValue -is [System.Array]) {
            $fonts += @($fontValue)
        } elseif ($fontValue -is [string]) {
            $fonts += $fontValue
        } elseif ($null -ne $fontValue -and $null -ne $fontValue.PSObject) {
            foreach ($prop in $fontValue.PSObject.Properties) {
                $fonts += $prop.Value
            }
        }
    }

    if (-not $fonts.Count -and -not [string]::IsNullOrWhiteSpace($IndexHtml)) {
        $fontPattern = "family=([^:&`"'>]+)"
        $matches = [System.Text.RegularExpressions.Regex]::Matches($IndexHtml, $fontPattern, $regexOptions)
        foreach ($match in $matches) {
            $font = [System.Net.WebUtility]::UrlDecode($match.Groups[1].Value)
            $font = $font -replace "\+", " "
            $font = $font -replace ":.*$", ""
            $fonts += $font
        }
    }

    return Get-UniqueOrderedStrings $fonts
}

function Get-Colors {
    param(
        [object]$TemplateData,
        [string]$CssContent
    )

    $colors = [ordered]@{}
    $preferredOrder = @("primary", "secondary", "accent", "dark", "light", "text", "background", "bg", "primary-dark", "primary-light", "accent-dark", "accent-light")

    if ($null -ne $TemplateData -and $TemplateData.PSObject.Properties.Name -contains "colors") {
        $colorValue = $TemplateData.colors
        if ($null -ne $colorValue -and $null -ne $colorValue.PSObject) {
            foreach ($prop in $colorValue.PSObject.Properties) {
                $name = Normalize-Text $prop.Name
                $value = Normalize-Text $prop.Value
                if (-not [string]::IsNullOrWhiteSpace($name) -and -not [string]::IsNullOrWhiteSpace($value)) {
                    $colors[$name] = $value
                }
            }
        }
    }

    if (-not $colors.Count -and -not [string]::IsNullOrWhiteSpace($CssContent)) {
        $matches = [System.Text.RegularExpressions.Regex]::Matches($CssContent, "--([a-zA-Z0-9\-]+)\s*:\s*([^;}`r`n]+)")
        foreach ($match in $matches) {
            $name = Normalize-Text $match.Groups[1].Value
            $value = Normalize-Text $match.Groups[2].Value
            if ($value -match "^(#|rgb\(|rgba\(|hsl\(|hsla\(|linear-gradient\()") {
                $colors[$name] = ($value.TrimEnd('}')).Trim()
            }
        }
    }

    $orderedNames = [System.Collections.Generic.List[string]]::new()
    foreach ($name in $preferredOrder) {
        if ($colors.Contains($name)) {
            [void]$orderedNames.Add($name)
        }
    }

    foreach ($name in $colors.Keys) {
        if (-not $orderedNames.Contains($name)) {
            [void]$orderedNames.Add($name)
        }
    }

    $result = [ordered]@{}
    foreach ($name in $orderedNames | Select-Object -First 8) {
        $result[$name] = $colors[$name]
    }

    return $result
}

function Get-Features {
    param(
        [object]$TemplateData,
        [string[]]$Pages
    )

    $features = @()

    if ($null -ne $TemplateData -and $TemplateData.PSObject.Properties.Name -contains "features") {
        $features += @($TemplateData.features)
    }

    $features += "Responsive Design"

    if ($Pages -contains "faq.html") { $features += "FAQ Accordion" }
    if ($Pages -contains "booking.html" -or $Pages -contains "register.html" -or $Pages -contains "consultation.html" -or $Pages -contains "contact.html") { $features += "Lead Form" }
    if ($Pages -contains "blog.html") { $features += "Blog / Content Hub" }
    if ($Pages -contains "portfolio.html" -or $Pages -contains "gallery.html") { $features += "Portfolio / Gallery" }
    if ($Pages -contains "reviews.html" -or $Pages -contains "testimonials.html") { $features += "Testimonials" }
    if ($Pages -contains "pricing.html" -or $Pages -contains "tickets.html") { $features += "Pricing / Packages" }

    return Get-UniqueOrderedStrings $features
}

function Get-HomeHeadings {
    param([string]$IndexHtml)

    if ([string]::IsNullOrWhiteSpace($IndexHtml)) {
        return @()
    }

    $items = @()
    foreach ($pattern in @("<h2[^>]*>(.*?)</h2>", "<h3[^>]*>(.*?)</h3>", "<h4[^>]*>(.*?)</h4>")) {
        $matches = [System.Text.RegularExpressions.Regex]::Matches($IndexHtml, $pattern, $regexOptions)
        foreach ($match in $matches) {
            $heading = Clean-HtmlText $match.Groups[1].Value
            if ($heading.Length -ge 2 -and $heading.Length -le 80) {
                $items += $heading
            }
        }
    }

    return (Get-UniqueOrderedStrings $items | Select-Object -First 8)
}

function Get-NavMap {
    param([string]$IndexHtml)

    $map = [ordered]@{}

    if ([string]::IsNullOrWhiteSpace($IndexHtml)) {
        return $map
    }

    $navMatch = [System.Text.RegularExpressions.Regex]::Match($IndexHtml, '<nav\b.*?</nav>', $regexOptions)
    if (-not $navMatch.Success) {
        return $map
    }

    $linkMatches = [System.Text.RegularExpressions.Regex]::Matches($navMatch.Value, '<a\b[^>]*href="([^"]+)"[^>]*>(.*?)</a>', $regexOptions)
    foreach ($match in $linkMatches) {
        $href = Normalize-Text $match.Groups[1].Value
        $label = Clean-HtmlText $match.Groups[2].Value
        if ([string]::IsNullOrWhiteSpace($href) -or [string]::IsNullOrWhiteSpace($label)) {
            continue
        }
        if ($href.StartsWith("http", [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }
        if ($href.StartsWith("#")) {
            continue
        }
        $fileName = [System.IO.Path]::GetFileName($href)
        if ([string]::IsNullOrWhiteSpace($fileName)) {
            continue
        }
        if (-not $map.Contains($fileName)) {
            $map[$fileName] = $label
        }
    }

    return $map
}

function Get-VisualKeywords {
    param(
        [string]$Slug,
        [string]$Name,
        [string]$Category,
        [string]$Description
    )

    $text = ($Slug, $Name, $Category, $Description -join " ").ToLowerInvariant()

    if ($text -match "ai|saas|app|cloud|cyber|system|conference|tech|software") {
        return @("科技未來", "高對比", "俐落幾何", "數位產品感")
    }
    if ($text -match "logistics|manufacturing|industrial|building|repair") {
        return @("工業專業", "穩定可靠", "強結構感", "效率導向")
    }
    if ($text -match "accounting|law|insurance|consulting|clinic|dental|medical|hr") {
        return @("專業信任", "秩序感", "清楚資訊層級", "商務穩重")
    }
    if ($text -match "beauty|spa|aesthetic|fragrance|pilates|yoga") {
        return @("高級感", "精緻留白", "柔和質感", "品牌美學")
    }
    if ($text -match "restaurant|coffee|bakery|tea|dessert|gift|bookstore|stationery|pet|toy|hotpot|farm|brand|shop") {
        return @("生活風格", "品牌敘事", "圖片導向", "溫度感")
    }
    if ($text -match "hotel|bnb|travel|camping|surf|spring") {
        return @("沉浸體驗", "大圖視覺", "情境導向", "旅宿氛圍")
    }
    if ($text -match "portfolio|artist|illustrator|creator|author|podcast|speaker") {
        return @("個人品牌", "編輯感", "內容驅動", "作品導向")
    }
    if ($text -match "school|kindergarten|course|music|dance|cooking|parent|child|nonprofit") {
        return @("人本溫度", "清楚導引", "故事感", "親和可信")
    }

    return @("現代感", "一致性", "高完成度", "清楚 CTA")
}

function Get-FirstNonEmpty {
    param([object[]]$Values)

    foreach ($value in $Values) {
        $text = Normalize-Text $value
        if (-not [string]::IsNullOrWhiteSpace($text)) {
            return $text
        }
    }

    return ""
}

function Get-PageRequirementLine {
    param(
        [string]$Page,
        [hashtable]$NavMap
    )

    $purpose = if ($pagePurposeMap.ContainsKey($Page)) { $pagePurposeMap[$Page] } else { "請依檔名語意與整體品牌脈絡補齊完整內頁內容與 CTA。" }

    if ($NavMap.ContainsKey($Page)) {
        $label = $NavMap[$Page]
        return "- $Page：導覽文案為「$label」。$purpose 如果檔名與實際頁面定位略有差異，請以導覽文案與整體樣板脈絡優先。"
    }

    return "- $Page：$purpose"
}

function Get-TemplateMetadata {
    param([System.IO.DirectoryInfo]$Directory)

    $templateJsonPath = Join-Path $Directory.FullName "template.json"
    $indexPath = Join-Path $Directory.FullName "index.html"
    $stylePath = Join-Path $Directory.FullName "assets\css\style.css"

    $templateData = $null
    if (Test-Path -LiteralPath $templateJsonPath) {
        $templateData = Get-Content -LiteralPath $templateJsonPath -Raw | ConvertFrom-Json
    }

    $indexHtml = if (Test-Path -LiteralPath $indexPath) { Get-Content -LiteralPath $indexPath -Raw } else { "" }
    $styleCss = if (Test-Path -LiteralPath $stylePath) { Get-Content -LiteralPath $stylePath -Raw } else { "" }

    $folderSlug = $Directory.Name -replace "^template-\d{3}-", ""
    $templateIdFromJson = if ($null -ne $templateData) { $templateData.id } else { $null }
    $templateNameLocalized = $null
    $templateNameEnglish = $null
    $templateCategoryValue = $null
    $templateIndustryCategoryValue = $null
    $templateIndustryValue = $null
    $templateDescriptionValue = $null
    $templateFrameworkValue = $null

    if ($null -ne $templateData) {
        $templateIdFromJson = $templateData.id
        $templateNameEnglish = $templateData.name
        $templateCategoryValue = $templateData.category
        $templateIndustryCategoryValue = $templateData.industryCategory
        $templateIndustryValue = $templateData.industry
        $templateFrameworkValue = $templateData.framework

        if ($templateData.PSObject.Properties.Name -contains "name_zh") {
            $templateNameLocalized = $templateData.name_zh
        } elseif ($templateData.PSObject.Properties.Name -contains "nameTW") {
            $templateNameLocalized = $templateData.nameTW
        }

        if ($templateData.PSObject.Properties.Name -contains "description_zh") {
            $templateDescriptionValue = $templateData.description_zh
        } else {
            $templateDescriptionValue = $templateData.description
        }
    }

    $templateId = Normalize-TemplateId -RawId $templateIdFromJson -FolderName $Directory.Name
    $siteTitle = Get-FirstRegexValue $indexHtml '<title>(.*?)</title>'
    $metaDescription = Get-FirstRegexValue $indexHtml '<meta[^>]+name="description"[^>]+content="([^"]+)"'
    $heroH1 = Get-FirstRegexValue $indexHtml '<h1[^>]*>(.*?)</h1>'
    $brandName = ""
    if ($siteTitle -match "\|") {
        $brandName = Normalize-Text ($siteTitle.Split("|")[0])
    }
    if ([string]::IsNullOrWhiteSpace($brandName)) {
        $brandName = Get-FirstRegexValue $indexHtml '<a[^>]*class="[^"]*navbar-brand[^"]*"[^>]*>(.*?)</a>'
    }

    $name = Get-FirstNonEmpty @(
        $templateNameLocalized,
        $templateNameEnglish,
        $brandName,
        (Convert-SlugToTitle $folderSlug)
    )

    $category = Get-FirstNonEmpty @(
        $templateCategoryValue,
        $templateIndustryCategoryValue,
        $templateIndustryValue,
        (Convert-SlugToTitle $folderSlug)
    )

    $description = Get-FirstNonEmpty @(
        $templateDescriptionValue,
        $metaDescription,
        $siteTitle,
        "$name 網站樣板"
    )

    $framework = Get-FirstNonEmpty @(
        $templateFrameworkValue,
        "Bootstrap 5"
    )

    return [pscustomobject]@{
        Directory = $Directory
        TemplateId = $templateId
        Name = $name
        Category = $category
        Description = $description
        Framework = $framework
        SiteTitle = $siteTitle
        MetaDescription = $metaDescription
        HeroH1 = $heroH1
        BrandName = $brandName
        Pages = @(Get-Pages -TemplateData $templateData -Directory $Directory)
        Fonts = @(Get-Fonts -TemplateData $templateData -IndexHtml $indexHtml)
        Colors = Get-Colors -TemplateData $templateData -CssContent $styleCss
        Features = @(Get-Features -TemplateData $templateData -Pages (Get-Pages -TemplateData $templateData -Directory $Directory))
        HomeHeadings = @(Get-HomeHeadings -IndexHtml $indexHtml)
        NavMap = Get-NavMap -IndexHtml $indexHtml
        FolderSlug = $folderSlug
        VisualKeywords = @(Get-VisualKeywords -Slug $folderSlug -Name $name -Category $category -Description $description)
    }
}

function Build-PromptContent {
    param([pscustomobject]$Meta)

    $displayName = $Meta.Name
    if (-not [string]::IsNullOrWhiteSpace($Meta.BrandName) -and $Meta.BrandName -ne $Meta.Name) {
        $displayName = "$($Meta.Name) / $($Meta.BrandName)"
    }

    $promptTitle = "$($Meta.TemplateId) $($Meta.Name) Prompt"
    $pageRequirementLines = foreach ($page in $Meta.Pages) {
        Get-PageRequirementLine -Page $page -NavMap $Meta.NavMap
    }

    $colorLines = foreach ($entry in $Meta.Colors.GetEnumerator()) {
        "- $($entry.Key)：$($entry.Value)"
    }
    if (-not $colorLines) {
        $colorLines = @("- 請根據此樣板現有視覺維持一致配色，避免自行更換主色調。"
        )
    }

    $fontLines = if ($Meta.Fonts.Count) {
        foreach ($font in $Meta.Fonts) { "- $font" }
    } else {
        @("- 請延續樣板的 Google Fonts 與 Bootstrap 5 視覺語氣，維持同等質感。"
        )
    }

    $featureLines = foreach ($feature in $Meta.Features) { "- $feature" }
    $headingLines = if ($Meta.HomeHeadings.Count) {
        foreach ($heading in $Meta.HomeHeadings) { "- $heading" }
    } else {
        @(
            "- Hero 主視覺",
            "- 服務/特色區塊",
            "- 社會證明或案例",
            "- 明確 CTA 與 footer"
        )
    }

    $navLines = if ($Meta.NavMap.Count) {
        foreach ($entry in $Meta.NavMap.GetEnumerator()) {
            "- $($entry.Key) -> $($entry.Value)"
        }
    } else {
        @("- 請依頁面清單建立清楚的主導覽與 CTA。"
        )
    }

    $fileListLines = @(
        "- assets/css/style.css",
        "- assets/css/responsive.css",
        "- assets/js/main.js"
    )
    foreach ($page in $Meta.Pages) {
        $fileListLines += "- $page"
    }

    $visualKeywords = $Meta.VisualKeywords -join "、"
    $siteTitleLine = if ([string]::IsNullOrWhiteSpace($Meta.SiteTitle)) { "- 首頁 title 請依品牌與產業寫出同等質感的 SEO 標題。" } else { "- 首頁 title 參考：$($Meta.SiteTitle)" }
    $heroLine = if ([string]::IsNullOrWhiteSpace($Meta.HeroH1)) { "- Hero 主標請寫出能代表此產業的高轉換繁中標題。" } else { "- Hero 主標方向：$($Meta.HeroH1)" }
    $metaLine = if ([string]::IsNullOrWhiteSpace($Meta.MetaDescription)) { "- Meta description 請依服務價值與信任感撰寫。" } else { "- Meta description 參考：$($Meta.MetaDescription)" }

    $lines = [System.Collections.Generic.List[string]]::new()
    [void]$lines.Add("# $promptTitle")
    [void]$lines.Add("")
    [void]$lines.Add("複製下面整段提示詞給任何網站生成型 AI，即可生成與這套樣板同等結構、視覺語言與完成度的完整網站：")
    [void]$lines.Add("")
    [void]$lines.Add('```text')
    [void]$lines.Add('你是一位頂尖品牌策略師、UI/UX 設計師與前端工程師。請直接生成一套「可交付、可本機直接開啟、可作為客戶提案或正式網站基底」的完整多頁靜態網站專案，高精度重現以下樣板的資訊架構、版面節奏、色彩系統、元件風格與內容調性。')
    [void]$lines.Add("")
    [void]$lines.Add('【硬性要求】')
    [void]$lines.Add('- 必須使用 HTML5 + Bootstrap 5 + 原生 CSS + 原生 JavaScript。')
    [void]$lines.Add('- 不可使用 React、Vue、Next.js、Tailwind、TypeScript、打包工具或任何需要編譯的框架。')
    [void]$lines.Add('- 所有頁面都要能以靜態檔案直接開啟，導覽與 CTA 連結必須互相對應。')
    [void]$lines.Add('- 全站內容請使用繁體中文，不可使用 lorem ipsum、假文或只寫標題不寫內容。')
    [void]$lines.Add('- 請一次輸出完整專案，不要只做首頁，不要省略任何頁面。')
    [void]$lines.Add('- 請先輸出完整檔案樹，再逐一輸出每個檔案的完整內容。')
    [void]$lines.Add('- 所有頁面都要具備完整 SEO：title、meta description、Open Graph、適合產業的 JSON-LD Schema、語意化 HTML、圖片 alt。')
    [void]$lines.Add('- 必須完整支援桌機、平板、手機，手機版需要可用的漢堡選單與合理間距。')
    [void]$lines.Add("")
    [void]$lines.Add('【樣板定位】')
    [void]$lines.Add("- 樣板 ID：$($Meta.TemplateId)")
    [void]$lines.Add("- 網站主題：$displayName")
    [void]$lines.Add("- 產業分類：$($Meta.Category)")
    [void]$lines.Add("- 核心描述：$($Meta.Description)")
    [void]$lines.Add("- 技術框架：$($Meta.Framework)")
    [void]$lines.Add($siteTitleLine)
    [void]$lines.Add($heroLine)
    [void]$lines.Add($metaLine)
    [void]$lines.Add("- 視覺關鍵字：$visualKeywords")
    [void]$lines.Add("")
    [void]$lines.Add('【固定輸出檔案】')
    foreach ($line in $fileListLines) { [void]$lines.Add($line) }
    [void]$lines.Add("")
    [void]$lines.Add('【主導覽參考】')
    foreach ($line in $navLines) { [void]$lines.Add($line) }
    [void]$lines.Add("")
    [void]$lines.Add('【首頁必備區塊】')
    [void]$lines.Add('- 需要有強烈 hero 區塊、品牌價值主張、代表性內容區塊、信任元素與明確 CTA。')
    [void]$lines.Add('- 請保留與此樣板一致的首頁節奏與敘事順序，不要改成通用企業模板。')
    [void]$lines.Add('- 參考首頁區塊標題與主題如下：')
    foreach ($line in $headingLines) { [void]$lines.Add($line) }
    [void]$lines.Add("")
    [void]$lines.Add('【每個頁面的內容職責】')
    foreach ($line in $pageRequirementLines) { [void]$lines.Add($line) }
    [void]$lines.Add("")
    [void]$lines.Add('【視覺系統】')
    [void]$lines.Add('- 請嚴格沿用此樣板的色彩關係，不可任意改掉品牌主色。')
    foreach ($line in $colorLines) { [void]$lines.Add($line) }
    [void]$lines.Add('- 請沿用或等價重現以下字體組合與字重層級：')
    foreach ($line in $fontLines) { [void]$lines.Add($line) }
    [void]$lines.Add('- 請保留與樣板一致的卡片樣式、按鈕語氣、區塊留白、圓角、陰影、背景層次與圖片使用方式。')
    [void]$lines.Add('- 如果此樣板偏深色、精品、科技、工業或生活風格，請完整延續，不要改成平庸的通用 SaaS/企業版型。')
    [void]$lines.Add("")
    [void]$lines.Add('【功能與互動】')
    [void]$lines.Add('- 請把下列功能做成可用的前端互動，而不是只做靜態外觀：')
    foreach ($line in $featureLines) { [void]$lines.Add($line) }
    [void]$lines.Add('- FAQ 頁或 FAQ 區塊請做可展開收合。')
    [void]$lines.Add('- 表單頁請有欄位、狀態、送出後成功訊息與基本驗證。')
    [void]$lines.Add('- 如果樣板屬於作品、活動、課程、產品或文章型網站，請補齊合理的卡片列表與詳情頁內容。')
    [void]$lines.Add("")
    [void]$lines.Add('【內容生成規則】')
    [void]$lines.Add('- 全站文案必須具備真實感，符合該產業，不要空泛，不要只有一句話。')
    [void]$lines.Add('- 若首頁或導覽顯示某些檔名實際對應其他內容定位，請以實際頁面角色優先，但檔名保持不變。')
    [void]$lines.Add('- 請為每一頁補齊對應的段落、清單、CTA、表單欄位、案例內容、FAQ 與社會證明。')
    [void]$lines.Add('- 請使用與此品牌/產業一致的圖片主題，可用合法授權圖片網址或可替換的高品質佔位圖。')
    [void]$lines.Add('- 每張圖片都要有具描述性的 alt。')
    [void]$lines.Add("")
    [void]$lines.Add('【輸出格式】')
    [void]$lines.Add('- 先輸出完整檔案樹。')
    [void]$lines.Add('- 再依序輸出每個檔案的完整內容。')
    [void]$lines.Add('- 每個檔案都要用清楚的檔名標題與程式碼區塊包起來。')
    [void]$lines.Add('- 不要只輸出概要、設計說明或 TODO。我要的是完整可直接落地的網站專案。')
    [void]$lines.Add('```')

    return ($lines -join "`r`n")
}

$templateDirectories = Get-ChildItem -LiteralPath $templatesRoot -Directory | Where-Object { $_.Name -like "template-*" } | Sort-Object Name
$updated = 0

foreach ($directory in $templateDirectories) {
    $meta = Get-TemplateMetadata -Directory $directory
    $content = Build-PromptContent -Meta $meta
    $promptPath = Join-Path $directory.FullName "prompt.md"
    [System.IO.File]::WriteAllText($promptPath, $content, $utf8NoBom)
    $updated++
    "Updated: $($directory.Name)\prompt.md"
}

"Total prompt files written: $updated"
