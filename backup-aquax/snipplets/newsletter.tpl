{# ========================================
   Newsletter - AquaX Piscinas
   Componente de inscrição na newsletter
   ======================================== #}

<div class="newsletter-box">
    <div class="newsletter-icon">
        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
            <polyline points="22,6 12,13 2,6"/>
        </svg>
    </div>

    <div class="newsletter-content">
        <h3>Receba novidades e ofertas exclusivas</h3>
        <p>Cadastre seu e-mail e fique por dentro das promoções</p>
    </div>

    <form class="newsletter-form-box" action="{{ store.newsletter_url }}" method="post">
        <div class="newsletter-input-group">
            <label for="newsletter-email-box" class="visually-hidden">Seu e-mail</label>
            <input type="email"
                   id="newsletter-email-box"
                   name="email"
                   placeholder="Digite seu e-mail"
                   required
                   class="newsletter-input-box">
            <button type="submit" class="newsletter-submit">
                Cadastrar
            </button>
        </div>

        <p class="newsletter-privacy">
            Ao se cadastrar, você concorda com nossa
            <a href="{{ store.privacy_url }}">Política de Privacidade</a>
        </p>
    </form>
</div>

<style>
.newsletter-box {
    text-align: center;
    max-width: 600px;
    margin: 0 auto;
    padding: var(--spacing-8);
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
}

.newsletter-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 80px;
    height: 80px;
    margin: 0 auto var(--spacing-4);
    background: var(--color-light);
    border-radius: var(--radius-full);
    color: var(--color-primary);
}

.newsletter-content {
    margin-bottom: var(--spacing-6);
}

.newsletter-content h3 {
    font-size: var(--text-xl);
    margin-bottom: var(--spacing-2);
}

.newsletter-content p {
    color: var(--color-gray-600);
    margin: 0;
}

.newsletter-input-group {
    display: flex;
    gap: var(--spacing-2);
}

.newsletter-input-box {
    flex: 1;
    padding: var(--spacing-3) var(--spacing-4);
    border: 2px solid var(--color-gray-200);
    border-radius: var(--radius-md);
    font-size: var(--text-base);
    transition: border-color var(--transition-fast);
}

.newsletter-input-box:focus {
    outline: none;
    border-color: var(--color-primary);
}

.newsletter-submit {
    padding: var(--spacing-3) var(--spacing-6);
    background: var(--color-primary);
    color: var(--color-white);
    border: none;
    border-radius: var(--radius-md);
    font-size: var(--text-base);
    font-weight: 600;
    cursor: pointer;
    transition: background var(--transition-fast);
    white-space: nowrap;
}

.newsletter-submit:hover {
    background: var(--color-secondary);
}

.newsletter-privacy {
    margin-top: var(--spacing-3);
    font-size: var(--text-xs);
    color: var(--color-gray-500);
}

.newsletter-privacy a {
    color: var(--color-primary);
}

@media (max-width: 575px) {
    .newsletter-input-group {
        flex-direction: column;
    }

    .newsletter-submit {
        width: 100%;
    }
}
</style>
