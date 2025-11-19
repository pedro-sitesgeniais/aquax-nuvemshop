{# ========================================
   Breadcrumbs - AquaX Piscinas
   Navegação estrutural reutilizável
   ======================================== #}

<nav class="breadcrumbs" aria-label="Navegação estrutural">
    <div class="container">
        <ul itemscope itemtype="http://schema.org/BreadcrumbList">
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{{ store.url }}" itemprop="item">
                    <span itemprop="name">Início</span>
                </a>
                <meta itemprop="position" content="1">
            </li>

            {% if breadcrumb_items %}
                {% for item in breadcrumb_items %}
                <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                    {% if item.url %}
                    <a href="{{ item.url }}" itemprop="item">
                        <span itemprop="name">{{ item.name }}</span>
                    </a>
                    {% else %}
                    <span itemprop="name">{{ item.name }}</span>
                    {% endif %}
                    <meta itemprop="position" content="{{ loop.index + 1 }}">
                </li>
                {% endfor %}
            {% endif %}
        </ul>
    </div>
</nav>
