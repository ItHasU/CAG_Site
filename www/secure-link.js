class SecureLink extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
    }

    connectedCallback() {
        const encodedData = this.getAttribute('data-url');
        const type = this.getAttribute('data-type') || 'raw';

        if (!encodedData) return;

        // Décodage de la valeur Base64
        const decoded = atob(encodedData);

        let content = '';
        const style = `
            <style>
                :host { display: inline; }
                a { color: inherit; text-decoration: underline; cursor: pointer; }
                span { color: inherit; }
            </style>
        `;

        // Logique selon le type
        switch (type) {
            case 'tel':
                const cleanTel = decoded.replace(/\s/g, ''); // Nettoie les espaces pour le lien
                content = `<a href="tel:${cleanTel}">${decoded}</a>`;
                break;
            case 'mailto':
                content = `<a href="mailto:${decoded}">${decoded}</a>`;
                break;
            case 'raw':
            default:
                content = `<span>${decoded}</span>`;
                break;
        }

        this.shadowRoot.innerHTML = `${style}${content}`;
    }
}

customElements.define('secure-link', SecureLink);