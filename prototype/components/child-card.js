class AppChildCard extends HTMLElement {
  connectedCallback() {
    const name = this.getAttribute('name') || 'Child';
    const score = this.getAttribute('score') || '0';
    const avatarSeed = this.getAttribute('avatar-seed') || name;
    const bgInfo = this.getAttribute('bg-info') || 'b6e3f4';
    const gender = this.getAttribute('gender') || 'boy'; // 'boy' or 'girl'
    const age = this.getAttribute('age') || '';
    const href = this.getAttribute('href') || '#';

    this.innerHTML = `
      <a href="${href}" class="group relative block overflow-hidden rounded-2xl bg-card-bg dark:bg-gray-800 p-6 shadow-card hover:shadow-float transition-all duration-300 transform hover:-translate-y-1 ring-1 ring-primary/10">
          <!-- Decorative Background Blob -->
          <div class="absolute -right-6 -top-6 size-32 rounded-full bg-primary/10 group-hover:bg-primary/20 transition-colors"></div>
          
          <div class="relative flex items-center justify-between">
            <div class="flex items-center gap-4">
              <!-- Avatar -->
              <div class="relative size-16 shrink-0 rounded-full bg-blue-50 p-1 ring-4 ring-card-bg dark:ring-gray-700 shadow-sm">
                <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}&backgroundColor=${bgInfo}" alt="${name}" class="h-full w-full rounded-full object-cover">
              </div>
              
              <!-- Text Info -->
              <div>
                <h3 class="text-lg font-bold text-text-main dark:text-white group-hover:text-primary-dark transition-colors">${name}</h3>
                <div class="flex items-center gap-2 mt-1">
                  <span class="px-2 py-0.5 rounded-md bg-background-light text-text-sub text-[10px] font-bold uppercase tracking-wider ring-1 ring-black/5 flex items-center gap-1">
                    <span class="material-symbols-rounded text-xs">${gender === 'boy' ? 'male' : 'female'}</span>
                    <span data-i18n="gender.${gender}">${gender === 'boy' ? 'Boy' : 'Girl'}</span>
                  </span>
                  ${age ? `
                  <span class="px-2 py-0.5 rounded-md bg-background-light text-text-sub text-[10px] font-bold uppercase tracking-wider ring-1 ring-black/5 flex items-center gap-1">
                    <span class="material-symbols-rounded text-xs">cake</span>
                    ${age} <span data-i18n="label.years">Years</span>
                  </span>
                  ` : ''}
                </div>
              </div>
            </div>

            <!-- Points Pill (Always Yellow) -->
            <div class="flex flex-col items-end">
              <div class="flex items-center gap-1 rounded-full bg-primary px-3 py-1 shadow-soft group-hover:scale-105 transition-transform">
                <span class="material-symbols-rounded text-white text-lg transition-colors fill-1">star</span>
                <span class="text-lg font-extrabold text-white transition-colors">${score}</span>
              </div>
              <span class="text-[10px] font-bold text-text-sub mt-1 uppercase tracking-wide opacity-0 group-hover:opacity-100 transition-opacity transform translate-x-2 group-hover:translate-x-0" data-i18n="btn.edit">View Profile</span>
            </div>
          </div>
        </a>
    `;
  }
}
customElements.define('app-child-card', AppChildCard);