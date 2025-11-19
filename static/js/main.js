/**
 * AquaX Piscinas - JavaScript Principal
 * Tema Nuvemshop
 */

(function() {
  'use strict';

  // ========================================
  // Variáveis Globais
  // ========================================
  const selectors = {
    menuToggle: '.menu-toggle',
    navMenu: '.nav-menu',
    menuOverlay: '.menu-overlay',
    header: '.header',
    searchInput: '.search-input',
    cartCount: '[data-cart-count]',
    cartTotal: '[data-cart-total]'
  };

  // ========================================
  // Menu Mobile
  // ========================================
  const MobileMenu = {
    init() {
      const toggle = document.querySelector(selectors.menuToggle);
      const menu = document.querySelector(selectors.navMenu);
      const overlay = document.querySelector(selectors.menuOverlay);

      if (!toggle || !menu) return;

      toggle.addEventListener('click', () => {
        const isOpen = toggle.getAttribute('aria-expanded') === 'true';
        this.toggleMenu(!isOpen, toggle, menu, overlay);
      });

      // Fechar ao clicar no overlay
      if (overlay) {
        overlay.addEventListener('click', () => {
          this.toggleMenu(false, toggle, menu, overlay);
        });
      }

      // Fechar ao pressionar ESC
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          this.toggleMenu(false, toggle, menu, overlay);
        }
      });
    },

    toggleMenu(open, toggle, menu, overlay) {
      toggle.setAttribute('aria-expanded', open);
      menu.classList.toggle('active', open);
      if (overlay) {
        overlay.classList.toggle('active', open);
      }
      document.body.style.overflow = open ? 'hidden' : '';
    }
  };

  // ========================================
  // Header Sticky com Scroll
  // ========================================
  const StickyHeader = {
    init() {
      const header = document.querySelector(selectors.header);
      if (!header) return;

      let lastScroll = 0;
      const scrollThreshold = 100;

      window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        if (currentScroll <= 0) {
          header.classList.remove('scroll-up');
          return;
        }

        if (currentScroll > lastScroll && currentScroll > scrollThreshold) {
          // Scroll down
          header.classList.remove('scroll-up');
          header.classList.add('scroll-down');
        } else if (currentScroll < lastScroll) {
          // Scroll up
          header.classList.remove('scroll-down');
          header.classList.add('scroll-up');
        }

        lastScroll = currentScroll;
      }, { passive: true });
    }
  };

  // ========================================
  // Busca
  // ========================================
  const Search = {
    init() {
      const searchInput = document.querySelector(selectors.searchInput);
      if (!searchInput) return;

      // Limpar campo ao focar
      searchInput.addEventListener('focus', function() {
        this.select();
      });

      // Prevenir submit vazio
      const form = searchInput.closest('form');
      if (form) {
        form.addEventListener('submit', (e) => {
          if (!searchInput.value.trim()) {
            e.preventDefault();
            searchInput.focus();
          }
        });
      }
    }
  };

  // ========================================
  // Carrinho (atualização AJAX)
  // ========================================
  const Cart = {
    init() {
      // Listener para eventos de atualização do carrinho
      document.addEventListener('cart:updated', (e) => {
        this.updateCartUI(e.detail);
      });
    },

    updateCartUI(data) {
      const countElement = document.querySelector(selectors.cartCount);
      const totalElement = document.querySelector(selectors.cartTotal);

      if (countElement && data.items_count !== undefined) {
        countElement.textContent = data.items_count;
        countElement.style.display = data.items_count > 0 ? 'flex' : 'none';
      }

      if (totalElement && data.total !== undefined) {
        totalElement.textContent = data.total;
      }
    },

    // Método para adicionar ao carrinho via AJAX
    async addToCart(productId, quantity = 1, variantId = null) {
      try {
        const formData = new FormData();
        formData.append('product_id', productId);
        formData.append('quantity', quantity);
        if (variantId) {
          formData.append('variant_id', variantId);
        }

        const response = await fetch('/cart/add', {
          method: 'POST',
          body: formData
        });

        if (response.ok) {
          const data = await response.json();
          document.dispatchEvent(new CustomEvent('cart:updated', { detail: data }));
          this.showFeedback('Produto adicionado ao carrinho!', 'success');
          return data;
        } else {
          throw new Error('Erro ao adicionar produto');
        }
      } catch (error) {
        console.error('Erro:', error);
        this.showFeedback('Erro ao adicionar produto ao carrinho', 'error');
        return null;
      }
    },

    showFeedback(message, type) {
      // Criar elemento de feedback
      const feedback = document.createElement('div');
      feedback.className = `cart-feedback cart-feedback--${type}`;
      feedback.innerHTML = `
        <span>${message}</span>
        <button type="button" aria-label="Fechar">&times;</button>
      `;

      document.body.appendChild(feedback);

      // Animar entrada
      setTimeout(() => feedback.classList.add('active'), 10);

      // Fechar automaticamente
      setTimeout(() => {
        feedback.classList.remove('active');
        setTimeout(() => feedback.remove(), 300);
      }, 3000);

      // Fechar ao clicar
      feedback.querySelector('button').addEventListener('click', () => {
        feedback.classList.remove('active');
        setTimeout(() => feedback.remove(), 300);
      });
    }
  };

  // ========================================
  // Lazy Loading de Imagens
  // ========================================
  const LazyLoad = {
    init() {
      if ('loading' in HTMLImageElement.prototype) {
        // Browser suporta lazy loading nativo
        const images = document.querySelectorAll('img[loading="lazy"]');
        images.forEach(img => {
          if (img.dataset.src) {
            img.src = img.dataset.src;
          }
        });
      } else {
        // Fallback com Intersection Observer
        const images = document.querySelectorAll('img[data-src]');

        const imageObserver = new IntersectionObserver((entries, observer) => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              const img = entry.target;
              img.src = img.dataset.src;
              img.removeAttribute('data-src');
              observer.unobserve(img);
            }
          });
        });

        images.forEach(img => imageObserver.observe(img));
      }
    }
  };

  // ========================================
  // Validação de Formulários
  // ========================================
  const FormValidation = {
    init() {
      const forms = document.querySelectorAll('form[data-validate]');

      forms.forEach(form => {
        form.addEventListener('submit', (e) => {
          if (!this.validateForm(form)) {
            e.preventDefault();
          }
        });

        // Validação em tempo real
        const inputs = form.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
          input.addEventListener('blur', () => {
            this.validateField(input);
          });
        });
      });
    },

    validateForm(form) {
      let isValid = true;
      const inputs = form.querySelectorAll('input, textarea, select');

      inputs.forEach(input => {
        if (!this.validateField(input)) {
          isValid = false;
        }
      });

      return isValid;
    },

    validateField(field) {
      const value = field.value.trim();
      let isValid = true;
      let errorMessage = '';

      // Required
      if (field.required && !value) {
        isValid = false;
        errorMessage = 'Este campo é obrigatório';
      }

      // Email
      if (field.type === 'email' && value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
          isValid = false;
          errorMessage = 'E-mail inválido';
        }
      }

      // Phone
      if (field.type === 'tel' && value) {
        const phoneRegex = /^[\d\s\(\)\-\+]+$/;
        if (!phoneRegex.test(value)) {
          isValid = false;
          errorMessage = 'Telefone inválido';
        }
      }

      // Min length
      if (field.minLength && value.length < field.minLength) {
        isValid = false;
        errorMessage = `Mínimo de ${field.minLength} caracteres`;
      }

      // Mostrar/esconder erro
      this.showFieldError(field, isValid, errorMessage);

      return isValid;
    },

    showFieldError(field, isValid, message) {
      const container = field.closest('.form-group') || field.parentElement;
      let errorElement = container.querySelector('.field-error');

      if (!isValid) {
        field.classList.add('is-invalid');
        field.classList.remove('is-valid');

        if (!errorElement) {
          errorElement = document.createElement('span');
          errorElement.className = 'field-error';
          container.appendChild(errorElement);
        }
        errorElement.textContent = message;
      } else {
        field.classList.remove('is-invalid');
        field.classList.add('is-valid');

        if (errorElement) {
          errorElement.remove();
        }
      }
    }
  };

  // ========================================
  // Quantity Selector
  // ========================================
  const QuantitySelector = {
    init() {
      document.addEventListener('click', (e) => {
        const btn = e.target.closest('[data-quantity-btn]');
        if (!btn) return;

        const wrapper = btn.closest('[data-quantity-wrapper]');
        const input = wrapper.querySelector('input');
        const action = btn.dataset.quantityBtn;
        let value = parseInt(input.value) || 1;
        const min = parseInt(input.min) || 1;
        const max = parseInt(input.max) || 999;

        if (action === 'minus' && value > min) {
          value--;
        } else if (action === 'plus' && value < max) {
          value++;
        }

        input.value = value;
        input.dispatchEvent(new Event('change', { bubbles: true }));
      });
    }
  };

  // ========================================
  // Smooth Scroll
  // ========================================
  const SmoothScroll = {
    init() {
      document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
          const targetId = this.getAttribute('href');
          if (targetId === '#') return;

          const target = document.querySelector(targetId);
          if (target) {
            e.preventDefault();
            target.scrollIntoView({
              behavior: 'smooth',
              block: 'start'
            });
          }
        });
      });
    }
  };

  // ========================================
  // Utilitários
  // ========================================
  const Utils = {
    // Debounce
    debounce(func, wait) {
      let timeout;
      return function executedFunction(...args) {
        const later = () => {
          clearTimeout(timeout);
          func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
      };
    },

    // Throttle
    throttle(func, limit) {
      let inThrottle;
      return function(...args) {
        if (!inThrottle) {
          func.apply(this, args);
          inThrottle = true;
          setTimeout(() => inThrottle = false, limit);
        }
      };
    },

    // Format money
    formatMoney(cents, format = 'R$ {{amount}}') {
      const amount = (cents / 100).toFixed(2).replace('.', ',');
      return format.replace('{{amount}}', amount);
    }
  };

  // ========================================
  // Inicialização
  // ========================================
  function init() {
    MobileMenu.init();
    StickyHeader.init();
    Search.init();
    Cart.init();
    LazyLoad.init();
    FormValidation.init();
    QuantitySelector.init();
    SmoothScroll.init();

    // Expor Cart globalmente para uso em outros scripts
    window.AquaXCart = Cart;
    window.AquaXUtils = Utils;

    console.log('AquaX Piscinas - Theme initialized');
  }

  // Iniciar quando DOM estiver pronto
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();
