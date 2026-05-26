document.addEventListener('DOMContentLoaded', function() {
    // Navbar scroll effect
    const nav = document.querySelector('.glass-nav');
    window.addEventListener('scroll', () => {
        nav.classList.toggle('scrolled', window.scrollY > 50);
    });

    // Particle effect for hero
    const hero = document.getElementById('particles-js');
    if (hero) {
        for (let i = 0; i < 50; i++) {
            const p = document.createElement('div');
            p.className = 'particle';
            p.style.cssText = `position:absolute;width:${Math.random()*4+2}px;height:${Math.random()*4+2}px;background:rgba(0,245,212,${Math.random()*0.5+0.1});border-radius:50%;left:${Math.random()*100}%;top:${Math.random()*100}%;animation:float ${Math.random()*6+4}s ease-in-out infinite;animation-delay:${Math.random()*3}s;`;
            hero.appendChild(p);
        }
        const style = document.createElement('style');
        style.textContent = '@keyframes float{0%,100%{transform:translateY(0) translateX(0);opacity:0.5}50%{transform:translateY(-30px) translateX(15px);opacity:1}}';
        document.head.appendChild(style);
    }

    // Form submission
    const forms = document.querySelectorAll('form.contact-form, form.booking-form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const thankYou = this.closest('section').querySelector('.thank-you-msg');
            if (thankYou) {
                this.style.display = 'none';
                thankYou.classList.add('show');
            } else {
                alert('感謝您的詢問！我們將盡快與您聯繫。');
            }
        });
    });

    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach(a => {
        a.addEventListener('click', e => {
            e.preventDefault();
            const target = document.querySelector(a.getAttribute('href'));
            if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
    });
});