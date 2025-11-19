{# ========================================
   Search Results - AquaX Piscinas
   Página de resultados de busca
   ======================================== #}

{% block body_class %}page-search{% endblock %}

{# Breadcrumbs #}
<nav class="breadcrumbs" aria-label="Navegação">
    <div class="container">
        <ul>
            <li><a href="{{ store.url }}">Início</a></li>
            <li><span>Busca</span></li>
        </ul>
    </div>
</nav>

<section class="search-section section">
    <div class="container">
        {# Cabeçalho da busca #}
        <div class="search-header">
            <h1>Resultados da busca</h1>
            {% if search_query %}
            <p class="search-query">
                Você buscou por: <strong>"{{ search_query }}"</strong>
            </p>
            {% endif %}

            {# Formulário de busca #}
            <form action="{{ store.search_url }}" method="get" class="search-form-page">
                <input type="search"
                       name="q"
                       value="{{ search_query }}"
                       placeholder="Buscar produtos..."
                       class="search-input-page"
                       aria-label="Buscar">
                <button type="submit" class="search-btn-page">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    Buscar
                </button>
            </form>
        </div>

        {% if products %}
        {# Resultados encontrados #}
        <div class="search-results">
            <div class="results-toolbar">
                <span class="results-count">
                    {{ products | length }} produto(s) encontrado(s)
                </span>
                <select class="sort-select" data-sort>
                    <option value="relevance">Relevância</option>
                    <option value="price-asc">Menor preço</option>
                    <option value="price-desc">Maior preço</option>
                    <option value="name-asc">A-Z</option>
                </select>
            </div>

            {# Grid de produtos #}
            <div class="products-grid">
                {% for product in products %}
                    {% include 'snipplets/product-card.tpl' with { 'product': product } %}
                {% endfor %}
            </div>

            {# Paginação #}
            {% if pages.total > 1 %}
            <nav class="pagination" aria-label="Paginação">
                {% if pages.previous %}
                <a href="{{ pages.previous.url }}" class="pagination-btn prev">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="15 18 9 12 15 6"/>
                    </svg>
                </a>
                {% endif %}

                <div class="pagination-numbers">
                    {% for page in pages.items %}
                        {% if page.current %}
                        <span class="pagination-number active">{{ page.number }}</span>
                        {% elseif page.separator %}
                        <span class="pagination-ellipsis">...</span>
                        {% else %}
                        <a href="{{ page.url }}" class="pagination-number">{{ page.number }}</a>
                        {% endif %}
                    {% endfor %}
                </div>

                {% if pages.next %}
                <a href="{{ pages.next.url }}" class="pagination-btn next">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 18 15 12 9 6"/>
                    </svg>
                </a>
                {% endif %}
            </nav>
            {% endif %}
        </div>

        {% else %}
        {# Nenhum resultado #}
        <div class="no-results">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                <circle cx="11" cy="11" r="8"/>
                <path d="m21 21-4.35-4.35"/>
                <path d="M8 11h6"/>
            </svg>
            <h2>Nenhum resultado encontrado</h2>
            <p>Não encontramos produtos para "{{ search_query }}"</p>

            <div class="search-suggestions">
                <h3>Sugestões:</h3>
                <ul>
                    <li>Verifique se as palavras estão escritas corretamente</li>
                    <li>Tente usar termos mais genéricos</li>
                    <li>Tente usar menos palavras</li>
                </ul>
            </div>

            <a href="{{ store.url }}" class="btn btn-primary">
                Ver todos os produtos
            </a>
        </div>
        {% endif %}
    </div>
</section>

<style>
.search-header {
    text-align: center;
    margin-bottom: var(--spacing-8);
}

.search-header h1 {
    margin-bottom: var(--spacing-2);
}

.search-query {
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
}

.search-form-page {
    display: flex;
    max-width: 600px;
    margin: 0 auto;
}

.search-input-page {
    flex: 1;
    padding: var(--spacing-4);
    border: 2px solid var(--color-gray-200);
    border-right: none;
    border-radius: var(--radius-lg) 0 0 var(--radius-lg);
    font-size: var(--text-base);
}

.search-input-page:focus {
    outline: none;
    border-color: var(--color-primary);
}

.search-btn-page {
    display: flex;
    align-items: center;
    gap: var(--spacing-2);
    padding: var(--spacing-4) var(--spacing-6);
    background: var(--color-primary);
    color: var(--color-white);
    border: none;
    border-radius: 0 var(--radius-lg) var(--radius-lg) 0;
    font-weight: 600;
    cursor: pointer;
    transition: background var(--transition-fast);
}

.search-btn-page:hover {
    background: var(--color-secondary);
}

.results-toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-4);
    padding-bottom: var(--spacing-4);
    border-bottom: 1px solid var(--color-gray-200);
}

.results-count {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.no-results {
    text-align: center;
    padding: var(--spacing-12) var(--spacing-4);
}

.no-results svg {
    color: var(--color-gray-300);
    margin-bottom: var(--spacing-4);
}

.no-results h2 {
    margin-bottom: var(--spacing-2);
}

.no-results p {
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
}

.search-suggestions {
    text-align: left;
    max-width: 400px;
    margin: 0 auto var(--spacing-6);
    padding: var(--spacing-4);
    background: var(--color-gray-50);
    border-radius: var(--radius-md);
}

.search-suggestions h3 {
    font-size: var(--text-sm);
    margin-bottom: var(--spacing-2);
}

.search-suggestions ul {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    padding-left: var(--spacing-4);
    list-style: disc;
}

.search-suggestions li {
    margin-bottom: var(--spacing-1);
}
</style>
