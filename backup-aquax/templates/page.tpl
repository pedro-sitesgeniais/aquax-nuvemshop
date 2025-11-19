{# ========================================
   Page - AquaX Piscinas
   Template para páginas institucionais
   ======================================== #}

{% block body_class %}page-content{% endblock %}

{# Breadcrumbs #}
<nav class="breadcrumbs" aria-label="Navegação">
    <div class="container">
        <ul>
            <li><a href="{{ store.url }}">Início</a></li>
            <li><span>{{ page.name }}</span></li>
        </ul>
    </div>
</nav>

<article class="page-article section">
    <div class="container">
        <div class="page-content-wrapper">
            <header class="page-header">
                <h1>{{ page.name }}</h1>
            </header>

            <div class="page-body">
                {{ page.content }}
            </div>
        </div>
    </div>
</article>

<style>
.page-content-wrapper {
    max-width: 800px;
    margin: 0 auto;
}

.page-header {
    margin-bottom: var(--spacing-8);
    padding-bottom: var(--spacing-6);
    border-bottom: 1px solid var(--color-gray-200);
    text-align: center;
}

.page-header h1 {
    margin: 0;
}

.page-body {
    font-size: var(--text-base);
    line-height: 1.8;
    color: var(--color-gray-700);

    h2, h3, h4 {
        margin-top: var(--spacing-8);
        margin-bottom: var(--spacing-4);
    }

    p {
        margin-bottom: var(--spacing-4);
    }

    ul, ol {
        margin-bottom: var(--spacing-4);
        padding-left: var(--spacing-6);
    }

    li {
        margin-bottom: var(--spacing-2);
    }

    ul {
        list-style: disc;
    }

    ol {
        list-style: decimal;
    }

    a {
        color: var(--color-primary);
        text-decoration: underline;

        &:hover {
            color: var(--color-secondary);
        }
    }

    img {
        max-width: 100%;
        height: auto;
        margin: var(--spacing-6) 0;
        border-radius: var(--radius-md);
    }

    blockquote {
        margin: var(--spacing-6) 0;
        padding: var(--spacing-4) var(--spacing-6);
        background: var(--color-gray-50);
        border-left: 4px solid var(--color-primary);
        font-style: italic;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: var(--spacing-6) 0;
    }

    th, td {
        padding: var(--spacing-3);
        border: 1px solid var(--color-gray-200);
        text-align: left;
    }

    th {
        background: var(--color-gray-50);
        font-weight: 600;
    }

    hr {
        border: none;
        border-top: 1px solid var(--color-gray-200);
        margin: var(--spacing-8) 0;
    }
}
</style>
