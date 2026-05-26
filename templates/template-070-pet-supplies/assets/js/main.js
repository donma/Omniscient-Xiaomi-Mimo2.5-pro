/* 毛孩樂園 | Pet Paradise - Main JS */
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('感謝您的詢問');
            form.reset();
        });
    });
});
