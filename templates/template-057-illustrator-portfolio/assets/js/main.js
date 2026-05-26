document.addEventListener('DOMContentLoaded',function(){
  var navbar=document.querySelector('.navbar');
  var scrollTop=document.querySelector('.scroll-top');
  window.addEventListener('scroll',function(){
    if(window.scrollY>50){navbar.classList.add('scrolled')}else{navbar.classList.remove('scrolled')}
    if(window.scrollY>300){scrollTop.classList.add('active')}else{scrollTop.classList.remove('active')}
  });
  if(scrollTop){scrollTop.addEventListener('click',function(){window.scrollTo({top:0,behavior:'smooth'})})}
  document.querySelectorAll('a[href^="#"]').forEach(function(a){a.addEventListener('click',function(e){e.preventDefault();var t=document.querySelector(this.getAttribute('href'));if(t){window.scrollTo({top:t.getBoundingClientRect().top+window.pageYOffset-80,behavior:'smooth'})}})});
  var fadeEls=document.querySelectorAll('.fade-in');
  var obs=new IntersectionObserver(function(entries){entries.forEach(function(entry){if(entry.isIntersecting){entry.target.classList.add('visible');obs.unobserve(entry.target)}})},{threshold:0.1});
  fadeEls.forEach(function(el){obs.observe(el)});
  document.querySelectorAll('form').forEach(function(form){form.addEventListener('submit',function(e){e.preventDefault();var btn=this.querySelector('button[type="submit"]');btn.textContent='處理中...';btn.disabled=true;setTimeout(function(){var container=form.closest('.contact-form')||form.parentElement;container.innerHTML='<div class="text-center py-5"><i class="bi bi-check-circle-fill" style="font-size:4rem;color:var(--primary)"></i><h3 class="mt-3">感謝您的詢問！</h3><p class="text-muted">我們已收到您的訊息，將盡快回覆您。</p></div>'},1500)})});
  var navCollapse=document.querySelector('.navbar-collapse');
  document.querySelectorAll('.navbar-nav .nav-link').forEach(function(l){l.addEventListener('click',function(){if(navCollapse.classList.contains('show'))navCollapse.classList.remove('show')})});
});
