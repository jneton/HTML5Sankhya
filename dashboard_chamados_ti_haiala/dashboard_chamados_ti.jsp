<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Gestão de Chamados - TI</title>
<snk:load/>
<style>
:root{--bg:#f4f6fa;--card:#fff;--ink:#182230;--muted:#667085;--line:#e5e9f0;--blue:#2864dc;--cyan:#0e9bb5;--green:#15966b;--orange:#e58b28;--red:#d84b4b;--purple:#805ad5}
*{box-sizing:border-box}
body{margin:0;padding:18px;background:var(--bg);color:var(--ink);font-family:Arial,Helvetica,sans-serif}
.header{display:flex;justify-content:space-between;align-items:center;gap:12px;margin-bottom:18px;flex-wrap:wrap}
.header h1{font-size:23px;margin:0 0 5px}.header p{margin:0;color:var(--muted);font-size:12px}
.tag{background:#e9efff;color:#2456b8;padding:7px 11px;border-radius:20px;font-size:11px;font-weight:bold}
.filters{display:grid;grid-template-columns:repeat(4,minmax(140px,1fr));gap:10px;background:var(--card);border:1px solid var(--line);border-radius:12px;padding:13px;margin-bottom:14px}
.filter label{display:block;font-size:11px;color:var(--muted);margin-bottom:5px;font-weight:bold}
.filter input,.filter select{width:100%;height:35px;border:1px solid #d8dee8;border-radius:7px;padding:0 9px;background:#fff;color:var(--ink);font-size:12px}
.actions{display:flex;align-items:end;gap:7px}.actions button{height:35px;border:0;border-radius:7px;padding:0 13px;cursor:pointer;font-weight:bold;font-size:12px}.apply{background:var(--blue);color:#fff}.clear{background:#edf0f5;color:#344054}
.kpis{display:grid;grid-template-columns:repeat(5,minmax(140px,1fr));gap:11px;margin-bottom:14px}
.kpi,.panel{background:var(--card);border:1px solid var(--line);border-radius:12px}
.kpi{padding:14px;min-height:96px}.kpi-label{font-size:10px;color:var(--muted);font-weight:bold;text-transform:uppercase;letter-spacing:.4px}.kpi-value{font-size:27px;font-weight:700;margin:8px 0 3px}.kpi-note{font-size:10px;color:var(--muted)}
.kpi.blue .kpi-value{color:var(--blue)}.kpi.orange .kpi-value{color:var(--orange)}.kpi.green .kpi-value{color:var(--green)}.kpi.purple .kpi-value{color:var(--purple)}
.charts{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px;margin-bottom:14px}
.panel{padding:14px;min-width:0}.panel h3{font-size:13px;margin:0 0 4px}.sub{font-size:10px;color:var(--muted);margin-bottom:13px}
.chart-area{min-height:190px;display:flex;align-items:stretch;gap:12px}
.bar-chart{display:flex;align-items:end;gap:9px;width:100%;height:175px;padding:10px 2px 23px;border-bottom:1px solid var(--line);overflow-x:auto}
.bar-col{min-width:28px;flex:1;display:flex;flex-direction:column;align-items:center;justify-content:end;height:100%;position:relative}
.bar-value{font-size:10px;color:var(--muted);margin-bottom:4px}.bar{width:min(34px,75%);min-height:2px;border-radius:5px 5px 0 0;background:var(--blue)}.bar-label{position:absolute;bottom:-20px;font-size:9px;color:var(--muted);white-space:nowrap}
.donut-wrap{display:flex;align-items:center;justify-content:center;gap:18px;min-height:175px;flex-wrap:wrap}
.donut{width:142px;height:142px;border-radius:50%;position:relative;flex:none}.donut:after{content:"";position:absolute;inset:34px;background:#fff;border-radius:50%}.donut-center{position:absolute;z-index:1;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;font-size:20px;font-weight:bold}.donut-center small{font-size:9px;color:var(--muted);font-weight:normal}
.legend{display:flex;flex-direction:column;gap:8px;font-size:11px;min-width:115px}.legend-item{display:flex;align-items:center;gap:7px}.dot{width:9px;height:9px;border-radius:3px;display:inline-block;flex:none}
.hbar-list{display:flex;flex-direction:column;gap:11px;width:100%;padding:6px 0}.hbar-head{display:flex;justify-content:space-between;font-size:10px;margin-bottom:4px;gap:8px}.hbar-track{height:9px;background:#edf0f5;border-radius:10px;overflow:hidden}.hbar-fill{height:100%;border-radius:10px;background:var(--cyan)}
.table-panel{padding:0;overflow:hidden}.table-head{padding:14px 14px 10px;display:flex;justify-content:space-between;gap:10px;align-items:center;flex-wrap:wrap}.table-head h3{margin:0;font-size:13px}.table-head span{font-size:10px;color:var(--muted)}
.table-wrap{overflow:auto;max-height:440px}table{width:100%;border-collapse:collapse;font-size:11px;white-space:nowrap}thead{position:sticky;top:0;background:#f7f9fc;z-index:1}th,td{text-align:left;padding:9px 10px;border-top:1px solid var(--line)}th{font-size:10px;color:#475467;text-transform:uppercase}tbody tr:hover{background:#f8faff}.status{display:inline-block;padding:4px 7px;border-radius:20px;font-size:9px;font-weight:bold;background:#fff1dc;color:#9a5a0a}.status.closed{background:#e5f6ee;color:#08784e}
.empty{padding:28px;text-align:center;color:var(--muted);font-size:12px}.foot{font-size:10px;color:var(--muted);margin:12px 2px 0;line-height:1.5}
@media(max-width:900px){.kpis{grid-template-columns:repeat(3,minmax(120px,1fr))}.filters{grid-template-columns:repeat(2,minmax(130px,1fr))}}
@media(max-width:620px){body{padding:10px}.charts{grid-template-columns:1fr}.kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.filters{grid-template-columns:1fr 1fr}.header h1{font-size:19px}}
</style>
</head>
<body>
<snk:query var="chamados">
WITH
parametros AS (
    SELECT 7.5 AS hora_inicio,
           11.5 AS hora_intervalo_inicio,
           13 AS hora_intervalo_fim,
           17.8 AS hora_fim,
           528 AS minutos_dia
      FROM dual
),
chamados AS (
    SELECT cha.nucha,
           cha.codusu,
           cha.dtabertura,
           cha.dtfecha,
           cha.status,
           cha.statendimento,
           cha.setor,
           cha.titulo,
           cha.tpchamado,
           COALESCE(cha.status, 'A') AS status_calculado,
           COALESCE(cha.statendimento, 'EM ABERTO') AS statendimento_calculado,
           COALESCE(cha.dtfecha, SYSDATE) AS data_fim,
           CASE
             WHEN cha.dtabertura IS NOT NULL
              AND COALESCE(cha.dtfecha, SYSDATE) >= cha.dtabertura THEN 1
             ELSE 0
           END AS indicador_calculo
      FROM ad_tgfcha cha
),
calendario AS (
    SELECT c.nucha,
           c.dtabertura,
           c.data_fim,
           TRUNC(c.dtabertura) + LEVEL - 1 AS data_dia
      FROM chamados c
     WHERE c.indicador_calculo = 1
    CONNECT BY LEVEL <= TRUNC(c.data_fim) - TRUNC(c.dtabertura) + 1
           AND PRIOR c.nucha = c.nucha
           AND PRIOR SYS_GUID() IS NOT NULL
),
dias_uteis AS (
    SELECT cal.nucha, cal.dtabertura, cal.data_fim, cal.data_dia
      FROM calendario cal
     WHERE cal.data_dia - TRUNC(cal.data_dia, 'IW') < 5
),
intervalos AS (
    SELECT du.nucha,
           GREATEST(du.data_dia + (p.hora_inicio / 24), du.dtabertura) AS inicio_manha,
           LEAST(du.data_dia + (p.hora_intervalo_inicio / 24), du.data_fim) AS fim_manha,
           GREATEST(du.data_dia + (p.hora_intervalo_fim / 24), du.dtabertura) AS inicio_tarde,
           LEAST(du.data_dia + (p.hora_fim / 24), du.data_fim) AS fim_tarde
      FROM dias_uteis du
      CROSS JOIN parametros p
),
tempo_trabalhado AS (
    SELECT i.nucha,
           SUM(GREATEST((i.fim_manha - i.inicio_manha) * 1440, 0)
             + GREATEST((i.fim_tarde - i.inicio_tarde) * 1440, 0)) AS total_minutos
      FROM intervalos i
     GROUP BY i.nucha
),
resultado_tempo AS (
    SELECT c.nucha,
           COALESCE(tt.total_minutos, 0) AS tempo_minutos,
           COALESCE(tt.total_minutos, 0) / 60 AS tempo_horas,
           COALESCE(tt.total_minutos, 0) / p.minutos_dia AS tempo_dias
      FROM chamados c
      CROSS JOIN parametros p
      LEFT JOIN tempo_trabalhado tt ON tt.nucha = c.nucha
)
SELECT cha.nucha,
       cha.codusu,
       usu.nomeusu AS usuario,
       TO_CHAR(cha.dtabertura, 'MM/YYYY') AS mesext,
       TO_CHAR(cha.dtabertura, 'YYYY-MM-DD') AS dtabertura_iso,
       TO_CHAR(cha.dtabertura, 'DD/MM/YYYY HH24:MI') AS dtabertura,
       TO_CHAR(cha.dtfecha, 'DD/MM/YYYY HH24:MI') AS dtfecha,
       cha.status_calculado AS status,
       cha.statendimento_calculado AS statendimento,
       CASE WHEN cha.indicador_calculo = 1 THEN rt.tempo_horas END AS tempo_horas,
       CASE WHEN cha.indicador_calculo = 1 THEN rt.tempo_dias END AS tempo_dias,
       CASE
         WHEN cha.dtabertura IS NULL THEN 'DATA DE ABERTURA INDEFINIDA'
         WHEN cha.indicador_calculo = 0 THEN 'DATA DE ENCERRAMENTO INVALIDA'
         WHEN rt.tempo_minutos < 528 THEN TO_CHAR(ROUND(rt.tempo_horas, 2), 'FM999G999G990D00') || ' horas'
         ELSE TO_CHAR(ROUND(rt.tempo_dias, 2), 'FM999G999G990D00') || ' dias'
       END AS tempo_formatado,
       UPPER(OPTION_LABEL('AD_TGFCHA', 'SETOR', cha.setor)) AS descsetor,
       UPPER(cha.titulo) AS titulo,
       cha.tpchamado,
       UPPER(OPTION_LABEL('AD_TGFCHA', 'TPCHAMADO', cha.tpchamado)) AS tipochamado
  FROM chamados cha
  LEFT JOIN tsiusu usu ON usu.codusu = cha.codusu
  LEFT JOIN resultado_tempo rt ON rt.nucha = cha.nucha
 ORDER BY cha.nucha DESC
</snk:query>

<div class="header">
  <div><h1>Gestão de Chamados | Tecnologia da Informação</h1><p>Visão gerencial de demanda, situação e tempo efetivo de atendimento</p></div>
  <span class="tag">HAIALA · TI</span>
</div>

<div class="filters">
  <div class="filter"><label for="fInicio">Abertura a partir de</label><input type="date" id="fInicio"></div>
  <div class="filter"><label for="fFim">Abertura até</label><input type="date" id="fFim"></div>
  <div class="filter"><label for="fStatus">Situação</label><select id="fStatus"><option value="">Todas</option></select></div>
  <div class="filter"><label for="fSetor">Setor</label><select id="fSetor"><option value="">Todos</option></select></div>
  <div class="filter"><label for="fTipo">Tipo de chamado</label><select id="fTipo"><option value="">Todos</option></select></div>
  <div class="filter actions"><button class="apply" id="btnAplicar" type="button">Aplicar filtros</button><button class="clear" id="btnLimpar" type="button">Limpar</button></div>
</div>

<div class="kpis">
  <div class="kpi blue"><div class="kpi-label">Total de chamados</div><div class="kpi-value" id="kTotal">0</div><div class="kpi-note">Registros no filtro atual</div></div>
  <div class="kpi orange"><div class="kpi-label">Em aberto</div><div class="kpi-value" id="kAbertos">0</div><div class="kpi-note">Sem data de encerramento</div></div>
  <div class="kpi green"><div class="kpi-label">Encerrados</div><div class="kpi-value" id="kFechados">0</div><div class="kpi-note">Com data de encerramento</div></div>
  <div class="kpi purple"><div class="kpi-label">Tempo médio</div><div class="kpi-value" id="kMedia">—</div><div class="kpi-note">Chamados encerrados · horas úteis</div></div>
  <div class="kpi"><div class="kpi-label">Tempo médio em aberto</div><div class="kpi-value" id="kMediaAberto">—</div><div class="kpi-note">Tempo útil decorrido · horas</div></div>
</div>

<div class="charts">
  <section class="panel"><h3>Chamados por mês</h3><div class="sub">Volume de chamados pela data de abertura</div><div id="chartMes" class="chart-area"></div></section>
  <section class="panel"><h3>Situação dos chamados</h3><div class="sub">Distribuição entre chamados abertos e encerrados</div><div id="chartStatus" class="chart-area"></div></section>
  <section class="panel"><h3>Chamados por setor</h3><div class="sub">Setores com maior volume de solicitações</div><div id="chartSetor" class="chart-area"></div></section>
  <section class="panel"><h3>Chamados por tipo</h3><div class="sub">Distribuição por classificação</div><div id="chartTipo" class="chart-area"></div></section>
  <section class="panel"><h3>Tempo médio por situação</h3><div class="sub">Média em horas úteis; encerrados e em aberto separados</div><div id="chartTempo" class="chart-area"></div></section>
  <section class="panel"><h3>Chamados em aberto por tempo</h3><div class="sub">Faixas de tempo útil decorrido (dias úteis de 8h48)</div><div id="chartAging" class="chart-area"></div></section>
</div>

<section class="panel table-panel">
  <div class="table-head"><h3>Detalhamento dos chamados</h3><span id="tableCount">0 registros</span></div>
  <div class="table-wrap">
    <table>
      <thead><tr><th>Nº</th><th>Usuário</th><th>Abertura</th><th>Encerramento</th><th>Setor</th><th>Tipo</th><th>Situação</th><th>Tempo útil</th><th>Título</th></tr></thead>
      <tbody id="tbodyChamados">
      <c:forEach items="${chamados.rows}" var="row">
        <tr class="ticket"
            data-numero="<c:out value='${row.NUCHA}'/>"
            data-usuario="<c:out value='${row.USUARIO}'/>"
            data-abertura="<c:out value='${row.DTABERTURA_ISO}'/>"
            data-abertura-texto="<c:out value='${row.DTABERTURA}'/>"
            data-fecha="<c:out value='${row.DTFECHA}'/>"
            data-status="<c:out value='${row.STATENDIMENTO}'/>"
            data-setor="<c:out value='${row.DESCSETOR}'/>"
            data-tipo="<c:out value='${row.TIPOCHAMADO}'/>"
            data-horas="<c:out value='${row.TEMPO_HORAS}'/>"
            data-tempo="<c:out value='${row.TEMPO_FORMATADO}'/>"
            data-titulo="<c:out value='${row.TITULO}'/>">
          <td><c:out value="${row.NUCHA}"/></td>
          <td><c:out value="${row.USUARIO}"/></td>
          <td><c:out value="${row.DTABERTURA}"/></td>
          <td><c:out value="${row.DTFECHA}"/></td>
          <td><c:out value="${row.DESCSETOR}"/></td>
          <td><c:out value="${row.TIPOCHAMADO}"/></td>
          <td><c:out value="${row.STATENDIMENTO}"/></td>
          <td><c:out value="${row.TEMPO_FORMATADO}"/></td>
          <td><c:out value="${row.TITULO}"/></td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
  <div id="emptyState" class="empty" style="display:none">Nenhum chamado encontrado para os filtros selecionados.</div>
</section>

<div class="foot">Cálculo do tempo: segunda a sexta-feira, 07:30–11:30 e 13:00–17:48. Intervalo de almoço e finais de semana não são contabilizados. Feriados não são descontados. O tempo médio de encerrados considera somente chamados com data de fechamento; chamados abertos são apresentados separadamente.</div>

<script>
(function(){
  "use strict";
  var rows = Array.prototype.slice.call(document.querySelectorAll("tr.ticket")).map(function(tr){
    var d=tr.dataset;
    var h=parseFloat(String(d.horas||"").replace(",","."));
    return {el:tr,numero:d.numero||"",usuario:d.usuario||"",abertura:d.abertura||"",aberturaTexto:d.aberturaTexto||"",
      fecha:d.fecha||"",status:d.status||"EM ABERTO",setor:d.setor||"NÃO INFORMADO",tipo:d.tipo||"NÃO INFORMADO",
      horas:isFinite(h)?h:null,tempo:d.tempo||"",titulo:d.titulo||""};
  });
  var colors=["#2864dc","#0e9bb5","#15966b","#e58b28","#805ad5","#d84b4b","#64748b","#b35c9e"];
  function norm(v){return String(v||"").trim().toUpperCase();}
  function isOpen(r){return !r.fecha || norm(r.status)==="EM ABERTO";}
  function unique(key){return Array.from(new Set(rows.map(function(r){return r[key]||"NÃO INFORMADO";}))).sort();}
  function fillSelect(id,values){var s=document.getElementById(id);values.forEach(function(v){var o=document.createElement("option");o.value=v;o.textContent=v;s.appendChild(o);});}
  fillSelect("fStatus",unique("status"));fillSelect("fSetor",unique("setor"));fillSelect("fTipo",unique("tipo"));

  function fmt(n){return Number(n||0).toLocaleString("pt-BR",{maximumFractionDigits:0});}
  function average(arr){var a=arr.filter(function(x){return x!==null&&isFinite(x);});return a.length?a.reduce(function(x,y){return x+y;},0)/a.length:null;}
  function setText(id,v){document.getElementById(id).textContent=v;}
  function filtered(){
    var ini=document.getElementById("fInicio").value, fim=document.getElementById("fFim").value;
    var st=document.getElementById("fStatus").value, se=document.getElementById("fSetor").value, ti=document.getElementById("fTipo").value;
    return rows.filter(function(r){
      return (!ini||r.abertura>=ini)&&(!fim||r.abertura<=fim)&&(!st||r.status===st)&&(!se||r.setor===se)&&(!ti||r.tipo===ti);
    });
  }
  function barChart(id,items,color){
    var el=document.getElementById(id);el.innerHTML="";
    if(!items.length){el.innerHTML='<div class="empty">Sem dados para exibir.</div>';return;}
    var max=Math.max.apply(null,items.map(function(x){return x.value;}))||1;
    var box=document.createElement("div");box.className="bar-chart";
    items.forEach(function(x,i){
      var col=document.createElement("div");col.className="bar-col";
      var val=document.createElement("div");val.className="bar-value";val.textContent=fmt(x.value);
      var b=document.createElement("div");b.className="bar";b.style.height=Math.max(2,(x.value/max)*125)+"px";b.style.background=color||colors[i%colors.length];b.title=x.label+": "+fmt(x.value);
      var lab=document.createElement("div");lab.className="bar-label";lab.textContent=x.label;
      col.appendChild(val);col.appendChild(b);col.appendChild(lab);box.appendChild(col);
    });el.appendChild(box);
  }
  function hbars(id,items){
    var el=document.getElementById(id);el.innerHTML="";
    if(!items.length){el.innerHTML='<div class="empty">Sem dados para exibir.</div>';return;}
    var max=Math.max.apply(null,items.map(function(x){return x.value;}))||1;
    var wrap=document.createElement("div");wrap.className="hbar-list";
    items.forEach(function(x,i){
      var item=document.createElement("div"),head=document.createElement("div"),track=document.createElement("div"),fill=document.createElement("div");
      head.className="hbar-head";head.innerHTML="<span></span><b></b>";head.children[0].textContent=x.label;head.children[1].textContent=fmt(x.value);
      track.className="hbar-track";fill.className="hbar-fill";fill.style.width=(x.value/max*100)+"%";fill.style.background=colors[i%colors.length];track.appendChild(fill);
      item.appendChild(head);item.appendChild(track);wrap.appendChild(item);
    });el.appendChild(wrap);
  }
  function donut(id,items){
    var el=document.getElementById(id);el.innerHTML="";
    var total=items.reduce(function(a,x){return a+x.value;},0);
    if(!total){el.innerHTML='<div class="empty">Sem dados para exibir.</div>';return;}
    var angle=0,stops=[];
    items.forEach(function(x,i){var end=angle+(x.value/total*360);stops.push(colors[i%colors.length]+" "+angle+"deg "+end+"deg");angle=end;});
    var wrap=document.createElement("div");wrap.className="donut-wrap";
    var chart=document.createElement("div");chart.className="donut";chart.style.background="conic-gradient("+stops.join(",")+")";
    var center=document.createElement("div");center.className="donut-center";center.textContent=fmt(total);
    var small=document.createElement("small");small.textContent="chamados";center.appendChild(small);chart.appendChild(center);wrap.appendChild(chart);
    var legend=document.createElement("div");legend.className="legend";
    items.forEach(function(x,i){var line=document.createElement("div");line.className="legend-item";var dot=document.createElement("i");dot.className="dot";dot.style.background=colors[i%colors.length];var label=document.createElement("span");label.textContent=x.label+" · "+fmt(x.value);line.appendChild(dot);line.appendChild(label);legend.appendChild(line);});
    wrap.appendChild(legend);el.appendChild(wrap);
  }
  function groupCount(data,key){var m={};data.forEach(function(r){var k=r[key]||"NÃO INFORMADO";m[k]=(m[k]||0)+1;});return Object.keys(m).map(function(k){return {label:k,value:m[k]};}).sort(function(a,b){return b.value-a.value;});}
  function monthCounts(data){
    var m={};data.forEach(function(r){if(!r.abertura)return;var k=r.abertura.substring(0,7);m[k]=(m[k]||0)+1;});
    return Object.keys(m).sort().slice(-12).map(function(k){var p=k.split("-");return {label:p[1]+"/"+p[0].substring(2),value:m[k]};});
  }
  function render(){
    var data=filtered(),open=data.filter(isOpen),closed=data.filter(function(r){return !isOpen(r);});
    var avgClosed=average(closed.map(function(r){return r.horas;})),avgOpen=average(open.map(function(r){return r.horas;}));
    setText("kTotal",fmt(data.length));setText("kAbertos",fmt(open.length));setText("kFechados",fmt(closed.length));
    setText("kMedia",avgClosed===null?"—":avgClosed.toLocaleString("pt-BR",{maximumFractionDigits:1})+" h");
    setText("kMediaAberto",avgOpen===null?"—":avgOpen.toLocaleString("pt-BR",{maximumFractionDigits:1})+" h");
    barChart("chartMes",monthCounts(data));
    donut("chartStatus",[{label:"Em aberto",value:open.length},{label:"Encerrados",value:closed.length}]);
    hbars("chartSetor",groupCount(data,"setor").slice(0,8));
    hbars("chartTipo",groupCount(data,"tipo").slice(0,8));
    hbars("chartTempo",[
      {label:"Encerrados · média (h)",value:avgClosed||0},
      {label:"Em aberto · média (h)",value:avgOpen||0}
    ]);
    var aging=[{label:"Até 1 dia útil",value:0},{label:"1 a 3 dias úteis",value:0},{label:"3 a 5 dias úteis",value:0},{label:"Acima de 5 dias úteis",value:0},{label:"Sem cálculo",value:0}];
    open.forEach(function(r){if(r.horas===null){aging[4].value++;}else if(r.horas<528/60){aging[0].value++;}else if(r.horas<3*528/60){aging[1].value++;}else if(r.horas<5*528/60){aging[2].value++;}else{aging[3].value++;}});
    hbars("chartAging",aging.filter(function(x){return x.value>0;}));
    var body=document.getElementById("tbodyChamados");body.innerHTML="";
    data.forEach(function(r){
      var tr=document.createElement("tr"),vals=[r.numero,r.usuario,r.aberturaTexto,r.fecha,r.setor,r.tipo,r.status,r.tempo,r.titulo];
      vals.forEach(function(v,i){var td=document.createElement("td");td.textContent=v||"—";if(i===6){var span=document.createElement("span");span.className="status"+(isOpen(r)?"":" closed");span.textContent=v||"EM ABERTO";td.textContent="";td.appendChild(span);}tr.appendChild(td);});body.appendChild(tr);
    });
    setText("tableCount",fmt(data.length)+" registros");document.getElementById("emptyState").style.display=data.length?"none":"block";
  }
  document.getElementById("btnAplicar").addEventListener("click",render);
  document.getElementById("btnLimpar").addEventListener("click",function(){["fInicio","fFim","fStatus","fSetor","fTipo"].forEach(function(id){document.getElementById(id).value="";});render();});
  render();
})();
</script>
</body>
</html>
