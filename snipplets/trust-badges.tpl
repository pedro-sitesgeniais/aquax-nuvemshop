{# ========================================
   Trust Badges - AquaX Piscinas
   Selos de confiança e garantias
   ======================================== #}

<div class="trust-badges-section">
    <div class="trust-badge-item">
        <div class="badge-icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <rect x="1" y="3" width="15" height="13"/>
                <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
                <circle cx="5.5" cy="18.5" r="2.5"/>
                <circle cx="18.5" cy="18.5" r="2.5"/>
            </svg>
        </div>
        <div class="badge-text">
            <strong>Entrega para todo Brasil</strong>
            <span>Envio rápido e seguro</span>
        </div>
    </div>

    <div class="trust-badge-item">
        <div class="badge-icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
            </svg>
        </div>
        <div class="badge-text">
            <strong>Pagamento Seguro</strong>
            <span>Ambiente 100% criptografado</span>
        </div>
    </div>

    <div class="trust-badge-item">
        <div class="badge-icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                <polyline points="9 12 11 14 15 10"/>
            </svg>
        </div>
        <div class="badge-text">
            <strong>Produtos de Qualidade</strong>
            <span>Garantia do fabricante</span>
        </div>
    </div>

    <div class="trust-badge-item">
        <div class="badge-icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
            </svg>
        </div>
        <div class="badge-text">
            <strong>Suporte Especializado</strong>
            <span>Atendimento técnico</span>
        </div>
    </div>
</div>

<style>
.trust-badges-section {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-4);
    padding: var(--spacing-6);
    background: var(--color-gray-50);
    border-radius: var(--radius-lg);
}

@media (min-width: 768px) {
    .trust-badges-section {
        grid-template-columns: repeat(4, 1fr);
    }
}

.trust-badge-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    padding: var(--spacing-4);
}

.badge-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 56px;
    height: 56px;
    margin-bottom: var(--spacing-3);
    background: var(--color-white);
    border-radius: var(--radius-full);
    color: var(--color-primary);
    box-shadow: var(--shadow-sm);
}

.badge-text {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-1);
}

.badge-text strong {
    font-size: var(--text-sm);
    color: var(--color-gray-800);
}

.badge-text span {
    font-size: var(--text-xs);
    color: var(--color-gray-500);
}
</style>
