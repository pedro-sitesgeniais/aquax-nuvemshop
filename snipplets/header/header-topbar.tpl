{# Header Topbar #}

{% if settings.show_topbar %}
<div class="topbar">
    <div class="container">
        <div class="row no-gutters align-items-center">
            {# Left side - Contact info #}
            <div class="col-auto d-none d-md-block">
                {% if settings.topbar_phone %}
                    <a href="tel:{{ settings.topbar_phone }}" class="mr-3">
                        {{ settings.topbar_phone }}
                    </a>
                {% endif %}
                {% if settings.topbar_email %}
                    <a href="mailto:{{ settings.topbar_email }}">
                        {{ settings.topbar_email }}
                    </a>
                {% endif %}
            </div>

            {# Center - Custom text #}
            <div class="col text-center">
                {% if settings.topbar_text %}
                    <span class="font-small opacity-80">{{ settings.topbar_text }}</span>
                {% endif %}
            </div>

            {# Right side - Account & Languages #}
            <div class="col-auto d-none d-md-block">
                {% if languages | length > 1 and settings.languages_header %}
                    {% include "snipplets/navigation/navigation-lang.tpl" with { header: true, topbar: true } %}
                {% endif %}
                {% if store.has_accounts %}
                    {% if customer %}
                        <a href="{{ store.customer_home_url }}">
                            {{ "Mi cuenta" | translate }}
                        </a>
                    {% else %}
                        <a href="{{ store.customer_login_url }}">
                            {{ "Iniciar sesión" | translate }}
                        </a>
                    {% endif %}
                {% endif %}
            </div>
        </div>
    </div>
</div>
{% endif %}
