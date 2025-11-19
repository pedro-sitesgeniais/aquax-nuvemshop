{# ========================================
   Product Grid - AquaX Piscinas
   Grid de produtos reutilizável
   ======================================== #}

{% if products %}
<div class="product-grid {% if grid_class %}{{ grid_class }}{% endif %}">
    {% for product in products %}
        {% include 'snipplets/product-card.tpl' with { 'product': product } %}
    {% endfor %}
</div>

{% if show_pagination and pages.total > 1 %}
<nav class="pagination" aria-label="Paginação de produtos">
    {% if pages.previous %}
    <a href="{{ pages.previous.url }}" class="pagination-btn prev" aria-label="Página anterior">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="15 18 9 12 15 6"/>
        </svg>
    </a>
    {% endif %}

    <div class="pagination-numbers">
        {% for page in pages.items %}
            {% if page.current %}
            <span class="pagination-number active" aria-current="page">{{ page.number }}</span>
            {% elseif page.separator %}
            <span class="pagination-ellipsis">...</span>
            {% else %}
            <a href="{{ page.url }}" class="pagination-number">{{ page.number }}</a>
            {% endif %}
        {% endfor %}
    </div>

    {% if pages.next %}
    <a href="{{ pages.next.url }}" class="pagination-btn next" aria-label="Próxima página">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"/>
        </svg>
    </a>
    {% endif %}
</nav>
{% endif %}

{% else %}
<div class="no-products-message">
    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
        <circle cx="11" cy="11" r="8"/>
        <path d="m21 21-4.35-4.35"/>
    </svg>
    <p>{{ empty_message | default('Nenhum produto encontrado') }}</p>
</div>
{% endif %}

<style>
.product-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-4);
}

@media (min-width: 576px) {
    .product-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (min-width: 768px) {
    .product-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (min-width: 992px) {
    .product-grid {
        grid-template-columns: repeat(4, 1fr);
    }
}

/* Variações de grid */
.product-grid.grid-3 {
    @media (min-width: 768px) {
        grid-template-columns: repeat(3, 1fr);
    }
}

.product-grid.grid-5 {
    @media (min-width: 1200px) {
        grid-template-columns: repeat(5, 1fr);
    }
}

.no-products-message {
    text-align: center;
    padding: var(--spacing-12) var(--spacing-4);
    color: var(--color-gray-400);
}

.no-products-message svg {
    margin-bottom: var(--spacing-4);
}

.no-products-message p {
    margin: 0;
    font-size: var(--text-lg);
}
</style>
