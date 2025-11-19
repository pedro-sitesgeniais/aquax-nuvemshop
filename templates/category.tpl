{# ========================================
   Category - AquaX Piscinas
   Página de listagem de produtos por categoria
   ======================================== #}

{% block body_class %}page-category{% endblock %}

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
            {% if category.parent %}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{{ category.parent.url }}" itemprop="item">
                    <span itemprop="name">{{ category.parent.name }}</span>
                </a>
                <meta itemprop="position" content="2">
            </li>
            {% endif %}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <span itemprop="name">{{ category.name }}</span>
                <meta itemprop="position" content="{% if category.parent %}3{% else %}2{% endif %}">
            </li>
        </ul>
    </div>
</nav>

{# Cabeçalho da categoria #}
<section class="category-header">
    <div class="container">
        <h1>{{ category.name }}</h1>
        {% if category.description %}
        <div class="category-description">
            {{ category.description }}
        </div>
        {% endif %}
    </div>
</section>

{# Conteúdo principal #}
<section class="category-content section">
    <div class="container">
        <div class="category-layout">
            {# Sidebar com filtros #}
            <aside class="category-sidebar">
                <div class="filters-wrapper">
                    <div class="filters-header">
                        <h2 class="filters-title">Filtros</h2>
                        <button class="filters-clear" data-clear-filters>
                            Limpar filtros
                        </button>
                    </div>

                    {# Subcategorias #}
                    {% if category.subcategories %}
                    <div class="filter-group">
                        <h3 class="filter-group-title">Categorias</h3>
                        <ul class="filter-list">
                            {% for subcategory in category.subcategories %}
                            <li>
                                <a href="{{ subcategory.url }}">
                                    {{ subcategory.name }}
                                    {% if subcategory.products_count %}
                                    <span class="count">({{ subcategory.products_count }})</span>
                                    {% endif %}
                                </a>
                            </li>
                            {% endfor %}
                        </ul>
                    </div>
                    {% endif %}

                    {# Filtro de preço #}
                    <div class="filter-group">
                        <h3 class="filter-group-title">Preço</h3>
                        <div class="price-filter">
                            <div class="price-inputs">
                                <input type="number"
                                       placeholder="Min"
                                       class="price-input"
                                       data-price-min>
                                <span>até</span>
                                <input type="number"
                                       placeholder="Max"
                                       class="price-input"
                                       data-price-max>
                            </div>
                            <button class="btn btn-secondary btn-sm" data-apply-price>
                                Aplicar
                            </button>
                        </div>
                    </div>

                    {# Filtros dinâmicos (se disponíveis) #}
                    {% if filters %}
                    {% for filter in filters %}
                    <div class="filter-group">
                        <h3 class="filter-group-title">{{ filter.name }}</h3>
                        <ul class="filter-list">
                            {% for option in filter.options %}
                            <li>
                                <label class="filter-checkbox">
                                    <input type="checkbox"
                                           name="filter[{{ filter.id }}][]"
                                           value="{{ option.id }}"
                                           {% if option.active %}checked{% endif %}>
                                    <span>{{ option.name }}</span>
                                    {% if option.count %}
                                    <span class="count">({{ option.count }})</span>
                                    {% endif %}
                                </label>
                            </li>
                            {% endfor %}
                        </ul>
                    </div>
                    {% endfor %}
                    {% endif %}
                </div>

                {# Botão para mobile #}
                <button class="filters-toggle" data-toggle-filters aria-expanded="false">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
                    </svg>
                    Filtros
                </button>
            </aside>

            {# Lista de produtos #}
            <div class="category-products">
                {# Toolbar #}
                <div class="products-toolbar">
                    <div class="toolbar-left">
                        <span class="products-count">
                            {{ products | length }} produto(s)
                        </span>
                    </div>
                    <div class="toolbar-right">
                        <label for="sort-select" class="visually-hidden">Ordenar por</label>
                        <select id="sort-select" class="sort-select" data-sort>
                            <option value="relevance">Relevância</option>
                            <option value="price-asc">Menor preço</option>
                            <option value="price-desc">Maior preço</option>
                            <option value="name-asc">A-Z</option>
                            <option value="name-desc">Z-A</option>
                            <option value="newest">Mais recentes</option>
                        </select>
                    </div>
                </div>

                {# Grid de produtos #}
                {% if products %}
                <div class="products-grid">
                    {% for product in products %}
                        {% include 'snipplets/product-card.tpl' with { 'product': product } %}
                    {% endfor %}
                </div>

                {# Paginação #}
                {% if pages.total > 1 %}
                <nav class="pagination" aria-label="Paginação">
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
                {# Sem produtos #}
                <div class="no-products">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    <h3>Nenhum produto encontrado</h3>
                    <p>Tente ajustar os filtros ou buscar por outro termo.</p>
                    <a href="{{ store.url }}" class="btn btn-primary">
                        Voltar à loja
                    </a>
                </div>
                {% endif %}
            </div>
        </div>
    </div>
</section>

{# Estilos da página de categoria #}
<style>
/* Header da categoria */
.category-header {
    padding: var(--spacing-8) 0;
    background: var(--color-light);
    text-align: center;
}

.category-header h1 {
    margin-bottom: var(--spacing-2);
}

.category-description {
    max-width: 700px;
    margin: 0 auto;
    color: var(--color-gray-600);
    font-size: var(--text-sm);
}

/* Layout */
.category-layout {
    display: grid;
    gap: var(--spacing-6);
}

@media (min-width: 992px) {
    .category-layout {
        grid-template-columns: 260px 1fr;
    }
}

/* Sidebar */
.category-sidebar {
    position: relative;
}

.filters-wrapper {
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    padding: var(--spacing-4);
    position: sticky;
    top: 100px;
}

@media (max-width: 991px) {
    .filters-wrapper {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: var(--z-modal);
        border-radius: 0;
        overflow-y: auto;
    }

    .filters-wrapper.active {
        display: block;
    }
}

.filters-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-200);
}

.filters-title {
    font-size: var(--text-lg);
    margin: 0;
}

.filters-clear {
    background: none;
    border: none;
    color: var(--color-primary);
    font-size: var(--text-sm);
    cursor: pointer;
}

.filters-clear:hover {
    text-decoration: underline;
}

/* Filter groups */
.filter-group {
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-100);
}

.filter-group:last-child {
    margin-bottom: 0;
    padding-bottom: 0;
    border-bottom: none;
}

.filter-group-title {
    font-size: var(--text-sm);
    font-weight: 600;
    margin-bottom: var(--spacing-3);
}

.filter-list {
    max-height: 200px;
    overflow-y: auto;
}

.filter-list li {
    margin-bottom: var(--spacing-2);
}

.filter-list a {
    display: flex;
    justify-content: space-between;
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.filter-list a:hover {
    color: var(--color-primary);
}

.filter-list .count {
    color: var(--color-gray-400);
    font-size: var(--text-xs);
}

.filter-checkbox {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    font-size: var(--text-sm);
    cursor: pointer;
}

.filter-checkbox input {
    accent-color: var(--color-primary);
}

/* Price filter */
.price-filter {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-3);
}

.price-inputs {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
}

.price-input {
    width: 80px;
    padding: var(--spacing-2);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-sm);
    font-size: var(--text-sm);
}

/* Botão de filtros mobile */
.filters-toggle {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    padding: var(--spacing-3) var(--spacing-4);
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    font-weight: 500;
    cursor: pointer;
    width: 100%;
    justify-content: center;
    margin-bottom: var(--spacing-4);
}

@media (min-width: 992px) {
    .filters-toggle {
        display: none;
    }
}

/* Toolbar */
.products-toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-200);
}

.products-count {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.sort-select {
    padding: var(--spacing-2) var(--spacing-8) var(--spacing-2) var(--spacing-3);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    background: var(--color-white);
    cursor: pointer;
}

/* Products Grid */
.products-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-4);
}

@media (min-width: 576px) {
    .products-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (min-width: 768px) {
    .products-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (min-width: 1200px) {
    .products-grid {
        grid-template-columns: repeat(4, 1fr);
    }
}

/* Paginação */
.pagination {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-2);
    margin-top: var(--spacing-8);
}

.pagination-btn {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    color: var(--color-gray-600);
    transition: all var(--transition-fast);
}

.pagination-btn:hover {
    border-color: var(--color-primary);
    color: var(--color-primary);
}

.pagination-numbers {
    display: flex;
    gap: var(--spacing-1);
}

.pagination-number {
    min-width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: var(--radius-md);
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    transition: all var(--transition-fast);
}

.pagination-number:hover {
    background: var(--color-gray-100);
}

.pagination-number.active {
    background: var(--color-primary);
    color: var(--color-white);
}

.pagination-ellipsis {
    display: flex;
    align-items: center;
    padding: 0 var(--spacing-2);
    color: var(--color-gray-400);
}

/* No products */
.no-products {
    text-align: center;
    padding: var(--spacing-12) var(--spacing-4);
}

.no-products svg {
    color: var(--color-gray-300);
    margin-bottom: var(--spacing-4);
}

.no-products h3 {
    margin-bottom: var(--spacing-2);
}

.no-products p {
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
}
</style>

{# JavaScript da página de categoria #}
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Toggle filtros mobile
    const toggleBtn = document.querySelector('[data-toggle-filters]');
    const filtersWrapper = document.querySelector('.filters-wrapper');

    if (toggleBtn && filtersWrapper) {
        toggleBtn.addEventListener('click', function() {
            const isExpanded = this.getAttribute('aria-expanded') === 'true';
            this.setAttribute('aria-expanded', !isExpanded);
            filtersWrapper.classList.toggle('active');
            document.body.style.overflow = !isExpanded ? 'hidden' : '';
        });
    }

    // Ordenação
    const sortSelect = document.querySelector('[data-sort]');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            const url = new URL(window.location);
            url.searchParams.set('sort', this.value);
            window.location = url;
        });

        // Selecionar opção atual
        const currentSort = new URLSearchParams(window.location.search).get('sort');
        if (currentSort) {
            sortSelect.value = currentSort;
        }
    }

    // Limpar filtros
    const clearBtn = document.querySelector('[data-clear-filters]');
    if (clearBtn) {
        clearBtn.addEventListener('click', function() {
            const url = new URL(window.location);
            url.search = '';
            window.location = url;
        });
    }

    // Filtros checkbox (opcional - AJAX)
    const filterCheckboxes = document.querySelectorAll('.filter-checkbox input');
    filterCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // Aqui pode implementar AJAX para filtros dinâmicos
            // Por enquanto, apenas mostra feedback visual
            this.closest('.filter-checkbox').classList.toggle('checked', this.checked);
        });
    });
});
</script>
