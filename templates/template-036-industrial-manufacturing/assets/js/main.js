document.addEventListener('DOMContentLoaded',function(){
  const nav=document.querySelector('.navbar');
  window.addEventListener('scroll',()=>{
    nav.classList.toggle('scrolled',window.scrollY>50);
  });
  document.querySelectorAll('form').forEach(f=>{
    f.addEventListener('submit',function(e){
      e.preventDefault();
      const t=this.closest('section')?.querySelector('.thank-you-msg');
      if(t){this.style.display='none';t.classList.add('show')}
      else{alert('感謝您的詢問！')}
    });
  });
});
