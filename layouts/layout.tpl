<!DOCTYPE html>
<html lang="{{ lang }}" itemscope itemtype="http://schema.org/WebSite">
<head>
    {# Meta tags básicas #}
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    {# SEO Meta tags #}
    <title>{{ page_title }}</title>
    <meta name="description" content="{{ page_description }}">
    <meta name="keywords" content="{{ store.name }}, piscinas, produtos químicos, equipamentos">

    {# Open Graph / Social #}
    <meta property="og:title" content="{{ page_title }}">
    <meta property="og:description" content="{{ page_description }}">
    <meta property="og:type" content="website">
    <meta property="og:url" content="{{ store.url }}">
    <meta property="og:site_name" content="{{ store.name }}">
    {% if store.logo %}
    <meta property="og:image" content="{{ store.logo }}">
    {% endif %}

    {# Twitter Card #}
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{{ page_title }}">
    <meta name="twitter:description" content="{{ page_description }}">

    {# Favicon #}
    {% if settings.favicon %}
    <link rel="icon" type="image/png" href="{{ settings.favicon }}">
    {% endif %}
    <link rel="apple-touch-icon" href="{{ settings.favicon | default(store.logo) }}">

    {# Preconnect para performance #}
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    {# Fontes Google - Poppins e Inter #}
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">

    {# CSS Principal #}
    <link rel="stylesheet" href="{{ 'css/style-critical.scss' | static_url }}">

    {# Canonical URL #}
    <link rel="canonical" href="{{ canonical_url }}">

    {# Nuvemshop head scripts #}
    {{ head_content }}

    {# Schema.org estruturado #}
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Organization",
        "name": "{{ store.name }}",
        "url": "{{ store.url }}",
        {% if store.logo %}
        "logo": "{{ store.logo }}",
        {% endif %}
        "contactPoint": {
            "@type": "ContactPoint",
            "contactType": "customer service"
        }
    }
    </script>
</head>
<body class="{% block body_class %}{% endblock %}" data-store="{{ store.id }}">

    {# Skip navigation para acessibilidade #}
    <a href="#main-content" class="skip-link visually-hidden">Pular para o conteúdo principal</a>

    {# Header #}
    {% include 'snipplets/header.tpl' %}

    {# Conteúdo principal #}
    <main id="main-content" role="main">
        {% template_content %}
    </main>

    {# Footer #}
    {% include 'snipplets/footer.tpl' %}

    {# Botão WhatsApp flutuante #}
    {% if settings.show_whatsapp and settings.whatsapp_number %}
    <a href="https://wa.me/{{ settings.whatsapp_number }}"
       class="whatsapp-float"
       target="_blank"
       rel="noopener noreferrer"
       aria-label="Fale conosco pelo WhatsApp">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
        </svg>
    </a>
    {% endif %}

    {# JavaScript Principal #}
    <script src="{{ 'js/main.js' | static_url }}" defer></script>

    {# Nuvemshop footer scripts #}
    {{ end_content }}

</body>
</html>
