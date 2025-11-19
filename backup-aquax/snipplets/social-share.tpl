{# ========================================
   Social Share - AquaX Piscinas
   Botões de compartilhamento em redes sociais
   ======================================== #}

<div class="social-share">
    <span class="share-label">Compartilhar:</span>

    <div class="share-buttons">
        {# Facebook #}
        <a href="https://www.facebook.com/sharer/sharer.php?u={{ share_url | default(canonical_url) | url_encode }}"
           target="_blank"
           rel="noopener noreferrer"
           class="share-btn share-facebook"
           aria-label="Compartilhar no Facebook">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>
            </svg>
        </a>

        {# Twitter/X #}
        <a href="https://twitter.com/intent/tweet?url={{ share_url | default(canonical_url) | url_encode }}&text={{ share_text | default(page_title) | url_encode }}"
           target="_blank"
           rel="noopener noreferrer"
           class="share-btn share-twitter"
           aria-label="Compartilhar no Twitter">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"/>
            </svg>
        </a>

        {# WhatsApp #}
        <a href="https://wa.me/?text={{ share_text | default(page_title) | url_encode }}%20{{ share_url | default(canonical_url) | url_encode }}"
           target="_blank"
           rel="noopener noreferrer"
           class="share-btn share-whatsapp"
           aria-label="Compartilhar no WhatsApp">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
            </svg>
        </a>

        {# Pinterest #}
        <a href="https://pinterest.com/pin/create/button/?url={{ share_url | default(canonical_url) | url_encode }}&media={{ share_image | url_encode }}&description={{ share_text | default(page_title) | url_encode }}"
           target="_blank"
           rel="noopener noreferrer"
           class="share-btn share-pinterest"
           aria-label="Compartilhar no Pinterest">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 0C5.373 0 0 5.372 0 12c0 5.084 3.163 9.426 7.627 11.174-.105-.949-.2-2.405.042-3.441.218-.937 1.407-5.965 1.407-5.965s-.359-.719-.359-1.782c0-1.668.967-2.914 2.171-2.914 1.023 0 1.518.769 1.518 1.69 0 1.029-.655 2.568-.994 3.995-.283 1.194.599 2.169 1.777 2.169 2.133 0 3.772-2.249 3.772-5.495 0-2.873-2.064-4.882-5.012-4.882-3.414 0-5.418 2.561-5.418 5.207 0 1.031.397 2.138.893 2.738.098.119.112.224.083.345l-.333 1.36c-.053.22-.174.267-.402.161-1.499-.698-2.436-2.889-2.436-4.649 0-3.785 2.75-7.262 7.929-7.262 4.163 0 7.398 2.967 7.398 6.931 0 4.136-2.607 7.464-6.227 7.464-1.216 0-2.359-.631-2.75-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146C9.57 23.812 10.763 24 12 24c6.627 0 12-5.373 12-12 0-6.628-5.373-12-12-12z"/>
            </svg>
        </a>

        {# Email #}
        <a href="mailto:?subject={{ share_text | default(page_title) | url_encode }}&body={{ share_url | default(canonical_url) | url_encode }}"
           class="share-btn share-email"
           aria-label="Compartilhar por e-mail">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                <polyline points="22,6 12,13 2,6"/>
            </svg>
        </a>

        {# Copiar link #}
        <button type="button"
                class="share-btn share-copy"
                data-copy-url="{{ share_url | default(canonical_url) }}"
                aria-label="Copiar link">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
                <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
            </svg>
        </button>
    </div>
</div>

<style>
.social-share {
    display: flex;
    align-items: center;
    gap: var(--spacing-3);
    flex-wrap: wrap;
}

.share-label {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
}

.share-buttons {
    display: flex;
    gap: var(--spacing-2);
}

.share-btn {
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-gray-100);
    border: none;
    border-radius: var(--radius-full);
    color: var(--color-gray-600);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.share-btn:hover {
    transform: translateY(-2px);
}

.share-facebook:hover {
    background: #1877F2;
    color: var(--color-white);
}

.share-twitter:hover {
    background: #1DA1F2;
    color: var(--color-white);
}

.share-whatsapp:hover {
    background: #25D366;
    color: var(--color-white);
}

.share-pinterest:hover {
    background: #E60023;
    color: var(--color-white);
}

.share-email:hover {
    background: var(--color-primary);
    color: var(--color-white);
}

.share-copy:hover {
    background: var(--color-gray-700);
    color: var(--color-white);
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Copiar link
    const copyButtons = document.querySelectorAll('[data-copy-url]');

    copyButtons.forEach(btn => {
        btn.addEventListener('click', async function() {
            const url = this.dataset.copyUrl;

            try {
                await navigator.clipboard.writeText(url);
                this.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>';

                setTimeout(() => {
                    this.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>';
                }, 2000);
            } catch (err) {
                console.error('Erro ao copiar:', err);
            }
        });
    });
});
</script>
