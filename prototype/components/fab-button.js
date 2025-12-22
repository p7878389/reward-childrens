class AppFab extends HTMLElement {
  connectedCallback() {
    const icon = this.getAttribute('icon') || 'add';
    const href = this.getAttribute('href') || '#';
    const onclick = this.getAttribute('onclick') || '';

    this.innerHTML = `
      <div class="fixed bottom-28 right-6 z-50">
        <a href="${href}" onclick="${onclick}" class="flex size-14 items-center justify-center rounded-2xl bg-primary text-white shadow-soft hover:bg-primary-dark hover:scale-105 active:scale-95 transition-all ring-1 ring-black/5">
          <span class="material-symbols-rounded text-3xl"> ${icon} </span>
        </a>
      </div>
    `;
  }
}
customElements.define('app-fab', AppFab);
