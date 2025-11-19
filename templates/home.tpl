{# ========================================
   Home - AquaX Piscinas
   Página inicial com banners, categorias e produtos
   ======================================== #}

{% block body_class %}page-home{% endblock %}

{# Hero Banner/Slider #}
<section class="hero-slider" aria-label="Banners promocionais">
    <div class="slider-container">
        <div class="slider-track" data-slider>
            {% if settings.banner_home_1 %}
            <div class="slide">
                <a href="{{ settings.banner_home_1_link | default('#') }}">
                    <img src="{{ settings.banner_home_1 }}"
                         alt="{{ settings.banner_home_1_alt | default('Banner promocional') }}"
                         class="slide-img"
                         loading="eager">
                </a>
            </div>
            {% endif %}

            {% if settings.banner_home_2 %}
            <div class="slide">
                <a href="{{ settings.banner_home_2_link | default('#') }}">
                    <img src="{{ settings.banner_home_2 }}"
                         alt="{{ settings.banner_home_2_alt | default('Banner promocional') }}"
                         class="slide-img"
                         loading="lazy">
                </a>
            </div>
            {% endif %}

            {% if settings.banner_home_3 %}
            <div class="slide">
                <a href="{{ settings.banner_home_3_link | default('#') }}">
                    <img src="{{ settings.banner_home_3 }}"
                         alt="{{ settings.banner_home_3_alt | default('Banner promocional') }}"
                         class="slide-img"
                         loading="lazy">
                </a>
            </div>
            {% endif %}
        </div>

        {# Navegação do slider #}
        <button class="slider-prev" aria-label="Banner anterior" data-slider-prev>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="15 18 9 12 15 6"/>
            </svg>
        </button>
        <button class="slider-next" aria-label="Próximo banner" data-slider-next>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"/>
            </svg>
        </button>

        {# Indicadores #}
        <div class="slider-dots" data-slider-dots></div>
    </div>
</section>

{# Categorias Destacadas #}
{% if categories %}
<section class="section categories-section">
    <div class="container">
        <div class="section-title">
            <h2>{{ settings.featured_categories_title | default('Categorias') }}</h2>
            <p>Encontre tudo para sua piscina</p>
        </div>

        <div class="categories-grid">
            {% for category in categories | slice(0, 8) %}
            <a href="{{ category.url }}" class="category-card">
                <div class="category-icon">
                    {% if category.image %}
                    <img src="{{ category.image }}"
                         alt="{{ category.name }}"
                         loading="lazy"
                         width="64"
                         height="64">
                    {% else %}
                    {# Ícone padrão #}
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <path d="M20.38 3.46L16 2a4 4 0 01-8 0L3.62 3.46a2 2 0 00-1.34 2.23l.58 3.47a1 1 0 00.99.84H6v10c0 1.1.9 2 2 2h8a2 2 0 002-2V10h2.15a1 1 0 00.99-.84l.58-3.47a2 2 0 00-1.34-2.23z"/>
                    </svg>
                    {% endif %}
                </div>
                <h3 class="category-name">{{ category.name }}</h3>
                {% if category.products_count %}
                <span class="category-count">{{ category.products_count }} produtos</span>
                {% endif %}
            </a>
            {% endfor %}
        </div>
    </div>
</section>
{% endif %}

{# Produtos em Destaque #}
{% if featured_products %}
<section class="section products-section">
    <div class="container">
        <div class="section-title">
            <h2>{{ settings.featured_products_title | default('Produtos em Destaque') }}</h2>
            <p>Os mais procurados pelos nossos clientes</p>
        </div>

        <div class="products-carousel" data-products-carousel>
            <div class="products-track">
                {% for product in featured_products %}
                    {% include 'snipplets/product-card.tpl' with { 'product': product } %}
                {% endfor %}
            </div>

            {# Navegação do carousel #}
            <button class="carousel-prev" aria-label="Produtos anteriores" data-carousel-prev>
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="15 18 9 12 15 6"/>
                </svg>
            </button>
            <button class="carousel-next" aria-label="Próximos produtos" data-carousel-next>
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="9 18 15 12 9 6"/>
                </svg>
            </button>
        </div>

        <div class="text-center">
            <a href="{{ store.products_url }}" class="btn btn-outline btn-lg">
                Ver todos os produtos
            </a>
        </div>
    </div>
</section>
{% endif %}

{# Por que escolher AquaX - Benefícios #}
<section class="section benefits-section">
    <div class="container">
        <div class="section-title">
            <h2>Por que escolher a AquaX?</h2>
        </div>

        <div class="benefits-grid">
            <div class="benefit-card">
                <div class="benefit-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <rect x="1" y="3" width="15" height="13"/>
                        <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
                        <circle cx="5.5" cy="18.5" r="2.5"/>
                        <circle cx="18.5" cy="18.5" r="2.5"/>
                    </svg>
                </div>
                <h3>{{ settings.benefit_1_title | default('Entrega Rápida') }}</h3>
                <p>{{ settings.benefit_1_description | default('Entrega expressa para todo Brasil') }}</p>
            </div>

            <div class="benefit-card">
                <div class="benefit-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                    </svg>
                </div>
                <h3>{{ settings.benefit_2_title | default('Pagamento Seguro') }}</h3>
                <p>{{ settings.benefit_2_description | default('Ambiente 100% seguro e criptografado') }}</p>
            </div>

            <div class="benefit-card">
                <div class="benefit-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                    </svg>
                </div>
                <h3>{{ settings.benefit_3_title | default('Suporte Especializado') }}</h3>
                <p>{{ settings.benefit_3_description | default('Equipe técnica para ajudar você') }}</p>
            </div>
        </div>
    </div>
</section>

{# Produtos Novos ou em Promoção #}
{% if new_products or sale_products %}
<section class="section new-products-section">
    <div class="container">
        {% if new_products %}
        <div class="section-title">
            <h2>Novidades</h2>
            <p>Produtos recém chegados</p>
        </div>

        <div class="row">
            {% for product in new_products | slice(0, 4) %}
            <div class="col-6 col-md-3">
                {% include 'snipplets/product-card.tpl' with { 'product': product } %}
            </div>
            {% endfor %}
        </div>
        {% endif %}
    </div>
</section>
{% endif %}

{# Banner Secundário #}
{% if settings.banner_secondary %}
<section class="secondary-banner">
    <div class="container">
        <a href="{{ settings.banner_secondary_link | default('#') }}">
            <img src="{{ settings.banner_secondary }}"
                 alt="{{ settings.banner_secondary_alt | default('Banner promocional') }}"
                 class="secondary-banner-img"
                 loading="lazy">
        </a>
    </div>
</section>
{% endif %}

{# Newsletter (standalone na home) #}
{% if settings.show_newsletter %}
<section class="section newsletter-section-home">
    <div class="container">
        {% include 'snipplets/newsletter.tpl' %}
    </div>
</section>
{% endif %}

{# Estilos específicos da Home #}
<style>
/* Hero Slider */
.hero-slider {
    position: relative;
    overflow: hidden;
    background: var(--color-gray-100);
}

.slider-container {
    position: relative;
}

.slider-track {
    display: flex;
    transition: transform 0.5s ease;
}

.slide {
    flex: 0 0 100%;
    min-width: 100%;
}

.slide-img {
    width: 100%;
    height: auto;
    display: block;
}

.slider-prev,
.slider-next {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.9);
    border: none;
    border-radius: var(--radius-full);
    color: var(--color-gray-700);
    cursor: pointer;
    transition: all var(--transition-fast);
    z-index: 10;
}

.slider-prev:hover,
.slider-next:hover {
    background: var(--color-white);
    color: var(--color-primary);
}

.slider-prev {
    left: var(--spacing-4);
}

.slider-next {
    right: var(--spacing-4);
}

.slider-dots {
    position: absolute;
    bottom: var(--spacing-4);
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: var(--spacing-2);
}

.slider-dot {
    width: 10px;
    height: 10px;
    background: rgba(255, 255, 255, 0.5);
    border: none;
    border-radius: var(--radius-full);
    cursor: pointer;
    transition: background var(--transition-fast);
}

.slider-dot.active,
.slider-dot:hover {
    background: var(--color-white);
}

/* Categorias Grid */
.categories-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-4);
}

@media (min-width: 576px) {
    .categories-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (min-width: 768px) {
    .categories-grid {
        grid-template-columns: repeat(4, 1fr);
    }
}

.category-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: var(--spacing-6);
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-lg);
    text-align: center;
    transition: all var(--transition-fast);
}

.category-card:hover {
    border-color: var(--color-primary);
    box-shadow: var(--shadow-md);
    transform: translateY(-4px);
}

.category-icon {
    width: 64px;
    height: 64px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: var(--spacing-3);
    color: var(--color-primary);
}

.category-icon img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

.category-name {
    font-size: var(--text-sm);
    font-weight: 600;
    margin: 0 0 var(--spacing-1);
    color: var(--color-gray-800);
}

.category-count {
    font-size: var(--text-xs);
    color: var(--color-gray-500);
}

/* Products Carousel */
.products-carousel {
    position: relative;
    margin-bottom: var(--spacing-8);
}

.products-track {
    display: flex;
    gap: var(--spacing-4);
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    scrollbar-width: none;
    -ms-overflow-style: none;
    padding: var(--spacing-2);
}

.products-track::-webkit-scrollbar {
    display: none;
}

.products-track .product-card {
    flex: 0 0 calc(50% - var(--spacing-2));
    scroll-snap-align: start;
}

@media (min-width: 576px) {
    .products-track .product-card {
        flex: 0 0 calc(33.333% - var(--spacing-3));
    }
}

@media (min-width: 992px) {
    .products-track .product-card {
        flex: 0 0 calc(25% - var(--spacing-3));
    }
}

.carousel-prev,
.carousel-next {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--color-white);
    border: 1px solid var(--color-gray-200);
    border-radius: var(--radius-full);
    color: var(--color-gray-700);
    cursor: pointer;
    transition: all var(--transition-fast);
    z-index: 10;
    display: none;
}

@media (min-width: 768px) {
    .carousel-prev,
    .carousel-next {
        display: flex;
    }
}

.carousel-prev:hover,
.carousel-next:hover {
    background: var(--color-primary);
    border-color: var(--color-primary);
    color: var(--color-white);
}

.carousel-prev {
    left: -20px;
}

.carousel-next {
    right: -20px;
}

/* Benefits */
.benefits-section {
    background: var(--color-light);
}

.benefits-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: var(--spacing-6);
}

@media (min-width: 768px) {
    .benefits-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}

.benefit-card {
    text-align: center;
    padding: var(--spacing-6);
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
}

.benefit-icon {
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

.benefit-card h3 {
    font-size: var(--text-lg);
    margin-bottom: var(--spacing-2);
}

.benefit-card p {
    font-size: var(--text-sm);
    color: var(--color-gray-600);
    margin: 0;
}

/* Secondary Banner */
.secondary-banner {
    padding: var(--spacing-8) 0;
}

.secondary-banner-img {
    width: 100%;
    border-radius: var(--radius-lg);
}

/* Newsletter Home */
.newsletter-section-home {
    background: var(--color-gray-100);
}

/* Utilities */
.text-center {
    text-align: center;
}
</style>

{# JavaScript específico da Home #}
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Slider
    const slider = document.querySelector('[data-slider]');
    if (slider) {
        const slides = slider.children;
        const prevBtn = document.querySelector('[data-slider-prev]');
        const nextBtn = document.querySelector('[data-slider-next]');
        const dotsContainer = document.querySelector('[data-slider-dots]');
        let currentIndex = 0;
        const totalSlides = slides.length;

        // Criar dots
        for (let i = 0; i < totalSlides; i++) {
            const dot = document.createElement('button');
            dot.className = 'slider-dot' + (i === 0 ? ' active' : '');
            dot.setAttribute('aria-label', 'Ir para banner ' + (i + 1));
            dot.addEventListener('click', () => goToSlide(i));
            dotsContainer.appendChild(dot);
        }

        const dots = dotsContainer.querySelectorAll('.slider-dot');

        function goToSlide(index) {
            currentIndex = index;
            slider.style.transform = 'translateX(-' + (currentIndex * 100) + '%)';
            dots.forEach((dot, i) => {
                dot.classList.toggle('active', i === currentIndex);
            });
        }

        function nextSlide() {
            goToSlide((currentIndex + 1) % totalSlides);
        }

        function prevSlide() {
            goToSlide((currentIndex - 1 + totalSlides) % totalSlides);
        }

        if (prevBtn) prevBtn.addEventListener('click', prevSlide);
        if (nextBtn) nextBtn.addEventListener('click', nextSlide);

        // Auto-play
        let autoPlay = setInterval(nextSlide, 5000);

        slider.addEventListener('mouseenter', () => clearInterval(autoPlay));
        slider.addEventListener('mouseleave', () => {
            autoPlay = setInterval(nextSlide, 5000);
        });
    }

    // Products Carousel
    const carousel = document.querySelector('[data-products-carousel]');
    if (carousel) {
        const track = carousel.querySelector('.products-track');
        const prevBtn = carousel.querySelector('[data-carousel-prev]');
        const nextBtn = carousel.querySelector('[data-carousel-next]');

        if (prevBtn && nextBtn) {
            prevBtn.addEventListener('click', () => {
                track.scrollBy({ left: -300, behavior: 'smooth' });
            });

            nextBtn.addEventListener('click', () => {
                track.scrollBy({ left: 300, behavior: 'smooth' });
            });
        }
    }
});
</script>
