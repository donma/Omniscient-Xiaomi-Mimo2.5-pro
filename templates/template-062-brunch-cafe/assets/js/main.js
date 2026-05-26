/* 晨光早午餐 Sunshine Brunch - Main JS */

window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('感謝您的詢問');
            form.reset();
        });
    });

    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const msg = document.getElementById('bookingSuccess');
            if (msg) {
                msg.style.display = 'block';
                bookingForm.reset();
                msg.scrollIntoView({ behavior: 'smooth' });
            }
        });
    }

    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const msg = document.getElementById('contactSuccess');
            if (msg) {
                msg.style.display = 'block';
                contactForm.reset();
                msg.scrollIntoView({ behavior: 'smooth' });
            }
        });
    }
});

const backToTop = document.createElement('button');
backToTop.innerHTML = '<i class="bi bi-arrow-up"></i>';
backToTop.className = 'btn btn-primary back-to-top';
backToTop.style.cssText = 'position:fixed;bottom:20px;right:20px;z-index:1000;display:none;width:50px;height:50px;border-radius:50%;padding:0;';
document.body.appendChild(backToTop);

window.addEventListener('scroll', function() {
    backToTop.style.display = window.scrollY > 300 ? 'block' : 'none';
});

backToTop.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
    link.addEventListener('click', function() {
        const collapse = document.querySelector('.navbar-collapse');
        if (collapse.classList.contains('show')) {
            new bootstrap.Collapse(collapse).hide();
        }
    });
});

const currentPath = window.location.pathname;
document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
    if (link.getAttribute('href') === currentPath.split('/').pop()) {
        link.classList.add('active');
    }
});