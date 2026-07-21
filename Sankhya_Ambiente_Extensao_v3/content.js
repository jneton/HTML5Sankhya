(() => {
    'use strict';

    const host = window.location.hostname.toLowerCase();
    const porta = window.location.port;

    let icone = "";

    // Identifica o ambiente
    if (host === "snkbrp01672.ativy.com" || porta === "40172") {
        icone = "🔴";
    } else if (host === "snkbrt01672.ativy.com" || porta === "50172") {
        icone = "🟢";
    } else {
        return; // Não é um ambiente monitorado
    }

    /**
     * Remove qualquer indicador anterior do título.
     */
    function limparTitulo(titulo) {
        return titulo.replace(/^(🔴|🟢|⚪|�)\s*/u, "");
    }

    /**
     * Atualiza o título da aba apenas quando necessário.
     */
    function atualizarTitulo() {
        const tituloLimpo = limparTitulo(document.title);
        const novoTitulo = `${icone} ${tituloLimpo}`;

        if (document.title !== novoTitulo) {
            document.title = novoTitulo;
        }
    }

    // Atualiza imediatamente
    atualizarTitulo();

    // Observa alterações no elemento <title>
    const elementoTitle = document.querySelector("title");

    if (elementoTitle) {
        const observer = new MutationObserver(() => {
            atualizarTitulo();
        });

        observer.observe(elementoTitle, {
            childList: true,
            characterData: true,
            subtree: true
        });
    } else {
        // Fallback caso o <title> ainda não exista
        setInterval(atualizarTitulo, 1000);
    }
})();