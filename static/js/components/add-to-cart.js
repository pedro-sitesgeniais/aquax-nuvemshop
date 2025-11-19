/**
 * AquaX Piscinas - Add to Cart Component
 * Adicionar ao carrinho com feedback visual
 */

class AquaXAddToCart {
    constructor() {
        this.init();
    }

    init() {
        this.bindEvents();
        this.createNotification();
    }

    bindEvents() {
        // Interceptar forms de adicionar ao carrinho
        document.addEventListener('submit', async (e) => {
            const form = e.target.closest('form[action*="cart"], .product-form, .product-form-detail');

            if (form && form.querySelector('[name="add_to_cart"]')) {
                e.preventDefault();
                await this.handleSubmit(form);
            }
        });
    }

    async handleSubmit(form) {
        const button = form.querySelector('button[type="submit"]');
        const originalText = button.innerHTML;

        // Estado de loading
        button.disabled = true;
        button.innerHTML = `
            <span class="spinner-small"></span>
            Adicionando...
        `;

        try {
            const formData = new FormData(form);

            const response = await fetch(form.action || '/cart/add', {
                method: 'POST',
                body: formData
            });

            if (response.ok) {
                const data = await response.json();

                // Atualizar contador do carrinho
                this.updateCartCount(data);

                // Mostrar notificação de sucesso
                this.showNotification('Produto adicionado ao carrinho!', 'success', data);

                // Feedback visual no botão
                button.innerHTML = `
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="20 6 9 17 4 12"/>
                    </svg>
                    Adicionado!
                `;
                button.classList.add('btn-success');

                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.classList.remove('btn-success');
                    button.disabled = false;
                }, 2000);

            } else {
                throw new Error('Erro ao adicionar');
            }

        } catch (error) {
            console.error('Add to cart error:', error);

            this.showNotification('Erro ao adicionar produto', 'error');

            button.innerHTML = originalText;
            button.disabled = false;
        }
    }

    updateCartCount(data) {
        // Atualizar contador no header
        const countElements = document.querySelectorAll('[data-cart-count]');
        const totalElements = document.querySelectorAll('[data-cart-total]');

        if (data.items_count !== undefined) {
            countElements.forEach(el => {
                el.textContent = data.items_count;
                el.style.display = data.items_count > 0 ? 'flex' : 'none';

                // Animação de bounce
                el.classList.add('bounce');
                setTimeout(() => el.classList.remove('bounce'), 300);
            });
        }

        if (data.total !== undefined) {
            totalElements.forEach(el => {
                el.textContent = data.total;
            });
        }

        // Disparar evento customizado
        document.dispatchEvent(new CustomEvent('cart:updated', { detail: data }));
    }

    createNotification() {
        // Container de notificações
        if (!document.querySelector('.cart-notifications')) {
            const container = document.createElement('div');
            container.className = 'cart-notifications';
            document.body.appendChild(container);
        }
    }

    showNotification(message, type = 'success', data = null) {
        const container = document.querySelector('.cart-notifications');

        const notification = document.createElement('div');
        notification.className = `cart-notification cart-notification--${type}`;

        let content = `
            <div class="notification-content">
                <div class="notification-icon">
                    ${type === 'success' ? `
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                    ` : `
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/>
                            <line x1="12" y1="8" x2="12" y2="12"/>
                            <line x1="12" y1="16" x2="12.01" y2="16"/>
                        </svg>
                    `}
                </div>
                <div class="notification-text">
                    <strong>${message}</strong>
                    ${data && data.product_name ? `<span>${data.product_name}</span>` : ''}
                </div>
            </div>
        `;

        if (type === 'success') {
            content += `
                <div class="notification-actions">
                    <a href="/cart" class="btn btn-sm btn-primary">Ver Carrinho</a>
                    <button type="button" class="btn btn-sm btn-secondary" data-close-notification>
                        Continuar
                    </button>
                </div>
            `;
        }

        content += `
            <button type="button" class="notification-close" data-close-notification aria-label="Fechar">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="18" y1="6" x2="6" y2="18"/>
                    <line x1="6" y1="6" x2="18" y2="18"/>
                </svg>
            </button>
        `;

        notification.innerHTML = content;
        container.appendChild(notification);

        // Animar entrada
        requestAnimationFrame(() => {
            notification.classList.add('active');
        });

        // Auto-fechar após 5 segundos
        const autoClose = setTimeout(() => {
            this.closeNotification(notification);
        }, 5000);

        // Fechar manualmente
        notification.querySelectorAll('[data-close-notification]').forEach(btn => {
            btn.addEventListener('click', () => {
                clearTimeout(autoClose);
                this.closeNotification(notification);
            });
        });
    }

    closeNotification(notification) {
        notification.classList.remove('active');
        setTimeout(() => notification.remove(), 300);
    }
}

// Inicializar
document.addEventListener('DOMContentLoaded', function() {
    new AquaXAddToCart();
});
