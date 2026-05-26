/* T011 Dental Clinic - Main JavaScript */

document.addEventListener('DOMContentLoaded', function() {
  const toggler = document.querySelector('.navbar-toggler');
  const navCollapse = document.querySelector('.navbar-collapse');
  if (toggler) {
    toggler.addEventListener('click', () => navCollapse.classList.toggle('show'));
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth < 992) navCollapse.classList.remove('show');
      });
    });
  }

  document.querySelectorAll('.faq-dental .faq-question').forEach(q => {
    q.addEventListener('click', function() {
      const item = this.closest('.faq-item');
      const wasActive = item.classList.contains('active');
      document.querySelectorAll('.faq-dental .faq-item').forEach(i => i.classList.remove('active'));
      if (!wasActive) item.classList.add('active');
    });
  });

  document.querySelectorAll('form[data-form]').forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      const msg = form.querySelector('.form-success');
      if (msg) { msg.classList.add('show'); form.reset(); setTimeout(() => msg.classList.remove('show'), 5000); }
    });
  });

  const navbar = document.querySelector('.nav-dental');
  if (navbar) {
    window.addEventListener('scroll', () => {
      navbar.style.boxShadow = window.scrollY > 50 ? '0 4px 20px rgba(0,0,0,0.1)' : '0 2px 8px rgba(0,0,0,0.06)';
    });
  }

  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', function(e) {
      const t = document.querySelector(this.getAttribute('href'));
      if (t) { e.preventDefault(); t.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
    });
  });

  const counters = document.querySelectorAll('.trust-badge .number[data-count]');
  if (counters.length) {
    const obs = new IntersectionObserver((entries) => {
      entries.forEach(e => {
        if (e.isIntersecting) {
          const target = parseInt(e.target.dataset.count);
          let cur = 0;
          const inc = target / 50;
          const timer = setInterval(() => {
            cur += inc;
            if (cur >= target) { e.target.textContent = target + '+'; clearInterval(timer); }
            else e.target.textContent = Math.floor(cur) + '+';
          }, 30);
          obs.unobserve(e.target);
        }
      });
    }, { threshold: 0.5 });
    counters.forEach(c => obs.observe(c));
  }
});
