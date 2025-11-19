{# ========================================
   Header - AquaX Piscinas
   Cabeçalho responsivo com menu, busca e carrinho
   ======================================== #}

<header class="header" role="banner">
    {# Barra superior com informações #}
    <div class="header-top">
        <div class="container">
            <div class="header-top-content">
                <div class="header-top-left">
                    {% if store.phone %}
                    <a href="tel:{{ store.phone }}" class="header-contact">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                        </svg>
                        <span>{{ store.phone }}</span>
                    </a>
                    {% endif %}
                    {% if store.email %}
                    <a href="mailto:{{ store.email }}" class="header-contact">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                            <polyline points="22,6 12,13 2,6"/>
                        </svg>
                        <span>{{ store.email }}</span>
                    </a>
                    {% endif %}
                </div>
                <div class="header-top-right">
                    {% if customer %}
                    <a href="{{ store.customer_url }}" class="header-account">
                        Olá, {{ customer.first_name }}
                    </a>
                    {% else %}
                    <a href="{{ store.customer_login_url }}" class="header-account">
                        Entrar / Cadastrar
                    </a>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>

    {# Header principal #}
    <div class="header-main">
        <div class="container">
            <div class="header-main-content">
                {# Botão menu mobile #}
                <button class="menu-toggle"
                        aria-label="Abrir menu"
                        aria-expanded="false"
                        aria-controls="nav-menu">
                    <span class="menu-toggle-bar"></span>
                    <span class="menu-toggle-bar"></span>
                    <span class="menu-toggle-bar"></span>
                </button>

                {# Logo #}
                <div class="header-logo">
                    <a href="{{ store.url }}" title="{{ store.name }}">
                        {% if store.logo %}
                        <img src="{{ store.logo }}"
                             alt="{{ store.name }}"
                             class="logo-img"
                             width="180"
                             height="50"
                             loading="eager">
                        {% else %}
                        <span class="logo-text">{{ store.name }}</span>
                        {% endif %}
                    </a>
                </div>

                {# Busca #}
                <div class="header-search">
                    <form action="{{ store.search_url }}" method="get" role="search" class="search-form">
                        <label for="search-input" class="visually-hidden">Buscar produtos</label>
                        <input type="search"
                               id="search-input"
                               name="q"
                               placeholder="O que você procura?"
                               class="search-input"
                               autocomplete="off"
                               aria-label="Campo de busca">
                        <button type="submit" class="search-button" aria-label="Buscar">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="11" cy="11" r="8"/>
                                <path d="m21 21-4.35-4.35"/>
                            </svg>
                        </button>
                    </form>
                </div>

                {# Ações (carrinho) #}
                <div class="header-actions">
                    {# Carrinho #}
                    <a href="{{ store.cart_url }}" class="header-cart" aria-label="Carrinho de compras">
                        <div class="cart-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="9" cy="21" r="1"/>
                                <circle cx="20" cy="21" r="1"/>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                            </svg>
                            {% if cart.items_count > 0 %}
                            <span class="cart-count" data-cart-count>{{ cart.items_count }}</span>
                            {% endif %}
                        </div>
                        <div class="cart-info">
                            <span class="cart-label">Carrinho</span>
                            <span class="cart-total" data-cart-total>{{ cart.total | money }}</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    {# Navegação principal #}
    <nav class="header-nav" role="navigation" aria-label="Menu principal">
        <div class="container">
            <ul class="nav-menu" id="nav-menu">
                <li class="nav-item">
                    <a href="{{ store.url }}" class="nav-link {% if template == 'home' %}active{% endif %}">
                        Início
                    </a>
                </li>

                {# Categorias #}
                {% for category in categories %}
                <li class="nav-item {% if category.subcategories %}has-dropdown{% endif %}">
                    <a href="{{ category.url }}" class="nav-link">
                        {{ category.name }}
                        {% if category.subcategories %}
                        <svg class="dropdown-arrow" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="6 9 12 15 18 9"/>
                        </svg>
                        {% endif %}
                    </a>

                    {% if category.subcategories %}
                    <ul class="nav-dropdown">
                        {% for subcategory in category.subcategories %}
                        <li>
                            <a href="{{ subcategory.url }}">{{ subcategory.name }}</a>
                        </li>
                        {% endfor %}
                    </ul>
                    {% endif %}
                </li>
                {% endfor %}

                <li class="nav-item">
                    <a href="{{ store.contact_url }}" class="nav-link">
                        Contato
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>

{# Overlay para menu mobile #}
<div class="menu-overlay" aria-hidden="true"></div>
