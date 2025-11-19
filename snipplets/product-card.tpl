{# ========================================
   Product Card - AquaX Piscinas
   Card de produto reutilizável
   ======================================== #}

<article class="product-card" itemscope itemtype="http://schema.org/Product">
    {# Badges/Tags #}
    <div class="product-badges">
        {% if product.promotional %}
        <span class="badge badge-sale">Oferta</span>
        {% endif %}
        {% if product.new %}
        <span class="badge badge-new">Novo</span>
        {% endif %}
        {% if product.free_shipping %}
        <span class="badge badge-shipping">Frete Grátis</span>
        {% endif %}
    </div>

    {# Imagem do produto #}
    <a href="{{ product.url }}" class="product-image-link">
        <div class="product-image">
            {% if product.featured_image %}
            <img src="{{ product.featured_image }}"
                 alt="{{ product.name }}"
                 itemprop="image"
                 loading="lazy"
                 width="300"
                 height="300">
            {% else %}
            <div class="product-no-image">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                    <circle cx="8.5" cy="8.5" r="1.5"/>
                    <polyline points="21 15 16 10 5 21"/>
                </svg>
            </div>
            {% endif %}
        </div>

        {# Overlay com ações rápidas #}
        <div class="product-actions-overlay">
            <button type="button"
                    class="btn-quick-action"
                    data-quick-view="{{ product.id }}"
                    aria-label="Visualização rápida">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                    <circle cx="12" cy="12" r="3"/>
                </svg>
            </button>
        </div>
    </a>

    {# Informações do produto #}
    <div class="product-info">
        {# Nome #}
        <h3 class="product-name" itemprop="name">
            <a href="{{ product.url }}">{{ product.name }}</a>
        </h3>

        {# Preço #}
        <div class="product-price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
            <meta itemprop="priceCurrency" content="{{ store.currency }}">

            {% if product.compare_at_price %}
            <span class="price-compare">{{ product.compare_at_price | money }}</span>
            {% endif %}

            <span class="price-current" itemprop="price" content="{{ product.price }}">
                {{ product.price | money }}
            </span>

            {% if product.available %}
            <link itemprop="availability" href="http://schema.org/InStock">
            {% else %}
            <link itemprop="availability" href="http://schema.org/OutOfStock">
            {% endif %}
        </div>

        {# Parcelas #}
        {% if product.installments %}
        <div class="product-installments">
            <span>{{ product.installments }}</span>
        </div>
        {% endif %}

        {# Botão Comprar #}
        {% if product.available %}
            {% if product.has_variants %}
            <a href="{{ product.url }}" class="btn btn-primary btn-block product-btn">
                Ver opções
            </a>
            {% else %}
            <form method="post" action="{{ store.cart_url }}" class="product-form">
                <input type="hidden" name="add_to_cart" value="{{ product.id }}">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="btn btn-primary btn-block product-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"/>
                        <circle cx="20" cy="21" r="1"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                    </svg>
                    Comprar
                </button>
            </form>
            {% endif %}
        {% else %}
        <button type="button" class="btn btn-secondary btn-block product-btn" disabled>
            Indisponível
        </button>
        {% endif %}
    </div>
</article>

{# Estilos do Product Card #}
<style>
.product-card {
    position: relative;
    display: flex;
    flex-direction: column;
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    overflow: hidden;
    transition: all var(--transition-fast);
}

.product-card:hover {
    border-color: var(--color-gray-300);
    box-shadow: var(--shadow-lg);
}

/* Badges */
.product-badges {
    position: absolute;
    top: var(--spacing-3);
    left: var(--spacing-3);
    z-index: 5;
    display: flex;
    flex-direction: column;
    gap: var(--spacing-1);
}

.badge {
    display: inline-block;
    padding: var(--spacing-1) var(--spacing-2);
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
    border-radius: var(--radius-sm);
}

.badge-sale {
    background: #EF4444;
    color: var(--color-white);
}

.badge-new {
    background: var(--color-success);
    color: var(--color-white);
}

.badge-shipping {
    background: var(--color-primary);
    color: var(--color-white);
}

/* Imagem */
.product-image-link {
    position: relative;
    display: block;
}

.product-image {
    aspect-ratio: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--spacing-4);
    background: var(--color-gray-50);
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform var(--transition-base);
}

.product-card:hover .product-image img {
    transform: scale(1.05);
}

.product-no-image {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--color-gray-300);
}

/* Actions Overlay */
.product-actions-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: var(--spacing-3);
    background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);
    display: flex;
    justify-content: center;
    gap: var(--spacing-2);
    opacity: 0;
    transform: translateY(10px);
    transition: all var(--transition-fast);
}

.product-card:hover .product-actions-overlay {
    opacity: 1;
    transform: translateY(0);
}

.btn-quick-action {
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-white);
    border: none;
    border-radius: var(--radius-full);
    color: var(--color-gray-700);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.btn-quick-action:hover {
    background: var(--color-primary);
    color: var(--color-white);
}

/* Info */
.product-info {
    padding: var(--spacing-4);
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.product-name {
    font-size: var(--text-sm);
    font-weight: 500;
    margin: 0 0 var(--spacing-2);
    line-height: 1.4;

    /* Limitar a 2 linhas */
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.product-name a {
    color: var(--color-gray-800);
}

.product-name a:hover {
    color: var(--color-primary);
}

/* Preço */
.product-price {
    margin-bottom: var(--spacing-2);
}

.price-compare {
    display: block;
    font-size: var(--text-sm);
    color: var(--color-gray-500);
    text-decoration: line-through;
}

.price-current {
    font-size: var(--text-lg);
    font-weight: 700;
    color: var(--color-primary);
}

/* Parcelas */
.product-installments {
    font-size: var(--text-xs);
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-3);
}

/* Botão */
.product-btn {
    margin-top: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-2);
}

.product-form {
    margin-top: auto;
}
</style>
