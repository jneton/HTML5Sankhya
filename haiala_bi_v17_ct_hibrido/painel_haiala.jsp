<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!doctype html>
<html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>HAIALA | Painel de Ordens de Producao</title>
<snk:load/>
<style>
*{box-sizing:border-box}body{margin:0;font:12px Arial,sans-serif;background:#f3f6fa;color:#172b40}.wrap{padding:12px 16px}header{border-bottom:2px solid #d92d32;padding-bottom:8px;display:flex;align-items:center;justify-content:space-between}.brand{font-size:19px;font-weight:900;color:#d92d32}h1{font-size:19px;margin:2px 0}small,.muted{color:#60748e;font-size:11px}.filters,.cards{display:flex;gap:8px;margin:10px 0;flex-wrap:wrap}.filters select,.filters input,.filters button{padding:6px 9px;background:white;border:1px solid #d5dce5;border-radius:5px;font-size:12px}.filters input{min-width:205px}.cards{flex-wrap:nowrap}.unit-values{display:flex;flex-direction:column;gap:3px;margin-top:5px}.unit-values>div{display:flex;align-items:center;justify-content:space-between;gap:8px}.unit-values span{font-size:10px;color:#60748e}.unit-values b{font-size:15px;white-space:nowrap}.card,.panel{background:white;border:1px solid #e0e5ed;border-radius:7px;box-shadow:0 2px 8px #172b4410}.card{flex:1;padding:9px 12px}.card strong{display:block;font-size:21px;margin-top:3px}.panel{margin:10px 0;overflow:auto}h2{font-size:14px;padding:9px 12px;margin:0;border-bottom:1px solid #e6eaf0}table{width:100%;border-collapse:collapse;font-size:12px}td,th{border-bottom:1px solid #e8edf2;padding:6px 8px;text-align:left}th{font-size:11px;background:#f6f8fb;color:#526378;white-space:nowrap}.right{text-align:right}.bar{height:6px;border-radius:8px;background:#e7edf4;overflow:hidden;min-width:70px}.bar i{display:block;height:100%;background:#d92d32}.pill{display:inline-block;border-radius:15px;padding:3px 8px;background:#eef2f7;font-size:11px;white-space:nowrap}.bad{background:#ffe2e2;color:#9d2020}.warn{background:#fff1d6;color:#8d5800}.good{background:#dff5e7;color:#17683a}tr[data-ct]{cursor:pointer}tr[data-ct]:hover{background:#fff4f4}.note{font-size:10px;color:#60748e}.statusbox{position:relative}.statusmenu{display:none;position:absolute;background:white;border:1px solid #ddd;z-index:100;padding:8px;min-width:170px;box-shadow:0 3px 12px #0002}.statusmenu.open{display:block}.statusmenu label{display:block;padding:3px;white-space:nowrap}.statusmenu input{min-width:auto}.nowrap{white-space:nowrap}@media(max-width:800px){.cards{flex-wrap:wrap}.panel table{min-width:1050px}}
</style></head><body>
<snk:query var="dados">
/* V17 - Somente leitura. CT da atividade para roteiros estruturados;
   atividade unica USUARIO: CTs distintos do cadastro TPRWXP (CT/SKU).
   A mesma OP pode existir em varios CTs, sem duplicar os cards gerais.
*/
WITH PLANEJAMENTO AS (
 SELECT IDIPROC, CODPRODPA, MAX(CONTROLEPA) CONTROLEPA,
 SUM(QTDPRODUZIR) PLANEJADO
 FROM TPRIPA GROUP BY IDIPROC,CODPRODPA
), APONTAMENTOS AS (
 SELECT A.IDIATV,PA.CODPRODPA,
 SUM(CASE WHEN A.SITUACAO='C' THEN NVL(PA.QTDAPONTADA,0) ELSE 0 END) EXECUTADO
 FROM TPRAPO A JOIN TPRAPA PA ON PA.NUAPO=A.NUAPO
 GROUP BY A.IDIATV,PA.CODPRODPA
), ATIVIDADES_OP AS (
 SELECT I.IDIPROC, COUNT(*) QTD_ATIVIDADES,
 SUM(CASE WHEN UPPER(TRIM(R.DESCRICAO))='USUÁRIO' THEN 1 ELSE 0 END) QTD_USUARIO
 FROM TPRIATV I
 LEFT JOIN TPRATV ATV ON ATV.IDEFX=I.IDEFX
 LEFT JOIN TPRRPA R ON R.IDRPA=ATV.IDRPAOPER
 GROUP BY I.IDIPROC
), VINCULOS_CT_SKU AS (
 /* Um vinculo por SKU, controle e CT, mesmo que existam varias SEQs. */
 SELECT DISTINCT CODPRODPA, NVL(CONTROLEPA,' ') CONTROLE_CHAVE, CODWCP
 FROM TPRWXP WHERE CODWCP IS NOT NULL
), TEMPOS_CADASTRADOS AS (
 SELECT IDEFX,CODPRODPA,CODWCP,CONTROLEPA,TEMPOATIVIDADE,UNTEMPO,TIPOTEMPO,USARCTPADRAO,
 ROW_NUMBER() OVER (
  PARTITION BY IDEFX,CODPRODPA,CODWCP,CONTROLEPA
  ORDER BY DHALTER DESC NULLS LAST,DHCAD DESC NULLS LAST
 ) RN
 FROM TPRTXP
), DETALHE AS (
 SELECT OP.IDIPROC, OP.STATUSPROC,OP.PRIORIDADE,OP.DHINC,OP.DHINST,
 P.CODPRODPA,PROD.DESCRPROD,PROD.CODVOL,P.PLANEJADO,
 I.IDIATV,ATV.SEQEXECUCAO,
 CASE WHEN AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1 THEN XS.CODWCP
      ELSE I.CODWCP END CODWCP,NVL(CT.NOME,'SEM CENTRO DE TRABALHO') CENTRO,
 NVL(CAT.DESCRICAO,'SEM CATEGORIA') CATEGORIA,
 NVL(R.DESCRICAO,'NÃO INICIADA') ATIVIDADE,
 NVL(AP.EXECUTADO,0) EXECUTADO,
 CASE WHEN AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1 THEN NULL
      WHEN TX.IDEFX IS NOT NULL AND NVL(TX.USARCTPADRAO,'N')<>'S'
      THEN TX.TEMPOATIVIDADE ELSE ATV.TEMPOATIVIDADE END TEMPO_CADASTRADO,
 CASE WHEN AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1 THEN NULL
      WHEN TX.IDEFX IS NOT NULL AND NVL(TX.USARCTPADRAO,'N')<>'S'
      THEN TX.UNTEMPO ELSE ATV.UNTEMPO END UN_TEMPO_CAD,
 CASE WHEN AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1 THEN NULL
      WHEN TX.IDEFX IS NOT NULL AND NVL(TX.USARCTPADRAO,'N')<>'S'
      THEN TX.TIPOTEMPO ELSE ATV.TIPOTEMPO END TIPO_TEMPO_CAD,
 CASE WHEN I.IDIATV IS NULL THEN 'AGUARDANDO PROGRAMAÇÃO' ELSE 'ATIVIDADE' END TIPO_REGISTRO
 FROM TPRIPROC OP
 JOIN PLANEJAMENTO P ON P.IDIPROC=OP.IDIPROC
 JOIN TGFPRO PROD ON PROD.CODPROD=P.CODPRODPA
 LEFT JOIN TPRIATV I ON I.IDIPROC=OP.IDIPROC
 LEFT JOIN ATIVIDADES_OP AO ON AO.IDIPROC=OP.IDIPROC
 LEFT JOIN VINCULOS_CT_SKU XS
   ON XS.CODPRODPA=P.CODPRODPA
   AND XS.CONTROLE_CHAVE=NVL(P.CONTROLEPA,' ')
   AND AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1
 LEFT JOIN TPRWCP CT ON CT.CODWCP=CASE
   WHEN AO.QTD_ATIVIDADES=1 AND AO.QTD_USUARIO=1 THEN XS.CODWCP
   ELSE I.CODWCP END
 LEFT JOIN TPRCWC CAT ON CAT.CODCWC=CT.CODCWC
 LEFT JOIN TPRATV ATV ON ATV.IDEFX=I.IDEFX
 LEFT JOIN TPRRPA R ON R.IDRPA=ATV.IDRPAOPER
 LEFT JOIN APONTAMENTOS AP ON AP.IDIATV=I.IDIATV AND AP.CODPRODPA=P.CODPRODPA
 LEFT JOIN TEMPOS_CADASTRADOS TX ON TX.IDEFX=I.IDEFX
     AND TX.CODPRODPA=P.CODPRODPA AND TX.CODWCP=I.CODWCP
     AND NVL(TX.CONTROLEPA,' ') = NVL(P.CONTROLEPA,' ')
     AND TX.RN=1
 WHERE OP.STATUSPROC IN ('R','A')
)
SELECT IDIPROC AS OP, STATUSPROC AS STATUS_CODIGO,PRIORIDADE,
 TO_CHAR(DHINC,'DD/MM/YYYY HH24:MI') INCLUSAO,
 TO_CHAR(DHINST,'DD/MM/YYYY HH24:MI') INICIALIZACAO,
 CASE WHEN DHINST IS NULL THEN NULL ELSE ROUND((SYSDATE-DHINST)*24,2) END CICLO_HORAS,
 CODPRODPA AS PRODUTO,DESCRPROD AS DESCRICAO_PRODUTO,CODVOL AS UNIDADE,
 IDIATV AS ID_ATIVIDADE,SEQEXECUCAO,CODWCP AS COD_CENTRO,
 CATEGORIA,CENTRO,ATIVIDADE,PLANEJADO,EXECUTADO,TIPO_REGISTRO,
 TEMPO_CADASTRADO,UN_TEMPO_CAD,TIPO_TEMPO_CAD
FROM DETALHE
ORDER BY CATEGORIA,CENTRO,IDIPROC DESC,IDIATV

</snk:query>
<table id="fonte" hidden><tbody><c:forEach items="${dados.rows}" var="r"><tr>
<td><c:out value="${r.OP}"/></td><td><c:out value="${r.STATUS_CODIGO}"/></td><td><c:out value="${r.PRIORIDADE}"/></td><td><c:out value="${r.INCLUSAO}"/></td><td><c:out value="${r.INICIALIZACAO}"/></td><td><c:out value="${r.CICLO_HORAS}"/></td><td><c:out value="${r.PRODUTO}"/></td><td><c:out value="${r.DESCRICAO_PRODUTO}"/></td><td><c:out value="${r.UNIDADE}"/></td><td><c:out value="${r.ID_ATIVIDADE}"/></td><td><c:out value="${r.SEQEXECUCAO}"/></td><td><c:out value="${r.COD_CENTRO}"/></td><td><c:out value="${r.CATEGORIA}"/></td><td><c:out value="${r.CENTRO}"/></td><td><c:out value="${r.ATIVIDADE}"/></td><td><c:out value="${r.PLANEJADO}"/></td><td><c:out value="${r.EXECUTADO}"/></td><td><c:out value="${r.TIPO_REGISTRO}"/></td><td><c:out value="${r.TEMPO_CADASTRADO}"/></td><td><c:out value="${r.UN_TEMPO_CAD}"/></td><td><c:out value="${r.TIPO_TEMPO_CAD}"/></td>
</tr></c:forEach></tbody></table>
<div class="wrap"><header><div><div class="brand">HAIALA</div><h1>Controle de Ordens de Produção</h1><small>Visão gerencial por Centro de Trabalho | Dados Oracle Sankhya | Validação inicial R/A</small></div><button onclick="resetar()">Limpar filtros</button></header>
<div class="filters"><select id="categoria" onchange="render()"><option value="">Todas as categorias</option></select><select id="centro" onchange="render()"><option value="">Todos os centros</option></select>
<div class="statusbox"><button onclick="document.getElementById('statusmenu').classList.toggle('open')" id="statusLabel">Status: 2 selecionados</button><div class="statusmenu" id="statusmenu"><label><input type="checkbox" value="R" checked onchange="render()"> Criado</label><label><input type="checkbox" value="A" checked onchange="render()"> Em Andamento</label><label title="Não carregado nesta etapa"><input type="checkbox" disabled> Cancelado (próxima fase)</label><label title="Não carregado nesta etapa"><input type="checkbox" disabled> Finalizado (próxima fase)</label></div></div>
<input id="busca" placeholder="Pesquisar OP, produto ou centro" oninput="render()"><select id="unidade" onchange="render()"><option value="" selected>Todas as unidades</option><option value="PC">PC - Peças</option><option value="KG">KG - Quilogramas</option></select></div>
<div id="cards" class="cards"></div>
<section class="panel"><h2>Centros de Trabalho <small>— clique em uma linha para detalhar</small></h2><table><thead><tr><th>Categoria</th><th>Centro de Trabalho</th><th>Atividade</th><th class="right">OPs</th><th class="right">Planejado</th><th class="right">Executado</th><th class="right">Tp Médio Exec OP</th><th class="right">Tp Médio Ciclo / SKU</th><th class="right">Tp Total Ciclo da OP</th><th class="right">Pendente</th><th>Execução</th></tr></thead><tbody id="centrosRows"></tbody></table></section>
<section class="panel"><h2 id="tituloDetalhe">Detalhamento de OPs</h2><table><thead><tr><th>OP</th><th>Produto</th><th>Descrição</th><th>Atividade</th><th>Prioridade</th><th>Inclusão</th><th>Inicialização</th><th class="right">Planejado</th><th class="right">Executado</th><th class="right">Tp Exec OP</th><th class="right">Tp Ciclo SKU</th><th class="right">Tp Total Ciclo OP</th><th class="right">Pendente</th><th>Situação calculada</th></tr></thead><tbody id="opsRows"></tbody></table></section>
<p class="note">Validação técnica: volume geral contabilizado por OP/produto; No bloco Centros de Trabalho, cada atividade possui uma linha própria. Os volumes por atividade representam cargas de etapas e não devem ser somados entre atividades ou CTs. Cards gerais continuam contabilizados por OP/produto distinto e OPs em escopo por OP única, mesmo em múltiplos CTs. A métrica geral de execução usa a maior SEQEXECUCAO por OP/produto (desempate por IDIATV), testada nos roteiros analisados; confirmar eventuais roteiros paralelos. O filtro de unidade abre em Todas as unidades. Em Todas as unidades, os cards apresentam valores separados por PC e KG, sem somar unidades incompatíveis. Tempos padronizados em minutos; atividade única USUÁRIO tem CT identificado pelos vínculos CT/SKU em TPRWXP (um registro por CT distinto) e seu tempo genérico permanece Não cadastrado. As demais atividades sem tempo cadastrado ou com unidade não reconhecida também são sinalizadas. Status Cancelado/Finalizado não são consultados nesta fase.</p></div>
<script>
const D=Array.from(document.querySelectorAll('#fonte tbody tr')).map(tr=>{const t=Array.from(tr.cells).map(x=>x.textContent.trim());return {op:t[0],st:t[1],prio:t[2],inc:t[3],ini:t[4],hor:num(t[5]),prod:t[6],desc:t[7],un:t[8],atv:t[9],seq:t[10]===""?null:Number(t[10]),codct:t[11],cat:t[12],ct:t[13],atividade:t[14],plan:num(t[15]),exec:num(t[16]),tipo:t[17],tpCad:t[18]===""?null:num(t[18]),unTempo:t[19],tipoTempo:t[20]}});
function num(v){const z=String(v||'0').replace(',','.');return Number(z)||0}
function e(s){return String(s==null?'':s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]))}
const $=s=>document.getElementById(s),fmt=n=>Number(n||0).toLocaleString('pt-BR',{maximumFractionDigits:2}),time=h=>!Number.isFinite(h)||!h?'N/A':Math.floor(h/24)+'d '+Math.round(h%24)+'h';
// Cadastro: Q = por quantidade; demais tipos são tratados como tempo fixo da OP.
// Tempos em unidades desconhecidas ficam sem valor, sem atribuir zero.
function tempoMinutos(x){
 if(x.codct==='' && String(x.atividade||'').trim().toUpperCase()==='USUÁRIO')return null;
 if(x.tpCad==null)return null;
 const u=String(x.unTempo||'').toUpperCase().trim();
 const fator=({'M':1,'MIN':1,'H':60,'S':1/60,'D':1440})[u];
 return fator==null?null:x.tpCad*fator;
}
function totalTempoMinutos(x){const t=tempoMinutos(x);if(t==null)return null;return t*(x.tipoTempo==='Q'?x.plan:1)}
function tempoFmt(v){return v==null||!Number.isFinite(v)?'Não cadastrado':fmt(v)+' min'}

function init(){[...new Set(D.map(x=>x.cat))].sort().forEach(v=>$('categoria').add(new Option(v,v)));[...new Set(D.map(x=>x.ct))].sort().forEach(v=>$('centro').add(new Option(v,v)));render()}
function resetar(){$('unidade').value='';$('categoria').value='';$('centro').value='';$('busca').value='';document.querySelectorAll('#statusmenu input:not(:disabled)').forEach(x=>x.checked=true);render()}
function uniqueMap(arr,fn){const m=new Map();arr.forEach(x=>m.set(fn(x),x));return [...m.values()]}
function render(){const unidade=$('unidade').value,cat=$('categoria').value,ct=$('centro').value,q=$('busca').value.toLowerCase(),st=[...document.querySelectorAll('#statusmenu input:checked')].map(x=>x.value);
$('statusLabel').textContent=st.length?'Status: '+st.length+' selecionado(s)':'Status: nenhum';
const rows=D.filter(x=>st.includes(x.st)&&(!unidade||x.un===unidade)&&(!cat||x.cat===cat)&&(!ct||x.ct===ct)&&(!q||[x.op,x.prod,x.desc,x.ct,x.cat].some(v=>String(v).toLowerCase().includes(q))));
// V10: cada linha do resumo representa uma atividade distinta dentro do CT.
// Evita duplicar a mesma OP/produto DENTRO de uma atividade, mas permite que a
// mesma OP apareca em atividades diferentes (carga por etapa, nao volume global).
const atividadesCentro=new Map();
rows.forEach(x=>{
 const k=[x.cat,x.ct,x.atividade].join('|');
 if(!atividadesCentro.has(k))atividadesCentro.set(k,{cat:x.cat,ct:x.ct,atividade:x.atividade,porOP:new Map(),op:new Set(),hrs:new Map(),tempos:new Map()});
 const z=atividadesCentro.get(k);
 const opKey=x.op+'|'+x.prod;
 if(!z.porOP.has(opKey))z.porOP.set(opKey,{plan:x.plan,exec:x.exec,un:x.un});
 else {const r=z.porOP.get(opKey);r.exec=Math.min(r.exec,x.exec)}
 z.op.add(x.op);
 if(x.hor)z.hrs.set(x.op,x.hor);
 // Cada OP/produto contribui uma única vez na média e no total desta atividade.
 if(!z.tempos.has(opKey))z.tempos.set(opKey,{sku:tempoMinutos(x),total:totalTempoMinutos(x)});
});
// Cards a partir de OP/produto distintos, nao somando etapas.
const global=new Map();rows.forEach(x=>{const k=x.op+'|'+x.prod;if(!global.has(k))global.set(k,{...x,lastSeq:-Infinity,lastId:-1,execFinal:0});const g=global.get(k);const seq=x.seq==null?-1:x.seq;const ident=Number(x.atv)||0;if(seq>g.lastSeq||(seq===g.lastSeq&&ident>g.lastId)){g.lastSeq=seq;g.lastId=ident;g.execFinal=x.exec}});
const uniqueOps=new Set([...global.values()].map(x=>x.op)).size;
const porUnidade=new Map();
global.forEach(g=>{const u=g.un||'SEM UNIDADE';if(!porUnidade.has(u))porUnidade.set(u,{plan:0,exec:0});const v=porUnidade.get(u);v.plan+=g.plan;v.exec+=g.execFinal});
const partes=[...porUnidade.entries()].sort((a,b)=>a[0]==='PC'?-1:b[0]==='PC'?1:a[0].localeCompare(b[0]));
const misto=partes.length>1;
function valores(campo){return partes.map(([u,v])=>{const n=campo==='plan'?v.plan:campo==='exec'?v.exec:campo==='pend'?v.plan-v.exec:v.plan?100*v.exec/v.plan:null;return {u:u,valor:n===null?'Sem base':fmt(n)+(campo==='pct'?'%':'')}})}
function exibirMetrica(campo){const dados=valores(campo);if(!dados.length)return '<strong>0</strong>';if(!misto)return '<strong>'+dados[0].valor+'</strong>';return '<div class="unit-values">'+dados.map(d=>'<div><span>'+e(d.u)+'</span><b>'+d.valor+'</b></div>').join('')+'</div>'}
$('cards').innerHTML='<div class="card"><small>OPs em escopo</small><strong>'+fmt(uniqueOps)+'</strong></div>'+[['Quantidade planejada','plan'],['Quantidade executada*','exec'],['Saldo líquido*','pend'],['Execução quantitativa*','pct']].map(x=>'<div class="card"><small>'+x[0]+'</small>'+exibirMetrica(x[1])+'</div>').join('');
$('centrosRows').innerHTML=[...atividadesCentro.values()].sort((a,b)=>a.cat.localeCompare(b.cat)||a.ct.localeCompare(b.ct)||a.atividade.localeCompare(b.atividade)).map(x=>{
 let planned=0,executed=0;
 const ctUnidades=new Set();x.porOP.forEach(r=>{planned+=r.plan;executed+=r.exec;ctUnidades.add(r.un)});const ctMisto=ctUnidades.size>1;
 const av=[...x.hrs.values()],h=av.length?av.reduce((a,b)=>a+b,0)/av.length:0;
 const tempos=[...x.tempos.values()];
 const tpV=tempos.map(t=>t.sku).filter(v=>v!=null);
 const tpMedio=tpV.length===tempos.length&&tpV.length?tpV.reduce((a,b)=>a+b,0)/tpV.length:null;
 const totais=tempos.map(t=>t.total);
 const tpTotal=totais.length&&totais.every(v=>v!=null)?totais.reduce((a,b)=>a+b,0):null;
 const porcento=planned?Math.round(executed/planned*100):0;
 return '<tr data-ct="'+e(x.ct)+'"><td>'+e(x.cat)+'</td><td><b>'+e(x.ct)+'</b></td><td>'+e(x.atividade)+'</td><td class="right">'+fmt(x.op.size)+'</td><td class="right">'+(ctMisto?'PC / KG':fmt(planned))+'</td><td class="right">'+(ctMisto?'PC / KG':fmt(executed))+'</td><td class="right">'+time(h)+'</td><td class="right">'+tempoFmt(tpMedio)+'</td><td class="right">'+tempoFmt(tpTotal)+'</td><td class="right">'+(ctMisto?'PC / KG':fmt(Math.max(0,planned-executed)))+'</td><td>'+(ctMisto?'Unidades mistas':'<div class="bar"><i style="width:'+Math.min(100,porcento)+'%"></i></div><small>'+porcento+'%</small>')+'</td></tr>'
}).join('')||'<tr><td colspan="11">Sem registros</td></tr>';
document.querySelectorAll('[data-ct]').forEach(tr=>tr.onclick=()=>{$('centro').value=tr.getAttribute('data-ct');render();$('tituloDetalhe').scrollIntoView({behavior:'smooth'})});
$('tituloDetalhe').textContent='Detalhamento de OPs — '+(ct||'todas as atividades');
$('opsRows').innerHTML=rows.map(x=>{const pend=Math.max(0,x.plan-x.exec),sit=x.exec===0?'Sem apontamento':x.exec>=x.plan?'Concluída em quantidade':'Parcial',cl=x.exec===0?'bad':x.exec>=x.plan?'good':'warn';return '<tr><td><b>'+e(x.op)+'</b></td><td>'+e(x.prod)+'</td><td>'+e(x.desc)+'</td><td>'+e(x.atividade)+'</td><td>'+e(x.prio)+'</td><td class="nowrap">'+e(x.inc)+'</td><td class="nowrap">'+e(x.ini)+'</td><td class="right">'+fmt(x.plan)+'</td><td class="right">'+fmt(x.exec)+'</td><td class="right">'+time(x.hor)+'</td><td class="right">'+tempoFmt(tempoMinutos(x))+'</td><td class="right">'+tempoFmt(totalTempoMinutos(x))+'</td><td class="right">'+fmt(pend)+'</td><td><span class="pill '+cl+'">'+sit+'</span></td></tr>'}).join('')||'<tr><td colspan="14">Sem OPs para os filtros selecionados</td></tr>';
}init();
</script></body></html>
