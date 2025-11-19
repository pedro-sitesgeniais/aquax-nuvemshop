/**
 * AquaX Piscinas - Carousel Component
 * Carousel/Slider avançado para produtos
 */

class AquaXCarousel {
    constructor(element, options = {}) {
        this.container = element;
        this.track = element.querySelector('[data-carousel-track]') || element.querySelector('.products-track');
        this.slides = this.track ? Array.from(this.track.children) : [];

        if (!this.track || this.slides.length === 0) return;

        // Opções padrão
        this.options = {
            slidesToShow: options.slidesToShow || 4,
            slidesToScroll: options.slidesToScroll || 1,
            gap: options.gap || 16,
            autoplay: options.autoplay || false,
            autoplaySpeed: options.autoplaySpeed || 5000,
            dots: options.dots || false,
            arrows: options.arrows !== false,
            infinite: options.infinite || false,
            responsive: options.responsive || [
                { breakpoint: 1200, settings: { slidesToShow: 4 } },
                { breakpoint: 992, settings: { slidesToShow: 3 } },
                { breakpoint: 768, settings: { slidesToShow: 2 } },
                { breakpoint: 576, settings: { slidesToShow: 1 } }
            ],
            ...options
        };

        this.currentIndex = 0;
        this.isAnimating = false;
        this.autoplayInterval = null;

        this.init();
    }

    init() {
        this.setupStructure();
        this.calculateDimensions();
        this.bindEvents();
        this.updateArrows();

        if (this.options.autoplay) {
            this.startAutoplay();
        }

        if (this.options.dots) {
            this.createDots();
        }
    }

    setupStructure() {
        this.container.classList.add('aquax-carousel');
        this.track.style.display = 'flex';
        this.track.style.transition = 'transform 0.4s ease';
    }

    calculateDimensions() {
        const containerWidth = this.container.offsetWidth;
        const slidesToShow = this.getSlidesToShow();
        const totalGap = this.options.gap * (slidesToShow - 1);
        this.slideWidth = (containerWidth - totalGap) / slidesToShow;

        this.slides.forEach(slide => {
            slide.style.flex = `0 0 ${this.slideWidth}px`;
            slide.style.marginRight = `${this.options.gap}px`;
        });

        // Remover margin do último slide visível
        if (this.slides.length > 0) {
            this.slides[this.slides.length - 1].style.marginRight = '0';
        }

        this.maxIndex = Math.max(0, this.slides.length - slidesToShow);
    }

    getSlidesToShow() {
        const width = window.innerWidth;
        let slidesToShow = this.options.slidesToShow;

        for (const bp of this.options.responsive) {
            if (width < bp.breakpoint) {
                slidesToShow = bp.settings.slidesToShow;
            }
        }

        return slidesToShow;
    }

    bindEvents() {
        // Botões de navegação
        const prevBtn = this.container.querySelector('[data-carousel-prev]');
        const nextBtn = this.container.querySelector('[data-carousel-next]');

        if (prevBtn) {
            prevBtn.addEventListener('click', () => this.prev());
        }

        if (nextBtn) {
            nextBtn.addEventListener('click', () => this.next());
        }

        // Resize
        let resizeTimeout;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(() => {
                this.calculateDimensions();
                this.goTo(this.currentIndex);
            }, 200);
        });

        // Touch/Swipe
        this.setupTouch();

        // Pausar autoplay no hover
        if (this.options.autoplay) {
            this.container.addEventListener('mouseenter', () => this.stopAutoplay());
            this.container.addEventListener('mouseleave', () => this.startAutoplay());
        }
    }

    setupTouch() {
        let startX = 0;
        let startY = 0;
        let isDragging = false;
        let currentX = 0;

        this.track.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;
            isDragging = true;
        }, { passive: true });

        this.track.addEventListener('touchmove', (e) => {
            if (!isDragging) return;

            currentX = e.touches[0].clientX;
            const diffX = startX - currentX;
            const diffY = Math.abs(startY - e.touches[0].clientY);

            // Se movimento vertical for maior, ignorar swipe
            if (diffY > Math.abs(diffX)) {
                isDragging = false;
                return;
            }
        }, { passive: true });

        this.track.addEventListener('touchend', () => {
            if (!isDragging) return;

            const diffX = startX - currentX;
            const threshold = this.slideWidth / 4;

            if (diffX > threshold) {
                this.next();
            } else if (diffX < -threshold) {
                this.prev();
            }

            isDragging = false;
        });
    }

    prev() {
        if (this.isAnimating || this.currentIndex === 0) return;
        this.goTo(this.currentIndex - this.options.slidesToScroll);
    }

    next() {
        if (this.isAnimating || this.currentIndex >= this.maxIndex) return;
        this.goTo(this.currentIndex + this.options.slidesToScroll);
    }

    goTo(index) {
        if (this.isAnimating) return;

        this.isAnimating = true;
        this.currentIndex = Math.max(0, Math.min(index, this.maxIndex));

        const translateX = this.currentIndex * (this.slideWidth + this.options.gap);
        this.track.style.transform = `translateX(-${translateX}px)`;

        setTimeout(() => {
            this.isAnimating = false;
        }, 400);

        this.updateArrows();
        this.updateDots();
    }

    updateArrows() {
        const prevBtn = this.container.querySelector('[data-carousel-prev]');
        const nextBtn = this.container.querySelector('[data-carousel-next]');

        if (prevBtn) {
            prevBtn.disabled = this.currentIndex === 0;
            prevBtn.style.opacity = this.currentIndex === 0 ? '0.5' : '1';
        }

        if (nextBtn) {
            nextBtn.disabled = this.currentIndex >= this.maxIndex;
            nextBtn.style.opacity = this.currentIndex >= this.maxIndex ? '0.5' : '1';
        }
    }

    createDots() {
        const dotsContainer = document.createElement('div');
        dotsContainer.className = 'carousel-dots';

        const totalDots = this.maxIndex + 1;

        for (let i = 0; i < totalDots; i++) {
            const dot = document.createElement('button');
            dot.className = 'carousel-dot' + (i === 0 ? ' active' : '');
            dot.setAttribute('aria-label', `Ir para slide ${i + 1}`);
            dot.addEventListener('click', () => this.goTo(i));
            dotsContainer.appendChild(dot);
        }

        this.container.appendChild(dotsContainer);
        this.dots = dotsContainer.querySelectorAll('.carousel-dot');
    }

    updateDots() {
        if (!this.dots) return;

        this.dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === this.currentIndex);
        });
    }

    startAutoplay() {
        if (this.autoplayInterval) return;

        this.autoplayInterval = setInterval(() => {
            if (this.currentIndex >= this.maxIndex) {
                this.goTo(0);
            } else {
                this.next();
            }
        }, this.options.autoplaySpeed);
    }

    stopAutoplay() {
        if (this.autoplayInterval) {
            clearInterval(this.autoplayInterval);
            this.autoplayInterval = null;
        }
    }

    destroy() {
        this.stopAutoplay();
        this.track.style.transform = '';
        this.track.style.transition = '';
        this.slides.forEach(slide => {
            slide.style.flex = '';
            slide.style.marginRight = '';
        });
    }
}

// Auto-inicializar carousels
document.addEventListener('DOMContentLoaded', function() {
    const carousels = document.querySelectorAll('[data-products-carousel]');

    carousels.forEach(carousel => {
        new AquaXCarousel(carousel, {
            slidesToShow: 4,
            gap: 16,
            responsive: [
                { breakpoint: 1200, settings: { slidesToShow: 4 } },
                { breakpoint: 992, settings: { slidesToShow: 3 } },
                { breakpoint: 768, settings: { slidesToShow: 2 } },
                { breakpoint: 576, settings: { slidesToShow: 2 } }
            ]
        });
    });
});

// Exportar para uso global
window.AquaXCarousel = AquaXCarousel;
