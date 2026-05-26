document.addEventListener('DOMContentLoaded',function(){
document.querySelectorAll('form').forEach(function(f){
f.addEventListener('submit',function(e){
e.preventDefault();
alert('感謝您的詢問');
f.reset());
});
});
