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

    // Parallax effect for hero
    const heroSection = document.querySelector('.hero-section.parallax');
    if (heroSection) {
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const speed = heroSection.dataset.speed || 0.5;
            heroSection.style.backgroundPositionY = -(scrolled * speed) + 'px';
        });
    }

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

    // Menu tabs animation
    const menuTabs = document.querySelectorAll('.menu-tabs .nav-link');
    menuTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            menuTabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
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
        const elements = document.querySelectorAll('.special-card, .menu-item, .value-card, .team-card, .review-card, .blog-card, .process-card');
        
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
    const elementsToAnimate = document.querySelectorAll('.special-card, .menu-item, .value-card, .team-card, .review-card, .blog-card, .process-card');
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

    // Neon text animation
    const neonText = document.querySelector('.neon-text');
    if (neonText) {
        setInterval(() => {
            neonText.style.textShadow = '0 0 10px rgba(201, 169, 110, 0.8), 0 0 20px rgba(201, 169, 110, 0.6)';
            setTimeout(() => {
                neonText.style.textShadow = '0 0 10px rgba(201, 169, 110, 0.5)';
            }, 500);
        }, 2000);
    }
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
