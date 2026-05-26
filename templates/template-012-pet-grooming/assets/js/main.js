/* T012 Pet Grooming - Main JavaScript */

document.addEventListener('DOMContentLoaded', function() {
  const toggler = document.querySelector('.navbar-toggler');
  const navCollapse = document.querySelector('.navbar-collapse');
  if (toggler) {
    toggler.addEventListener('click', () => navCollapse.classList.toggle('show'));
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
      link.addEventListener('click', () => { if (window.innerWidth < 992) navCollapse.classList.remove('show'); });
    });
  }

  document.querySelectorAll('.faq-pet .faq-question').forEach(q => {
    q.addEventListener('click', function() {
      const item = this.closest('.faq-item');
      const wasActive = item.classList.contains('active');
      document.querySelectorAll('.faq-pet .faq-item').forEach(i => i.classList.remove('active'));
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

  const nav = document.querySelector('.nav-pet');
  if (nav) {
    window.addEventListener('scroll', () => {
      nav.style.boxShadow = window.scrollY > 50 ? '0 4px 24px rgba(255,139,167,0.2)' : '0 4px 20px rgba(255,139,167,0.15)';
    });
  }

  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', function(e) {
      const t = document.querySelector(this.getAttribute('href'));
      if (t) { e.preventDefault(); t.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
    });
  });
});
