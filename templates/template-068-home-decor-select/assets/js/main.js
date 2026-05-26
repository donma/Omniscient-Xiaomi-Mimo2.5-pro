/* 拾光選物 | Curated Living - Main JS */
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('感謝您的詢問');
            form.reset();
        });
    });
});
