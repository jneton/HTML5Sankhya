<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,javax.naming.*,javax.sql.DataSource,java.math.BigDecimal,java.util.*" %>
<%!
/*
 * Dashboard RFM - Haiala Metalurgica / Sankhya
 *
 * INTEGRACAO A VALIDAR:
 * 1) Configure no servidor de aplicacao um JNDI DataSource com o nome:
 *      java:comp/env/jdbc/SankhyaDS
 *    e declare o resource-ref correspondente no contexto da aplicacao.
 * 2) Confirme que esta JSP fica protegida pela autenticacao/autorizacao do Sankhya.
 * 3) Se a instalacao usa outro mecanismo oficial para obter conexoes, substitua
 *    SOMENTE o metodo openConnection() pelo mecanismo homologado no ambiente.
 * 4) Chart.js e carregado por CDN. Para ambientes sem acesso externo, hospede uma
 *    versao aprovada localmente e altere o src do script no HTML.
 *
 * Nao ha dados de demonstracao. A API action=data executa a SQL real no Oracle.
 */

private Connection openConnection() throws Exception {
    Context init = new InitialContext();
    try {
        DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/SankhyaDS");
        return ds.getConnection();
    } finally {
        try { init.close(); } catch (Exception ignored) {}
    }
}

private String jsonEscape(String value) {
    if (value == null) return "null";
    StringBuilder out = new StringBuilder("\"");
    for (int i = 0; i < value.length(); i++) {
        char c = value.charAt(i);
        switch (c) {
            case '"': out.append("\\\""); break;
            case '\\': out.append("\\\\"); break;
            case '\b': out.append("\\b"); break;
            case '\f': out.append("\\f"); break;
            case '\n': out.append("\\n"); break;
            case '\r': out.append("\\r"); break;
            case '\t': out.append("\\t"); break;
            default:
                if (c < 0x20) out.append(String.format("\\u%04x", (int)c));
                else out.append(c);
        }
    }
    return out.append('"').toString();
}

private String jsonNumber(ResultSet rs, String column) throws SQLException {
    Object value = rs.getObject(column);
    if (value == null) return "null";
    if (value instanceof Number) return new BigDecimal(value.toString()).toPlainString();
    try { return new BigDecimal(value.toString().trim()).toPlainString(); }
    catch (Exception e) { return "null"; }
}

private String jsonText(ResultSet rs, String column) throws SQLException {
    String value = rs.getString(column);
    return value == null ? "null" : jsonEscape(value);
}
%>
<%
String action = request.getParameter("action");
if ("data".equalsIgnoreCase(action)) {
    response.setContentType("application/json; charset=UTF-8");
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("X-Content-Type-Options", "nosniff");

    /*
     * SQL de origem preservada. O intervalo de datas segue a consulta fornecida.
     * Atenção: a CTE de recência/frequência usa BETWEEN diretamente em DTNEG,
     * enquanto a monetária usa TRUNC(DTNEG). Validar a fronteira do último dia.
     */
    final String sql =
        "WITH " +
        "parametros_periodo AS ( " +
        " SELECT TRUNC(ADD_MONTHS(SYSDATE, -6), 'MM') AS dt_inicio, " +
        "        TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) AS dt_fim FROM dual ), " +
        "tops_validas AS ( " +
        " SELECT DISTINCT top.codtipoper, top.dhalter FROM tgftop top " +
        " WHERE top.tipmov = 'P' AND COALESCE(top.orcamento, 'N') = 'N' " +
        "   AND top.codtipoper > 0 AND top.atualfin = 1 ), " +
        "metricas_recencia_frequencia AS ( " +
        " SELECT cab.codparc, p.dt_fim - MAX(cab.dtneg) AS qtd_recencia, " +
        "        COUNT(DISTINCT cab.dtneg) AS qtd_frequencia " +
        " FROM tgfcab cab INNER JOIN parametros_periodo p " +
        "   ON cab.dtneg BETWEEN p.dt_inicio AND p.dt_fim " +
        " INNER JOIN tops_validas top ON top.codtipoper = cab.codtipoper " +
        "   AND top.dhalter = cab.dhtipoper " +
        " GROUP BY cab.codparc, p.dt_fim ), " +
        "metrica_monetaria AS ( " +
        " SELECT cab.codparc, SUM(ite.ad_vlrliq) AS valor_monetario " +
        " FROM tgfcab cab INNER JOIN tgfite ite ON ite.nunota = cab.nunota " +
        " INNER JOIN tops_validas top ON top.codtipoper = cab.codtipoper " +
        "   AND top.dhalter = cab.dhtipoper " +
        " INNER JOIN parametros_periodo p ON TRUNC(cab.dtneg) BETWEEN p.dt_inicio AND p.dt_fim " +
        " GROUP BY cab.codparc ), " +
        "metricas_clientes AS ( " +
        " SELECT par.codparc, COALESCE(rf.qtd_recencia, 0) AS qtd_recencia, " +
        "        COALESCE(rf.qtd_frequencia, 0) AS qtd_frequencia, " +
        "        COALESCE(mm.valor_monetario, 0) AS valor_monetario " +
        " FROM tgfpar par LEFT JOIN metricas_recencia_frequencia rf ON rf.codparc = par.codparc " +
        " LEFT JOIN metrica_monetaria mm ON mm.codparc = par.codparc " +
        " WHERE par.ativo = 'S' AND par.codparc > 1 AND par.cliente = 'S' ), " +
        "pontuacao_rfm AS ( " +
        " SELECT mc.codparc, mc.qtd_recencia, " +
        " CASE WHEN mc.qtd_recencia BETWEEN 0 AND 30 THEN 5 " +
        " WHEN mc.qtd_recencia BETWEEN 31 AND 60 THEN 4 " +
        " WHEN mc.qtd_recencia BETWEEN 61 AND 90 THEN 3 " +
        " WHEN mc.qtd_recencia BETWEEN 91 AND 120 THEN 2 " +
        " WHEN mc.qtd_recencia > 120 THEN 1 END AS nota_recencia, " +
        " mc.qtd_frequencia, " +
        " CASE WHEN mc.qtd_frequencia >= 5 THEN 5 WHEN mc.qtd_frequencia = 4 THEN 4 " +
        " WHEN mc.qtd_frequencia = 3 THEN 3 WHEN mc.qtd_frequencia = 2 THEN 2 " +
        " WHEN mc.qtd_frequencia <= 1 THEN 1 END AS nota_frequencia, " +
        " mc.valor_monetario, " +
        " CASE WHEN mc.valor_monetario >= 240000 THEN 5 " +
        " WHEN mc.valor_monetario BETWEEN 120000 AND 239999.999999 THEN 4 " +
        " WHEN mc.valor_monetario BETWEEN 60000 AND 119999.999999 THEN 3 " +
        " WHEN mc.valor_monetario BETWEEN 20000.01 AND 59999.999999 THEN 2 " +
        " WHEN mc.valor_monetario <= 20000 THEN 1 END AS nota_monetaria " +
        " FROM metricas_clientes mc ), " +
        "media_ponderada AS ( " +
        " SELECT rfm.codparc, rfm.qtd_recencia, rfm.nota_recencia, rfm.qtd_frequencia, " +
        " rfm.nota_frequencia, rfm.valor_monetario, rfm.nota_monetaria, " +
        " (rfm.nota_recencia * 0.1) + (rfm.nota_frequencia * 0.2) + " +
        " (rfm.nota_monetaria * 0.7) AS media FROM pontuacao_rfm rfm ), " +
        "classificacao_clientes AS ( " +
        " SELECT mp.codparc, mp.qtd_recencia, mp.nota_recencia, mp.qtd_frequencia, " +
        " mp.nota_frequencia, mp.valor_monetario, mp.nota_monetaria, mp.media, " +
        " CASE WHEN mp.media BETWEEN 4.01 AND 5 THEN 'ALTA' " +
        " WHEN mp.media BETWEEN 3.01 AND 4 THEN 'MÉDIA ALTA' " +
        " WHEN mp.media BETWEEN 2.01 AND 3 THEN 'MÉDIA' " +
        " WHEN mp.media BETWEEN 1.01 AND 2 THEN 'BAIXA' " +
        " WHEN mp.media BETWEEN 0.00 AND 1 THEN 'QUALIFICAR' END AS classificacao " +
        " FROM media_ponderada mp ) " +
        "SELECT grv.codvend AS codgrv, grv.apelido AS nomegrv, " +
        " rca.codvend AS codrca, rca.apelido AS nomerca, par.codparc, par.razaosocial, " +
        " cc.qtd_recencia, cc.nota_recencia, cc.qtd_frequencia, cc.nota_frequencia, " +
        " cc.valor_monetario AS vlrmonetario, cc.nota_monetaria, cc.media, " +
        " cc.classificacao AS classificacao " +
        "FROM tgfpar par INNER JOIN tgfven rca ON rca.codvend = par.codvend " +
        "INNER JOIN tgfven grv ON grv.codvend = rca.codger " +
        "INNER JOIN classificacao_clientes cc ON cc.codparc = par.codparc " +
        "WHERE par.ativo = 'S' AND par.codparc > 1 " +
        "ORDER BY grv.apelido, rca.apelido, par.razaosocial";

    try (Connection conn = openConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        StringBuilder jsonOut = new StringBuilder(65536);
        jsonOut.append("{\"success\":true,\"rows\":[");
        boolean first = true;
        while (rs.next()) {
            if (!first) jsonOut.append(',');
            first = false;
            jsonOut.append('{')
                .append("\"codgrv\":").append(jsonNumber(rs, "codgrv")).append(',')
                .append("\"nomegrv\":").append(jsonText(rs, "nomegrv")).append(',')
                .append("\"codrca\":").append(jsonNumber(rs, "codrca")).append(',')
                .append("\"nomerca\":").append(jsonText(rs, "nomerca")).append(',')
                .append("\"codparc\":").append(jsonNumber(rs, "codparc")).append(',')
                .append("\"razaosocial\":").append(jsonText(rs, "razaosocial")).append(',')
                .append("\"qtd_recencia\":").append(jsonNumber(rs, "qtd_recencia")).append(',')
                .append("\"nota_recencia\":").append(jsonNumber(rs, "nota_recencia")).append(',')
                .append("\"qtd_frequencia\":").append(jsonNumber(rs, "qtd_frequencia")).append(',')
                .append("\"nota_frequencia\":").append(jsonNumber(rs, "nota_frequencia")).append(',')
                .append("\"vlrmonetario\":").append(jsonNumber(rs, "vlrmonetario")).append(',')
                .append("\"nota_monetaria\":").append(jsonNumber(rs, "nota_monetaria")).append(',')
                .append("\"media\":").append(jsonNumber(rs, "media")).append(',')
                .append("\"classificacao\":").append(jsonText(rs, "classificacao"))
                .append('}');
        }
        jsonOut.append("]}");
        response.getWriter().write(jsonOut.toString());
    } catch (Exception e) {
        response.setStatus(500);
        String message = "Falha ao consultar os dados do dashboard. Verifique o log do servidor e a configuracao do DataSource.";
        response.getWriter().write("{\"success\":false,\"message\":" + jsonEscape(message) + "}");
        application.log("Dashboard RFM: erro ao consultar dados", e);
    }
    return;
}
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard RFM | Haiala</title>
<style>
:root{--rfm-navy:#172b4d;--rfm-blue:#2457a7;--rfm-bg:#f4f6fa;--rfm-card:#fff;--rfm-text:#243247;--rfm-muted:#66758a;--rfm-border:#dfe5ee;--rfm-shadow:0 2px 10px rgba(20,42,74,.06)}
*{box-sizing:border-box}
body{margin:0;background:var(--rfm-bg);color:var(--rfm-text);font:14px/1.45 Arial,Helvetica,sans-serif}
.rfm-app{max-width:1600px;margin:0 auto;padding:18px}
.rfm-header{background:var(--rfm-navy);color:#fff;border-radius:12px;padding:22px 24px;margin-bottom:16px}
.rfm-eyebrow{font-size:11px;letter-spacing:.12em;text-transform:uppercase;opacity:.8;margin:0 0 5px}
.rfm-header h1{font-size:clamp(22px,3vw,30px);margin:0;font-weight:700}
.rfm-header p{margin:7px 0 0;color:#d8e2f0}
.rfm-panel,.rfm-kpi,.rfm-chart-card,.rfm-table-card{background:var(--rfm-card);border:1px solid var(--rfm-border);border-radius:12px;box-shadow:var(--rfm-shadow)}
.rfm-filters{padding:16px;margin-bottom:16px;display:grid;grid-template-columns:repeat(2,minmax(180px,1fr)) auto;gap:12px;align-items:end}
.rfm-field label{display:block;font-weight:700;font-size:12px;margin-bottom:6px}
.rfm-field select,.rfm-search{width:100%;min-height:40px;border:1px solid #cbd5e1;border-radius:8px;background:#fff;color:var(--rfm-text);padding:8px 10px;font:inherit}
.rfm-actions{display:flex;gap:8px;flex-wrap:wrap}
.rfm-btn{border:0;border-radius:8px;min-height:40px;padding:9px 14px;cursor:pointer;font-weight:700;font:inherit}
.rfm-btn-primary{background:var(--rfm-blue);color:#fff}
.rfm-btn-secondary{background:#edf1f7;color:var(--rfm-text)}
.rfm-btn:focus-visible,.rfm-field select:focus-visible,.rfm-search:focus-visible{outline:3px solid #9dc2ff;outline-offset:2px}
.rfm-active{grid-column:1/-1;color:var(--rfm-muted);font-size:12px}
.rfm-kpis{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:12px;margin-bottom:16px}
.rfm-kpi{padding:16px;min-width:0}
.rfm-kpi-label{color:var(--rfm-muted);font-size:12px;font-weight:700}
.rfm-kpi-value{font-size:clamp(21px,2.5vw,29px);font-weight:700;margin-top:7px;overflow-wrap:anywhere}
.rfm-kpi-note{font-size:11px;color:var(--rfm-muted);margin-top:4px}
.rfm-charts{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px;margin-bottom:16px}
.rfm-chart-card{padding:16px;min-width:0}
.rfm-card-title{font-size:15px;margin:0 0 12px;font-weight:700}
.rfm-chart-wrap{height:280px;position:relative}
.rfm-table-card{overflow:hidden}
.rfm-table-head{padding:16px;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}
.rfm-table-tools{display:flex;gap:8px;align-items:center;flex-wrap:wrap}
.rfm-search{width:min(300px,70vw)}
.rfm-count{color:var(--rfm-muted);font-size:12px}
.rfm-table-scroll{overflow:auto;max-width:100%}
.rfm-table{border-collapse:collapse;width:100%;min-width:1150px;font-size:12px}
.rfm-table th,.rfm-table td{padding:10px 12px;border-top:1px solid var(--rfm-border);text-align:left;white-space:nowrap}
.rfm-table th{background:#f7f9fc;color:#4a5b72;position:sticky;top:0;z-index:1}
.rfm-table th button{border:0;background:none;color:inherit;font:inherit;font-weight:700;cursor:pointer;padding:0}
.rfm-table td.num,.rfm-table th.num{text-align:right;font-variant-numeric:tabular-nums}
.rfm-table tbody tr:hover{background:#f8fbff}
.rfm-pill{display:inline-block;border-radius:99px;padding:3px 8px;font-size:11px;font-weight:700;background:#edf1f7}
.rfm-pill-alta{background:#d9f5e5;color:#17643b}.rfm-pill-media-alta{background:#dceafe;color:#234e91}.rfm-pill-media{background:#fff0c2;color:#7c5900}.rfm-pill-baixa{background:#ffe4d5;color:#8c3d16}.rfm-pill-qualificar{background:#fce0e4;color:#8e2636}
.rfm-pagination{display:flex;justify-content:space-between;align-items:center;gap:10px;padding:12px 16px;border-top:1px solid var(--rfm-border);flex-wrap:wrap}
.rfm-pagination-controls{display:flex;gap:6px}
.rfm-status{padding:20px;text-align:center;color:var(--rfm-muted)}
.rfm-error{color:#9b1c1c;background:#fff0f0;border:1px solid #ffd0d0;border-radius:8px;padding:12px;margin-bottom:14px}
.rfm-hidden{display:none!important}
@media(max-width:900px){.rfm-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.rfm-charts{grid-template-columns:1fr}.rfm-filters{grid-template-columns:repeat(2,minmax(0,1fr))}.rfm-actions{grid-column:1/-1}}
@media(max-width:560px){.rfm-app{padding:10px}.rfm-header{padding:18px}.rfm-filters{grid-template-columns:1fr}.rfm-actions{grid-column:auto}.rfm-btn{flex:1}.rfm-kpi{padding:12px}.rfm-kpi-value{font-size:22px}.rfm-table-head{align-items:flex-start}.rfm-search{width:100%}.rfm-table-tools{width:100%}}
</style>
</head>
<body>
<div class="rfm-app" id="rfmApp">
  <header class="rfm-header">
    <p class="rfm-eyebrow">Haiala Metalúrgica · Sankhya ERP</p>
    <h1>Análise RFM de Clientes</h1>
    <p>Recência, frequência e valor monetário · Período calculado pela consulta SQL</p>
  </header>

  <div id="rfmError" class="rfm-error rfm-hidden" role="alert"></div>

  <section class="rfm-panel rfm-filters" aria-label="Filtros do dashboard">
    <div class="rfm-field"><label for="rfmGrupo">Grupo de vendas (NOMEGRV)</label><select id="rfmGrupo"><option value="">Carregando...</option></select></div>
    <div class="rfm-field"><label for="rfmRca">Representante (NOMERCA)</label><select id="rfmRca"><option value="">Carregando...</option></select></div>
    <div class="rfm-actions"><button type="button" class="rfm-btn rfm-btn-primary" id="rfmApply">Aplicar filtros</button><button type="button" class="rfm-btn rfm-btn-secondary" id="rfmClear">Limpar</button></div>
    <div class="rfm-active" id="rfmActive">Filtros: todos os grupos e representantes.</div>
  </section>

  <section class="rfm-kpis" aria-label="Indicadores">
    <article class="rfm-kpi"><div class="rfm-kpi-label">Clientes</div><div class="rfm-kpi-value" id="rfmKpiClientes">—</div><div class="rfm-kpi-note">Clientes distintos na consulta</div></article>
    <article class="rfm-kpi"><div class="rfm-kpi-label">Valor monetário</div><div class="rfm-kpi-value" id="rfmKpiValor">—</div><div class="rfm-kpi-note">Soma do valor monetário dos clientes filtrados</div></article>
    <article class="rfm-kpi"><div class="rfm-kpi-label">Média ponderada RFM</div><div class="rfm-kpi-value" id="rfmKpiMedia">—</div><div class="rfm-kpi-note">Média simples da coluna MEDIA</div></article>
    <article class="rfm-kpi"><div class="rfm-kpi-label">Clientes classificados como ALTA</div><div class="rfm-kpi-value" id="rfmKpiAlta">—</div><div class="rfm-kpi-note" id="rfmKpiAltaPct">—</div></article>
  </section>

  <section class="rfm-charts" aria-label="Gráficos RFM">
    <article class="rfm-chart-card"><h2 class="rfm-card-title">Clientes por classificação</h2><div class="rfm-chart-wrap"><canvas id="rfmClassChart" aria-label="Distribuição de clientes por classificação"></canvas></div></article>
    <article class="rfm-chart-card"><h2 class="rfm-card-title">Valor monetário por grupo</h2><div class="rfm-chart-wrap"><canvas id="rfmGrupoChart" aria-label="Valor monetário por grupo de vendas"></canvas></div></article>
    <article class="rfm-chart-card"><h2 class="rfm-card-title">Top 10 RCAs por valor monetário</h2><div class="rfm-chart-wrap"><canvas id="rfmRcaChart" aria-label="Ranking de representantes por valor monetário"></canvas></div></article>
    <article class="rfm-chart-card"><h2 class="rfm-card-title">Média RFM por classificação</h2><div class="rfm-chart-wrap"><canvas id="rfmMediaChart" aria-label="Média RFM por classificação"></canvas></div></article>
  </section>

  <section class="rfm-table-card">
    <div class="rfm-table-head">
      <div><h2 class="rfm-card-title" style="margin-bottom:4px">Detalhamento dos clientes</h2><div class="rfm-count" id="rfmTableCount">Aguardando consulta...</div></div>
      <div class="rfm-table-tools"><input id="rfmSearch" class="rfm-search" type="search" placeholder="Pesquisar cliente, código ou RCA..." aria-label="Pesquisar na tabela"><button id="rfmExport" class="rfm-btn rfm-btn-secondary" type="button">Exportar CSV</button></div>
    </div>
    <div class="rfm-table-scroll">
      <table class="rfm-table" id="rfmTable">
        <thead><tr>
          <th><button data-sort="codparc">Cód. cliente ↕</button></th><th><button data-sort="razaosocial">Razão social ↕</button></th>
          <th><button data-sort="nomegrv">Grupo ↕</button></th><th><button data-sort="nomerca">RCA ↕</button></th>
          <th class="num"><button data-sort="qtd_recencia">Recência (dias) ↕</button></th><th class="num"><button data-sort="qtd_frequencia">Frequência ↕</button></th>
          <th class="num"><button data-sort="vlrmonetario">Valor monetário ↕</button></th><th class="num"><button data-sort="media">Média RFM ↕</button></th><th>Classificação</th>
        </tr></thead>
        <tbody id="rfmTbody"><tr><td colspan="9" class="rfm-status">Carregando dados reais do Sankhya...</td></tr></tbody>
      </table>
    </div>
    <div class="rfm-pagination"><span class="rfm-count" id="rfmPageInfo">—</span><div class="rfm-pagination-controls"><button class="rfm-btn rfm-btn-secondary" id="rfmPrev" type="button">Anterior</button><button class="rfm-btn rfm-btn-secondary" id="rfmNext" type="button">Próxima</button></div></div>
  </section>
  <p class="rfm-count" style="padding:10px 2px">Fonte: consulta RFM Oracle. Os filtros são aplicados no navegador após uma única consulta ao servidor.</p>
</div>

<!-- Chart.js CDN: se o servidor bloquear acesso externo, hospede o arquivo aprovado localmente. -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
<script>
(function(){
  'use strict';
  var rows = [];
  var filteredRows = [];
  var page = 0;
  var pageSize = 25;
  var sortKey = 'vlrmonetario';
  var sortDirection = -1;
  var charts = {};
  var classifications = ['ALTA','MÉDIA ALTA','MÉDIA','BAIXA','QUALIFICAR'];
  var currency = new Intl.NumberFormat('pt-BR',{style:'currency',currency:'BRL',maximumFractionDigits:2});
  var integer = new Intl.NumberFormat('pt-BR',{maximumFractionDigits:0});
  var decimal = new Intl.NumberFormat('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
  var $ = function(id){return document.getElementById(id);};
  var safe = function(v){return v === null || v === undefined || v === '' ? '—' : String(v);};
  var number = function(v){var n = Number(v);return Number.isFinite(n) ? n : 0;};
  var money = function(v){return currency.format(number(v));};
  var esc = function(v){return String(v === null || v === undefined ? '' : v).replace(/[&<>"']/g,function(c){return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];});};
  var classSlug = function(v){return String(v||'').normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/\s+/g,'-');};

  function showError(message){$('rfmError').textContent=message;$('rfmError').classList.remove('rfm-hidden');}
  function hideError(){$('rfmError').classList.add('rfm-hidden');}
  function uniqueOptions(select, items, key){
    var prior = select.value;
    var values = {};
    items.forEach(function(r){var v = (r[key] || '').trim(); if(v) values[v]=true;});
    var list = Object.keys(values).sort(function(a,b){return a.localeCompare(b,'pt-BR',{sensitivity:'base'});});
    select.innerHTML = '<option value="">Todos</option>';
    list.forEach(function(v){var o=document.createElement('option');o.value=v;o.textContent=v;select.appendChild(o);});
    if(list.indexOf(prior)>=0) select.value=prior;
  }
  function refreshRcaOptions(){
    var group=$('rfmGrupo').value;
    var base=group ? rows.filter(function(r){return (r.nomegrv||'')===group;}) : rows;
    uniqueOptions($('rfmRca'),base,'nomerca');
  }
  function applyFilters(){
    var group=$('rfmGrupo').value, rca=$('rfmRca').value;
    filteredRows=rows.filter(function(r){
      return (!group || r.nomegrv===group) && (!rca || r.nomerca===rca);
    });
    page=0;
    $('rfmActive').textContent='Filtros ativos: Grupo = '+(group||'Todos')+' · RCA = '+(rca||'Todos');
    renderAll();
  }
  function aggregate(data,key){
    var out={};
    data.forEach(function(r){var k=r[key]||'Não informado';if(!out[k])out[k]={label:k,count:0,value:0,media:0};out[k].count++;out[k].value+=number(r.vlrmonetario);out[k].media+=number(r.media);});
    return out;
  }
  function makeChart(id, config){
    if(typeof Chart==='undefined') return;
    if(charts[id]) charts[id].destroy();
    charts[id]=new Chart($(id),config);
  }
  function renderCharts(data){
    if(typeof Chart==='undefined'){
      document.querySelectorAll('.rfm-chart-wrap').forEach(function(el){el.innerHTML='<div class="rfm-status">Chart.js não carregado. Verifique a política de rede ou hospede a biblioteca localmente.</div>';});
      return;
    }
    var counts=classifications.map(function(c){return data.filter(function(r){return r.classificacao===c;}).length;});
    makeChart('rfmClassChart',{type:'doughnut',data:{labels:classifications,datasets:[{data:counts}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{position:'bottom'}}}});
    var groups=aggregate(data,'nomegrv');
    var groupEntries=Object.keys(groups).map(function(k){return groups[k];}).sort(function(a,b){return b.value-a.value;}).slice(0,12);
    makeChart('rfmGrupoChart',{type:'bar',data:{labels:groupEntries.map(function(x){return x.label;}),datasets:[{label:'Valor monetário',data:groupEntries.map(function(x){return x.value;})}]},options:{indexAxis:'y',responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(ctx){return money(ctx.raw);}}}},scales:{x:{ticks:{callback:function(v){return new Intl.NumberFormat('pt-BR',{notation:'compact',maximumFractionDigits:1}).format(v);}}}}}});
    var rcas=aggregate(data,'nomerca');
    var rcaEntries=Object.keys(rcas).map(function(k){return rcas[k];}).sort(function(a,b){return b.value-a.value;}).slice(0,10).reverse();
    makeChart('rfmRcaChart',{type:'bar',data:{labels:rcaEntries.map(function(x){return x.label;}),datasets:[{label:'Valor monetário',data:rcaEntries.map(function(x){return x.value;})}]},options:{indexAxis:'y',responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false},tooltip:{callbacks:{label:function(ctx){return money(ctx.raw);}}}}}});
    var mediaByClass=classifications.map(function(c){var a=data.filter(function(r){return r.classificacao===c;});return a.length ? a.reduce(function(s,r){return s+number(r.media);},0)/a.length : 0;});
    makeChart('rfmMediaChart',{type:'bar',data:{labels:classifications,datasets:[{label:'Média RFM',data:mediaByClass}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true,max:5}}}});
  }
  function renderKpis(data){
    var total=data.length, totalValue=data.reduce(function(s,r){return s+number(r.vlrmonetario);},0);
    var avg=total ? data.reduce(function(s,r){return s+number(r.media);},0)/total : 0;
    var high=data.filter(function(r){return r.classificacao==='ALTA';}).length;
    $('rfmKpiClientes').textContent=integer.format(total);
    $('rfmKpiValor').textContent=money(totalValue);
    $('rfmKpiMedia').textContent=total ? decimal.format(avg)+'/5' : '—';
    $('rfmKpiAlta').textContent=integer.format(high);
    $('rfmKpiAltaPct').textContent=total ? decimal.format(high*100/total)+'% dos clientes filtrados' : 'Sem clientes no filtro';
  }
  function sortData(data){
    return data.slice().sort(function(a,b){
      var av=a[sortKey], bv=b[sortKey];
      if(typeof av==='number'||typeof bv==='number') return (number(av)-number(bv))*sortDirection;
      return String(av||'').localeCompare(String(bv||''),'pt-BR',{numeric:true,sensitivity:'base'})*sortDirection;
    });
  }
  function renderTable(){
    var search=$('rfmSearch').value.trim().toLocaleLowerCase('pt-BR');
    var data=filteredRows.filter(function(r){
      if(!search)return true;
      return [r.codparc,r.razaosocial,r.nomegrv,r.nomerca,r.classificacao].some(function(v){return String(v||'').toLocaleLowerCase('pt-BR').indexOf(search)>=0;});
    });
    data=sortData(data);
    var pages=Math.max(1,Math.ceil(data.length/pageSize));
    if(page>=pages)page=pages-1;
    var start=page*pageSize, part=data.slice(start,start+pageSize);
    var html='';
    if(!part.length) html='<tr><td colspan="9" class="rfm-status">Nenhum cliente corresponde aos filtros/pesquisa.</td></tr>';
    part.forEach(function(r){
      html+='<tr>'+
        '<td>'+esc(safe(r.codparc))+'</td><td>'+esc(safe(r.razaosocial))+'</td>'+
        '<td>'+esc(safe(r.nomegrv))+'</td><td>'+esc(safe(r.nomerca))+'</td>'+
        '<td class="num">'+esc(safe(r.qtd_recencia))+'</td><td class="num">'+esc(safe(r.qtd_frequencia))+'</td>'+
        '<td class="num">'+esc(money(r.vlrmonetario))+'</td><td class="num">'+esc(decimal.format(number(r.media)))+'</td>'+
        '<td><span class="rfm-pill rfm-pill-'+esc(classSlug(r.classificacao))+'">'+esc(safe(r.classificacao))+'</span></td></tr>';
    });
    $('rfmTbody').innerHTML=html;
    $('rfmTableCount').textContent=integer.format(data.length)+' cliente(s) na pesquisa atual';
    $('rfmPageInfo').textContent=data.length ? 'Exibindo '+(start+1)+'–'+Math.min(start+pageSize,data.length)+' de '+integer.format(data.length) : '0 registros';
    $('rfmPrev').disabled=page<=0;
    $('rfmNext').disabled=page>=pages-1;
    $('rfmPrev').style.opacity=$('rfmPrev').disabled?'.5':'1';
    $('rfmNext').style.opacity=$('rfmNext').disabled?'.5':'1';
  }
  function renderAll(){renderKpis(filteredRows);renderCharts(filteredRows);renderTable();}
  function exportCsv(){
    var headers=['CODPARC','RAZAOSOCIAL','CODGRV','NOMEGRV','CODRCA','NOMERCA','QTD_RECENCIA','NOTA_RECENCIA','QTD_FREQUENCIA','NOTA_FREQUENCIA','VLRMONETARIO','NOTA_MONETARIA','MEDIA','CLASSIFICACAO'];
    var data=sortData(filteredRows);
    function cell(v){var s=String(v===null||v===undefined?'':v);return '"'+s.replace(/"/g,'""')+'"';}
    var lines=[headers.map(cell).join(';')];
    data.forEach(function(r){lines.push([r.codparc,r.razaosocial,r.codgrv,r.nomegrv,r.codrca,r.nomerca,r.qtd_recencia,r.nota_recencia,r.qtd_frequencia,r.nota_frequencia,r.vlrmonetario,r.nota_monetaria,r.media,r.classificacao].map(cell).join(';'));});
    var blob=new Blob(['\ufeff'+lines.join('\r\n')],{type:'text/csv;charset=utf-8;'});
    var url=URL.createObjectURL(blob), a=document.createElement('a');a.href=url;a.download='dashboard_rfm_haiala.csv';document.body.appendChild(a);a.click();a.remove();URL.revokeObjectURL(url);
  }
  function loadData(){
    hideError();$('rfmTbody').innerHTML='<tr><td colspan="9" class="rfm-status">Consultando dados reais do Sankhya...</td></tr>';
    fetch(window.location.pathname+'?action=data',{method:'GET',credentials:'same-origin',headers:{'Accept':'application/json'}})
      .then(function(resp){if(!resp.ok)throw new Error('O servidor retornou HTTP '+resp.status+'. Verifique o log da aplicação.');return resp.json();})
      .then(function(payload){
        if(!payload.success)throw new Error(payload.message||'Falha ao consultar dados.');
        rows=Array.isArray(payload.rows)?payload.rows:[];
        rows=rows.map(function(r){
          ['codgrv','codrca','codparc','qtd_recencia','nota_recencia','qtd_frequencia','nota_frequencia','vlrmonetario','nota_monetaria','media'].forEach(function(k){r[k]=r[k]===null?null:Number(r[k]);});
          return r;
        });
        uniqueOptions($('rfmGrupo'),rows,'nomegrv');refreshRcaOptions();applyFilters();
        if(!rows.length)$('rfmTbody').innerHTML='<tr><td colspan="9" class="rfm-status">A consulta não retornou clientes para os critérios atuais.</td></tr>';
      })
      .catch(function(err){showError('Não foi possível carregar o dashboard. '+err.message+' Confirme o DataSource JNDI, a sessão autenticada e a permissão de execução da JSP.');$('rfmTbody').innerHTML='<tr><td colspan="9" class="rfm-status">Dados indisponíveis. Corrija a integração e atualize a página.</td></tr>';});
  }
  $('rfmGrupo').addEventListener('change',function(){refreshRcaOptions();applyFilters();});
  $('rfmRca').addEventListener('change',applyFilters);
  $('rfmApply').addEventListener('click',applyFilters);
  $('rfmClear').addEventListener('click',function(){$('rfmGrupo').value='';refreshRcaOptions();$('rfmRca').value='';$('rfmSearch').value='';applyFilters();});
  $('rfmSearch').addEventListener('input',function(){page=0;renderTable();});
  $('rfmPrev').addEventListener('click',function(){if(page>0){page--;renderTable();}});
  $('rfmNext').addEventListener('click',function(){page++;renderTable();});
  $('rfmExport').addEventListener('click',exportCsv);
  document.querySelectorAll('[data-sort]').forEach(function(btn){btn.addEventListener('click',function(){var key=btn.getAttribute('data-sort');if(sortKey===key)sortDirection*=-1;else{sortKey=key;sortDirection=1;}page=0;renderTable();});});
  loadData();
})();
</script>
</body>
</html>
