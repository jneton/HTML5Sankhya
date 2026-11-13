(() => {
    'use strict';

    const host = window.location.hostname.toLowerCase();
    const port = window.location.port;

    // Identifica o ambiente pela porta ou pelo nome do servidor.
    let environment = null;

    if (port === '40172' || host === 'snkbrp01672.ativy.com' || host === 'snkbrp01672.wevy.cloud') {
        environment = {
            code: 'PRD',
            label: 'AMBIENTE DE PRODUÇÃO',
            className: 'snk-prd',
            color: '#c90000',
            emoji: '🔴'
        };
    } else if (port === '50172' || host === 'snkbrt01672.ativy.com' || host === 'snkbrt01672.wevy.cloud') {
        environment = {
            code: 'TST',
            label: 'AMBIENTE DE TESTE',
            className: 'snk-tst',
            color: '#079b32',
            emoji: '🟢'
        };
    }

    // Não interfere em páginas que não pertencem aos ambientes monitorados.
    if (!environment) return;

    const INDICATOR_ID = 'snk-environment-indicator';
    const TITLE_PREFIX = /^(?:🔴|🟢|⚪)\s*/u;
    const EDGE_TRIGGER_PX = 12;

    function updateTitle() {
        const cleanTitle = (document.title || 'Sankhya').replace(TITLE_PREFIX, '');
        const newTitle = `${environment.emoji} ${cleanTitle}`;
        if (document.title !== newTitle) document.title = newTitle;
    }

    function createIndicator() {
        if (!document.body) return;

        let indicator = document.getElementById(INDICATOR_ID);

        if (!indicator) {
            indicator = document.createElement('div');
            indicator.id = INDICATOR_ID;
            indicator.setAttribute('role', 'status');
            indicator.setAttribute('aria-label', environment.label);
            indicator.setAttribute('title', environment.label);
            document.body.appendChild(indicator);
        }

        indicator.className = environment.className;
        indicator.textContent = environment.code;
    }

    function handleMouseMove(event) {
        const indicator = document.getElementById(INDICATOR_ID);
        if (!indicator) return;

        // Exibe a bolinha somente quando o ponteiro encosta na borda esquerda.
        indicator.classList.toggle('snk-visible', event.clientX <= EDGE_TRIGGER_PX);
    }

    function hideIndicator() {
        const indicator = document.getElementById(INDICATOR_ID);
        if (indicator) indicator.classList.remove('snk-visible');
    }

    function initialize() {
        createIndicator();
        updateTitle();
    }

    initialize();

    document.addEventListener('mousemove', handleMouseMove, { passive: true });
    document.addEventListener('mouseleave', hideIndicator);

    // Recria o indicador se a aplicação substituir o conteúdo do body.
    const bodyObserver = new MutationObserver(() => {
        if (!document.getElementById(INDICATOR_ID)) createIndicator();
    });

    if (document.body) {
        bodyObserver.observe(document.body, { childList: true });
    }

    // Atualiza o título quando o Sankhya altera o nome da página.
    const titleElement = document.querySelector('title');
    if (titleElement) {
        const titleObserver = new MutationObserver(updateTitle);
        titleObserver.observe(titleElement, {
            childList: true,
            characterData: true,
            subtree: true
        });
    }

    document.addEventListener('DOMContentLoaded', initialize, { once: true });
})();