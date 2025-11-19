{# ========================================
   Schema.org Organization - AquaX Piscinas
   Dados estruturados da organização
   ======================================== #}

<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "{{ store.name }}",
    "url": "{{ store.url }}",
    {% if store.logo %}
    "logo": "{{ store.logo }}",
    {% endif %}
    {% if store.description %}
    "description": "{{ store.description }}",
    {% endif %}
    "address": {
        "@type": "PostalAddress"
        {% if store.address %},
        "streetAddress": "{{ store.address }}"
        {% endif %}
    },
    "contactPoint": [
        {% if store.phone %}
        {
            "@type": "ContactPoint",
            "telephone": "{{ store.phone }}",
            "contactType": "customer service",
            "availableLanguage": "Portuguese"
        }
        {% endif %}
        {% if store.email %}
        {% if store.phone %},{% endif %}
        {
            "@type": "ContactPoint",
            "email": "{{ store.email }}",
            "contactType": "customer service"
        }
        {% endif %}
    ],
    "sameAs": [
        {% if settings.facebook %}"{{ settings.facebook }}"{% endif %}
        {% if settings.instagram %}{% if settings.facebook %},{% endif %}"{{ settings.instagram }}"{% endif %}
        {% if settings.youtube %}{% if settings.facebook or settings.instagram %},{% endif %}"{{ settings.youtube }}"{% endif %}
    ]
}
</script>
