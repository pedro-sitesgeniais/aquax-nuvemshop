{# ========================================
   Cart - AquaX Piscinas
   Página do carrinho de compras
   ======================================== #}

{% block body_class %}page-cart{% endblock %}

{# Breadcrumbs #}
<nav class="breadcrumbs" aria-label="Navegação">
    <div class="container">
        <ul>
            <li><a href="{{ store.url }}">Início</a></li>
            <li><span>Carrinho</span></li>
        </ul>
    </div>
</nav>

<section class="cart-section section">
    <div class="container">
        <h1 class="cart-title">Meu Carrinho</h1>

        {% if cart.items %}
        <div class="cart-layout">
            {# Lista de produtos #}
            <div class="cart-items">
                {# Header da tabela (desktop) #}
                <div class="cart-header">
                    <span class="col-product">Produto</span>
                    <span class="col-price">Preço</span>
                    <span class="col-quantity">Quantidade</span>
                    <span class="col-subtotal">Subtotal</span>
                    <span class="col-remove"></span>
                </div>

                {# Itens do carrinho #}
                {% for item in cart.items %}
                <div class="cart-item" data-item-id="{{ item.id }}">
                    {# Produto #}
                    <div class="item-product">
                        <a href="{{ item.product.url }}" class="item-image">
                            {% if item.product.featured_image %}
                            <img src="{{ item.product.featured_image }}"
                                 alt="{{ item.product.name }}"
                                 loading="lazy"
                                 width="80"
                                 height="80">
                            {% else %}
                            <div class="item-no-image">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                                    <circle cx="8.5" cy="8.5" r="1.5"/>
                                    <polyline points="21 15 16 10 5 21"/>
                                </svg>
                            </div>
                            {% endif %}
                        </a>
                        <div class="item-info">
                            <h3 class="item-name">
                                <a href="{{ item.product.url }}">{{ item.product.name }}</a>
                            </h3>
                            {% if item.variant %}
                            <p class="item-variant">{{ item.variant.name }}</p>
                            {% endif %}
                            {% if item.product.sku %}
                            <p class="item-sku">SKU: {{ item.product.sku }}</p>
                            {% endif %}
                        </div>
                    </div>

                    {# Preço unitário #}
                    <div class="item-price" data-label="Preço:">
                        {{ item.unit_price | money }}
                    </div>

                    {# Quantidade #}
                    <div class="item-quantity" data-label="Quantidade:">
                        <form method="post" action="{{ store.cart_url }}" class="quantity-form">
                            <input type="hidden" name="item_id" value="{{ item.id }}">
                            <div class="quantity-control" data-quantity-wrapper>
                                <button type="button"
                                        class="quantity-btn"
                                        data-quantity-btn="minus"
                                        aria-label="Diminuir quantidade">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <line x1="5" y1="12" x2="19" y2="12"/>
                                    </svg>
                                </button>
                                <input type="number"
                                       name="quantity"
                                       value="{{ item.quantity }}"
                                       min="1"
                                       max="{{ item.product.stock | default(99) }}"
                                       class="quantity-input"
                                       data-update-cart>
                                <button type="button"
                                        class="quantity-btn"
                                        data-quantity-btn="plus"
                                        aria-label="Aumentar quantidade">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <line x1="12" y1="5" x2="12" y2="19"/>
                                        <line x1="5" y1="12" x2="19" y2="12"/>
                                    </svg>
                                </button>
                            </div>
                        </form>
                    </div>

                    {# Subtotal #}
                    <div class="item-subtotal" data-label="Subtotal:">
                        <strong>{{ item.subtotal | money }}</strong>
                    </div>

                    {# Remover #}
                    <div class="item-remove">
                        <form method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="remove" value="{{ item.id }}">
                            <button type="submit" class="remove-btn" aria-label="Remover item">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="3 6 5 6 21 6"/>
                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                                    <line x1="10" y1="11" x2="10" y2="17"/>
                                    <line x1="14" y1="11" x2="14" y2="17"/>
                                </svg>
                            </button>
                        </form>
                    </div>
                </div>
                {% endfor %}
            </div>

            {# Resumo do pedido #}
            <aside class="cart-summary">
                <div class="summary-box">
                    <h2 class="summary-title">Resumo do Pedido</h2>

                    {# Cálculo de frete #}
                    <div class="shipping-calc">
                        <h3>Calcular Frete</h3>
                        <form class="shipping-form" data-shipping-form>
                            <div class="shipping-input-group">
                                <label for="shipping-zip" class="visually-hidden">CEP</label>
                                <input type="text"
                                       id="shipping-zip"
                                       name="zip"
                                       placeholder="Digite seu CEP"
                                       maxlength="9"
                                       pattern="[0-9]{5}-?[0-9]{3}"
                                       class="shipping-input">
                                <button type="submit" class="shipping-btn">
                                    Calcular
                                </button>
                            </div>
                            <a href="https://buscacepinter.correios.com.br/app/endereco/index.php"
                               target="_blank"
                               rel="noopener noreferrer"
                               class="find-zip">
                                Não sei meu CEP
                            </a>
                        </form>

                        {# Resultado do frete #}
                        <div class="shipping-results" data-shipping-results style="display: none;">
                            {# Preenchido via JavaScript #}
                        </div>
                    </div>

                    {# Valores #}
                    <div class="summary-values">
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>{{ cart.subtotal | money }}</span>
                        </div>

                        {% if cart.discount %}
                        <div class="summary-row discount">
                            <span>Desconto</span>
                            <span>-{{ cart.discount | money }}</span>
                        </div>
                        {% endif %}

                        {% if cart.shipping %}
                        <div class="summary-row">
                            <span>Frete</span>
                            <span>{{ cart.shipping | money }}</span>
                        </div>
                        {% endif %}

                        <div class="summary-row total">
                            <span>Total</span>
                            <span>{{ cart.total | money }}</span>
                        </div>

                        {% if cart.installments %}
                        <div class="summary-installments">
                            {{ cart.installments }}
                        </div>
                        {% endif %}
                    </div>

                    {# Cupom de desconto #}
                    <div class="coupon-section">
                        <form method="post" action="{{ store.cart_url }}" class="coupon-form">
                            <label for="coupon-code" class="visually-hidden">Cupom de desconto</label>
                            <input type="text"
                                   id="coupon-code"
                                   name="coupon"
                                   placeholder="Cupom de desconto"
                                   class="coupon-input">
                            <button type="submit" class="coupon-btn">
                                Aplicar
                            </button>
                        </form>
                    </div>

                    {# Botão finalizar #}
                    <a href="{{ store.checkout_url }}" class="btn btn-primary btn-lg btn-block checkout-btn">
                        Finalizar Compra
                    </a>

                    {# Continuar comprando #}
                    <a href="{{ store.url }}" class="continue-shopping">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="15 18 9 12 15 6"/>
                        </svg>
                        Continuar Comprando
                    </a>

                    {# Selos de segurança #}
                    <div class="trust-badges">
                        <div class="trust-badge">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <span>Compra Segura</span>
                        </div>
                        <div class="trust-badge">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                            </svg>
                            <span>Dados Protegidos</span>
                        </div>
                    </div>
                </div>
            </aside>
        </div>

        {% else %}
        {# Carrinho vazio #}
        <div class="cart-empty">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                <circle cx="9" cy="21" r="1"/>
                <circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
            </svg>
            <h2>Seu carrinho está vazio</h2>
            <p>Adicione produtos para continuar</p>
            <a href="{{ store.url }}" class="btn btn-primary btn-lg">
                Ir às Compras
            </a>
        </div>
        {% endif %}
    </div>
</section>

{# Estilos da página de carrinho #}
<style>
.cart-title {
    text-align: center;
    margin-bottom: var(--spacing-8);
}

/* Layout */
.cart-layout {
    display: grid;
    gap: var(--spacing-6);
}

@media (min-width: 992px) {
    .cart-layout {
        grid-template-columns: 1fr 380px;
        align-items: start;
    }
}

/* Cart Items */
.cart-items {
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    overflow: hidden;
}

.cart-header {
    display: none;
    padding: var(--spacing-4);
    background: var(--color-gray-50);
    font-size: var(--text-sm);
    font-weight: 600;
    color: var(--color-gray-600);
}

@media (min-width: 768px) {
    .cart-header {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr 1fr 50px;
        gap: var(--spacing-4);
    }
}

/* Cart Item */
.cart-item {
    padding: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-100);
}

.cart-item:last-child {
    border-bottom: none;
}

@media (min-width: 768px) {
    .cart-item {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr 1fr 50px;
        gap: var(--spacing-4);
        align-items: center;
    }
}

/* Item Product */
.item-product {
    display: flex;
    gap: var(--spacing-3);
    margin-bottom: var(--spacing-3);
}

@media (min-width: 768px) {
    .item-product {
        margin-bottom: 0;
    }
}

.item-image {
    flex-shrink: 0;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-gray-50);
    border-radius: var(--radius-md);
    overflow: hidden;
}

.item-image img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

.item-no-image {
    color: var(--color-gray-300);
}

.item-name {
    font-size: var(--text-sm);
    font-weight: 600;
    margin: 0 0 var(--spacing-1);
    line-height: 1.4;
}

.item-name a {
    color: var(--color-gray-800);
}

.item-name a:hover {
    color: var(--color-primary);
}

.item-variant,
.item-sku {
    font-size: var(--text-xs);
    color: var(--color-gray-500);
    margin: 0;
}

/* Item columns (mobile) */
.item-price,
.item-quantity,
.item-subtotal {
    display: flex;
    justify-content: space-between;
    margin-bottom: var(--spacing-2);
    font-size: var(--text-sm);
}

@media (min-width: 768px) {
    .item-price,
    .item-quantity,
    .item-subtotal {
        display: block;
        margin-bottom: 0;
    }

    [data-label]::before {
        display: none;
    }
}

[data-label]::before {
    content: attr(data-label);
    color: var(--color-gray-500);
}

/* Quantity */
.quantity-form {
    display: inline-block;
}

.cart-item .quantity-control {
    display: flex;
    align-items: center;
}

.cart-item .quantity-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-gray-100);
    border: 1px solid var(--color-gray-200);
    cursor: pointer;
}

.cart-item .quantity-btn:first-child {
    border-radius: var(--radius-sm) 0 0 var(--radius-sm);
}

.cart-item .quantity-btn:last-child {
    border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
}

.cart-item .quantity-input {
    width: 48px;
    height: 32px;
    text-align: center;
    border: 1px solid var(--color-gray-200);
    border-left: none;
    border-right: none;
    font-size: var(--text-sm);
}

/* Remove */
.item-remove {
    text-align: right;
}

.remove-btn {
    padding: var(--spacing-2);
    background: none;
    border: none;
    color: var(--color-gray-400);
    cursor: pointer;
    transition: color var(--transition-fast);
}

.remove-btn:hover {
    color: #EF4444;
}

/* Summary */
.summary-box {
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    padding: var(--spacing-6);
    position: sticky;
    top: 100px;
}

.summary-title {
    font-size: var(--text-lg);
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-200);
}

/* Shipping */
.shipping-calc {
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-200);
}

.shipping-calc h3 {
    font-size: var(--text-sm);
    font-weight: 600;
    margin-bottom: var(--spacing-3);
}

.shipping-input-group {
    display: flex;
    gap: var(--spacing-2);
    margin-bottom: var(--spacing-2);
}

.shipping-input {
    flex: 1;
    padding: var(--spacing-2) var(--spacing-3);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
}

.shipping-btn {
    padding: var(--spacing-2) var(--spacing-4);
    background: var(--color-gray-100);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    font-weight: 500;
    cursor: pointer;
}

.shipping-btn:hover {
    background: var(--color-gray-200);
}

.find-zip {
    font-size: var(--text-xs);
    color: var(--color-primary);
}

/* Summary values */
.summary-values {
    margin-bottom: var(--spacing-4);
}

.summary-row {
    display: flex;
    justify-content: space-between;
    padding: var(--spacing-2) 0;
    font-size: var(--text-sm);
}

.summary-row.discount {
    color: var(--color-success);
}

.summary-row.total {
    padding-top: var(--spacing-3);
    margin-top: var(--spacing-2);
    border-top: 1px solid var(--color-gray-200);
    font-size: var(--text-lg);
    font-weight: 700;
}

.summary-installments {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    text-align: right;
}

/* Coupon */
.coupon-section {
    margin-bottom: var(--spacing-4);
}

.coupon-form {
    display: flex;
    gap: var(--spacing-2);
}

.coupon-input {
    flex: 1;
    padding: var(--spacing-2) var(--spacing-3);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
}

.coupon-btn {
    padding: var(--spacing-2) var(--spacing-3);
    background: var(--color-gray-100);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    cursor: pointer;
}

/* Checkout button */
.checkout-btn {
    margin-bottom: var(--spacing-4);
}

.continue-shopping {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-2);
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-4);
}

.continue-shopping:hover {
    color: var(--color-primary);
}

/* Trust badges */
.trust-badges {
    display: flex;
    justify-content: center;
    gap: var(--spacing-4);
    padding-top: var(--spacing-4);
    border-top: 1px solid var(--color-gray-200);
}

.trust-badge {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    font-size: var(--text-xs);
    color: var(--color-gray-500);
}

.trust-badge svg {
    color: var(--color-success);
}

/* Cart empty */
.cart-empty {
    text-align: center;
    padding: var(--spacing-12) var(--spacing-4);
}

.cart-empty svg {
    color: var(--color-gray-300);
    margin-bottom: var(--spacing-4);
}

.cart-empty h2 {
    margin-bottom: var(--spacing-2);
}

.cart-empty p {
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
}
</style>

{# JavaScript do carrinho #}
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Atualizar quantidade automaticamente
    const quantityInputs = document.querySelectorAll('[data-update-cart]');

    quantityInputs.forEach(input => {
        let timeout;

        input.addEventListener('change', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                this.closest('form').submit();
            }, 500);
        });
    });

    // Máscara de CEP
    const zipInput = document.getElementById('shipping-zip');
    if (zipInput) {
        zipInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 5) {
                value = value.substring(0, 5) + '-' + value.substring(5, 8);
            }
            e.target.value = value;
        });
    }

    // Calcular frete (placeholder - integrar com API)
    const shippingForm = document.querySelector('[data-shipping-form]');
    const shippingResults = document.querySelector('[data-shipping-results]');

    if (shippingForm && shippingResults) {
        shippingForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const zip = this.querySelector('input[name="zip"]').value;

            if (zip.length >= 8) {
                // Aqui integraria com a API de cálculo de frete
                shippingResults.innerHTML = '<p>Calculando...</p>';
                shippingResults.style.display = 'block';

                // Simulação
                setTimeout(() => {
                    shippingResults.innerHTML = `
                        <p class="shipping-option">
                            <strong>PAC</strong> - R$ 25,00 (5-8 dias úteis)
                        </p>
                        <p class="shipping-option">
                            <strong>SEDEX</strong> - R$ 35,00 (2-4 dias úteis)
                        </p>
                    `;
                }, 1000);
            }
        });
    }
});
</script>
