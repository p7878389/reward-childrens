class AppBottomNav extends HTMLElement {
  connectedCallback() {
    const activeTab = this.getAttribute('active') || 'home';
    
    // Define styles for active vs inactive
    const activeClass = "relative flex items-center justify-center size-12 rounded-xl bg-card-bg shadow-card ring-1 ring-primary/20 transition-all transform active:scale-95";
    const activeIconClass = "text-[26px] text-primary fill-1";
    
    const inactiveClass = "flex items-center justify-center size-12 rounded-xl text-text-sub/50 hover:text-text-main transition-all";
    const inactiveIconClass = "text-[26px]";

    // Render
    this.innerHTML = `
    <nav class="bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-xl px-6 py-3 pb-8 transition-colors z-50 absolute bottom-0 left-0 w-full border-t border-transparent">
       <div class="flex items-center justify-around max-w-sm mx-auto">
          <!-- Home Tab -->
          <a href="index.html" class="${activeTab === 'home' ? activeClass : inactiveClass}">
            <span class="material-symbols-rounded ${activeTab === 'home' ? activeIconClass : inactiveIconClass}">home</span>
            ${activeTab === 'home' ? '<div class="absolute -bottom-1.5 size-1.5 bg-primary rounded-full"></div>' : ''}
          </a>

          <!-- Shop Tab -->
          <a href="rewards-store.html" class="${activeTab === 'shop' ? activeClass : inactiveClass}">
            <span class="material-symbols-rounded ${activeTab === 'shop' ? activeIconClass : inactiveIconClass}">trophy</span>
            ${activeTab === 'shop' ? '<div class="absolute -bottom-1.5 size-1.5 bg-primary rounded-full"></div>' : ''}
          </a>

          <!-- Manage Tab -->
          <a href="settings.html" class="${activeTab === 'manage' ? activeClass : inactiveClass}">
            <span class="material-symbols-rounded ${activeTab === 'manage' ? activeIconClass : inactiveIconClass}">manage_accounts</span>
            ${activeTab === 'manage' ? '<div class="absolute -bottom-1.5 size-1.5 bg-primary rounded-full"></div>' : ''}
          </a>
       </div>
    </nav>
    <div class="h-24"></div> <!-- Spacer -->
    `;
  }
}
customElements.define('app-bottom-nav', AppBottomNav);
