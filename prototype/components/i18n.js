class I18n {
  constructor() {
    this.lang = localStorage.getItem('app_lang') || 'en';
    this.init();
  }

  init() {
    this.updatePage();
    this.updateComponents();
  }

  setLanguage(lang) {
    this.lang = lang;
    localStorage.setItem('app_lang', lang);
    this.updatePage();
    this.updateComponents();
    // Dispatch event for components to listen
    window.dispatchEvent(new CustomEvent('lang-change', { detail: { lang } }));
  }

  t(key, params = {}) {
    let text = translations[this.lang][key] || key;
    // Simple parameter replacement {key}
    for (const [k, v] of Object.entries(params)) {
      text = text.replace(`{${k}}`, v);
    }
    return text;
  }

  updatePage() {
    // Update text content
    document.querySelectorAll('[data-i18n]').forEach(el => {
      const key = el.getAttribute('data-i18n');
      if (key) el.innerText = this.t(key);
    });

    // Update placeholders
    document.querySelectorAll('[data-i18n-placeholder]').forEach(el => {
      const key = el.getAttribute('data-i18n-placeholder');
      if (key) el.placeholder = this.t(key);
    });
  }
  
  updateComponents() {
    // Helper to refresh custom components if they have specific update logic
    // Most components will need to re-render or listen to 'lang-change'
    const header = document.querySelector('app-header');
    if(header && header.render) header.render(); // If we implement render method
  }
}

// Initialize globally
window.i18n = new I18n();
