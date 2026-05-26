document.addEventListener('DOMContentLoaded',function(){
  const b=document.querySelector('.back-to-top');
  if(b){window.addEventListener('scroll',()=>b.classList.toggle('show',window.scrollY>300));b.addEventListener('click',()=>window.scrollTo({top:0,behavior:'smooth'}))}
  document.querySelectorAll('.fade-in').forEach(el=>{const o=new IntersectionObserver(e=>{e.forEach(i=>{if(i.isIntersecting)i.target.classList.add('visible')})},{threshold:0.1});o.observe(el)});
  document.querySelectorAll('form').forEach(f=>{f.addEventListener('submit',function(e){e.preventDefault();alert('感謝您的詢問！我們會盡快與您聯繫。');f.reset()})});
  const c=window.location.pathname.split('/').pop()||'index.html';
  document.querySelectorAll('.nav-link').forEach(l=>{if(l.getAttribute('href')===c)l.classList.add('active')})
});
