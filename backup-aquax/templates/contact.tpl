{# ========================================
   Contact - AquaX Piscinas
   Página de contato
   ======================================== #}

{% block body_class %}page-contact{% endblock %}

{# Breadcrumbs #}
<nav class="breadcrumbs" aria-label="Navegação">
    <div class="container">
        <ul>
            <li><a href="{{ store.url }}">Início</a></li>
            <li><span>Contato</span></li>
        </ul>
    </div>
</nav>

<section class="contact-section section">
    <div class="container">
        <div class="section-title">
            <h1>Entre em Contato</h1>
            <p>Estamos aqui para ajudar você</p>
        </div>

        <div class="contact-layout">
            {# Informações de contato #}
            <div class="contact-info">
                <div class="contact-card">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                                <circle cx="12" cy="10" r="3"/>
                            </svg>
                        </div>
                        <div class="contact-details">
                            <h3>Endereço</h3>
                            {% if store.address %}
                            <p>{{ store.address }}</p>
                            {% else %}
                            <p>Endereço não informado</p>
                            {% endif %}
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                            </svg>
                        </div>
                        <div class="contact-details">
                            <h3>Telefone</h3>
                            {% if store.phone %}
                            <a href="tel:{{ store.phone }}">{{ store.phone }}</a>
                            {% else %}
                            <p>Telefone não informado</p>
                            {% endif %}
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                                <polyline points="22,6 12,13 2,6"/>
                            </svg>
                        </div>
                        <div class="contact-details">
                            <h3>E-mail</h3>
                            {% if store.email %}
                            <a href="mailto:{{ store.email }}">{{ store.email }}</a>
                            {% else %}
                            <p>E-mail não informado</p>
                            {% endif %}
                        </div>
                    </div>

                    {% if settings.whatsapp_number %}
                    <div class="contact-item">
                        <div class="contact-icon whatsapp">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                            </svg>
                        </div>
                        <div class="contact-details">
                            <h3>WhatsApp</h3>
                            <a href="https://wa.me/{{ settings.whatsapp_number }}" target="_blank" rel="noopener">
                                Iniciar conversa
                            </a>
                        </div>
                    </div>
                    {% endif %}
                </div>

                {# Horário de atendimento #}
                <div class="business-hours">
                    <h3>Horário de Atendimento</h3>
                    <p>Segunda a Sexta: 8h às 18h</p>
                    <p>Sábado: 8h às 12h</p>
                </div>
            </div>

            {# Formulário de contato #}
            <div class="contact-form-wrapper">
                <form action="{{ store.contact_url }}" method="post" class="contact-form" data-validate>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="contact-name" class="form-label">Nome *</label>
                            <input type="text"
                                   id="contact-name"
                                   name="name"
                                   class="form-control"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="contact-email" class="form-label">E-mail *</label>
                            <input type="email"
                                   id="contact-email"
                                   name="email"
                                   class="form-control"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="contact-phone" class="form-label">Telefone</label>
                        <input type="tel"
                               id="contact-phone"
                               name="phone"
                               class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="contact-subject" class="form-label">Assunto *</label>
                        <select id="contact-subject" name="subject" class="form-control" required>
                            <option value="">Selecione...</option>
                            <option value="duvida">Dúvidas sobre produtos</option>
                            <option value="orcamento">Solicitar orçamento</option>
                            <option value="pedido">Informações sobre pedido</option>
                            <option value="troca">Troca ou devolução</option>
                            <option value="outro">Outro assunto</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="contact-message" class="form-label">Mensagem *</label>
                        <textarea id="contact-message"
                                  name="message"
                                  class="form-control"
                                  rows="5"
                                  required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg">
                        Enviar Mensagem
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<style>
.contact-layout {
    display: grid;
    gap: var(--spacing-8);

    @media (min-width: 992px) {
        grid-template-columns: 1fr 1.5fr;
    }
}

.contact-card {
    background: var(--color-gray-50);
    border-radius: var(--radius-lg);
    padding: var(--spacing-6);
    margin-bottom: var(--spacing-6);
}

.contact-item {
    display: flex;
    gap: var(--spacing-4);
    padding: var(--spacing-4) 0;
    border-bottom: 1px solid var(--color-gray-200);

    &:last-child {
        border-bottom: none;
        padding-bottom: 0;
    }

    &:first-child {
        padding-top: 0;
    }
}

.contact-icon {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-white);
    border-radius: var(--radius-full);
    color: var(--color-primary);

    &.whatsapp {
        color: #25D366;
    }
}

.contact-details {
    h3 {
        font-size: var(--text-sm);
        font-weight: 600;
        margin-bottom: var(--spacing-1);
    }

    p, a {
        font-size: var(--text-sm);
        color: var(--color-gray-600);
        margin: 0;
    }

    a:hover {
        color: var(--color-primary);
    }
}

.business-hours {
    background: var(--color-primary);
    color: var(--color-white);
    border-radius: var(--radius-lg);
    padding: var(--spacing-6);

    h3 {
        color: var(--color-white);
        font-size: var(--text-base);
        margin-bottom: var(--spacing-3);
    }

    p {
        font-size: var(--text-sm);
        margin: 0 0 var(--spacing-1);
        opacity: 0.9;
    }
}

.contact-form-wrapper {
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    padding: var(--spacing-6);
}

.form-row {
    display: grid;
    gap: var(--spacing-4);

    @media (min-width: 576px) {
        grid-template-columns: 1fr 1fr;
    }
}

textarea.form-control {
    resize: vertical;
    min-height: 120px;
}
</style>
