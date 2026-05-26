document.addEventListener('DOMContentLoaded', function() {
    const nav = document.querySelector('.navbar');
    window.addEventListener('scroll', () => nav.classList.toggle('shadow', window.scrollY > 50));
    document.querySelectorAll('form').forEach(f => f.addEventListener('submit', function(e) {
        e.preventDefault();
        const ty = this.closest('section')?.querySelector('.thank-you-msg');
        if (ty) { this.style.display = 'none'; ty.classList.add('show'); }
        else alert('感謝您的詢問！');
    }));
});