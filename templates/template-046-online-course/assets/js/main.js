// T046 Online Course - Main JS
document.addEventListener('DOMContentLoaded', function() {
  const navbar = document.querySelector('.navbar');
  const scrollTop = document.querySelector('.scroll-top');
  window.addEventListener('scroll', function() {
    if (window.scrollY > 50) { navbar.classList.add('scrolled'); } else { navbar.classList.remove('scrolled'); }
    if (window.scrollY > 300) { scrollTop.classList.add('active'); } else { scrollTop.classList.remove('active'); }
  });
  if (scrollTop) { scrollTop.addEventListener('click', function() { window.scrollTo({ top: 0, behavior: 'smooth' }); }); }
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) { const offset = 80; const pos = target.getBoundingClientRect().top + window.pageYOffset - offset; window.scrollTo({ top: pos, behavior: 'smooth' }); }
    });
  });
  const filterBtns = document.querySelectorAll('.category-filter .btn');
  const courseItems = document.querySelectorAll('.course-item');
  filterBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      filterBtns.forEach(b => b.classList.remove('active'));
      this.classList.add('active');
      const filter = this.getAttribute('data-filter');
      courseItems.forEach(item => {
        if (filter === 'all' || item.classList.contains(filter)) { item.style.display = 'block'; item.style.animation = 'fadeInUp 0.5s ease'; }
        else { item.style.display = 'none'; }
      });
    });
  });
  const fadeEls = document.querySelectorAll('.fade-in');
  const obs = new IntersectionObserver(function(entries) { entries.forEach(entry => { if (entry.isIntersecting) { entry.target.classList.add('visible'); obs.unobserve(entry.target); } }); }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });
  fadeEls.forEach(el => obs.observe(el));
  const counters = document.querySelectorAll('.counter');
  const counterObs = new IntersectionObserver(function(entries) { entries.forEach(entry => { if (entry.isIntersecting) { const c = entry.target; const t = parseInt(c.getAttribute('data-target')); let cur = 0; const inc = t / 125; const upd = () => { cur += inc; if (cur < t) { c.textContent = Math.ceil(cur); requestAnimationFrame(upd); } else { c.textContent = t; } }; upd(); counterObs.unobserve(c); } }); }, { threshold: 0.5 });
  counters.forEach(c => counterObs.observe(c));
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      const btn = this.querySelector('button[type="submit"]');
      const orig = btn.textContent;
      btn.textContent = '處理中...'; btn.disabled = true;
      setTimeout(() => {
        const container = this.closest('.contact-form, .booking-form, .enroll-form') || this.parentElement;
        container.innerHTML = '<div class="text-center py-5"><i class="bi bi-check-circle-fill" style="font-size:4rem;color:#7c3aed;"></i><h3 class="mt-3">感謝您的詢問！</h3><p class="text-muted">我們已收到您的訊息，將盡快回覆您。</p></div>';
      }, 1500);
    });
  });
  const pricingToggle = document.getElementById('pricingToggle');
  if (pricingToggle) { pricingToggle.addEventListener('change', function() { document.querySelectorAll('.monthly-price').forEach(el => el.style.display = this.checked ? 'none' : 'block'); document.querySelectorAll('.yearly-price').forEach(el => el.style.display = this.checked ? 'block' : 'none'); }); }
  const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
  const navCollapse = document.querySelector('.navbar-collapse');
  navLinks.forEach(link => { link.addEventListener('click', () => { if (navCollapse.classList.contains('show')) navCollapse.classList.remove('show'); }); });
});
const style = document.createElement('style');
style.textContent = '@keyframes fadeInUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}';
document.head.appendChild(style);
