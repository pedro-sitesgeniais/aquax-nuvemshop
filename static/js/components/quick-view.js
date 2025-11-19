/**
 * AquaX Piscinas - Quick View Component
 * Modal de visualização rápida de produto
 */

class AquaXQuickView {
    constructor() {
        this.modal = null;
        this.isLoading = false;
        this.init();
    }

    init() {
        this.createModal();
        this.bindEvents();
    }

    createModal() {
        const modal = document.createElement('div');
        modal.className = 'quick-view-modal';
        modal.innerHTML = `
            <div class="quick-view-overlay" data-close-modal></div>
            <div class="quick-view-content">
                <button class="quick-view-close" data-close-modal aria-label="Fechar">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="18" y1="6" x2="6" y2="18"/>
                        <line x1="6" y1="6" x2="18" y2="18"/>
                    </svg>
                </button>
                <div class="quick-view-body" data-quick-view-body>
                    <div class="quick-view-loading">
                        <div class="spinner"></div>
                        <span>Carregando...</span>
                    </div>
                </div>
            </div>
        `;

        document.body.appendChild(modal);
        this.modal = modal;
    }

    bindEvents() {
        // Abrir quick view
        document.addEventListener('click', (e) => {
            const trigger = e.target.closest('[data-quick-view]');
            if (trigger) {
                e.preventDefault();
                const productId = trigger.dataset.quickView;
                this.open(productId);
            }
        });

        // Fechar modal
        this.modal.addEventListener('click', (e) => {
            if (e.target.closest('[data-close-modal]')) {
                this.close();
            }
        });

        // Fechar com ESC
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.modal.classList.contains('active')) {
                this.close();
            }
        });
    }

    async open(productId) {
        if (this.isLoading) return;

        this.modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        this.isLoading = true;

        try {
            const response = await fetch(`/product/${productId}?quick_view=true`);

            if (response.ok) {
                const html = await response.text();
                this.renderContent(html, productId);
            } else {
                this.showError('Erro ao carregar produto');
            }
        } catch (error) {
            console.error('Quick view error:', error);
            this.showError('Erro ao carregar produto');
        } finally {
            this.isLoading = false;
        }
    }

    renderContent(html, productId) {
        const body = this.modal.querySelector('[data-quick-view-body]');

        // Parse HTML ou usar template
        // Por simplicidade, vamos usar um template estático que será preenchido via API
        body.innerHTML = `
            <div class="quick-view-product">
                <div class="quick-view-gallery">
                    <div class="quick-view-image" id="quick-view-image">
                        <!-- Imagem será carregada -->
                    </div>
                </div>
                <div class="quick-view-info">
                    <h2 class="quick-view-title" id="quick-view-title">Carregando...</h2>
                    <div class="quick-view-price" id="quick-view-price"></div>
                    <div class="quick-view-description" id="quick-view-description"></div>
                    <form class="quick-view-form" id="quick-view-form">
                        <input type="hidden" name="add_to_cart" value="${productId}">
                        <div class="quick-view-quantity" data-quantity-wrapper>
                            <label>Quantidade</label>
                            <div class="quantity-control">
                                <button type="button" class="quantity-btn" data-quantity-btn="minus">-</button>
                                <input type="number" name="quantity" value="1" min="1" class="quantity-input">
                                <button type="button" class="quantity-btn" data-quantity-btn="plus">+</button>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg btn-block">
                            Adicionar ao Carrinho
                        </button>
                    </form>
                    <a href="/product/${productId}" class="quick-view-link">
                        Ver detalhes completos
                    </a>
                </div>
            </div>
        `;

        // Carregar dados do produto via API (simulado)
        this.loadProductData(productId);
    }

    async loadProductData(productId) {
        // Em produção, isso viria de uma API
        // Por agora, extraímos dados do card clicado
        const card = document.querySelector(`[data-quick-view="${productId}"]`)?.closest('.product-card');

        if (card) {
            const image = card.querySelector('.product-image img')?.src || '';
            const title = card.querySelector('.product-name a')?.textContent || '';
            const price = card.querySelector('.price-current')?.textContent || '';
            const comparePrice = card.querySelector('.price-compare')?.textContent || '';

            document.getElementById('quick-view-image').innerHTML = image ?
                `<img src="${image}" alt="${title}">` : '';
            document.getElementById('quick-view-title').textContent = title;
            document.getElementById('quick-view-price').innerHTML =
                (comparePrice ? `<span class="price-compare">${comparePrice}</span>` : '') +
                `<span class="price-current">${price}</span>`;
        }
    }

    showError(message) {
        const body = this.modal.querySelector('[data-quick-view-body]');
        body.innerHTML = `
            <div class="quick-view-error">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <p>${message}</p>
                <button class="btn btn-secondary" data-close-modal>Fechar</button>
            </div>
        `;
    }

    close() {
        this.modal.classList.remove('active');
        document.body.style.overflow = '';

        // Reset conteúdo
        setTimeout(() => {
            const body = this.modal.querySelector('[data-quick-view-body]');
            body.innerHTML = `
                <div class="quick-view-loading">
                    <div class="spinner"></div>
                    <span>Carregando...</span>
                </div>
            `;
        }, 300);
    }
}

// Inicializar
document.addEventListener('DOMContentLoaded', function() {
    new AquaXQuickView();
});
