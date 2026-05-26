// gallery.js - 全職設計視角 Template Gallery
// data/templates.json 是唯一正式資料來源。
// fallbackTemplates 僅供本地 fetch 失敗時測試畫面，不是正式資料來源。
(function () {
  'use strict';

  const fallbackTemplates = [
    {
      "id": "template-001", "name": "Beauty Studio", "industry": "美容美學", "industryCategory": "美容健康",
      "colorTheme": "奶茶色", "previewImage": "assets/img/previews/template-001.jpg",
      "demoUrl": "templates/template-001-beauty-studio/index.html",
      "zipUrl": "", "hasZip": false, "promptUrl": "templates/template-001-beauty-studio/prompt.md",
      "tags": ["美容美學", "淺色系", "服務列表", "作品集", "FAQ", "Line 預約", "強 SEO"],
      "layoutType": "Landing Page", "imageRich": true
    },
    {
      "id": "template-002", "name": "Modern Restaurant", "industry": "餐廳美食", "industryCategory": "餐飲甜點",
      "colorTheme": "暖色", "previewImage": "assets/img/previews/template-002.jpg",
      "demoUrl": "templates/template-002-modern-restaurant/index.html",
      "zipUrl": "", "hasZip": false, "promptUrl": "templates/template-002-modern-restaurant/prompt.md",
      "tags": ["餐廳美食", "淺色系", "菜單分類", "訂位", "地圖區塊", "強 SEO"],
      "layoutType": "Landing Page", "imageRich": true
    },
    {
      "id": "template-003", "name": "Fashion Boutique", "industry": "時尚服飾", "industryCategory": "零售商品",
      "colorTheme": "黑白灰", "previewImage": "assets/img/previews/template-003.jpg",
      "demoUrl": "templates/template-003-fashion-boutique/index.html",
      "zipUrl": "", "hasZip": false, "promptUrl": "templates/template-003-fashion-boutique/prompt.md",
      "tags": ["時尚服飾", "深色系", "商品分類", "Instagram 連結", "強 SEO"],
      "layoutType": "商品型 Grid Catalog", "imageRich": true
    }
  ];

  let templates = [];
  let filteredTemplates = [];
  let activeFilters = { industryCategory: [], colorTheme: [], layoutType: [], tags: [] };
  let isListView = false;

  const $ = (sel) => document.querySelector(sel);
  const $$ = (sel) => document.querySelectorAll(sel);

  async function loadTemplates() {
    try {
      const resp = await fetch('data/templates.json');
      if (!resp.ok) throw new Error('fetch failed');
      templates = await resp.json();
    } catch (e) {
      if (typeof TEMPLATES_DATA !== 'undefined') {
        templates = TEMPLATES_DATA;
      } else {
        templates = fallbackTemplates;
      }
    }
    filteredTemplates = [...templates];
    buildFilters();
    renderTemplates();
  }

  function buildFilters() {
    const industries = new Set();
    const colors = new Set();
    const layouts = new Set();
    const features = new Set();

    templates.forEach(t => {
      if (t.industryCategory) industries.add(t.industryCategory);
      if (t.colorTheme) colors.add(t.colorTheme);
      if (t.layoutType) layouts.add(t.layoutType);
      if (t.tags) t.tags.forEach(tag => features.add(tag));
    });

    // Desktop sidebar
    renderFilterGroup('#industryFilters', [...industries], 'industryCategory');
    renderFilterGroup('#colorFilters', [...colors], 'colorTheme');
    renderFilterGroup('#layoutFilters', [...layouts], 'layoutType');
    renderFilterGroup('#featureFilters', [...features], 'tags');
    // Mobile drawer
    renderFilterGroup('#industryFiltersM', [...industries], 'industryCategory');
    renderFilterGroup('#colorFiltersM', [...colors], 'colorTheme');
    renderFilterGroup('#layoutFiltersM', [...layouts], 'layoutType');
    renderFilterGroup('#featureFiltersM', [...features], 'tags');
  }

  function renderFilterGroup(selector, items, filterKey) {
    const container = $(selector);
    if (!container) return;
    container.innerHTML = items.sort().map(item => `
      <label>
        <input type="checkbox" value="${item}" data-filter="${filterKey}">
        <span>${item}</span>
      </label>
    `).join('');

    container.querySelectorAll('input').forEach(cb => {
      cb.addEventListener('change', () => {
        const key = cb.dataset.filter;
        if (cb.checked) {
          activeFilters[key].push(cb.value);
        } else {
          activeFilters[key] = activeFilters[key].filter(v => v !== cb.value);
        }
        applyFilters();
      });
    });
  }

  function applyFilters() {
    filteredTemplates = templates.filter(t => {
      if (activeFilters.industryCategory.length && !activeFilters.industryCategory.includes(t.industryCategory)) return false;
      if (activeFilters.colorTheme.length && !activeFilters.colorTheme.includes(t.colorTheme)) return false;
      if (activeFilters.layoutType.length && !activeFilters.layoutType.includes(t.layoutType)) return false;
      if (activeFilters.tags.length && !activeFilters.tags.some(tag => t.tags && t.tags.includes(tag))) return false;
      return true;
    });
    renderTemplates();
    renderActiveFilters();
  }

  function renderActiveFilters() {
    const container = $('#activeFilters');
    if (!container) return;
    const allFilters = [];
    Object.keys(activeFilters).forEach(key => {
      activeFilters[key].forEach(val => allFilters.push({ key, val }));
    });
    container.innerHTML = allFilters.map(f =>
      `<span class="badge bg-primary">${f.val} <i class="bi bi-x"></i></span>`
    ).join('');

    container.querySelectorAll('.badge').forEach((badge, i) => {
      badge.addEventListener('click', () => {
        const f = allFilters[i];
        activeFilters[f.key] = activeFilters[f.key].filter(v => v !== f.val);
        const cb = document.querySelector(`input[data-filter="${f.key}"][value="${f.val}"]`);
        if (cb) cb.checked = false;
        applyFilters();
      });
    });
  }

  function renderTemplates() {
    const grid = $('#templateGrid');
    const noResults = $('#noResults');
    const count = $('#resultCount');
    if (!grid) return;

    count.textContent = filteredTemplates.length;

    if (filteredTemplates.length === 0) {
      grid.innerHTML = '';
      noResults.classList.remove('d-none');
      return;
    }
    noResults.classList.add('d-none');

    grid.className = isListView ? 'row g-4 template-grid list-view' : 'row g-4 template-grid';

    const colClass = isListView ? 'col-12' : 'col-sm-6 col-xl-4';

    grid.innerHTML = filteredTemplates.map(t => {
      const tagsHtml = (t.tags || []).slice(0, 5).map(tag => `<span class="tag">${tag}</span>`).join('');
      const zipBadge = t.hasZip
        ? '<span class="badge badge-zip">ZIP</span>'
        : '<span class="badge badge-zip-waiting">ZIP 待打包</span>';
      const imageBadge = t.imageRich ? '<span class="badge badge-image-rich">圖片豐富</span>' : '';
      const num = t.id.replace('template-', '');

      return `
        <div class="${colClass}">
          <div class="template-card">
            <div class="card-img-wrapper">
              <span class="card-number">${num}</span>
              <img src="${t.previewImage}" alt="${t.name} 預覽" loading="lazy"
                   onerror="this.style.display='none'">
              <div class="card-badges">
                <span class="badge badge-pages">12 Pages</span>
                <span class="badge badge-prompt">Prompt</span>
                ${zipBadge}
                ${imageBadge}
              </div>
            </div>
            <div class="card-body">
              <h3 class="card-title">${t.name}</h3>
              <p class="card-subtitle">${t.industryCategory || t.industry} / ${t.colorTheme} / ${t.layoutType || 'Landing Page'}</p>
              <div class="card-tags">${tagsHtml}</div>
              <div class="card-actions">
                <a href="${t.demoUrl}" target="_blank" class="btn btn-outline-primary"><i class="bi bi-eye"></i> 預覽</a>
                <a href="template-detail.html?id=${t.id}" class="btn btn-outline-secondary"><i class="bi bi-info-circle"></i> 詳情</a>
                <a href="${t.promptUrl}" target="_blank" class="btn btn-outline-purple" style="border-color:#6f42c1;color:#6f42c1"><i class="bi bi-file-text"></i> Prompt</a>
                ${t.hasZip ? `<a href="${t.zipUrl}" class="btn btn-success"><i class="bi bi-download"></i> ZIP</a>` : `<button class="btn btn-secondary" disabled><i class="bi bi-archive"></i> 待打包</button>`}
              </div>
            </div>
          </div>
        </div>`;
    }).join('');
  }

  function initViewToggle() {
    const btnGrid = $('#btnGrid');
    const btnList = $('#btnList');
    if (btnGrid) btnGrid.addEventListener('click', () => { isListView = false; renderTemplates(); });
    if (btnList) btnList.addEventListener('click', () => { isListView = true; renderTemplates(); });
  }

  function initClearFilters() {
    const clearFn = () => {
      activeFilters = { industryCategory: [], colorTheme: [], layoutType: [], tags: [] };
      $$('.filter-group input').forEach(cb => cb.checked = false);
      applyFilters();
    };
    const btn = $('#btnClearFilters');
    if (btn) btn.addEventListener('click', clearFn);
    const btnM = $('#btnClearFiltersM');
    if (btnM) btnM.addEventListener('click', clearFn);
  }

  function initFilterDrawer() {
    const overlay = $('#filterOverlay');
    const drawer = $('#filterDrawer');
    const btnOpen = $('#btnFilter');
    const btnClose = $('#btnCloseFilter');
    const btnApply = $('#btnApplyFilter');

    if (!overlay || !drawer || !btnOpen) return;

    function openDrawer() {
      overlay.classList.add('active');
      drawer.classList.add('active');
      document.body.style.overflow = 'hidden';
    }
    function closeDrawer() {
      overlay.classList.remove('active');
      drawer.classList.remove('active');
      document.body.style.overflow = '';
    }

    btnOpen.addEventListener('click', openDrawer);
    if (btnClose) btnClose.addEventListener('click', closeDrawer);
    overlay.addEventListener('click', closeDrawer);
    if (btnApply) btnApply.addEventListener('click', closeDrawer);
  }

  document.addEventListener('DOMContentLoaded', () => {
    initViewToggle();
    initClearFilters();
    initFilterDrawer();
    loadTemplates();
  });
})();
