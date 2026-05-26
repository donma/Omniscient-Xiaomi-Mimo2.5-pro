document.addEventListener('DOMContentLoaded', function() {
    // Matrix rain effect
    const canvas = document.getElementById('matrixCanvas');
    if (canvas) {
        const c = document.createElement('canvas');
        canvas.appendChild(c);
        c.width = window.innerWidth;
        c.height = window.innerHeight;
        const ctx = c.getContext('2d');
        const chars = '01アイウエオカキクケコ';
        const fontSize = 14;
        const cols = c.width / fontSize;
        const drops = Array(Math.floor(cols)).fill(1);
        function draw() {
            ctx.fillStyle = 'rgba(10,14,23,0.05)';
            ctx.fillRect(0, 0, c.width, c.height);
            ctx.fillStyle = '#00ff88';
            ctx.font = fontSize + 'px JetBrains Mono';
            for (let i = 0; i < drops.length; i++) {
                const text = chars[Math.floor(Math.random() * chars.length)];
                ctx.fillText(text, i * fontSize, drops[i] * fontSize);
                if (drops[i] * fontSize > c.height && Math.random() > 0.975) drops[i] = 0;
                drops[i]++;
            }
        }
        setInterval(draw, 50);
        window.addEventListener('resize', () => { c.width = window.innerWidth; c.height = window.innerHeight; });
    }

    // Counter animation
    document.querySelectorAll('.threat-num').forEach(el => {
        const target = parseFloat(el.dataset.target);
        const isFloat = target % 1 !== 0;
        let current = 0;
        const step = target / 60;
        const timer = setInterval(() => {
            current += step;
            if (current >= target) { current = target; clearInterval(timer); }
            el.textContent = isFloat ? current.toFixed(1) : Math.floor(current).toLocaleString();
        }, 30);
    });

    // Form submission
    document.querySelectorAll('form').forEach(f => f.addEventListener('submit', function(e) {
        e.preventDefault();
        const ty = this.closest('section')?.querySelector('.thank-you-msg');
        if (ty) { this.style.display = 'none'; ty.classList.add('show'); }
        else alert('感謝您的詢問！');
    }));
});