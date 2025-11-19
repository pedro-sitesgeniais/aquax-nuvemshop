{# ========================================
   Product - AquaX Piscinas
   Página de detalhes do produto
   ======================================== #}

{% block body_class %}page-product{% endblock %}

{# Breadcrumbs #}
<nav class="breadcrumbs" aria-label="Navegação">
    <div class="container">
        <ul itemscope itemtype="http://schema.org/BreadcrumbList">
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{{ store.url }}" itemprop="item">
                    <span itemprop="name">Início</span>
                </a>
                <meta itemprop="position" content="1">
            </li>
            {% if product.category %}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{{ product.category.url }}" itemprop="item">
                    <span itemprop="name">{{ product.category.name }}</span>
                </a>
                <meta itemprop="position" content="2">
            </li>
            {% endif %}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <span itemprop="name">{{ product.name }}</span>
                <meta itemprop="position" content="3">
            </li>
        </ul>
    </div>
</nav>

{# Conteúdo do produto #}
<section class="product-detail section" itemscope itemtype="http://schema.org/Product">
    <div class="container">
        <div class="product-main">
            {# Galeria de imagens #}
            <div class="product-gallery">
                {# Imagem principal #}
                <div class="gallery-main">
                    {% if product.images %}
                    <div class="gallery-image" data-zoom>
                        <img src="{{ product.featured_image }}"
                             alt="{{ product.name }}"
                             id="product-main-image"
                             itemprop="image"
                             loading="eager">
                    </div>
                    {% else %}
                    <div class="gallery-no-image">
                        <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                            <circle cx="8.5" cy="8.5" r="1.5"/>
                            <polyline points="21 15 16 10 5 21"/>
                        </svg>
                    </div>
                    {% endif %}

                    {# Badges #}
                    <div class="product-badges">
                        {% if product.promotional %}
                        <span class="badge badge-sale">Oferta</span>
                        {% endif %}
                        {% if product.new %}
                        <span class="badge badge-new">Novo</span>
                        {% endif %}
                    </div>
                </div>

                {# Thumbnails #}
                {% if product.images | length > 1 %}
                <div class="gallery-thumbs">
                    {% for image in product.images %}
                    <button class="gallery-thumb {% if loop.first %}active{% endif %}"
                            data-image="{{ image }}"
                            aria-label="Ver imagem {{ loop.index }}">
                        <img src="{{ image }}" alt="{{ product.name }} - Imagem {{ loop.index }}" loading="lazy">
                    </button>
                    {% endfor %}
                </div>
                {% endif %}
            </div>

            {# Informações do produto #}
            <div class="product-info-detail">
                {# Nome #}
                <h1 class="product-title" itemprop="name">{{ product.name }}</h1>

                {# SKU #}
                {% if product.sku %}
                <p class="product-sku">
                    <span>SKU:</span> <span itemprop="sku">{{ product.sku }}</span>
                </p>
                {% endif %}

                {# Preço #}
                <div class="product-pricing" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                    <meta itemprop="priceCurrency" content="{{ store.currency }}">
                    <link itemprop="availability" href="http://schema.org/{% if product.available %}InStock{% else %}OutOfStock{% endif %}">

                    {% if product.compare_at_price %}
                    <div class="price-compare">
                        <span>De:</span>
                        <span class="price-old">{{ product.compare_at_price | money }}</span>
                        {% set discount = ((product.compare_at_price - product.price) / product.compare_at_price * 100) | round %}
                        <span class="price-discount">-{{ discount }}%</span>
                    </div>
                    {% endif %}

                    <div class="price-main">
                        <span class="price-label">Por:</span>
                        <span class="price-value" itemprop="price" content="{{ product.price }}">
                            {{ product.price | money }}
                        </span>
                    </div>

                    {% if product.installments %}
                    <div class="price-installments">
                        {{ product.installments }}
                    </div>
                    {% endif %}
                </div>

                {# Descrição curta #}
                {% if product.short_description %}
                <div class="product-short-description">
                    {{ product.short_description }}
                </div>
                {% endif %}

                {# Formulário de compra #}
                <form method="post" action="{{ store.cart_url }}" class="product-form-detail" id="product-form">
                    <input type="hidden" name="add_to_cart" value="{{ product.id }}">

                    {# Variantes #}
                    {% if product.variants %}
                    <div class="product-variants">
                        {% for variant in product.variants %}
                        <div class="variant-group">
                            <label class="variant-label">{{ variant.name }}</label>
                            <div class="variant-options">
                                {% for option in variant.options %}
                                <label class="variant-option">
                                    <input type="radio"
                                           name="variant[{{ variant.id }}]"
                                           value="{{ option.id }}"
                                           {% if option.stock == 0 %}disabled{% endif %}
                                           {% if loop.first %}checked{% endif %}>
                                    <span class="variant-option-label">{{ option.name }}</span>
                                </label>
                                {% endfor %}
                            </div>
                        </div>
                        {% endfor %}
                    </div>
                    {% endif %}

                    {# Quantidade #}
                    <div class="quantity-wrapper" data-quantity-wrapper>
                        <label class="quantity-label">Quantidade</label>
                        <div class="quantity-control">
                            <button type="button" class="quantity-btn" data-quantity-btn="minus" aria-label="Diminuir">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="5" y1="12" x2="19" y2="12"/>
                                </svg>
                            </button>
                            <input type="number"
                                   name="quantity"
                                   value="1"
                                   min="1"
                                   max="{{ product.stock | default(99) }}"
                                   class="quantity-input"
                                   aria-label="Quantidade">
                            <button type="button" class="quantity-btn" data-quantity-btn="plus" aria-label="Aumentar">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="12" y1="5" x2="12" y2="19"/>
                                    <line x1="5" y1="12" x2="19" y2="12"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    {# Botões de ação #}
                    <div class="product-actions">
                        {% if product.available %}
                        <button type="submit" class="btn btn-primary btn-lg btn-block add-to-cart-btn">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="9" cy="21" r="1"/>
                                <circle cx="20" cy="21" r="1"/>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                            </svg>
                            Adicionar ao Carrinho
                        </button>
                        {% else %}
                        <button type="button" class="btn btn-secondary btn-lg btn-block" disabled>
                            Produto Indisponível
                        </button>
                        {% endif %}
                    </div>
                </form>

                {# Informações adicionais #}
                <div class="product-meta">
                    {% if product.available %}
                    <div class="meta-item stock-available">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        <span>Produto em estoque</span>
                    </div>
                    {% endif %}

                    <div class="meta-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="1" y="3" width="15" height="13"/>
                            <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
                            <circle cx="5.5" cy="18.5" r="2.5"/>
                            <circle cx="18.5" cy="18.5" r="2.5"/>
                        </svg>
                        <span>Calcule o frete no carrinho</span>
                    </div>

                    <div class="meta-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <span>Compra 100% segura</span>
                    </div>
                </div>

                {# Compartilhar #}
                <div class="product-share">
                    <span>Compartilhar:</span>
                    <a href="https://www.facebook.com/sharer/sharer.php?u={{ product.url }}"
                       target="_blank"
                       rel="noopener noreferrer"
                       aria-label="Compartilhar no Facebook">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>
                        </svg>
                    </a>
                    <a href="https://wa.me/?text={{ product.name }} - {{ product.url }}"
                       target="_blank"
                       rel="noopener noreferrer"
                       aria-label="Compartilhar no WhatsApp">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>

        {# Tabs de conteúdo #}
        <div class="product-tabs">
            <div class="tabs-nav" role="tablist">
                <button class="tab-btn active"
                        role="tab"
                        aria-selected="true"
                        aria-controls="tab-description"
                        data-tab="description">
                    Descrição
                </button>
                {% if product.specifications %}
                <button class="tab-btn"
                        role="tab"
                        aria-selected="false"
                        aria-controls="tab-specs"
                        data-tab="specs">
                    Especificações
                </button>
                {% endif %}
            </div>

            <div class="tabs-content">
                <div class="tab-panel active"
                     id="tab-description"
                     role="tabpanel"
                     data-tab-panel="description">
                    <div class="product-description" itemprop="description">
                        {{ product.description }}
                    </div>
                </div>

                {% if product.specifications %}
                <div class="tab-panel"
                     id="tab-specs"
                     role="tabpanel"
                     data-tab-panel="specs">
                    <table class="specs-table">
                        {% for spec in product.specifications %}
                        <tr>
                            <th>{{ spec.name }}</th>
                            <td>{{ spec.value }}</td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                {% endif %}
            </div>
        </div>

        {# Produtos relacionados #}
        {% if related_products %}
        <div class="related-products">
            <div class="section-title">
                <h2>Produtos Relacionados</h2>
            </div>

            <div class="row">
                {% for product in related_products | slice(0, 4) %}
                <div class="col-6 col-md-3">
                    {% include 'snipplets/product-card.tpl' with { 'product': product } %}
                </div>
                {% endfor %}
            </div>
        </div>
        {% endif %}
    </div>
</section>

{# Estilos da página de produto #}
<style>
/* Layout principal */
.product-main {
    display: grid;
    gap: var(--spacing-8);
    margin-bottom: var(--spacing-12);
}

@media (min-width: 992px) {
    .product-main {
        grid-template-columns: 1fr 1fr;
    }
}

/* Galeria */
.gallery-main {
    position: relative;
    margin-bottom: var(--spacing-4);
}

.gallery-image {
    background: var(--color-gray-50);
    border-radius: var(--radius-lg);
    padding: var(--spacing-4);
    cursor: zoom-in;
}

.gallery-image img {
    width: 100%;
    height: auto;
}

.gallery-no-image {
    aspect-ratio: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-gray-100);
    border-radius: var(--radius-lg);
    color: var(--color-gray-300);
}

.gallery-thumbs {
    display: flex;
    gap: var(--spacing-2);
    overflow-x: auto;
    padding-bottom: var(--spacing-2);
}

.gallery-thumb {
    flex-shrink: 0;
    width: 60px;
    height: 60px;
    padding: var(--spacing-1);
    background: var(--color-white);
    border: 2px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: border-color var(--transition-fast);
}

.gallery-thumb:hover,
.gallery-thumb.active {
    border-color: var(--color-primary);
}

.gallery-thumb img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

/* Info produto */
.product-title {
    font-size: var(--text-2xl);
    margin-bottom: var(--spacing-2);
}

@media (min-width: 768px) {
    .product-title {
        font-size: var(--text-3xl);
    }
}

.product-sku {
    font-size: var(--text-sm);
    color: var(--color-gray-500);
    margin-bottom: var(--spacing-4);
}

/* Preços */
.product-pricing {
    padding: var(--spacing-4);
    background: var(--color-light);
    border-radius: var(--radius-lg);
    margin-bottom: var(--spacing-6);
}

.price-compare {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    margin-bottom: var(--spacing-2);
    font-size: var(--text-sm);
}

.price-old {
    text-decoration: line-through;
    color: var(--color-gray-500);
}

.price-discount {
    padding: var(--spacing-1) var(--spacing-2);
    background: #EF4444;
    color: var(--color-white);
    border-radius: var(--radius-sm);
    font-weight: 600;
    font-size: var(--text-xs);
}

.price-main {
    display: flex;
    align-items: baseline;
    gap: var(--spacing-2);
}

.price-label {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.price-value {
    font-size: var(--text-3xl);
    font-weight: 700;
    color: var(--color-primary);
}

.price-installments {
    margin-top: var(--spacing-2);
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

/* Descrição curta */
.product-short-description {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
    line-height: 1.7;
}

/* Variantes */
.product-variants {
    margin-bottom: var(--spacing-4);
}

.variant-group {
    margin-bottom: var(--spacing-4);
}

.variant-label {
    display: block;
    font-weight: 600;
    margin-bottom: var(--spacing-2);
}

.variant-options {
    display: flex;
    flex-wrap: wrap;
    gap: var(--spacing-2);
}

.variant-option {
    cursor: pointer;
}

.variant-option input {
    position: absolute;
    opacity: 0;
}

.variant-option-label {
    display: block;
    padding: var(--spacing-2) var(--spacing-4);
    border: 2px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    transition: all var(--transition-fast);
}

.variant-option input:checked + .variant-option-label {
    border-color: var(--color-primary);
    background: var(--color-light);
}

.variant-option input:disabled + .variant-option-label {
    opacity: 0.5;
    cursor: not-allowed;
    text-decoration: line-through;
}

/* Quantidade */
.quantity-wrapper {
    margin-bottom: var(--spacing-4);
}

.quantity-label {
    display: block;
    font-weight: 600;
    margin-bottom: var(--spacing-2);
}

.quantity-control {
    display: flex;
    align-items: center;
    width: fit-content;
}

.quantity-btn {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-gray-100);
    border: 1px solid var(--color-gray-200);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.quantity-btn:first-child {
    border-radius: var(--radius-md) 0 0 var(--radius-md);
}

.quantity-btn:last-child {
    border-radius: 0 var(--radius-md) var(--radius-md) 0;
}

.quantity-btn:hover {
    background: var(--color-gray-200);
}

.quantity-input {
    width: 60px;
    height: 40px;
    text-align: center;
    border: 1px solid var(--color-gray-200);
    border-left: none;
    border-right: none;
    font-size: var(--text-base);
    -moz-appearance: textfield;
}

.quantity-input::-webkit-outer-spin-button,
.quantity-input::-webkit-inner-spin-button {
    -webkit-appearance: none;
}

/* Botões de ação */
.product-actions {
    margin-bottom: var(--spacing-6);
}

.add-to-cart-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-2);
}

/* Meta informações */
.product-meta {
    margin-bottom: var(--spacing-6);
}

.meta-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-2);
}

.meta-item svg {
    color: var(--color-primary);
}

.stock-available {
    color: var(--color-success);
}

.stock-available svg {
    color: var(--color-success);
}

/* Compartilhar */
.product-share {
    display: flex;
    align-items: center;
    gap: var(--spacing-3);
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.product-share a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    background: var(--color-gray-100);
    border-radius: var(--radius-full);
    color: var(--color-gray-600);
    transition: all var(--transition-fast);
}

.product-share a:hover {
    background: var(--color-primary);
    color: var(--color-white);
}

/* Tabs */
.product-tabs {
    margin-bottom: var(--spacing-12);
}

.tabs-nav {
    display: flex;
    border-bottom: 2px solid var(--color-gray-200);
    margin-bottom: var(--spacing-6);
    overflow-x: auto;
}

.tab-btn {
    padding: var(--spacing-4) var(--spacing-6);
    background: none;
    border: none;
    font-size: var(--text-base);
    font-weight: 600;
    color: var(--color-gray-500);
    cursor: pointer;
    white-space: nowrap;
    position: relative;
    transition: color var(--transition-fast);
}

.tab-btn::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    right: 0;
    height: 2px;
    background: var(--color-primary);
    transform: scaleX(0);
    transition: transform var(--transition-fast);
}

.tab-btn:hover {
    color: var(--color-gray-700);
}

.tab-btn.active {
    color: var(--color-primary);
}

.tab-btn.active::after {
    transform: scaleX(1);
}

.tab-panel {
    display: none;
}

.tab-panel.active {
    display: block;
}

.product-description {
    line-height: 1.8;
    color: var(--color-gray-700);
}

.product-description img {
    max-width: 100%;
    height: auto;
    margin: var(--spacing-4) 0;
}

/* Especificações */
.specs-table {
    width: 100%;
    border-collapse: collapse;
}

.specs-table th,
.specs-table td {
    padding: var(--spacing-3) var(--spacing-4);
    text-align: left;
    border-bottom: 1px solid var(--color-gray-200);
}

.specs-table th {
    font-weight: 600;
    background: var(--color-gray-50);
    width: 30%;
}

/* Relacionados */
.related-products {
    padding-top: var(--spacing-8);
    border-top: 1px solid var(--color-gray-200);
}
</style>

{# JavaScript da página de produto #}
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Galeria - trocar imagem principal
    const thumbs = document.querySelectorAll('.gallery-thumb');
    const mainImage = document.getElementById('product-main-image');

    thumbs.forEach(thumb => {
        thumb.addEventListener('click', function() {
            thumbs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            mainImage.src = this.dataset.image;
        });
    });

    // Tabs
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabPanels = document.querySelectorAll('.tab-panel');

    tabButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const tab = this.dataset.tab;

            tabButtons.forEach(b => {
                b.classList.remove('active');
                b.setAttribute('aria-selected', 'false');
            });

            tabPanels.forEach(p => p.classList.remove('active'));

            this.classList.add('active');
            this.setAttribute('aria-selected', 'true');
            document.querySelector(`[data-tab-panel="${tab}"]`).classList.add('active');
        });
    });

    // Zoom simples (abrir em modal)
    const zoomTrigger = document.querySelector('[data-zoom]');
    if (zoomTrigger) {
        zoomTrigger.addEventListener('click', function() {
            const img = this.querySelector('img');
            const modal = document.createElement('div');
            modal.className = 'zoom-modal';
            modal.innerHTML = `
                <div class="zoom-modal-content">
                    <img src="${img.src}" alt="${img.alt}">
                    <button class="zoom-close" aria-label="Fechar">&times;</button>
                </div>
            `;
            document.body.appendChild(modal);
            document.body.style.overflow = 'hidden';

            modal.addEventListener('click', function(e) {
                if (e.target === modal || e.target.classList.contains('zoom-close')) {
                    modal.remove();
                    document.body.style.overflow = '';
                }
            });
        });
    }
});
</script>

<style>
/* Zoom Modal */
.zoom-modal {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: var(--z-modal);
    padding: var(--spacing-4);
}

.zoom-modal-content {
    position: relative;
    max-width: 90vw;
    max-height: 90vh;
}

.zoom-modal-content img {
    max-width: 100%;
    max-height: 90vh;
    object-fit: contain;
}

.zoom-close {
    position: absolute;
    top: -40px;
    right: 0;
    width: 40px;
    height: 40px;
    background: var(--color-white);
    border: none;
    border-radius: var(--radius-full);
    font-size: 24px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}
</style>
