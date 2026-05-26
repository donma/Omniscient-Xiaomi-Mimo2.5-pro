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
  const observer=new IntersectionObserver((entries)=>{
    entries.forEach(e=>{if(e.isIntersecting){e.target.classList.add('visible');observer.unobserve(e.target)}});
  },{threshold:0.1});
  document.querySelectorAll('.fade-up').forEach(el=>observer.observe(el));
});
