class AppHeader extends HTMLElement {
  connectedCallback() {
    const type = this.getAttribute('type') || 'default'; // 'home' or 'back'
    const title = this.getAttribute('title') || '';
    const backUrl = this.getAttribute('back-url') || 'index.html';

    if (type === 'home') {
      this.innerHTML = `
        <header class="relative flex items-center px-8 pt-10 pb-6 justify-between z-50 bg-background-light dark:bg-background-dark">
          <div class="flex flex-col">
            <p class="text-text-sub text-sm font-bold tracking-wider uppercase mb-1">Good Morning!</p>
            <h1 class="text-text-main dark:text-white text-2xl font-extrabold tracking-tight">
              Who is earning<br>
              <span class="text-primary decoration-wavy underline decoration-2 underline-offset-4">stars</span> today?
            </h1>
          </div>
        </header>
      `;
    } else {
      // Detail/Back Header
      const hideMore = this.hasAttribute('hide-more');
      const rightIcon = this.getAttribute('right-icon') || 'more_horiz';
      const onRightClick = this.getAttribute('on-right-click') || '';
      
      this.innerHTML = `
        <header class="relative flex items-center px-6 pt-10 pb-4 justify-between z-50 bg-background-light dark:bg-background-dark">
          <a href="${backUrl}" class="size-10 flex items-center justify-center rounded-full bg-card-bg shadow-card hover:bg-white text-text-main transition-colors ring-1 ring-primary/10">
            <span class="material-symbols-rounded">arrow_back</span>
          </a>
          <div class="flex items-center gap-2 px-4 py-1.5 bg-card-bg rounded-full shadow-card ring-1 ring-primary/10">
            <span class="size-2 rounded-full bg-success animate-pulse"></span>
            <span class="text-[11px] font-bold text-text-sub uppercase tracking-widest">${title || 'Connected'}</span>
          </div>
          ${hideMore ? '<div class="size-10"></div>' : `
          <button onclick="${onRightClick}" class="size-10 flex items-center justify-center rounded-full bg-card-bg shadow-card hover:bg-white text-text-main transition-colors ring-1 ring-primary/10">
            <span class="material-symbols-rounded">${rightIcon}</span>
          </button>`}
        </header>
      `;
    }
  }
}
customElements.define('app-header', AppHeader);
