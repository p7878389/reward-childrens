class AppConfirmModal extends HTMLElement {
  constructor() {
    super();
    this.connected = false;
  }

  connectedCallback() {
    if (!this.connected) {
      this.render();
      this.connected = true;
    }
  }

  show(options = {}) {
    this.titleEl.textContent = options.title || 'Confirm Action';
    this.messageEl.textContent = options.message || 'Are you sure you want to proceed?';
    this.confirmBtn.textContent = options.confirmText || 'Yes, Confirm';
    
    this.confirmBtn.onclick = () => {
        if (options.onConfirm) options.onConfirm();
        this.hide();
    };
    
    // Style switching based on type
    if (options.type === 'danger') {
        this.confirmBtn.className = "w-full py-3 bg-red-500 text-white font-bold rounded-xl shadow-sm hover:bg-red-600 transition-colors";
        this.iconBg.className = "size-16 rounded-2xl bg-red-50 text-red-500 flex items-center justify-center mx-auto mb-4";
        this.icon.textContent = "delete";
    } else {
        this.confirmBtn.className = "w-full py-3 bg-primary text-white font-bold rounded-xl shadow-sm hover:bg-primary-dark transition-colors";
        this.iconBg.className = "size-16 rounded-2xl bg-primary/10 text-primary flex items-center justify-center mx-auto mb-4";
        this.icon.textContent = "check_circle"; // or 'save'
    }

    this.modal.classList.remove('opacity-0', 'pointer-events-none');
  }

  hide() {
    this.modal.classList.add('opacity-0', 'pointer-events-none');
  }

  render() {
    this.innerHTML = `
    <div id="modal-overlay" class="fixed inset-0 bg-black/40 backdrop-blur-sm z-[100] flex items-center justify-center p-6 opacity-0 pointer-events-none transition-opacity duration-300">
       <div class="bg-background-light rounded-3xl p-6 shadow-2xl max-w-xs w-full text-center border border-primary/10 transform transition-all scale-100">
          <div id="modal-icon-bg" class="size-16 rounded-2xl bg-primary/10 text-primary flex items-center justify-center mx-auto mb-4">
             <span id="modal-icon" class="material-symbols-rounded text-3xl">check_circle</span>
          </div>
          <h3 id="modal-title" class="text-lg font-extrabold text-text-main mb-2">Confirm</h3>
          <p id="modal-message" class="text-sm text-text-sub font-medium mb-6 leading-relaxed">Are you sure?</p>
          <div class="flex flex-col gap-3">
             <button id="modal-confirm-btn" class="w-full py-3 bg-primary text-white font-bold rounded-xl shadow-sm transition-colors">Yes</button>
             <button id="modal-cancel-btn" class="w-full py-3 bg-white text-text-sub font-bold rounded-xl ring-1 ring-black/5 hover:bg-gray-50">Cancel</button>
          </div>
       </div>
    </div>
    `;

    this.modal = this.querySelector('#modal-overlay');
    this.titleEl = this.querySelector('#modal-title');
    this.messageEl = this.querySelector('#modal-message');
    this.confirmBtn = this.querySelector('#modal-confirm-btn');
    this.cancelBtn = this.querySelector('#modal-cancel-btn');
    this.iconBg = this.querySelector('#modal-icon-bg');
    this.icon = this.querySelector('#modal-icon');

    this.cancelBtn.onclick = () => this.hide();
    this.modal.onclick = (e) => {
        if (e.target === this.modal) this.hide();
    }
  }
}
customElements.define('app-confirm-modal', AppConfirmModal);
