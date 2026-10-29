<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard RFM - Clientes</title>
<snk:load/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root{--bg:#f3f6fb;--card:#fff;--ink:#172033;--muted:#68758a;--line:#e4e9f2;--blue:#2563eb;--navy:#14213d}
*{box-sizing:border-box}body{margin:0;background:var(--bg);font-family:Arial,Helvetica,sans-serif;color:var(--ink);padding:18px}
.header{background:linear-gradient(120deg,#14213d,#244d83);color:#fff;border-radius:16px;padding:22px 24px;margin-bottom:16px;display:flex;justify-content:space-between;align-items:center;gap:16px;flex-wrap:wrap}
.header h1{font-size:24px;margin:0 0 7px}.header p{margin:0;color:#dbeafe;font-size:13px}.period{font-size:12px;border:1px solid #ffffff55;border-radius:20px;padding:9px 12px}
.filters{display:flex;gap:10px;flex-wrap:wrap;margin:0 0 16px}.filters input,.filters select{background:#fff;border:1px solid var(--line);border-radius:9px;padding:10px 12px;color:var(--ink);min-width:180px}
.kpis{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px;margin-bottom:16px}.kpi,.panel{background:var(--card);border:1px solid var(--line);border-radius:14px;box-shadow:0 3px 12px #17203308}
.kpi{padding:17px}.kpi .label{font-size:12px;color:var(--muted);margin-bottom:10px}.kpi .value{font-size:25px;font-weight:700;letter-spacing:-.5px}.kpi .note{font-size:11px;color:var(--muted);margin-top:7px}
.charts{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px;margin-bottom:16px}.panel{padding:17px;min-width:0}.panel h2{font-size:15px;margin:0 0 4px}.sub{font-size:11px;color:var(--muted);margin-bottom:12px}.chartbox{height:260px;position:relative}
.table-panel{padding:0;overflow:hidden}.table-head{padding:17px 17px 10px;display:flex;justify-content:space-between;gap:10px;align-items:center;flex-wrap:wrap}.table-wrap{overflow:auto;max-height:470px}table{border-collapse:collapse;width:100%;font-size:12px;white-space:nowrap}thead th{position:sticky;top:0;background:#f8fafc;color:#5b667a;font-weight:600;text-align:left;padding:12px 14px;border-top:1px solid var(--line);border-bottom:1px solid var(--line)}tbody td{padding:11px 14px;border-bottom:1px solid #edf0f5}tbody tr:hover{background:#f8fbff}.num{text-align:right;font-variant-numeric:tabular-nums}.pill{display:inline-block;border-radius:30px;padding:5px 8px;font-weight:700;font-size:10px}.alta{background:#dcfce7;color:#166534}.media-alta{background:#dbeafe;color:#1d4ed8}.media{background:#fef3c7;color:#92400e}.baixa{background:#ffedd5;color:#9a3412}.qualificar{background:#fee2e2;color:#991b1b}.empty{padding:25px;text-align:center;color:var(--muted)}.foot{font-size:10px;color:var(--muted);padding:12px 2px}
@media(max-width:900px){.kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.charts{grid-template-columns:1fr}}@media(max-width:520px){body{padding:9px}.kpis{gap:8px}.kpi{padding:12px}.kpi .value{font-size:20px}.header{padding:17px}.header h1{font-size:20px}}
</style>
</head>
<body>
<snk:query var="clientes">
WITH
parametros_periodo AS (SELECT TRUNC(ADD_MONTHS(SYSDATE,-6),'MM') dt_inicio, TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE,-1))) dt_fim FROM dual),
tops_validas AS (SELECT DISTINCT codtipoper,dhalter FROM tgftop WHERE tipmov='P' AND COALESCE(orcamento,'N')='N' AND codtipoper>0 AND atualfin=1),
metricas_recencia_frequencia AS (
 SELECT cab.codparc,p.dt_fim-MAX(cab.dtneg) qtd_recencia,COUNT(DISTINCT cab.dtneg) qtd_frequencia
 FROM tgfcab cab JOIN parametros_periodo p ON cab.dtneg>=p.dt_inicio AND cab.dtneg<p.dt_fim+1
 JOIN tops_validas top ON top.codtipoper=cab.codtipoper AND top.dhalter=cab.dhtipoper
 GROUP BY cab.codparc,p.dt_fim),
metrica_monetaria AS (
 SELECT cab.codparc,SUM(ite.ad_vlrliq) valor_monetario
 FROM tgfcab cab JOIN tgfite ite ON ite.nunota=cab.nunota
 JOIN tops_validas top ON top.codtipoper=cab.codtipoper AND top.dhalter=cab.dhtipoper
 CROSS JOIN parametros_periodo p
 WHERE cab.dtneg>=p.dt_inicio AND cab.dtneg<p.dt_fim+1 GROUP BY cab.codparc),
metricas_clientes AS (
 SELECT par.codparc,COALESCE(rf.qtd_recencia,999999) qtd_recencia,COALESCE(rf.qtd_frequencia,0) qtd_frequencia,COALESCE(mm.valor_monetario,0) valor_monetario
 FROM tgfpar par LEFT JOIN metricas_recencia_frequencia rf ON rf.codparc=par.codparc
 LEFT JOIN metrica_monetaria mm ON mm.codparc=par.codparc
 WHERE par.ativo='S' AND par.codparc>1 AND par.cliente='S'),
pontuacao_rfm AS (
 SELECT mc.codparc,mc.qtd_recencia,
 CASE WHEN mc.qtd_recencia<=30 THEN 5 WHEN mc.qtd_recencia<=60 THEN 4 WHEN mc.qtd_recencia<=90 THEN 3 WHEN mc.qtd_recencia<=120 THEN 2 ELSE 1 END nota_recencia,
 mc.qtd_frequencia,CASE WHEN mc.qtd_frequencia>=5 THEN 5 WHEN mc.qtd_frequencia=4 THEN 4 WHEN mc.qtd_frequencia=3 THEN 3 WHEN mc.qtd_frequencia=2 THEN 2 ELSE 1 END nota_frequencia,
 mc.valor_monetario,CASE WHEN mc.valor_monetario>=240000 THEN 5 WHEN mc.valor_monetario>=120000 THEN 4 WHEN mc.valor_monetario>=60000 THEN 3 WHEN mc.valor_monetario>20000 THEN 2 ELSE 1 END nota_monetaria
 FROM metricas_clientes mc),
media_ponderada AS (SELECT rfm.*,(nota_recencia*.10)+(nota_frequencia*.20)+(nota_monetaria*.70) media FROM pontuacao_rfm rfm),
classificacao_clientes AS (
 SELECT mp.*,CASE WHEN media>=4.01 THEN 'ALTA' WHEN media>=3.01 THEN 'MÉDIA ALTA' WHEN media>=2.01 THEN 'MÉDIA' WHEN media>=1.01 THEN 'BAIXA' ELSE 'QUALIFICAR' END classificacao
 FROM media_ponderada mp),
rcas_vnd_ativos AS (SELECT ven.codvend, ven.apelido, ven.tipvend FROM tgfven ven WHERE ven.tipvend IN ('R', 'V'))
SELECT grv.codvend codgrv,grv.apelido nomegrv,rca.codvend codrca,rca.apelido nomerca,par.codparc,par.razaosocial,
cc.qtd_recencia,cc.nota_recencia,cc.qtd_frequencia,cc.nota_frequencia,cc.valor_monetario vlrmonetario,cc.nota_monetaria,cc.media,cc.classificacao
FROM tgfpar par JOIN rcas_vnd_ativos rva ON rva.codvend = par.codvend JOIN tgfven rca ON rca.codvend=rva.codvend JOIN tgfven grv ON grv.codvend=rca.codger
JOIN classificacao_clientes cc ON cc.codparc=par.codparc
WHERE par.ativo='S' AND par.codparc>1 AND par.cliente='S'
ORDER BY cc.media DESC,cc.valor_monetario DESC
</snk:query>
<div class="header"><div><h1>Dashboard de Clientes · RFM</h1><p>Recência, frequência e valor monetário · Segmentação comercial</p></div><div class="period">Período: últimos 6 meses completos</div></div>
<div class="filters">
<input id="busca" type="search" placeholder="Buscar cliente, código ou RCA...">
<select id="filtroClass"><option value="">Todas as classificações</option><option>ALTA</option><option>MÉDIA ALTA</option><option>MÉDIA</option><option>BAIXA</option><option>QUALIFICAR</option></select>
<select id="filtroGrv"><option value="">Todos os GRVs</option></select>
<select id="filtroRca"><option value="">Todos os RCAs</option></select>
</div>
<div class="kpis">
 <div class="kpi"><div class="label">Clientes na carteira exibida</div><div class="value" id="kClientes">0</div><div class="note">Clientes ativos vinculados a RCA/GRV</div></div>
 <div class="kpi"><div class="label">Valor monetário acumulado</div><div class="value" id="kValor">R$ 0</div><div class="note">Soma do valor líquido no período</div></div>
 <div class="kpi"><div class="label">Clientes de classificação ALTA</div><div class="value" id="kAlta">0</div><div class="note" id="kAltaPct">0% da carteira filtrada</div></div>
 <div class="kpi"><div class="label">Média ponderada RFM</div><div class="value" id="kMedia">0,00</div><div class="note">Recência 10% · Frequência 20% · Monetário 70%</div></div>
</div>
<div class="charts">
 <section class="panel"><h2>Distribuição por classificação</h2><div class="sub">Quantidade de clientes por segmento</div><div class="chartbox"><canvas id="chartClass"></canvas></div></section>
 <section class="panel"><h2>Valor monetário por classificação</h2><div class="sub">Participação no valor total da carteira filtrada</div><div class="chartbox"><canvas id="chartValor"></canvas></div></section>
 <section class="panel"><h2>Notas médias por dimensão</h2><div class="sub">Comparativo de Recência, Frequência e Monetário (escala de 1 a 5)</div><div class="chartbox"><canvas id="chartNotas"></canvas></div></section>
 <section class="panel"><h2>Top 10 clientes por valor</h2><div class="sub">Clientes com maior valor monetário no período</div><div class="chartbox"><canvas id="chartTop"></canvas></div></section>
</div>
<section class="panel table-panel">
 <div class="table-head"><div><h2>Detalhamento da carteira</h2><div class="sub" style="margin:5px 0 0">Use a busca e os filtros para explorar os clientes</div></div><div id="contador" class="sub" style="margin:0">0 registros</div></div>
 <div class="table-wrap"><table><thead><tr><th>Classificação</th><th>Cód.</th><th>Cliente</th><th>GRV</th><th>RCA</th><th class="num">Recência (dias)</th><th class="num">Freq.</th><th class="num">Valor monetário</th><th class="num">Nota R</th><th class="num">Nota F</th><th class="num">Nota M</th><th class="num">Média</th></tr></thead><tbody id="tbody">
 <c:forEach items="${clientes.rows}" var="r"><tr data-class="<c:out value='${r.CLASSIFICACAO}'/>" data-grv="<c:out value='${r.CODGRV}'/>" data-rca="<c:out value='${r.CODRCA}'/>" data-search="<c:out value='${r.CODPARC} ${r.RAZAOSOCIAL} ${r.NOMERCA} ${r.NOMEGRV}'/>">
 <td><c:out value="${r.CLASSIFICACAO}"/></td><td><c:out value="${r.CODPARC}"/></td><td><c:out value="${r.RAZAOSOCIAL}"/></td><td><c:out value="${r.NOMEGRV}"/></td><td><c:out value="${r.NOMERCA}"/></td>
 <td class="num"><c:out value="${r.QTD_RECENCIA}"/></td><td class="num"><c:out value="${r.QTD_FREQUENCIA}"/></td><td class="num"><c:out value="${r.VLRMONETARIO}"/></td><td class="num"><c:out value="${r.NOTA_RECENCIA}"/></td><td class="num"><c:out value="${r.NOTA_FREQUENCIA}"/></td><td class="num"><c:out value="${r.NOTA_MONETARIA}"/></td><td class="num"><c:out value="${r.MEDIA}"/></td>
 </tr></c:forEach>
 </tbody></table></div>
</section>
<div class="foot">Dashboard RFM · Dados consultados no Oracle/Sankhya. Os filtros desta tela são locais e não alteram os filtros nativos do Sankhya.</div>
<script>
(function(){
 const rows=[...document.querySelectorAll('#tbody tr')].map(tr=>{const c=tr.children;return {tr,cls:tr.dataset.class,grv:tr.dataset.grv,rca:tr.dataset.rca,search:(tr.dataset.search||'').toLowerCase(),cod:c[1].textContent.trim(),nome:c[2].textContent.trim(),rec:Number(c[5].textContent)||0,freq:Number(c[6].textContent)||0,valor:(()=>{const v=c[7].textContent.trim();return (v.includes(',')?Number(v.replace(/\./g,'').replace(',','.')):Number(v))||0;})(),nr:Number(c[8].textContent)||0,nf:Number(c[9].textContent)||0,nm:Number(c[10].textContent)||0,media:Number(c[11].textContent.replace(',','.'))||0};});
 const filtroGrv=document.getElementById('filtroGrv');
 const filtroRca=document.getElementById('filtroRca');
 // Preenche os filtros com nomes únicos, usando os códigos como identificadores.
 const grvs=new Map();
 rows.forEach(r=>{const nome=r.tr.children[3].textContent.trim();if(r.grv&&!grvs.has(r.grv))grvs.set(r.grv,nome);});
 [...grvs.entries()].sort((a,b)=>a[1].localeCompare(b[1],'pt-BR')).forEach(([cod,nome])=>{const op=document.createElement('option');op.value=cod;op.textContent=nome+' ('+cod+')';filtroGrv.appendChild(op);});
 function atualizarRcas(){
   const grvSelecionado=filtroGrv.value, rcaAnterior=filtroRca.value;
   const rcas=new Map();
   rows.filter(r=>!grvSelecionado||r.grv===grvSelecionado).forEach(r=>{const nome=r.tr.children[4].textContent.trim();if(r.rca&&!rcas.has(r.rca))rcas.set(r.rca,nome);});
   filtroRca.innerHTML='<option value="">Todos os RCAs</option>';
   [...rcas.entries()].sort((a,b)=>a[1].localeCompare(b[1],'pt-BR')).forEach(([cod,nome])=>{const op=document.createElement('option');op.value=cod;op.textContent=nome+' ('+cod+')';filtroRca.appendChild(op);});
   if(rcas.has(rcaAnterior))filtroRca.value=rcaAnterior;
 }
 atualizarRcas();
 const classes=['ALTA','MÉDIA ALTA','MÉDIA','BAIXA','QUALIFICAR'];
 const colors=['#16a34a','#3b82f6','#f59e0b','#f97316','#ef4444'];
 const money=v=>Number(v||0).toLocaleString('pt-BR',{style:'currency',currency:'BRL',minimumFractionDigits:2,maximumFractionDigits:2});
 const num=v=>v.toLocaleString('pt-BR',{maximumFractionDigits:2});
 // Formata a coluna monetária da tabela em Real (pt-BR), mantendo os valores numéricos para os cálculos.
 rows.forEach(r=>{r.tr.children[7].textContent=money(r.valor);});
 const common={responsive:true,maintainAspectRatio:false,plugins:{legend:{position:'bottom',labels:{boxWidth:10,usePointStyle:true,font:{size:10}}}}};
 const chClass=new Chart(document.getElementById('chartClass'),{type:'doughnut',data:{labels:classes,datasets:[{data:classes.map(()=>0),backgroundColor:colors,borderWidth:0}]},options:{...common,cutout:'62%'}});
 const chValor=new Chart(document.getElementById('chartValor'),{type:'bar',data:{labels:classes,datasets:[{label:'Valor monetário',data:classes.map(()=>0),backgroundColor:colors,borderRadius:6}]},options:{...common,indexAxis:'y',plugins:{legend:{display:false},tooltip:{callbacks:{label:c=>money(c.raw)}}},scales:{x:{ticks:{callback:v=>money(v)},grid:{color:'#eef2f7'}},y:{grid:{display:false}}}}});
 const chNotas=new Chart(document.getElementById('chartNotas'),{type:'bar',data:{labels:classes,datasets:[{label:'Recência',data:[],backgroundColor:'#60a5fa'},{label:'Frequência',data:[],backgroundColor:'#a78bfa'},{label:'Monetário',data:[],backgroundColor:'#34d399'}]},options:{...common,scales:{y:{min:0,max:5,ticks:{stepSize:1},grid:{color:'#eef2f7'}},x:{grid:{display:false}}}}});
 const chTop=new Chart(document.getElementById('chartTop'),{type:'bar',data:{labels:[],datasets:[{label:'Valor monetário',data:[],backgroundColor:'#2563eb',borderRadius:5}]},options:{...common,indexAxis:'y',plugins:{legend:{display:false},tooltip:{callbacks:{label:c=>money(c.raw)}}},scales:{x:{ticks:{callback:v=>money(v)},grid:{color:'#eef2f7'}},y:{grid:{display:false}}}}});
 function update(){const q=document.getElementById('busca').value.toLowerCase().trim(),cl=document.getElementById('filtroClass').value,gr=filtroGrv.value,rca=filtroRca.value;
 const filtered=rows.filter(r=>(!q||r.search.includes(q))&&(!cl||r.cls===cl)&&(!gr||r.grv===gr)&&(!rca||r.rca===rca));
 rows.forEach(r=>r.tr.style.display=filtered.includes(r)?'':'none');
 const count=filtered.length,total=filtered.reduce((s,r)=>s+r.valor,0),alta=filtered.filter(r=>r.cls==='ALTA').length,avg=count?filtered.reduce((s,r)=>s+r.media,0)/count:0;
 document.getElementById('kClientes').textContent=count.toLocaleString('pt-BR');document.getElementById('kValor').textContent=money(total);document.getElementById('kAlta').textContent=alta.toLocaleString('pt-BR');document.getElementById('kAltaPct').textContent=(count?num(alta/count*100):'0')+'% da carteira filtrada';document.getElementById('kMedia').textContent=num(avg);document.getElementById('contador').textContent=count+' registros';
 const subset=classes.map(c=>filtered.filter(r=>r.cls===c));chClass.data.datasets[0].data=subset.map(a=>a.length);chClass.update();
 chValor.data.datasets[0].data=subset.map(a=>a.reduce((s,r)=>s+r.valor,0));chValor.update();
 chNotas.data.datasets[0].data=subset.map(a=>a.length?a.reduce((s,r)=>s+r.nr,0)/a.length:0);
 chNotas.data.datasets[1].data=subset.map(a=>a.length?a.reduce((s,r)=>s+r.nf,0)/a.length:0);
 chNotas.data.datasets[2].data=subset.map(a=>a.length?a.reduce((s,r)=>s+r.nm,0)/a.length:0);chNotas.update();
 const top=[...filtered].sort((a,b)=>b.valor-a.valor).slice(0,10).reverse();chTop.data.labels=top.map(r=>r.cod+' · '+r.nome.slice(0,22));chTop.data.datasets[0].data=top.map(r=>r.valor);chTop.update();
 document.querySelectorAll('#tbody tr').forEach(tr=>{const c=tr.children[0],v=c.textContent.trim();c.innerHTML='<span class="pill '+({'ALTA':'alta','MÉDIA ALTA':'media-alta','MÉDIA':'media','BAIXA':'baixa','QUALIFICAR':'qualificar'}[v]||'')+'">'+v+'</span>';});
 }
 ['busca','filtroClass','filtroRca'].forEach(id=>document.getElementById(id).addEventListener(id==='busca'?'input':'change',update));
 filtroGrv.addEventListener('change',()=>{atualizarRcas();update();});
 update();
})();
</script>
</body></html>