document.addEventListener('DOMContentLoaded', function() {
    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
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

    // Portfolio filter
    const filterButtons = document.querySelectorAll('.portfolio-filter .btn');
    const portfolioItems = document.querySelectorAll('.portfolio-item');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            const filter = this.getAttribute('data-filter');
            
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            portfolioItems.forEach(item => {
                if (filter === 'all' || item.getAttribute('data-category') === filter) {
                    item.style.display = 'block';
                    item.style.animation = 'fadeIn 0.5s ease';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });

    // Before/After slider
    const baSliders = document.querySelectorAll('.ba-slider');
    baSliders.forEach(slider => {
        const container = slider.closest('.ba-container');
        const afterDiv = container.querySelector('.ba-after');
        let isDown = false;

        slider.addEventListener('mousedown', (e) => {
            isDown = true;
            e.preventDefault();
        });

        document.addEventListener('mouseup', () => {
            isDown = false;
        });

        document.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            const rect = container.getBoundingClientRect();
            let x = e.clientX - rect.left;
            x = Math.max(0, Math.min(x, rect.width));
            const percent = (x / rect.width) * 100;
            slider.style.left = percent + '%';
            afterDiv.style.width = percent + '%';
        });

        // Touch support
        slider.addEventListener('touchstart', (e) => {
            isDown = true;
            e.preventDefault();
        });

        document.addEventListener('touchend', () => {
            isDown = false;
        });

        document.addEventListener('touchmove', (e) => {
            if (!isDown) return;
            const rect = container.getBoundingClientRect();
            let x = e.touches[0].clientX - rect.left;
            x = Math.max(0, Math.min(x, rect.width));
            const percent = (x / rect.width) * 100;
            slider.style.left = percent + '%';
            afterDiv.style.width = percent + '%';
        });
    });

    // Form submission
    const bookingForm = document.getElementById('bookingForm');
    const contactForm = document.getElementById('contactForm');
    const thankYouModal = new bootstrap.Modal(document.getElementById('thankYouModal'));

    if (bookingForm) {
        bookingForm.addEventListener('submit', function(e) {
            e.preventDefault();
            thankYouModal.show();
            this.reset();
        });
    }

    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            thankYouModal.show();
            this.reset();
        });
    }

    // Animate on scroll
    const animateOnScroll = function() {
        const elements = document.querySelectorAll('.service-circle-card, .value-card, .team-card, .review-card, .blog-card, .process-step');
        
        elements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const elementBottom = element.getBoundingClientRect().bottom;
            
            if (elementTop < window.innerHeight && elementBottom > 0) {
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }
        });
    };

    // Set initial state for animate on scroll elements
    const elementsToAnimate = document.querySelectorAll('.service-circle-card, .value-card, .team-card, .review-card, .blog-card, .process-step');
    elementsToAnimate.forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(30px)';
        element.style.transition = 'all 0.6s ease';
    });

    window.addEventListener('scroll', animateOnScroll);
    animateOnScroll(); // Run on load

    // Active nav link based on current page
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage || (currentPage === '' && href === 'index.html')) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    // Counter animation
    const counters = document.querySelectorAll('.stat-item h3');
    const speed = 200;

    const countUp = function() {
        counters.forEach(counter => {
            const target = +counter.innerText.replace('+', '');
            const count = +counter.getAttribute('data-count') || 0;
            const inc = target / speed;

            if (count < target) {
                counter.setAttribute('data-count', Math.ceil(count + inc));
                counter.innerText = Math.ceil(count + inc) + '+';
                setTimeout(countUp, 1);
            } else {
                counter.innerText = target + '+';
            }
        });
    };

    // Intersection Observer for counter animation
    const observerOptions = {
        threshold: 0.5
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                countUp();
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    const statsSection = document.querySelector('.about-stats');
    if (statsSection) {
        observer.observe(statsSection);
    }

    // Mobile menu close on click
    const navbarCollapse = document.querySelector('.navbar-collapse');
    const navbarToggler = document.querySelector('.navbar-toggler');
    
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
        link.addEventListener('click', () => {
            if (window.innerWidth < 992) {
                navbarCollapse.classList.remove('show');
                navbarToggler.classList.add('collapsed');
                navbarToggler.setAttribute('aria-expanded', 'false');
            }
        });
    });
});

// Add fadeIn animation
const style = document.createElement('style');
style.textContent = `
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
`;
document.head.appendChild(style);
