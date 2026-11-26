<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard de Ordens de Carga</title>
    <snk:load/>
    <link rel="stylesheet" href="css/mainCSS.css">
</head>
<body>
<div class="dashboard" id="dashboard">
    <header class="topbar">
        <div>
            <span class="eyebrow">LOGÍSTICA • EXPEDIÇÃO</span>
            <h1>Ordens de Carga</h1>
            <p class="subtitle">Visão consolidada de pendências, estoque e frete</p>
        </div>
        <div class="toolbar">
            <span id="statusAtualizacao" class="status">Aguardando consulta</span>
            <button id="btnAtualizar" class="btn btn-primary" type="button">Atualizar dados</button>
        </div>
    </header>

    <section class="filters" aria-label="Filtros aplicados">
        <div class="filter-info"><span class="filter-label">Ordens selecionadas</span><strong id="totalOCs">—</strong></div>
        <div class="filter-info"><span class="filter-label">Situações</span><strong id="situacoes">Parâmetro Sankhya</strong></div>
        <div class="filter-info"><span class="filter-label">Última atualização</span><strong id="ultimaAtualizacao">—</strong></div>
    </section>

    <section class="kpis" aria-label="Indicadores">
        <article class="kpi"><span>Produtos</span><strong id="kpiProdutos">0</strong><small>Produtos distintos</small></article>
        <article class="kpi"><span>Quantidade pendente</span><strong id="kpiPendente">0</strong><small>Unidades a expedir</small></article>
        <article class="kpi"><span>Valor dos itens</span><strong id="kpiValor">R$ 0,00</strong><small>Valor líquido pendente</small></article>
        <article class="kpi"><span>Frete previsto</span><strong id="kpiFrete">R$ 0,00</strong><small>Frete dos itens pendentes</small></article>
        <article class="kpi"><span>Volume total</span><strong id="kpiVolume">0,00 m³</strong><small>Volume estimado</small></article>
        <article class="kpi"><span>Produtos em falta</span><strong id="kpiFalta">0</strong><small>Saldo de estoque negativo</small></article>
    </section>

    <section class="panel charts">
        <div class="panel-heading"><div><h2>Resumo por ordem de carga</h2><p>Comparativo de quantidade pendente e valor de frete</p></div></div>
        <div id="graficoOC" class="chart-area"><div class="empty">Aguardando dados…</div></div>
    </section>

    <section class="panel">
        <div class="panel-heading table-heading">
            <div><h2>Detalhamento por produto e ordem</h2><p id="resumoTabela">0 registros</p></div>
            <div class="table-tools">
                <input id="pesquisa" type="search" placeholder="Buscar produto, descrição ou OC…" aria-label="Pesquisar">
                <button id="btnCSV" class="btn btn-secondary" type="button">Exportar CSV</button>
            </div>
        </div>
        <div class="table-wrap">
            <table id="tabelaDados">
                <thead><tr>
                    <th>Produto</th><th>Descrição</th><th>OC</th><th>Qtd. pendente</th>
                    <th>Estoque</th><th>Saldo</th><th>Valor itens</th><th>Frete</th><th>Volume m³</th><th>Pedidos c/ observação</th>
                </tr></thead>
                <tbody id="corpoTabela"><tr><td colspan="10" class="empty">Selecione os parâmetros e atualize o dashboard.</td></tr></tbody>
            </table>
        </div>
        <footer class="table-footer"><span id="contadorLinhas">0 linhas</span><span>As ordens são apresentadas dinamicamente, sem limite fixo de 30.</span></footer>
    </section>
    <div id="mensagemErro" class="error-message" role="alert" hidden></div>
</div>

<script>
(function () {
    "use strict";

    const SQL = `/* SQL_ORDEM_CARGA */
WITH
ordens_selecionadas AS (
 SELECT DISTINCT cab.ordemcarga
 FROM tgfcab cab
 JOIN tgfite ite ON ite.nunota = cab.nunota
 LEFT JOIN tgford ord ON ord.ordemcarga = cab.ordemcarga
 WHERE cab.tipmov = 'P' AND cab.pendente = 'S' AND ite.pendente = 'S'
   AND cab.ordemcarga IN :P_OC
   AND NVL(ord.ad_formconc, 'N') IN :SIT
   AND cab.ordemcarga IS NOT NULL
),
itens_base AS (
 SELECT cab.ordemcarga, ite.nunota, ite.codprod, ite.qtdneg, ite.qtdentregue,
        ite.qtdconferida, ite.ad_vlrliq, ite.ad_vlrunitfrete,
        ite.qtdneg - ite.qtdentregue - ite.qtdconferida qtd_pendente
 FROM ordens_selecionadas os
 JOIN tgfcab cab ON cab.ordemcarga = os.ordemcarga
 JOIN tgfite ite ON ite.nunota = cab.nunota
 WHERE cab.tipmov = 'P' AND cab.pendente = 'S' AND ite.pendente = 'S'
),
estoques AS (
 SELECT est.codprod,
        SUM(CASE WHEN est.codparc = 0 AND est.codlocal <> 2030000 THEN NVL(est.estoque,0) ELSE 0 END) estoque_disponivel,
        SUM(CASE WHEN est.codparc = 0 AND est.codlocal = 2030000 THEN NVL(est.estoque,0) ELSE 0 END) estoque_definido,
        SUM(CASE WHEN est.codlocal = 2010000 THEN NVL(est.estoque,0) ELSE 0 END) estoque_sa
 FROM tgfest est
 WHERE est.codparc = 0 OR est.codlocal IN (2010000,2030000)
 GROUP BY est.codprod
),
produtos_sa_base AS (
 SELECT pro.codprod, pro.ad_cod_prod_sa cod_sa_1,
        sa1.descrprod || sa1.compldesc descricao_sa_1,
        SUBSTR(sa1.codgrupoprod,1,3) grupo_sa_1,
        pro_sa.ad_cod_prod_sa cod_sa_2
 FROM tgfpro pro
 LEFT JOIN tgfpro pro_sa ON pro_sa.codprod = pro.ad_cod_prod_sa
 LEFT JOIN tgfpro sa1 ON sa1.codprod = pro.ad_cod_prod_sa
 WHERE SUBSTR(pro.codgrupoprod,1,1) = '4'
),
produtos_sa AS (
 SELECT codprod,
        CASE WHEN grupo_sa_1 = '301' THEN cod_sa_1 ELSE cod_sa_2 END codpro_sa,
        CASE WHEN grupo_sa_1 = '301' THEN cod_sa_1 ELSE cod_sa_1 END codpro_pint
 FROM produtos_sa_base
 WHERE CASE WHEN grupo_sa_1 = '301' THEN cod_sa_1 ELSE cod_sa_2 END IS NOT NULL
),
observacoes AS (
 SELECT x.ordemcarga, x.codprod, COUNT(*) qtdpedobs,
        LISTAGG(TO_CHAR(x.nunota), ', ') WITHIN GROUP (ORDER BY x.nunota) pedidos_observados
 FROM (
   SELECT DISTINCT ib.ordemcarga, ib.codprod, ib.nunota
   FROM itens_base ib
   JOIN tgfite itobs ON itobs.nunota = ib.nunota AND itobs.codprod = ib.codprod
   WHERE itobs.observacao IS NOT NULL
 ) x
 GROUP BY x.ordemcarga,x.codprod
),
produto_oc AS (
 SELECT ib.ordemcarga, ib.codprod,
        SUM(ib.qtd_pendente) qtd_pendente,
        SUM(ib.qtd_pendente * (ib.ad_vlrliq / NULLIF(ib.qtdneg,0))) valor_total,
        SUM(ib.qtd_pendente * ib.ad_vlrunitfrete) valor_frete,
        SUM(NVL(pro.m3,0) * ib.qtd_pendente) volume_m3
 FROM itens_base ib JOIN tgfpro pro ON pro.codprod = ib.codprod
 GROUP BY ib.ordemcarga,ib.codprod
),
produto_total AS (
 SELECT codprod,SUM(qtd_pendente) pendente,SUM(valor_total) vlttot,
        SUM(valor_frete) frete,SUM(volume_m3) volume_m3
 FROM produto_oc GROUP BY codprod
)
SELECT TO_CHAR(LPAD(gru.codgrupoprod,10,'0'),'FM00G00G00G000') codgrupoprod,
       gru.descrgrupoprod,pro.codprod,pro.descrprod,pro.marca,
       pt.pendente,NVL(est.estoque_disponivel,0) estoque,
       NVL(est.estoque_definido,0) estoque_def,
       NVL(est.estoque_disponivel,0)-NVL(pt.pendente,0) diferenca_estoque,
       CASE WHEN NVL(est.estoque_disponivel,0)-NVL(pt.pendente,0)>=0 THEN 'Sobrando' ELSE 'Faltando' END situacao,
       ps.codpro_sa,NVL(es_sa.estoque_sa,0) estsa,
       ps.codpro_pint,NVL(es_pi.estoque_sa,0) estpint,
       pt.vlttot,pt.frete,pt.volume_m3,NVL(pro.estmin,0) estmin,
       CASE WHEN NVL(est.estoque_disponivel,0)-NVL(pt.pendente,0)<=0 THEN 'RED'
            WHEN NVL(est.estoque_disponivel,0)-NVL(pt.pendente,0)<=NVL(pro.estmin,0) THEN 'YELLOW' ELSE 'BLUE' END farol,
       poc.ordemcarga,poc.qtd_pendente qtd_oc,poc.valor_total valor_oc,
       poc.valor_frete frete_oc,poc.volume_m3 volume_oc,
       NVL(obs.qtdpedobs,0) qtdpedobs_oc,obs.pedidos_observados
FROM produto_oc poc
JOIN produto_total pt ON pt.codprod=poc.codprod
JOIN tgfpro pro ON pro.codprod=poc.codprod
JOIN tgfgru gru ON gru.codgrupoprod=pro.codgrupoprod
LEFT JOIN estoques est ON est.codprod=pro.codprod
LEFT JOIN produtos_sa ps ON ps.codprod=pro.codprod
LEFT JOIN estoques es_sa ON es_sa.codprod=ps.codpro_sa
LEFT JOIN estoques es_pi ON es_pi.codprod=ps.codpro_pint
LEFT JOIN observacoes obs ON obs.ordemcarga=poc.ordemcarga AND obs.codprod=poc.codprod
ORDER BY pro.codprod,poc.ordemcarga`;

    const $ = id => document.getElementById(id);
    let linhas = [];
    let linhasFiltradas = [];
    const fmtNum = new Intl.NumberFormat("pt-BR", { maximumFractionDigits: 2 });
    const fmtMoeda = new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" });
    const num = v => v === null || v === undefined || v === "" ? 0 : Number(String(v).replace(",", "."));
    const esc = v => String(v ?? "").replace(/[&<>"']/g, c => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));
    const val = (o, ...keys) => { for (const k of keys) if (o[k] !== undefined) return o[k]; return null; };

    function setStatus(text, busy) {
        $("statusAtualizacao").textContent = text;
        $("statusAtualizacao").classList.toggle("busy", !!busy);
        $("btnAtualizar").disabled = !!busy;
    }

    function parametros() {
        const oc = "${P_OC}";
        const sit = "${SIT}";
        if (!oc || oc.trim() === "" || oc === "0") throw new Error("Selecione ao menos uma Ordem de Carga no parâmetro P_OC.");
        if (!sit || sit.trim() === "" || sit === "0") throw new Error("Selecione ao menos uma situação no parâmetro SIT.");
        return [
            { value: oc, type: "IN" },
            { value: sit, type: "IN" }
        ];
    }

    function consultar() {
        $("mensagemErro").hidden = true;
        setStatus("Consultando…", true);
        let params;
        try { params = parametros(); }
        catch (e) { setStatus("Parâmetros pendentes", false); mostrarErro(e.message); return; }

        executeQuery(SQL, params, function (retorno) {
            try {
                const dados = typeof retorno === "string" ? JSON.parse(retorno) : retorno;
                linhas = Array.isArray(dados) ? dados : [];
                normalizar();
                renderizar();
                $("ultimaAtualizacao").textContent = new Date().toLocaleString("pt-BR");
                $("totalOCs").textContent = new Set(linhas.map(x => String(val(x,"ORDEMCARGA","ordemcarga")))).size;
                $("situacoes").textContent = "${SIT}";
                setStatus(linhas.length ? "Dados atualizados" : "Sem resultados", false);
            } catch (e) { mostrarErro("Não foi possível interpretar o retorno da consulta: " + e.message); setStatus("Erro no retorno", false); }
        }, function (erro) {
            mostrarErro("Falha ao consultar as ordens de carga: " + erro);
            setStatus("Falha na consulta", false);
        });
    }

    function normalizar() {
        linhas = linhas.map(r => ({
            grupo: val(r,"CODGRUPOPROD"), descricaoGrupo: val(r,"DESCRGRUPOPROD"),
            codprod: val(r,"CODPROD"), descrprod: val(r,"DESCRPROD"),
            marca: val(r,"MARCA"), pendente: num(val(r,"PENDENTE")),
            estoque: num(val(r,"ESTOQUE")), estoqueDef: num(val(r,"ESTOQUE_DEF")),
            saldo: num(val(r,"DIFERENCA_ESTOQUE")), situacao: val(r,"SITUACAO"),
            codSa: val(r,"CODPRO_SA"), estSa: num(val(r,"ESTSA")),
            codPint: val(r,"CODPRO_PINT"), estPint: num(val(r,"ESTPINT")),
            valorTotal: num(val(r,"VLTTOT")), frete: num(val(r,"FRETE")),
            volume: num(val(r,"VOLUME_M3")), estmin: num(val(r,"ESTMIN")),
            farol: val(r,"FAROL"), oc: val(r,"ORDEMCARGA"),
            qtdOc: num(val(r,"QTD_OC")), valorOc: num(val(r,"VALOR_OC")),
            freteOc: num(val(r,"FRETE_OC")), volumeOc: num(val(r,"VOLUME_OC")),
            qtdObs: num(val(r,"QTDPEDOBS_OC")), pedidosObs: val(r,"PEDIDOS_OBSERVADOS")
        }));
    }

    function renderizar() {
        const termo = $("pesquisa").value.trim().toLocaleLowerCase("pt-BR");
        linhasFiltradas = linhas.filter(r => !termo || [r.codprod,r.descrprod,r.oc,r.marca].some(v => String(v ?? "").toLocaleLowerCase("pt-BR").includes(termo)));
        const produtos = new Map();
        const ordens = new Map();
        linhas.forEach(r => {
            if (!produtos.has(String(r.codprod))) produtos.set(String(r.codprod), r);
            const k = String(r.oc);
            const atual = ordens.get(k) || { oc:r.oc, qtd:0, frete:0, valor:0, volume:0 };
            atual.qtd += r.qtdOc; atual.frete += r.freteOc; atual.valor += r.valorOc; atual.volume += r.volumeOc;
            ordens.set(k, atual);
        });
        const ps = [...produtos.values()];
        $("kpiProdutos").textContent = fmtNum.format(ps.length);
        $("kpiPendente").textContent = fmtNum.format(ps.reduce((a,r)=>a+r.pendente,0));
        $("kpiValor").textContent = fmtMoeda.format(ps.reduce((a,r)=>a+r.valorTotal,0));
        $("kpiFrete").textContent = fmtMoeda.format(ps.reduce((a,r)=>a+r.frete,0));
        $("kpiVolume").textContent = fmtNum.format(ps.reduce((a,r)=>a+r.volume,0)) + " m³";
        $("kpiFalta").textContent = fmtNum.format(ps.filter(r=>r.saldo<0).length);
        $("resumoTabela").textContent = `${linhasFiltradas.length} linhas • ${produtos.size} produtos • ${ordens.size} ordens`;
        $("contadorLinhas").textContent = `${linhasFiltradas.length} linhas exibidas`;
        desenharGrafico([...ordens.values()]);
        desenharTabela(linhasFiltradas);
    }

    function desenharGrafico(dados) {
        const alvo = $("graficoOC");
        if (!dados.length) { alvo.innerHTML = '<div class="empty">Nenhuma ordem encontrada para os filtros informados.</div>'; return; }
        const max = Math.max(1, ...dados.map(d=>d.qtd));
        alvo.innerHTML = dados.map(d => {
            const pct = Math.max(2, d.qtd/max*100);
            return `<div class="bar-row"><div class="bar-label">OC ${esc(d.oc)}</div><div class="bar-track"><div class="bar-fill" style="width:${pct}%"></div></div><div class="bar-value">${fmtNum.format(d.qtd)} un.</div><div class="bar-extra">${fmtMoeda.format(d.frete)}</div></div>`;
        }).join("");
    }

    function desenharTabela(dados) {
        const body = $("corpoTabela");
        if (!dados.length) { body.innerHTML = '<tr><td colspan="10" class="empty">Nenhum registro encontrado.</td></tr>'; return; }
        body.innerHTML = dados.map(r => `<tr>
            <td class="code">${esc(r.codprod)}</td><td class="description">${esc(r.descrprod)}</td>
            <td class="code"> ${esc(r.oc)}</td><td class="numeric">${fmtNum.format(r.qtdOc)}</td>
            <td class="numeric">${fmtNum.format(r.estoque)}</td>
            <td class="numeric ${r.saldo<0?'negative':'positive'}">${fmtNum.format(r.saldo)}</td>
            <td class="numeric">${fmtMoeda.format(r.valorOc)}</td><td class="numeric">${fmtMoeda.format(r.freteOc)}</td>
            <td class="numeric">${fmtNum.format(r.volumeOc)}</td>
            <td class="observacao">${esc(r.pedidosObs || "—")}</td></tr>`).join("");
    }

    function mostrarErro(msg) { $("mensagemErro").textContent = msg; $("mensagemErro").hidden = false; }
    function exportarCSV() {
        const cab = ["Produto","Descrição","Ordem de carga","Quantidade pendente","Estoque","Saldo","Valor itens","Frete","Volume m3","Pedidos observados"];
        const linhasCsv = linhasFiltradas.map(r => [r.codprod,r.descrprod,r.oc,r.qtdOc,r.estoque,r.saldo,r.valorOc,r.freteOc,r.volumeOc,r.pedidosObs]);
        const csv = [cab,...linhasCsv].map(row => row.map(v => `"${String(v ?? "").replace(/"/g,'""')}"`).join(";")).join("\r\n");
        const blob = new Blob(["\uFEFF"+csv], {type:"text/csv;charset=utf-8"});
        const url = URL.createObjectURL(blob);
        const a = document.createElement("a"); a.href=url; a.download="dashboard_ordens_carga.csv";
        document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
    }

    $("btnAtualizar").addEventListener("click", consultar);
    $("pesquisa").addEventListener("input", renderizar);
    $("btnCSV").addEventListener("click", exportarCSV);
    document.addEventListener("DOMContentLoaded", consultar);
    // A página pode ser carregada depois do evento DOMContentLoaded pelo container Sankhya.
    if (document.readyState !== "loading") consultar();
})();
</script>
</body>
</html>
