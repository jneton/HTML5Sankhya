<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <snk:load/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Painel Gerencial PCP">
    <title>Painel Gerencial PCP</title>

    <style>
        :root {
            --bg: #ffffff;
            --topbar: #e9e9e9;
            --card: #e9e9eb;
            --card-hover: #dedee1;
            --text: #050505;
            --muted: #555;
            --accent: #ffff00;
            --radius: 15px;
            --content-max: 1160px;
            --gap: 34px;
        }

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background: var(--bg);
            color: var(--text);
            font-family: Arial, Helvetica, sans-serif;
            -webkit-font-smoothing: antialiased;
            text-rendering: optimizeLegibility;
        }

        /* Barra superior */
        .topbar {
            width: 100%;
            height: 20px;
            display: flex;
            align-items: center;
            padding: 0 27px;
            background: var(--topbar);
            font-size: 10px;
            font-weight: 700;
        }

        /* Área principal */
        .page {
            width: min(100% - 40px, 1340px);
            margin: 0 auto;
            padding: 56px 0 46px;
        }

        .dashboard-header {
            display: grid;
            grid-template-columns: 155px minmax(0, 1fr);
            align-items: center;
            gap: 30px;
            margin-bottom: 34px;
        }

        .filters {
            align-self: start;
            padding-top: 1px;
            font-size: 14px;
            font-style: italic;
            font-weight: 800;
            line-height: 1.25;
        }

        .filter-group + .filter-group {
            margin-top: 31px;
        }

        .filter-label {
            display: block;
            margin-bottom: 2px;
        }

        .filter-value {
            display: inline-block;
            padding: 0 2px;
            background: var(--accent);
            font-style: normal;
        }

        .main-title {
            margin: 0;
            text-align: center;
            font-size: clamp(14px, 1.35vw, 16px);
            font-style: italic;
            font-weight: 800;
            line-height: 1.3;
        }

        /* Grade de cards */
        .cards-grid {
            width: min(100%, 870px);
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px 34px;
        }

        .stock-card {
            min-height: 92px;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 145px;
            align-items: center;
            gap: 12px;
            padding: 12px 25px 12px 15px;
            border: 0;
            border-radius: var(--radius);
            background: var(--card);
            color: var(--text);
            text-decoration: none;
            cursor: pointer;
            transition:
                transform 150ms ease,
                background-color 150ms ease,
                box-shadow 150ms ease;
            outline: none;
        }

        .stock-card:hover {
            background: var(--card-hover);
            transform: translateY(-2px);
            box-shadow: 0 5px 14px rgba(0, 0, 0, 0.08);
        }

        .stock-card:active {
            transform: scale(0.985);
        }

        .stock-card:focus-visible {
            box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.25);
        }

        .stock-card__name {
            font-size: 14px;
            font-weight: 800;
            line-height: 1.2;
        }

        .stock-card__metric {
            text-align: center;
            min-width: 0;
        }

        .stock-card__label {
            display: block;
            margin-bottom: 2px;
            font-size: 13px;
            font-weight: 700;
            line-height: 1.1;
        }

        .stock-card__value {
            display: block;
            font-size: clamp(35px, 3.2vw, 42px);
            font-weight: 800;
            line-height: 0.95;
            letter-spacing: -1.5px;
        }

        /* Responsividade */
        @media (max-width: 1000px) {
            .page {
                width: min(100% - 30px, 850px);
                padding-top: 42px;
            }

            .dashboard-header {
                grid-template-columns: 125px minmax(0, 1fr);
                gap: 20px;
            }

            .cards-grid {
                width: 100%;
                gap: 12px 22px;
            }

            .stock-card {
                grid-template-columns: minmax(0, 1fr) 125px;
                padding-right: 15px;
            }
        }

        @media (max-width: 700px) {
            .topbar {
                padding-left: 14px;
                font-size: 9px;
            }

            .page {
                width: min(100% - 24px, 520px);
                padding: 30px 0 35px;
            }

            .dashboard-header {
                grid-template-columns: 1fr;
                gap: 22px;
                margin-bottom: 25px;
            }

            .filters {
                display: flex;
                justify-content: center;
                gap: 28px;
                padding: 0;
                font-size: 13px;
            }

            .filter-group + .filter-group {
                margin-top: 0;
            }

            .main-title {
                order: -1;
            }

            .cards-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .stock-card {
                min-height: 84px;
                grid-template-columns: minmax(0, 1fr) 125px;
                padding: 10px 15px;
            }

            .stock-card__name {
                font-size: 13px;
            }

            .stock-card__label {
                font-size: 12px;
            }

            .stock-card__value {
                font-size: 36px;
            }
        }

        @media (max-width: 390px) {
            .filters {
                justify-content: space-between;
                gap: 12px;
            }

            .stock-card {
                grid-template-columns: minmax(0, 1fr) 112px;
            }

            .stock-card__value {
                font-size: 33px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            html {
                scroll-behavior: auto;
            }

            .stock-card {
                transition: none;
            }
        }
    </style>
</head>

<body>
    <header class="topbar">
        Painel Gerencial PCP
    </header>

    <main class="page">
        <header class="dashboard-header">
            <aside class="filters" aria-label="Filtros do painel">
                <div class="filter-group">
                    <span class="filter-label">Filtro:</span>
                    <span class="filter-value" id="dateFilter">Data do Dia</span>
                </div>

                <div class="filter-group">
                    <span class="filter-label">Status:</span>
                    <span class="filter-value" id="statusFilter">Ativo</span>
                </div>
            </aside>

            <h1 class="main-title">
                Informações Agrupadas conforme Estrutura de Grupos (Quantitativo)
            </h1>
        </header>

        <section class="cards-grid" aria-label="Níveis de estoque">
            <a class="stock-card"
               href="#"
               data-name="Matéria Prima AÇO"
               data-value="68,5%">
                <span class="stock-card__name">Matéria Prima AÇO</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">68,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="Produtos Intermediários (PERFIL)"
               data-value="90,5%">
                <span class="stock-card__name">Produtos Intermediários (PERFIL)</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">90,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="Matéria Prima ALUMÍNIO"
               data-value="72,5%">
                <span class="stock-card__name">Matéria Prima ALUMÍNIO</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">72,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="Produtos em Processo (SA / PINT)"
               data-value="88,5%">
                <span class="stock-card__name">Produtos em Processo (SA / PINT)</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">88,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="Matéria Prima ACESSÓRIOS"
               data-value="61,5%">
                <span class="stock-card__name">Matéria Prima ACESSÓRIOS</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">61,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="Produtos Acabado AÇO"
               data-value="79,5%">
                <span class="stock-card__name">Produtos Acabado AÇO</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">79,5%</span>
                </span>
            </a>

            <a class="stock-card"
               href="#"
               data-name="EMBALAGENS"
               data-value="89,5%">
                <span class="stock-card__name">EMBALAGENS</span>
                <span class="stock-card__metric">
                    <span class="stock-card__label">Nível de Estoque %</span>
                    <span class="stock-card__value">89,5%</span>
                </span>
            </a>
        </section>
    </main>

    <script>
        (() => {
            'use strict';

            /*
             * Futuras telas:
             * ------------------------------------------------------------
             * Quando as páginas de detalhe estiverem prontas, basta
             * cadastrar a URL correspondente neste objeto.
             *
             * Exemplo:
             *
             * const ROUTES = {
             *     "Matéria Prima AÇO": "materia-prima-aco.html",
             *     "Matéria Prima ALUMÍNIO": "materia-prima-aluminio.html"
             * };
             */
            const ROUTES = Object.freeze({
                // "Matéria Prima AÇO": "materia-prima-aco.html",
                // "Produtos Intermediários (PERFIL)": "produtos-perfil.html",
                // "Matéria Prima ALUMÍNIO": "materia-prima-aluminio.html",
                // "Produtos em Processo (SA / PINT)": "produtos-processo.html",
                // "Matéria Prima ACESSÓRIOS": "materia-prima-acessorios.html",
                // "Produtos Acabado AÇO": "produtos-acabados-aco.html",
                // "EMBALAGENS": "embalagens.html"
            });

            const cards = document.querySelectorAll('.stock-card');

            cards.forEach((card) => {
                const name = card.dataset.name;
                const route = ROUTES[name];

                if (route) {
                    card.setAttribute('href', route);
                    card.setAttribute('target', '_blank');
                    card.setAttribute('rel', 'noopener noreferrer');
                } else {
                    card.setAttribute('aria-label', `${name} — tela em desenvolvimento`);
                }

                card.addEventListener('click', (event) => {
                    const destination = ROUTES[name];

                    /*
                     * Enquanto a tela de destino não existir, não realiza
                     * navegação. Isso permite desenvolver o painel primeiro.
                     */
                    if (!destination) {
                        event.preventDefault();
                        card.classList.add('is-clicked');

                        window.setTimeout(() => {
                            card.classList.remove('is-clicked');
                        }, 120);

                        console.info(`Tela "${name}" ainda não cadastrada.`);
                    }
                });

                /*
                 * Acessibilidade: permite ativar o card com Enter ou Espaço.
                 */
                card.addEventListener('keydown', (event) => {
                    if (event.key !== 'Enter' && event.key !== ' ') {
                        return;
                    }

                    event.preventDefault();
                    card.click();
                });
            });
        })();
    </script>
</body>
</html>
