<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peças Carregadas</title>
    <snk:load />

    <%--
      REGRA DE CONTAGEM VALIDADA:
      Cada registro retornado pela base de conferências representa uma peça.
      Mantidos os relacionamentos e o filtro de grupo utilizados no dashboard original.
    --%>
    <snk:query var="resumoDia">
        WITH base AS (
            SELECT g.ordemcarga
              FROM tgfconser e
              INNER JOIN tgfcon2 d ON d.nuconf = e.nuconf
              INNER JOIN tgfpro f ON f.codprod = e.codprod
              INNER JOIN tgfcab g ON g.nunota = d.nunotaorig
              INNER JOIN tgford h ON h.ordemcarga = g.ordemcarga
             WHERE e.dtalter >= TRUNC(SYSDATE)
               AND e.dtalter < TRUNC(SYSDATE) + 1
               AND SUBSTR(f.codgrupoprod, 1, 5) NOT IN ('40209')
        )
        SELECT COUNT(*) AS pecas_hoje,
               COUNT(DISTINCT ordemcarga) AS cargas_hoje,
               ROUND(COUNT(*) / NULLIF(COUNT(DISTINCT ordemcarga), 0), 1) AS media_carga,
               TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') AS atualizado_em
          FROM base
    </snk:query>

    <snk:query var="historico">
        WITH calendario AS
        (SELECT trunc(SYSDATE) - 6 + LEVEL - 1 AS dia FROM dual CONNECT BY LEVEL <= 7),
        base AS
        (SELECT e.dtalter,
                g.ordemcarga
            FROM tgfconser e
          INNER JOIN tgfcon2 d
              ON d.nuconf = e.nuconf
          INNER JOIN tgfpro f
              ON f.codprod = e.codprod
          INNER JOIN tgfcab g
              ON g.nunota = d.nunotaorig
          INNER JOIN tgford h
              ON h.ordemcarga = g.ordemcarga
          WHERE e.dtalter >= trunc(SYSDATE) - 6
            AND e.dtalter < trunc(SYSDATE) + 1
            AND substr(f.codgrupoprod, 1, 5) NOT IN ('40209')),
        diario AS
        (SELECT c.dia,
                COUNT(b.ordemcarga) AS pecas,
                COUNT(DISTINCT b.ordemcarga) AS cargas
            FROM calendario c
            LEFT JOIN base b
              ON b.dtalter >= c.dia
            AND b.dtalter < c.dia + 1
          GROUP BY c.dia)
        SELECT to_char(dia, 'DD/MM') AS dia,
              to_char(dia, 'DY', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS dia_semana,
              CASE
                  WHEN dia = trunc(SYSDATE) THEN
                  'S'
                  ELSE
                  'N'
              END AS eh_hoje,
              pecas,
              cargas,
              round(pecas / nullif(cargas, 0), 1) AS media_carga,
              CASE
                  WHEN MAX(pecas) over() = 0 THEN
                  0
                  ELSE
                  round(pecas * 100 / MAX(pecas) over(), 1)
              END AS percentual_barra,
              SUM(pecas) over () AS total_periodo
          FROM diario
        ORDER BY dia DESC
    </snk:query>
<style>
:root {
  --blue:#2563eb; --orange:#f59e0b; --green:#16a34a; --purple:#7c3aed;
  --bg:#f3f6fb; --surface:#fff; --text:#172033; --muted:#667085;
  --border:#e5eaf0; --track:#edf1f7;
}
*{box-sizing:border-box}
html,body{
  width:390px!important;height:448px!important;min-width:390px!important;
  min-height:448px!important;max-width:390px!important;max-height:448px!important;
  margin:0!important;padding:0!important;overflow:hidden!important;
}
body{font-family:"Segoe UI",Arial,sans-serif;background:var(--bg);color:var(--text);font-size:11px}
.dashboard{
  width:390px;height:448px;padding:9px;overflow:hidden;
  display:grid;grid-template-rows:34px 94px 112px 1fr 12px;gap:7px;
}
.topbar{display:flex;align-items:center;justify-content:space-between;gap:8px;min-width:0}
.title{min-width:0}
.title h1{margin:0;font-size:16px;line-height:18px;font-weight:750;letter-spacing:-.2px}
.title p{margin:2px 0 0;color:var(--muted);font-size:8px;line-height:10px;white-space:nowrap}
.updated{flex:0 0 auto;color:var(--muted);font-size:7px;text-align:right;white-space:nowrap}
.updated strong{display:block;color:var(--text);font-size:8px}
.kpis{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));grid-template-rows:repeat(2,minmax(0,1fr));gap:6px;min-height:0}
.kpi{
  position:relative;min-width:0;overflow:hidden;padding:6px 8px 5px 11px;
  background:var(--surface);border:1px solid var(--border);border-radius:8px;
  box-shadow:0 1px 3px rgba(16,24,40,.04)
}
.kpi:before{content:"";position:absolute;left:0;top:0;bottom:0;width:3px;background:var(--blue)}
.kpi.orange:before{background:var(--orange)}.kpi.green:before{background:var(--green)}.kpi.purple:before{background:var(--purple)}
.kpi-label{color:var(--muted);font-size:8px;line-height:10px;font-weight:650;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.kpi-value{margin-top:2px;font-size:20px;line-height:22px;font-weight:800;letter-spacing:-.4px;font-variant-numeric:tabular-nums;white-space:nowrap}
.kpi-note{margin-top:1px;color:var(--muted);font-size:7px;line-height:9px;white-space:nowrap}
.panel{min-width:0;min-height:0;overflow:hidden;background:var(--surface);border:1px solid var(--border);border-radius:8px;box-shadow:0 1px 3px rgba(16,24,40,.035)}
.panel-head{height:26px;padding:5px 8px;display:flex;align-items:center;justify-content:space-between;gap:6px;border-bottom:1px solid var(--border)}
.panel-title{font-size:9px;line-height:12px;font-weight:750;white-space:nowrap}
.panel-note{font-size:7px;line-height:10px;color:var(--muted);white-space:nowrap}
.chart{height:84px;display:flex;align-items:flex-end;justify-content:space-around;gap:5px;padding:4px 8px 5px}
.bar-item{height:74px;min-width:0;flex:1;display:flex;flex-direction:column;justify-content:flex-end;align-items:center;gap:2px}
.bar-value{font-size:7px;line-height:8px;font-weight:700;color:var(--text);white-space:nowrap;font-variant-numeric:tabular-nums}
.bar-track{height:47px;width:22px;display:flex;align-items:flex-end;overflow:hidden;background:var(--track);border-radius:4px 4px 2px 2px}
.bar-fill{width:100%;min-height:2px;background:linear-gradient(180deg,#83b9ff,var(--blue));border-radius:4px 4px 0 0}
.bar-item.today .bar-fill{background:linear-gradient(180deg,#ffd166,var(--orange))}
.bar-label{font-size:7px;line-height:8px;color:var(--muted);white-space:nowrap}
.table-panel{display:flex;flex-direction:column}
.table-wrap{flex:1;min-height:0;overflow:hidden}
table{width:100%;height:100%;border-collapse:collapse;table-layout:fixed}
thead tr{height:18px}
thead th{padding:2px 7px;background:#f8faff;color:#475467;font-size:7px;line-height:9px;font-weight:750;text-align:left;white-space:nowrap}
tbody tr{height:calc((100% - 18px)/7)}
tbody td{padding:1px 7px;border-top:1px solid #f0f2f6;color:var(--text);font-size:8px;line-height:10px;white-space:nowrap}
th.num,td.num{text-align:right;font-variant-numeric:tabular-nums}
td.day{font-weight:650}
tr.today-row td{background:#fff8e8}
tr.today-row td.day{color:#a16207}
.total{font-size:8px;line-height:10px;color:var(--blue);font-weight:750;white-space:nowrap}
.footnote{margin:0;color:var(--muted);font-size:7px;line-height:12px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
</style>
</head>
<body>
<div class="dashboard">
  <header class="topbar">
    <div class="title">
      <h1>Peças Carregadas</h1>
      <p>Resumo operacional · posição de hoje e últimos 7 dias</p>
    </div>
    <c:forEach items="${resumoDia.rows}" var="r">
      <div class="updated">Atualizado em<strong><c:out value="${r.ATUALIZADO_EM}" /></strong></div>
    </c:forEach>
  </header>

  <section class="kpis">
    <c:forEach items="${resumoDia.rows}" var="r">
      <article class="kpi">
        <div class="kpi-label">Peças carregadas hoje</div>
        <div class="kpi-value"><c:out value="${r.PECAS_HOJE}" /></div>
        <div class="kpi-note">Registros de conferência</div>
      </article>
      <article class="kpi orange">
        <div class="kpi-label">Cargas conferidas hoje</div>
        <div class="kpi-value"><c:out value="${r.CARGAS_HOJE}" /></div>
        <div class="kpi-note">Ordens distintas</div>
      </article>
      <article class="kpi green">
        <div class="kpi-label">Peças nos últimos 7 dias</div>
        <div class="kpi-value"><c:forEach items="${historico.rows}" var="h" begin="0" end="0"><c:out value="${h.TOTAL_PERIODO}" /></c:forEach></div>
        <div class="kpi-note">Acumulado do período</div>
      </article>
      <article class="kpi purple">
        <div class="kpi-label">Média por carga hoje</div>
        <div class="kpi-value"><c:choose><c:when test="${empty r.MEDIA_CARGA}">0</c:when><c:otherwise><c:out value="${r.MEDIA_CARGA}" /></c:otherwise></c:choose></div>
        <div class="kpi-note">Peças por ordem de carga</div>
      </article>
    </c:forEach>
  </section>

  <section class="panel">
    <div class="panel-head">
      <div class="panel-title">Evolução diária de peças</div>
      <div class="panel-note">Comparativo dos 7 dias</div>
    </div>
    <div class="chart">
      <c:forEach items="${historico.rows}" var="h">
        <div class="bar-item <c:if test='${h.EH_HOJE == "S"}'>today</c:if>">
          <div class="bar-value"><c:out value="${h.PECAS}" /></div>
          <div class="bar-track"><div class="bar-fill" style="height:<c:out value='${h.PERCENTUAL_BARRA}' />%;"></div></div>
          <div class="bar-label"><c:out value="${h.DIA_SEMANA}" /></div>
        </div>
      </c:forEach>
    </div>
  </section>

  <section class="panel table-panel">
    <div class="panel-head">
      <div class="panel-title">Resumo dos últimos 7 dias</div>
      <c:forEach items="${historico.rows}" var="h" begin="0" end="0">
        <div class="total">Total: <c:out value="${h.TOTAL_PERIODO}" /> peças</div>
      </c:forEach>
    </div>
    <div class="table-wrap">
      <table>
        <thead><tr><th style="width:40%">Dia</th><th class="num" style="width:20%">Peças</th><th class="num" style="width:18%">Cargas</th><th class="num" style="width:22%">Média</th></tr></thead>
        <tbody>
          <c:forEach items="${historico.rows}" var="h">
            <tr <c:if test='${h.EH_HOJE == "S"}'>class="today-row"</c:if>>
              <td class="day"><c:out value="${h.DIA_SEMANA}" /> · <c:out value="${h.DIA}" /></td>
              <td class="num"><c:out value="${h.PECAS}" /></td>
              <td class="num"><c:out value="${h.CARGAS}" /></td>
              <td class="num"><c:choose><c:when test="${empty h.MEDIA_CARGA}">—</c:when><c:otherwise><c:out value="${h.MEDIA_CARGA}" /></c:otherwise></c:choose></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </section>

  <p class="footnote">Cada registro de conferência = 1 peça · Cargas = ordens distintas conferidas hoje.</p>
</div>
</body>
</html>
