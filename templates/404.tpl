{# ========================================
   404 - AquaX Piscinas
   Página não encontrada
   ======================================== #}

{% block body_class %}page-404{% endblock %}

<section class="error-section">
    <div class="container">
        <div class="error-content">
            <div class="error-icon">
                <svg width="120" height="120" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <circle cx="12" cy="12" r="10"/>
                    <path d="M16 16s-1.5-2-4-2-4 2-4 2"/>
                    <line x1="9" y1="9" x2="9.01" y2="9"/>
                    <line x1="15" y1="9" x2="15.01" y2="9"/>
                </svg>
            </div>

            <h1>404</h1>
            <h2>Página não encontrada</h2>
            <p>Desculpe, a página que você está procurando não existe ou foi movida.</p>

            <div class="error-actions">
                <a href="{{ store.url }}" class="btn btn-primary btn-lg">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                        <polyline points="9 22 9 12 15 12 15 22"/>
                    </svg>
                    Voltar ao Início
                </a>

                <a href="{{ store.contact_url }}" class="btn btn-outline btn-lg">
                    Fale Conosco
                </a>
            </div>

            {# Busca #}
            <div class="error-search">
                <p>Ou tente buscar o que procura:</p>
                <form action="{{ store.search_url }}" method="get" class="search-form-404">
                    <input type="search"
                           name="q"
                           placeholder="Buscar produtos..."
                           class="search-input-404"
                           required>
                    <button type="submit" class="search-btn-404">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"/>
                            <path d="m21 21-4.35-4.35"/>
                        </svg>
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<style>
.error-section {
    min-height: 60vh;
    display: flex;
    align-items: center;
    padding: var(--spacing-12) 0;
}

.error-content {
    text-align: center;
    max-width: 600px;
    margin: 0 auto;
}

.error-icon {
    color: var(--color-gray-300);
    margin-bottom: var(--spacing-6);
}

.error-content h1 {
    font-size: 6rem;
    font-weight: 700;
    color: var(--color-primary);
    margin: 0;
    line-height: 1;
}

.error-content h2 {
    font-size: var(--text-2xl);
    margin-bottom: var(--spacing-4);
}

.error-content p {
    color: var(--color-gray-600);
    margin-bottom: var(--spacing-6);
}

.error-actions {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-3);
    margin-bottom: var(--spacing-8);
}

@media (min-width: 576px) {
    .error-actions {
        flex-direction: row;
        justify-content: center;
    }
}

.error-actions .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-2);
}

.error-search {
    padding-top: var(--spacing-6);
    border-top: 1px solid var(--color-gray-200);
}

.error-search p {
    font-size: var(--text-sm);
    margin-bottom: var(--spacing-4);
}

.search-form-404 {
    display: flex;
    max-width: 400px;
    margin: 0 auto;
}

.search-input-404 {
    flex: 1;
    padding: var(--spacing-3) var(--spacing-4);
    border: 2px solid var(--color-gray-200);
    border-right: none;
    border-radius: var(--radius-md) 0 0 var(--radius-md);
    font-size: var(--text-base);
}

.search-input-404:focus {
    outline: none;
    border-color: var(--color-primary);
}

.search-btn-404 {
    padding: var(--spacing-3) var(--spacing-4);
    background: var(--color-primary);
    border: none;
    border-radius: 0 var(--radius-md) var(--radius-md) 0;
    color: var(--color-white);
    cursor: pointer;
    transition: background var(--transition-fast);
}

.search-btn-404:hover {
    background: var(--color-secondary);
}
</style>
