class AppActionButton extends HTMLElement {
  connectedCallback() {
    const label = this.getAttribute('label') || 'Action';
    const icon = this.getAttribute('icon') || 'add';
    const onclick = this.getAttribute('onclick') || '';

    this.innerHTML = `
    <div class="absolute bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-background-light via-background-light to-transparent pt-12 z-40">
        <button onclick="${onclick}" class="w-full bg-primary hover:bg-primary-dark text-white font-bold text-lg py-4 rounded-2xl shadow-soft flex items-center justify-center gap-2 transition-transform active:scale-95 ring-1 ring-black/5">
            <span class="material-symbols-rounded text-2xl">${icon}</span>
            ${label}
        </button>
    </div>
    `;
  }
}
customElements.define('app-action-button', AppActionButton);
