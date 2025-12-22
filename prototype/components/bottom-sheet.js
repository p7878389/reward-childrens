class AppBottomSheet extends HTMLElement {
  constructor() {
    super();
    this.isOpen = false;
  }

  connectedCallback() {
    this.render();
  }

  open() {
    this.isOpen = true;
    this.render();
    document.body.style.overflow = 'hidden'; // 防止背景滚动
  }

  close() {
    this.isOpen = false;
    this.render();
    document.body.style.overflow = '';
  }

  render() {
    const visibilityClass = this.isOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none';
    const transformClass = this.isOpen ? 'translate-y-0' : 'translate-y-full';

    this.innerHTML = `
      <!-- Backdrop -->
      <div id="sheet-backdrop" class="fixed inset-0 bg-black/40 backdrop-blur-[2px] z-[60] transition-opacity duration-300 ${visibilityClass}"></div>
      
      <!-- Sheet Content -->
      <div id="sheet-panel" class="fixed bottom-0 left-0 right-0 max-w-md mx-auto bg-background-light rounded-t-[2.5rem] shadow-2xl z-[70] transition-transform duration-500 ease-out transform ${transformClass} border-t border-primary/10">
        
        <!-- Handle Bar -->
        <div class="flex justify-center pt-3 pb-1">
          <div class="w-12 h-1.5 bg-text-sub/20 rounded-full"></div>
        </div>

        <div class="px-8 pt-4 pb-12">
          <h3 class="text-xl font-extrabold text-text-main mb-6 text-center">What happened?</h3>
          
          <div class="grid grid-cols-1 gap-4">
            <!-- Reward Option -->
            <button class="flex items-center gap-4 bg-[#EAFBF3] p-5 rounded-2xl ring-1 ring-success/10 active:scale-[0.98] transition-all text-left">
              <div class="size-12 rounded-xl bg-white flex items-center justify-center text-[#2E7D58] shadow-sm">
                <span class="material-symbols-rounded text-3xl fill-1">add_circle</span>
              </div>
              <div>
                <p class="font-bold text-text-main">Reward</p>
                <p class="text-xs text-text-sub font-medium">Add points for good behavior</p>
              </div>
            </button>

            <!-- Punish Option -->
            <button class="flex items-center gap-4 bg-[#FFF0F0] p-5 rounded-2xl ring-1 ring-danger/10 active:scale-[0.98] transition-all text-left">
              <div class="size-12 rounded-xl bg-white flex items-center justify-center text-[#D6455D] shadow-sm">
                <span class="material-symbols-rounded text-3xl fill-1">remove_circle</span>
              </div>
              <div>
                <p class="font-bold text-text-main">Punish</p>
                <p class="text-xs text-text-sub font-medium">Deduct points for mistakes</p>
              </div>
            </button>

            <!-- Redeem Option -->
            <button class="flex items-center gap-4 bg-[#F0F4FF] p-5 rounded-2xl ring-1 ring-blue-500/10 active:scale-[0.98] transition-all text-left">
              <div class="size-12 rounded-xl bg-white flex items-center justify-center text-[#4B6BFB] shadow-sm">
                <span class="material-symbols-rounded text-3xl">storefront</span>
              </div>
              <div>
                <p class="font-bold text-text-main">Redeem</p>
                <p class="text-xs text-text-sub font-medium">Exchange stars for a reward</p>
              </div>
            </button>
          </div>

          <!-- Close Button -->
          <button id="close-sheet" class="mt-8 w-full py-3 text-sm font-bold text-text-sub hover:text-text-main transition-colors uppercase tracking-widest">
            Cancel
          </button>
        </div>
      </div>
    `;

    // Add events
    this.querySelector('#sheet-backdrop')?.addEventListener('click', () => this.close());
    this.querySelector('#close-sheet')?.addEventListener('click', () => this.close());
  }
}
customElements.define('app-bottom-sheet', AppBottomSheet);
