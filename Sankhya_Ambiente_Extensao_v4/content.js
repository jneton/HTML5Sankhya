(() => {
    'use strict';

    const host = window.location.hostname.toLowerCase();
    const port = window.location.port;

    // A porta é a referência principal para os ambientes acessados pelo servidor Haiala.
    // Os nomes dos servidores identificam os ambientes hospedados nos demais endereços.
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

    const BANNER_ID = 'snk-environment-banner';
    const TITLE_PREFIX = /^(?:🔴|🟢|⚪)\s*/u;

    function updateTitle() {
        const cleanTitle = (document.title || 'Sankhya').replace(TITLE_PREFIX, '');
        const newTitle = `${environment.emoji} ${cleanTitle}`;
        if (document.title !== newTitle) document.title = newTitle;
    }

    function createBanner() {
        if (!document.body) return;

        let banner = document.getElementById(BANNER_ID);
        if (!banner) {
            banner = document.createElement('div');
            banner.id = BANNER_ID;
            banner.setAttribute('role', 'status');
            banner.setAttribute('aria-label', environment.label);
            document.body.appendChild(banner);
        }

        banner.className = environment.className;
        banner.textContent = `${environment.emoji}  ${environment.label}`;
    }

    function initialize() {
        createBanner();
        updateTitle();
    }

    initialize();

    // Recria o banner se a aplicação substituir o conteúdo do body.
    const bodyObserver = new MutationObserver(() => {
        if (!document.getElementById(BANNER_ID)) createBanner();
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

    // Garante a identificação mesmo se o título for criado posteriormente.
    document.addEventListener('DOMContentLoaded', initialize, { once: true });
})();