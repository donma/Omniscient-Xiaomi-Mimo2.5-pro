/* T023 Main JS */
document.addEventListener('DOMContentLoaded', function() {
  const navbar = document.querySelector('.navbar-craft');
  if (navbar) window.addEventListener('scroll', () => navbar.classList.toggle('scrolled', window.scrollY > 50));
  const backToTop = document.querySelector('.back-to-top');
  if (backToTop) {
    window.addEventListener('scroll', () => backToTop.classList.toggle('show', window.scrollY > 300));
    backToTop.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
  }
  const fadeElements = document.querySelectorAll('.fade-in');
  if (fadeElements.length > 0) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => { if (entry.isIntersecting) entry.target.classList.add('visible'); });
    }, { threshold: 0.1 });
    fadeElements.forEach(el => observer.observe(el));
  }
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      alert('感謝您的詢問！我們會盡快與您聯繫。');
      form.reset();
    });
  });
  const currentPath = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.getAttribute('href') === currentPath) link.classList.add('active');
  });
});
