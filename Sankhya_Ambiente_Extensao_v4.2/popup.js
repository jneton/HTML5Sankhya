'use strict';

document.addEventListener('DOMContentLoaded', () => {
    const status = document.getElementById('status');
    const address = document.getElementById('address');

    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
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
    });
});