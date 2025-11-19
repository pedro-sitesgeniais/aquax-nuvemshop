/**
 * AquaX Piscinas - Filters Component
 * Filtros de categoria com AJAX
 */

class AquaXFilters {
    constructor(container) {
        this.container = container;
        this.form = container.querySelector('form') || container;
        this.productsContainer = document.querySelector('.category-products');
        this.productsGrid = document.querySelector('.products-grid');

        if (!this.productsContainer) return;

        this.isLoading = false;
        this.init();
    }

    init() {
        this.bindEvents();
        this.setupPriceRange();
    }

    bindEvents() {
        // Filtros checkbox
        const checkboxes = this.container.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => this.applyFilters());
        });

        // Ordenação
        const sortSelect = document.querySelector('[data-sort]');
        if (sortSelect) {
            sortSelect.addEventListener('change', () => this.applyFilters());
        }

        // Limpar filtros
        const clearBtn = this.container.querySelector('[data-clear-filters]');
        if (clearBtn) {
            clearBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.clearFilters();
            });
        }

        // Aplicar preço
        const priceBtn = this.container.querySelector('[data-apply-price]');
        if (priceBtn) {
            priceBtn.addEventListener('click', () => this.applyFilters());
        }

        // Navegação com histórico
        window.addEventListener('popstate', (e) => {
            if (e.state && e.state.filters) {
                this.loadProducts(e.state.url, false);
            }
        });
    }

    setupPriceRange() {
        const minInput = this.container.querySelector('[data-price-min]');
        const maxInput = this.container.querySelector('[data-price-max]');

        if (minInput && maxInput) {
            // Carregar valores da URL
            const params = new URLSearchParams(window.location.search);
            if (params.has('price_min')) {
                minInput.value = params.get('price_min');
            }
            if (params.has('price_max')) {
                maxInput.value = params.get('price_max');
            }

            // Enter para aplicar
            [minInput, maxInput].forEach(input => {
                input.addEventListener('keypress', (e) => {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.applyFilters();
                    }
                });
            });
        }
    }

    getFilterData() {
        const data = {};

        // Checkboxes
        const checkboxes = this.container.querySelectorAll('input[type="checkbox"]:checked');
        checkboxes.forEach(checkbox => {
            const name = checkbox.name;
            if (!data[name]) {
                data[name] = [];
            }
            data[name].push(checkbox.value);
        });

        // Preço
        const minPrice = this.container.querySelector('[data-price-min]')?.value;
        const maxPrice = this.container.querySelector('[data-price-max]')?.value;

        if (minPrice) data.price_min = minPrice;
        if (maxPrice) data.price_max = maxPrice;

        // Ordenação
        const sort = document.querySelector('[data-sort]')?.value;
        if (sort) data.sort = sort;

        return data;
    }

    buildUrl(data) {
        const url = new URL(window.location.href);

        // Limpar parâmetros existentes
        url.search = '';

        // Adicionar novos parâmetros
        Object.entries(data).forEach(([key, value]) => {
            if (Array.isArray(value)) {
                value.forEach(v => url.searchParams.append(key, v));
            } else {
                url.searchParams.set(key, value);
            }
        });

        return url.toString();
    }

    async applyFilters() {
        if (this.isLoading) return;

        const data = this.getFilterData();
        const url = this.buildUrl(data);

        await this.loadProducts(url);
    }

    async loadProducts(url, updateHistory = true) {
        if (this.isLoading) return;

        this.isLoading = true;
        this.showLoading();

        try {
            const response = await fetch(url, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });

            if (response.ok) {
                const html = await response.text();
                this.updateProducts(html);

                if (updateHistory) {
                    history.pushState({ filters: true, url }, '', url);
                }
            }
        } catch (error) {
            console.error('Filter error:', error);
            // Fallback: recarregar página
            window.location.href = url;
        } finally {
            this.isLoading = false;
            this.hideLoading();
        }
    }

    updateProducts(html) {
        // Extrair conteúdo da resposta
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        // Atualizar grid de produtos
        const newGrid = doc.querySelector('.products-grid');
        const newToolbar = doc.querySelector('.products-toolbar');
        const newPagination = doc.querySelector('.pagination');

        if (newGrid && this.productsGrid) {
            this.productsGrid.innerHTML = newGrid.innerHTML;
        }

        // Atualizar toolbar (contagem)
        const toolbar = document.querySelector('.products-toolbar');
        if (newToolbar && toolbar) {
            toolbar.innerHTML = newToolbar.innerHTML;
        }

        // Atualizar paginação
        const pagination = document.querySelector('.pagination');
        if (pagination) {
            if (newPagination) {
                pagination.innerHTML = newPagination.innerHTML;
            } else {
                pagination.style.display = 'none';
            }
        }

        // Scroll para topo dos produtos
        this.productsContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    clearFilters() {
        // Desmarcar checkboxes
        const checkboxes = this.container.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(cb => cb.checked = false);

        // Limpar preços
        const minInput = this.container.querySelector('[data-price-min]');
        const maxInput = this.container.querySelector('[data-price-max]');
        if (minInput) minInput.value = '';
        if (maxInput) maxInput.value = '';

        // Resetar ordenação
        const sortSelect = document.querySelector('[data-sort]');
        if (sortSelect) sortSelect.value = 'relevance';

        // Aplicar (carregar sem filtros)
        const url = window.location.pathname;
        this.loadProducts(url);
    }

    showLoading() {
        this.productsContainer.classList.add('loading');

        // Criar overlay de loading se não existir
        if (!this.productsContainer.querySelector('.loading-overlay')) {
            const overlay = document.createElement('div');
            overlay.className = 'loading-overlay';
            overlay.innerHTML = '<div class="spinner"></div>';
            this.productsContainer.appendChild(overlay);
        }
    }

    hideLoading() {
        this.productsContainer.classList.remove('loading');
    }
}

// Inicializar
document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.querySelector('.category-sidebar');
    if (sidebar) {
        new AquaXFilters(sidebar);
    }
});
