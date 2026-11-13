'use strict';

document.addEventListener('DOMContentLoaded', async () => {
    const status = document.getElementById('status');
    const address = document.getElementById('address');

    // Firefox disponibiliza a API padrão em browser; Chrome e Edge em chrome.
    // O acesso por Promise funciona nos três navegadores atuais.
    const extensionAPI = globalThis.browser || globalThis.chrome;

    try {
        if (!extensionAPI || !extensionAPI.tabs || !extensionAPI.tabs.query) {
            throw new Error('API de abas indisponível');
        }

        const tabs = await extensionAPI.tabs.query({ active: true, currentWindow: true });
        const tab = tabs && tabs[0];
        const tabUrl = tab && tab.url;

        if (!tabUrl) {
            status.textContent = 'Não foi possível identificar a aba.';
            status.className = 'unknown';
            return;
        }

        let url;
        try {
            url = new URL(tabUrl);
        } catch {
            status.textContent = 'Página não monitorada';
            status.className = 'unknown';
            address.textContent = tabUrl;
            return;
        }

        const host = url.hostname.toLowerCase();
        const port = url.port;
        let environment = null;

        if (port === '40172' || host === 'snkbrp01672.ativy.com' || host === 'snkbrp01672.wevy.cloud') {
            environment = { label: '🔴 AMBIENTE DE PRODUÇÃO', className: 'prd' };
        } else if (port === '50172' || host === 'snkbrt01672.ativy.com' || host === 'snkbrt01672.wevy.cloud') {
            environment = { label: '🟢 AMBIENTE DE TESTE', className: 'tst' };
        }

        if (environment) {
            status.textContent = environment.label;
            status.className = environment.className;
        } else {
            status.textContent = 'Página não monitorada';
            status.className = 'unknown';
        }

        address.textContent = url.origin;
    } catch (error) {
        status.textContent = 'Não foi possível consultar a aba.';
        status.className = 'unknown';
        address.textContent = error && error.message ? error.message : '';
    }
});
