{# ========================================
   Schema.org Product - AquaX Piscinas
   Dados estruturados para SEO de produtos
   ======================================== #}

<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "{{ product.name }}",
    "description": "{{ product.description | striptags | slice(0, 200) }}",
    {% if product.featured_image %}
    "image": "{{ product.featured_image }}",
    {% endif %}
    {% if product.sku %}
    "sku": "{{ product.sku }}",
    {% endif %}
    {% if product.brand %}
    "brand": {
        "@type": "Brand",
        "name": "{{ product.brand }}"
    },
    {% endif %}
    "offers": {
        "@type": "Offer",
        "url": "{{ product.url }}",
        "priceCurrency": "{{ store.currency | default('BRL') }}",
        "price": "{{ product.price }}",
        "availability": "{% if product.available %}https://schema.org/InStock{% else %}https://schema.org/OutOfStock{% endif %}",
        "seller": {
            "@type": "Organization",
            "name": "{{ store.name }}"
        }
        {% if product.compare_at_price %},
        "priceValidUntil": "{{ 'now' | date_modify('+30 days') | date('Y-m-d') }}"
        {% endif %}
    }
    {% if product.reviews_count > 0 %},
    "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "{{ product.average_rating }}",
        "reviewCount": "{{ product.reviews_count }}"
    }
    {% endif %}
}
</script>
