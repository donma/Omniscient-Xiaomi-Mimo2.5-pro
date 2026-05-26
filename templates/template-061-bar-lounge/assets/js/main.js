/* 夜幕酒廊 Nightfall Lounge - Main JS */

// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});

// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Form submission handling
document.addEventListener('DOMContentLoaded', function() {
    // Booking form
    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const successMsg = document.getElementById('bookingSuccess');
            if (successMsg) {
                successMsg.style.display = 'block';
                bookingForm.reset();
                successMsg.scrollIntoView({ behavior: 'smooth' });
            }
        });
    }

    // Contact form
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const successMsg = document.getElementById('contactSuccess');
            if (successMsg) {
                successMsg.style.display = 'block';
                contactForm.reset();
                successMsg.scrollIntoView({ behavior: 'smooth' });
            }
        });
    }

    // Generic form handling
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('感謝您的詢問');
            form.reset();
        });
    });
});

// Lazy loading images
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.add('loaded');
                observer.unobserve(img);
            }
        });
    });

    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
}

// Back to top button
const backToTopButton = document.createElement('button');
backToTopButton.innerHTML = '<i class="bi bi-arrow-up"></i>';
backToTopButton.className = 'btn btn-gold back-to-top';
backToTopButton.style.cssText = 'position: fixed; bottom: 20px; right: 20px; z-index: 1000; display: none; width: 50px; height: 50px; border-radius: 50%; padding: 0;';
document.body.appendChild(backToTopButton);

window.addEventListener('scroll', function() {
    if (window.scrollY > 300) {
        backToTopButton.style.display = 'block';
    } else {
        backToTopButton.style.display = 'none';
    }
});

backToTopButton.addEventListener('click', function() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// Counter animation
function animateCounters() {
    const counters = document.querySelectorAll('.stat-number');
    counters.forEach(counter => {
        const target = counter.innerText;
        counter.style.opacity = '1';
    });
}

// Trigger counter animation when visible
if ('IntersectionObserver' in window) {
    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounters();
                counterObserver.unobserve(entry.target);
            }
        });
    });

    document.querySelectorAll('.stat-item').forEach(item => {
        counterObserver.observe(item);
    });
}

// Mobile menu close on click
document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
    link.addEventListener('click', function() {
        const navbarCollapse = document.querySelector('.navbar-collapse');
        if (navbarCollapse.classList.contains('show')) {
            const bsCollapse = new bootstrap.Collapse(navbarCollapse);
            bsCollapse.hide();
        }
    });
});

// Initialize tooltips
const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
});

// Add active class to current nav link
const currentLocation = window.location.pathname;
document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
    if (link.getAttribute('href') === currentLocation.split('/').pop()) {
        link.classList.add('active');
    }
});