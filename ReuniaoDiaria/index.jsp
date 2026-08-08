<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<!DOCTYPE html>
<html lang="pt-BR">

<head>

<snk:load/>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>PAINEL DE REUNIÃO DIARIA</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script>Chart.register(ChartDataLabels);</script>

<style>

/*****************************************************
*
* DASHBOARD PRODUÇÃO
* Desenvolvido em HTML5 + CSS3 + JavaScript
*
******************************************************/

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Segoe UI,Tahoma,Geneva,Verdana,sans-serif;
}

body{

    background:#ECECEC;
    padding:8px;

}

/*****************************************************
                CABEÇALHO
*****************************************************/

.header{

    background:#4DA3F4;
    color:#FFF;
    text-align:center;
    font-size:28px;
    font-weight:bold;
    padding:12px;
    border-radius:6px;
    margin-bottom:10px;
    letter-spacing:2px;

}

/*****************************************************
                GRID
*****************************************************/

.dashboard{

    display:grid;
    gap:10px;
    grid-template-columns:
    repeat(12,1fr);

}

/*****************************************************
                CARDS
*****************************************************/

.card{

    background:white;
    border:2px solid #4DA3F4;
    border-radius:5px;
    display:flex;
    flex-direction:column;
    min-height:250px;
    overflow:hidden;
    box-shadow:
    0 3px 8px rgba(0,0,0,.12);
    transition:.25s;

}

.card:hover{

    transform:translateY(-2px);
    box-shadow:
    0 8px 18px rgba(0,0,0,.20);

}

/*****************************************************
                TÍTULO
*****************************************************/

.card-title{
    background-color: #4DA3F4;
    color: #fff;
    font-weight: bold;
    padding:6px;
    font-size:15px;
    height:38px;
    display:flex;
    align-items:center;
    justify-content:center;
    position: sticky; /* fixa dentro do container */
    top: 0;           /* gruda no topo do card */
    z-index: 10;      /* fica acima do conteúdo */
}

.card-body{
    flex:1;
    display:flex;
    align-items:stretch;
    justify-content:center;
    padding:8px;
    position:relative;
}

.card-body canvas{
    width:100% !important;
    height:100% !important;
}

/*****************************************************
                POSIÇÕES
*****************************************************/

.eficiencia{
    grid-column: span 6;
    grid-row: span 2;
    height:600px;
    display:flex;
    flex-direction:column;
}

.eficiencia .card-body{
    flex:1;
    position:relative;
    min-height:0;
}

.eficiencia canvas{
    width:100% !important;
    height:100% !important;
}

.semana{
    grid-column: span 6;
    grid-row: span 2;
    height:600px;
    display:flex;
    flex-direction:column;
}

.semana .card-body{
    flex:1;
    position:relative;
    min-height:0;
}

.semana canvas{
    width:100% !important;
    height:100% !important;
}
.diaria{
    grid-column: span 6;
    grid-row: span 2;
    height:600px;
    display:flex;
    flex-direction:column;
}

.diaria .card-body{
    flex:1;
    position:relative;
    min-height:0;
}

.diaria canvas{
    width:100% !important;
    height:100% !important;
}

.tempo{
    grid-column: span 6;
    grid-row: span 2;
    height:600px;
    display:flex;
    flex-direction:column;
}

.tempo .card-body{
    flex:1;
    position:relative;
    min-height:0;
}

.tempo canvas{
    width:100% !important;
    height:100% !important;
}


/* ==========================================================
   OCORRÊNCIAS NA OP
   Tabela responsiva com rolagem horizontal.
   COD e DESCRIÇÃO ficam fixos à esquerda.
   TOTAL fica fixo à direita.
   ========================================================== */

.ocorrencia {
    grid-column: span 6;
    grid-row: span 2;
    height: 600px;
    min-height: 0;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    box-sizing: border-box;
}

.ocorrencia .card-body {
    flex: 1;
    min-height: 0;
    display: block;
    padding: 0;
    overflow: hidden;
}

.ocorrencia-tabela-scroll {
    width: 100%;
    height: 100%;
    overflow-x: auto;
    overflow-y: auto;
    scrollbar-width: thin;
}

.ocorrencia table {
    width: max-content;
    min-width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    table-layout: fixed;
    font-size: 11px;
    color: #333;
}

.ocorrencia th {
    height: 25px;
    padding: 3px 4px;
    background: #4DA3F4;
    color: #FFF;
    font-weight: bold;
    text-align: center;
    white-space: nowrap;
    border-right: 1px solid rgba(255,255,255,.55);
    border-bottom: 1px solid #FFF;
    position: sticky;
    top: 0;
    z-index: 10;
}

.ocorrencia td {
    height: 23px;
    padding: 2px 4px;
    text-align: center;
    white-space: nowrap;
    border-right: 1px solid #E0E0E0;
    border-bottom: 1px solid #E0E0E0;
    background: #FFF;
}

.ocorrencia tbody tr:nth-child(even):not(.linha-total) td {
    background: #F5F5F5;
}

.ocorrencia tbody tr:not(.linha-total):hover td {
    background: #EAF4FD;
}

.ocorrencia .col-cod {
    width: 40px;
    min-width: 40px;
    max-width: 40px;
}

.ocorrencia .col-descricao {
    width: 175px;
    min-width: 175px;
    max-width: 175px;
    text-align: left;
}

.ocorrencia .col-dia {
    width: 30px;
    min-width: 30px;
    max-width: 30px;
}

.ocorrencia .col-total {
    width: 70px;
    min-width: 70px;
    max-width: 70px;
}

.ocorrencia .fixo-cod {
    position: sticky;
    left: 0;
    z-index: 8;
}

.ocorrencia .fixo-descricao {
    position: sticky;
    left: 40px;
    z-index: 8;
    box-shadow: 3px 0 5px rgba(0,0,0,.06);
}

.ocorrencia thead tr:nth-child(2) th {
    top: 25px;
}

.ocorrencia thead .fixo-cod,
.ocorrencia thead .fixo-descricao,
.ocorrencia thead .fixo-total {
    background: #4DA3F4;
    z-index: 20;
}

.ocorrencia .fixo-total {
    position: sticky;
    right: 0;
    z-index: 8;
    box-shadow: -3px 0 5px rgba(0,0,0,.08);
}

.ocorrencia .linha-total td {
    background: #4DA3F4 !important;
    color: #FFF;
    font-weight: bold;
    border-color: #FFF;
}

.ocorrencia .linha-total .fixo-cod,
.ocorrencia .linha-total .fixo-descricao,
.ocorrencia .linha-total .fixo-total {
    background: #4DA3F4 !important;
}

.ocorrencia .dados-ocorrencia {
    display: none;
}

/* ==========================================================
   CARD - OCORRÊNCIAS
   ========================================================== */

.card-ocorrencias {
    height: 100%;
    min-height: 0;

    display: flex;
    flex-direction: column;
}


/* ==========================================================
   CORPO DO CARD
   ========================================================== */

.card-ocorrencias .card-body {
    flex: 1 1 auto;

    min-height: 0;

    display: flex;
    flex-direction: column;

    padding: 0;
}


/* ==========================================================
   CONTAINER DA TABELA
   ========================================================== */

.card-ocorrencias .tabela-container {
    flex: 1 1 auto;

    min-height: 0;

    width: 100%;
    height: 100%;

    display: flex;
    flex-direction: column;

    overflow: hidden;
}


/* ==========================================================
   ÁREA DE ROLAGEM
   ========================================================== */

.card-ocorrencias .tabela-scroll {
    flex: 1 1 auto;

    min-height: 0;

    width: 100%;
    height: 100%;

    overflow-x: auto;
    overflow-y: auto;
}


/* ==========================================================
   TABELA
   ========================================================== */

.card-ocorrencias .tabela-minutos {
    width: max-content;
    min-width: 100%;
}

@media (max-width: 768px) {

    .ocorrencia {
        height: 600px;
    }

    .ocorrencia table {
        font-size: 10px;
    }

    .ocorrencia .col-cod {
        width: 35px;
        min-width: 35px;
        max-width: 35px;
    }

    .ocorrencia .col-descricao {
        width: 145px;
        min-width: 145px;
        max-width: 145px;
    }

    .ocorrencia .col-dia {
        width: 28px;
        min-width: 28px;
        max-width: 28px;
    }

    .ocorrencia .col-total {
        width: 65px;
        min-width: 65px;
        max-width: 65px;
    }

    .ocorrencia .fixo-descricao {
        left: 35px;
    }
}

@media (max-width: 480px) {

    .ocorrencia .col-descricao {
        width: 130px;
        min-width: 130px;
        max-width: 130px;
    }

    .ocorrencia .fixo-descricao {
        left: 35px;
    }
}


.plano {
  grid-column: span 6;
  grid-row: span 2;      /* ocupa altura de dois cards */
  max-height: 600px;     /* limite de altura */
  overflow-y: auto;      /* rolagem vertical */
  overflow-x: auto;      /* rolagem horizontal */
  box-sizing: border-box;
}

.plano table {
  width: 100%;
  table-layout: fixed;   /* força ajuste das colunas */
}

.plano th, .plano td {
  word-wrap: break-word;
  white-space: normal;
}

.qualidade{
    grid-column: span 6;
    grid-row: span 2;
    height:600px;
    display:flex;
    flex-direction:column;
}

.qualidade .card-body{
    flex:1;
    position:relative;
    min-height:0;
}

.qualidade canvas{
    width:100% !important;
    height:100% !important;
}


.perdas{

  grid-column:span 6;
  grid-row: span 2;
  max-height: 600px;     /* limite de altura */
  overflow-y: auto;      /* rolagem vertical */
  overflow-x: auto;      /* rolagem horizontal */
  box-sizing: border-box;

}

.perdas table {
  width: 100%;
  table-layout: fixed;   /* força ajuste das colunas */
}

.perdas th, .perdas td {
  word-wrap: break-word;
  white-space: normal;
}

.ranking{

  grid-column:span 6;
  grid-row: span 2;
  max-height: 600px;     /* limite de altura */
  overflow-y: auto;      /* rolagem vertical */
  overflow-x: auto;      /* rolagem horizontal */
  box-sizing: border-box;

}

.ranking table {
  width: 100%;
  table-layout: fixed;   /* força ajuste das colunas */
}

.ranking th, .ranking td {
  word-wrap: break-word;
  white-space: normal;
}


.manutencao{

  grid-column:span 6;
  grid-row: span 2;
  max-height: 600px;     /* limite de altura */
  overflow-y: auto;      /* rolagem vertical */
  overflow-x: auto;      /* rolagem horizontal */
  box-sizing: border-box;

}

.manutencao table {
  width: 100%;
  table-layout: fixed;   /* força ajuste das colunas */
}

.manutencao th, .manutencao td {
  word-wrap: break-word;
  white-space: normal;
}

.rotinas{

grid-column:span 12;
min-height:120px;

}

/*****************************************************
                TABELAS
*****************************************************/

table{

width:100%;
border-collapse:collapse;
font-size:13px;

}

thead{

background:#4DA3F4;
color:white;

}

th,td{

padding:7px;

border:1px solid #DDD;

}

tbody tr:nth-child(even){

background:#F5F5F5;

}

tbody tr:hover{

background:#DDEEFF;

}

/*****************************************************
                CANVAS
*****************************************************/

canvas{

width:100%!important;
height:auto; /*180px!important;*/

}

/*****************************************************
            ROTINAS
*****************************************************/

.rotinas-grid{

display:grid;

grid-template-columns:

repeat(auto-fit,minmax(180px,1fr));

gap:10px;

padding:10px;

}

.rotina{

background:#F8F8F8;

padding:8px;

border-radius:5px;

border:1px solid #DDD;

text-align:center;

font-size:13px;

}

/*****************************************************
            RESPONSIVO
*****************************************************/

@media(max-width:1100px){

.eficiencia,
.semana,
.diaria,
.tempo,
.ocorrencia,
.plano,
.qualidade,
.perdas,
.ranking,
.manutencao{

grid-column:span 12;

}

}

</style>

</head>

<body>

<snk:query var="cabecalho">
    SELECT UPPER(
            w.opcao || ' - ' ||
            TO_CHAR(
            TRUNC(:P_XDT),
            'MONTH/YYYY',
            'NLS_DATE_LANGUAGE=PORTUGUESE'
            )
            )AS DESCRICAO
    FROM tddopc w
    WHERE w.nucampo = 9999990191
    AND TO_CHAR(w.valor, 'FM00') = :XSETOR
</snk:query>

<snk:query var="qualityQuery">
    WITH base AS
    (SELECT DISTINCT qld.idiproc,
	        coalesce(qld.qtdreprovada, 0) AS qtdreprovado,
            coalesce(qld.qtdretida, 0) AS qtdretido,
            coalesce(qld.qtdnotificada, 0) AS qtdnotificado
        FROM ad_qualihaiala qld
        INNER JOIN tpriatv atv
            ON qld.idiproc = atv.idiproc
        INNER JOIN tpripa ipa
            ON qld.idiproc = ipa.idiproc
        INNER JOIN tgfpro pro
            ON ipa.codprodpa = pro.codprod
        INNER JOIN tprapo apo
            ON atv.idiatv = apo.idiatv
        WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(TRUNC(:P_XDT), -1)) + 1) AND last_day(TRUNC(:P_XDT))
        AND (coalesce(qld.qtdreprovada, 0) + coalesce(qld.qtdretida, 0) + coalesce(qld.qtdnotificada, 0)) > 0
        AND to_char(coalesce(qld.setor_def, pro.ad_set_producao), 'FM00') = :XSETOR),
    tipos AS
    (SELECT 'REPROVADO' AS tipo FROM dual
        UNION ALL
        SELECT 'RETIDO' FROM dual
        UNION ALL
        SELECT 'NOTIFICADO' FROM dual)
    SELECT t.tipo, coalesce(SUM(val.valor), 0) AS vlr
        FROM tipos t
        LEFT JOIN (SELECT tipo, valor
        FROM base unpivot(valor FOR tipo IN(qtdreprovado AS 'REPROVADO', qtdretido AS 'RETIDO', qtdnotificado AS 'NOTIFICADO'))) val
        ON t.tipo = val.tipo
    GROUP BY t.tipo
</snk:query>

<snk:query var="eficienciaQuery">
WITH golpes AS
 (SELECT pro.codprod,
         pro.ad_golpes AS golpes
    FROM tgfpro pro
   WHERE coalesce(pro.ad_golpes, 0) > 0),
base_producao AS
 (SELECT trunc(apo.dhapo) AS dhapo,
         CASE
            WHEN :XSETOR = '04' THEN
             SUM(apf.qtd) * gol.golpes
            ELSE
             SUM(apf.qtd)
         END AS qtd,
         coalesce((SELECT SUM(mpc.meta) AS meta
                    FROM ad_metapcp mpc
                   WHERE mpc.dataprod = trunc(apo.dhapo)
                     AND to_char(mpc.setor, 'FM00') = :XSETOR), 0) AS meta
    FROM tpriproc ord
   INNER JOIN tpriatv atv
      ON ord.idiproc = atv.idiproc
   INNER JOIN tpripa ipa
      ON atv.idiproc = ipa.idiproc
   INNER JOIN tprapo apo
      ON atv.idiatv = apo.idiatv
   INNER JOIN tprapf apf
      ON apo.nuapo = apf.nuapo
   INNER JOIN tgfpro pro
      ON ipa.codprodpa = pro.codprod
    LEFT JOIN golpes gol
      ON ipa.codprodpa = gol.codprod
   WHERE to_char(apo.dhapo, 'YYYY') = to_char(trunc(:P_XDT), 'YYYY')
     AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
   GROUP BY trunc(apo.dhapo),
            gol.golpes),
/*producao_anual AS
 (SELECT to_char(dhapo, 'YYYY') AS anomes,
         SUM(meta) AS meta,
         SUM(qtd) AS qtd
    FROM base_producao
   GROUP BY to_char(dhapo, 'YYYY')),*/
producao_mensal AS
 (SELECT to_char(dhapo, 'YYYYMM') AS anomes,
         SUM(meta) AS meta,
         SUM(qtd) AS qtd
    FROM base_producao
   GROUP BY to_char(dhapo, 'YYYYMM')),
meses AS
 (SELECT to_char(trunc(:P_XDT), 'YYYY') || to_char(LEVEL, 'FM00') AS anomes,
         to_char(to_date(LEVEL, 'MM'), 'MON') AS mesano
    FROM dual
  CONNECT BY LEVEL <= 12),
resultado AS
 (/*SELECT 1 AS ordem,
         pa.anomes,
         'ANO' AS mesano,
         pa.meta,
         pa.qtd,
         CASE
            WHEN pa.meta = 0 THEN
             0
            ELSE
             (pa.qtd / pa.meta) * 100
         END AS perc
    FROM producao_anual pa
  UNION ALL
  -- Separador
  SELECT 2    AS ordem,
         NULL AS anomes,
         NULL AS mesano,
         NULL AS meta,
         NULL AS qtd,
         NULL AS perc
    FROM dual
  UNION ALL*/
  -- Produção Mensal
  SELECT 3 AS ordem,
         m.anomes,
         m.mesano,
         coalesce(pm.meta, 0) AS meta,
         coalesce(pm.qtd, 0) AS qtd,
         CASE
            WHEN coalesce(pm.meta, 0) = 0 THEN
             0
            ELSE
             (coalesce(pm.qtd, 0) / coalesce(pm.meta, 0)) * 100
         END AS perc
    FROM meses m
    LEFT JOIN producao_mensal pm
      ON m.anomes = pm.anomes)
SELECT mesano,
       meta,
       qtd,
       perc
  FROM resultado
 ORDER BY ordem,
          anomes

</snk:query>

<snk:query var = "mediaSemanaQuery">

    WITH golpes AS
 (SELECT pro.codprod,
         pro.ad_golpes AS golpes
    FROM tgfpro pro
   WHERE coalesce(pro.ad_golpes, 0) > 0),
semanas AS
 (SELECT DISTINCT to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'IW') AS iw FROM dual CONNECT BY LEVEL <= to_number(to_char(last_day(trunc(:P_XDT)), 'DD'))),
dados_brutos AS
 (SELECT to_char(apo.dhapo, 'IW') AS semana,
         trunc(apo.dhapo) AS dia,
         CASE
            WHEN :XSETOR = '04' THEN
             apf.qtd * gol.golpes
            ELSE
             apf.qtd
         END AS qtd
    FROM tpriproc ord
   INNER JOIN tpriatv atv
      ON ord.idiproc = atv.idiproc
   INNER JOIN tpripa ipa
      ON atv.idiproc = ipa.idiproc
   INNER JOIN tprapo apo
      ON atv.idiatv = apo.idiatv
   INNER JOIN tprapf apf
      ON apo.nuapo = apf.nuapo
   INNER JOIN tgfpro pro
      ON ipa.codprodpa = pro.codprod
    LEFT JOIN golpes gol
	   ON ipa.codprodpa = gol.codprod
   WHERE trunc(apo.dhapo) BETWEEN last_day(add_months(trunc(:P_XDT), -1)) + 1 AND last_day(trunc(:P_XDT))
     AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR),
dados_consolidados AS
 (SELECT semana,
         COUNT(DISTINCT dia) AS dias,
         SUM(qtd) AS qtd
    FROM dados_brutos
   GROUP BY semana),
metas AS
 (SELECT to_char(mpc.dataprod, 'IW') AS semana,
         mpc.setor,
         mpc.pessoas,
         SUM(mpc.meta) AS meta,
         mpc.turno
    FROM ad_metapcp mpc
   WHERE mpc.dataprod BETWEEN last_day(add_months(trunc(:P_XDT), -1)) + 1 AND last_day(trunc(:P_XDT))
     AND to_char(mpc.setor, 'FM00') = :XSETOR
   GROUP BY to_char(mpc.dataprod, 'IW'),
            mpc.setor,
            mpc.pessoas,
            mpc.turno
   ORDER BY to_char(mpc.dataprod, 'IW'))
SELECT s.iw,
       row_number() over (ORDER BY s.iw) || 'ª SEM' AS semana_label,
       nvl(round(dc.qtd / nullif(dc.dias, 0), 2), 0) AS qtd_media,
       nvl(round(mt.meta / nullif(dc.dias, 0), 2), 0) AS met_media
  FROM semanas s
  LEFT JOIN dados_consolidados dc
    ON s.iw = dc.semana
  LEFT JOIN metas mt
    ON s.iw = mt.semana
 ORDER BY s.iw

</snk:query>

<snk:query var = "producaoDiariaQuery">

WITH golpes AS
 (SELECT pro.codprod,
         pro.ad_golpes AS golpes
    FROM tgfpro pro
   WHERE coalesce(pro.ad_golpes, 0) > 0),
dias_mes AS
 (SELECT to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'DD') AS d,
         to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'DD') || '-' ||
         to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'DY', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS dia
    FROM dual
   WHERE to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'D') IN (2, 3, 4, 5, 6, 7) -- exclui domingo
  CONNECT BY LEVEL <= to_number(to_char(last_day(trunc(:P_XDT)), 'DD'))),
dados_producao AS
 (SELECT to_char(apo.dhapo, 'DD') AS dia,
         CASE
            WHEN :XSETOR = '04' THEN
             SUM(apf.qtd * gol.golpes)
            ELSE
             SUM(apf.qtd)
         END AS qtd
    FROM tpriproc ord
   INNER JOIN tpriatv atv
      ON ord.idiproc = atv.idiproc
   INNER JOIN tpripa ipa
      ON atv.idiproc = ipa.idiproc
   INNER JOIN tprapo apo
      ON atv.idiatv = apo.idiatv
   INNER JOIN tprapf apf
      ON apo.nuapo = apf.nuapo
   INNER JOIN tgfpro pro
      ON ipa.codprodpa = pro.codprod
    LEFT JOIN golpes gol
      ON ipa.codprodpa = gol.codprod
   WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(trunc(:P_XDT), -1)) + 1) AND last_day(trunc(:P_XDT))
     AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
   GROUP BY to_char(apo.dhapo, 'DD')),
metasdiaria AS
 (SELECT to_char(mpc.dataprod, 'DD') AS dia,
         mpc.setor,
         mpc.pessoas,
         SUM(mpc.meta) AS meta
    FROM ad_metapcp mpc
   WHERE mpc.dataprod BETWEEN last_day(add_months(trunc(:P_XDT), -1)) + 1 AND last_day(trunc(:P_XDT))
     AND to_char(mpc.setor, 'FM00') = :XSETOR
   GROUP BY to_char(mpc.dataprod, 'DD'),
            mpc.setor,
            mpc.pessoas)
SELECT dm.dia AS d,
       coalesce(dp.qtd, 0) AS qtd,
       coalesce(md.meta, 0) AS met
  FROM dias_mes dm
  LEFT JOIN dados_producao dp
    ON dm.d = dp.dia
  LEFT JOIN metasdiaria md
    ON dm.d = md.dia
 ORDER BY dm.d

</snk:query>

<snk:query var="ocorrenciaOPQuery">

    /*
     * ============================================================
     * OCORRÊNCIAS NA OP - QTE MINUTOS POR DIA
     *
     * Retorna uma linha por classificação, com os minutos
     * distribuídos nas colunas correspondentes ao dia do mês.
     * ============================================================
     */
    WITH
    parametros AS
    (
        SELECT TRUNC(:P_XDT, 'MM') AS dt_inicio,
               LAST_DAY(:P_XDT) AS dt_fim,
               :XSETOR AS setor
          FROM dual
    ),

    dias_mes AS
    (
        SELECT p.dt_inicio + LEVEL - 1 AS dt_dia,
               TO_CHAR(
                   p.dt_inicio + LEVEL - 1,
                   'DD'
               ) AS dia,
               TO_CHAR(
                   p.dt_inicio + LEVEL - 1,
                   'DD'
               ) || '-' ||
               TO_CHAR(
                   p.dt_inicio + LEVEL - 1,
                   'DY',
                   'NLS_DATE_LANGUAGE=PORTUGUESE'
               ) AS dia_descricao
          FROM parametros p
        CONNECT BY LEVEL <= (p.dt_fim - p.dt_inicio + 1)
    ),

    mtp_ativos AS
    (
        SELECT mtp.codmtp,
               COALESCE(
                   REPLACE(
                       REPLACE(
                           REPLACE(
                               mtp.descricao,
                               ' DE MÁQUINA / FERRAMENTA / GABARITO',
                               ''
                           ),
                           ' NO ',
                           ' '
                       ),
                       ' DE ',
                       ' '
                   ),
                   'TOTAIS'
               ) AS descricao
          FROM tprmtp mtp
         WHERE mtp.ativo = 'S'
    ),

    mtp_formatado AS
    (
        SELECT codmtp,
               INITCAP(descricao) AS descricao
          FROM mtp_ativos
    ),

    cnc_apontamentos AS
    (
        SELECT TRUNC(apo.dhapo) AS dt_dia,
               COALESCE(cnc.codmtp, 100) AS codmtp,

               SUM(
                   (cnc.dtfinal - cnc.dtinicio) * 24 * 60
               ) AS minutos

          FROM ad_cnc cnc

          LEFT JOIN tpriatv atv
            ON atv.idiproc = cnc.idiproc

          LEFT JOIN tpripa ipa
            ON ipa.idiproc = cnc.idiproc

          LEFT JOIN tgfpro pro
            ON pro.codprod = ipa.codprodpa

          LEFT JOIN tprapo apo
            ON apo.idiatv = atv.idiatv

         CROSS JOIN parametros p

         WHERE apo.dhapo >= p.dt_inicio
           AND apo.dhapo < p.dt_fim + 1

           /* Exclui domingo */
           AND TRUNC(apo.dhapo)
               - TRUNC(apo.dhapo, 'IW') <> 6

           AND TO_CHAR(
                   pro.ad_set_producao,
                   'FM00'
               ) = p.setor

         GROUP BY TRUNC(apo.dhapo),
                  COALESCE(cnc.codmtp, 100)
    ),

    cnc_por_dia AS
    (
        SELECT dm.dia,
               ca.codmtp,
               ca.minutos
          FROM dias_mes dm

          LEFT JOIN cnc_apontamentos ca
            ON ca.dt_dia = dm.dt_dia
    ),

    minutos_pivot AS
    (
        SELECT codmtp,
               d01_m,
               d02_m,
               d03_m,
               d04_m,
               d05_m,
               d06_m,
               d07_m,
               d08_m,
               d09_m,
               d10_m,
               d11_m,
               d12_m,
               d13_m,
               d14_m,
               d15_m,
               d16_m,
               d17_m,
               d18_m,
               d19_m,
               d20_m,
               d21_m,
               d22_m,
               d23_m,
               d24_m,
               d25_m,
               d26_m,
               d27_m,
               d28_m,
               d29_m,
               d30_m,
               d31_m

          FROM cnc_por_dia

        PIVOT
        (
            SUM(minutos)
            FOR dia IN
            (
                '01' AS d01_m,
                '02' AS d02_m,
                '03' AS d03_m,
                '04' AS d04_m,
                '05' AS d05_m,
                '06' AS d06_m,
                '07' AS d07_m,
                '08' AS d08_m,
                '09' AS d09_m,
                '10' AS d10_m,
                '11' AS d11_m,
                '12' AS d12_m,
                '13' AS d13_m,
                '14' AS d14_m,
                '15' AS d15_m,
                '16' AS d16_m,
                '17' AS d17_m,
                '18' AS d18_m,
                '19' AS d19_m,
                '20' AS d20_m,
                '21' AS d21_m,
                '22' AS d22_m,
                '23' AS d23_m,
                '24' AS d24_m,
                '25' AS d25_m,
                '26' AS d26_m,
                '27' AS d27_m,
                '28' AS d28_m,
                '29' AS d29_m,
                '30' AS d30_m,
                '31' AS d31_m
            )
        )
    )

    SELECT x1.codmtp,
           UPPER(x1.descricao) AS descricao,

           /* ====================================================
              MINUTOS POR DIA
              ==================================================== */

           SUM(COALESCE(x2.d01_m, 0)) AS d01,
           SUM(COALESCE(x2.d02_m, 0)) AS d02,
           SUM(COALESCE(x2.d03_m, 0)) AS d03,
           SUM(COALESCE(x2.d04_m, 0)) AS d04,
           SUM(COALESCE(x2.d05_m, 0)) AS d05,
           SUM(COALESCE(x2.d06_m, 0)) AS d06,
           SUM(COALESCE(x2.d07_m, 0)) AS d07,
           SUM(COALESCE(x2.d08_m, 0)) AS d08,
           SUM(COALESCE(x2.d09_m, 0)) AS d09,
           SUM(COALESCE(x2.d10_m, 0)) AS d10,
           SUM(COALESCE(x2.d11_m, 0)) AS d11,
           SUM(COALESCE(x2.d12_m, 0)) AS d12,
           SUM(COALESCE(x2.d13_m, 0)) AS d13,
           SUM(COALESCE(x2.d14_m, 0)) AS d14,
           SUM(COALESCE(x2.d15_m, 0)) AS d15,
           SUM(COALESCE(x2.d16_m, 0)) AS d16,
           SUM(COALESCE(x2.d17_m, 0)) AS d17,
           SUM(COALESCE(x2.d18_m, 0)) AS d18,
           SUM(COALESCE(x2.d19_m, 0)) AS d19,
           SUM(COALESCE(x2.d20_m, 0)) AS d20,
           SUM(COALESCE(x2.d21_m, 0)) AS d21,
           SUM(COALESCE(x2.d22_m, 0)) AS d22,
           SUM(COALESCE(x2.d23_m, 0)) AS d23,
           SUM(COALESCE(x2.d24_m, 0)) AS d24,
           SUM(COALESCE(x2.d25_m, 0)) AS d25,
           SUM(COALESCE(x2.d26_m, 0)) AS d26,
           SUM(COALESCE(x2.d27_m, 0)) AS d27,
           SUM(COALESCE(x2.d28_m, 0)) AS d28,
           SUM(COALESCE(x2.d29_m, 0)) AS d29,
           SUM(COALESCE(x2.d30_m, 0)) AS d30,
           SUM(COALESCE(x2.d31_m, 0)) AS d31,

           /* ====================================================
              TOTAL DE MINUTOS DO MÊS
              ==================================================== */

           SUM(
               COALESCE(x2.d01_m, 0) +
               COALESCE(x2.d02_m, 0) +
               COALESCE(x2.d03_m, 0) +
               COALESCE(x2.d04_m, 0) +
               COALESCE(x2.d05_m, 0) +
               COALESCE(x2.d06_m, 0) +
               COALESCE(x2.d07_m, 0) +
               COALESCE(x2.d08_m, 0) +
               COALESCE(x2.d09_m, 0) +
               COALESCE(x2.d10_m, 0) +
               COALESCE(x2.d11_m, 0) +
               COALESCE(x2.d12_m, 0) +
               COALESCE(x2.d13_m, 0) +
               COALESCE(x2.d14_m, 0) +
               COALESCE(x2.d15_m, 0) +
               COALESCE(x2.d16_m, 0) +
               COALESCE(x2.d17_m, 0) +
               COALESCE(x2.d18_m, 0) +
               COALESCE(x2.d19_m, 0) +
               COALESCE(x2.d20_m, 0) +
               COALESCE(x2.d21_m, 0) +
               COALESCE(x2.d22_m, 0) +
               COALESCE(x2.d23_m, 0) +
               COALESCE(x2.d24_m, 0) +
               COALESCE(x2.d25_m, 0) +
               COALESCE(x2.d26_m, 0) +
               COALESCE(x2.d27_m, 0) +
               COALESCE(x2.d28_m, 0) +
               COALESCE(x2.d29_m, 0) +
               COALESCE(x2.d30_m, 0) +
               COALESCE(x2.d31_m, 0)
           ) AS total

      FROM mtp_formatado x1

      LEFT JOIN minutos_pivot x2
        ON x2.codmtp = x1.codmtp

     GROUP BY ROLLUP(
         (
             x1.codmtp,
             UPPER(x1.descricao)
         )
     )

     ORDER BY x1.codmtp

</snk:query>

<snk:query var="rankingOSQuery">

    WITH qtdmes AS
    (SELECT coditem,
            REPLACE(REPLACE(descritem, '<', ''), '>', '') AS descritem,
            COUNT(qtdosmes) AS mes
        FROM (SELECT mit.coditem,
                    mit.descmaquina AS descritem,
                    mos.coditem     AS qtdosmes
                FROM ad_mcabos mos
            INNER JOIN ad_msetor mse
                ON mos.codsetor = mse.codsetor
            INNER JOIN ad_mitens mit
                ON mos.coditem = mit.coditem
            WHERE mos.codsetor = (SELECT codsetor
                                    FROM (SELECT x.codsetor,
                                                    translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
                                            FROM ad_msetor x)
                                    WHERE setdescricao = (SELECT CASE
                                                                    WHEN upper(w.opcao) = 'DOBRA' THEN
                                                                    'C.D.M.'
                                                                    ELSE
                                                                    upper(w.opcao)
                                                                END
                                                            FROM tddopc w
                                                            WHERE w.nucampo = 9999990191
                                                            AND to_char(w.valor, 'FM00') = :XSETOR))
                AND to_char(mos.dtos, 'YYYYMM') = to_char(trunc(:P_XDT), 'YYYYMM'))
    GROUP BY coditem,
                descritem),
    qtdano AS
    (SELECT coditem,
            REPLACE(REPLACE(descritem, '<', ''), '>', '') AS descritem,
            COUNT(qtdosano) AS ano
        FROM (SELECT mit.coditem,
                    mit.descmaquina AS descritem,
                    mos.coditem     AS qtdosano
                FROM ad_mcabos mos
            INNER JOIN ad_msetor mse
                ON mos.codsetor = mse.codsetor
            INNER JOIN ad_mitens mit
                ON mos.coditem = mit.coditem
            WHERE mos.codsetor = (SELECT codsetor
                                    FROM (SELECT x.codsetor,
                                                    translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
                                            FROM ad_msetor x)
                                    WHERE setdescricao = (SELECT CASE
                                                                    WHEN upper(w.opcao) = 'DOBRA' THEN
                                                                    'C.D.M.'
                                                                    ELSE
                                                                    upper(w.opcao)
                                                                END
                                                            FROM tddopc w
                                                            WHERE w.nucampo = 9999990191
                                                            AND to_char(w.valor, 'FM00') = :XSETOR))
                AND to_char(mos.dtos, 'YYYY') = to_char(trunc(:P_XDT), 'YYYY'))
    GROUP BY coditem,
                descritem)
    SELECT REPLACE(REPLACE(mit.codmaq, '<', ' '), '>', ' ') || ' ' || REPLACE(REPLACE(mit.descmaquina, '<', ''), '>', '') AS descritem,
        coalesce(m.mes, 0) AS mes,
        coalesce(a.ano, 0) AS ano
    FROM ad_mitens mit
    LEFT JOIN qtdmes m
        ON mit.coditem = m.coditem
    LEFT JOIN qtdano a
        ON mit.coditem = a.coditem
    WHERE (coalesce(m.mes, 0) + coalesce(a.ano, 0)) > 0
    ORDER BY coalesce(a.ano, 0)

    </snk:query>

<snk:query var = "manutencaoOSQuery">

    WITH campo_status AS
    (SELECT nucampo
        FROM tddcam
    WHERE nometab = 'AD_MCABOS'
        AND nomecampo = 'STATUSORDEMSERVICO'),
    opcoes_status AS
    (SELECT w.valor,
            upper(w.opcao) AS opcao
        FROM tddopc w
    WHERE w.nucampo = (SELECT nucampo FROM campo_status)
    ORDER BY w.nucampo,
                w.ordem),
    setor_filtrado AS
    (SELECT x.codsetor,
            translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
        FROM ad_msetor x
    WHERE translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') = (SELECT CASE
                                                                WHEN upper(w.opcao) = 'DOBRA' THEN
                                                                'C.D.M.'
                                                                ELSE
                                                                upper(w.opcao)
                                                            END
                                                        FROM tddopc w
                                                        WHERE w.nucampo = 9999990191
                                                        AND to_char(w.valor, 'FM00') = :XSETOR)),
    ordens_servico AS
    (SELECT mos.statusordemservico,
            option_label('AD_MCABOS', 'STATUSORDEMSERVICO', mos.statusordemservico) AS stordemservico,
            coalesce(mos.tpmanutencao, 1) AS codtpmanutencao,
            1 AS qtd -- coluna usada para contagem
        FROM ad_mcabos mos
    INNER JOIN ad_msetor mse
        ON mos.codsetor = mse.codsetor
    WHERE mos.codsetor = (SELECT codsetor FROM setor_filtrado)
        AND trunc(mos.dtos) BETWEEN (last_day(add_months(TRUNC(:P_XDT), -1)) + 1) AND last_day(TRUNC(:P_XDT))),
    dados_pivot AS
    (SELECT *
        FROM (SELECT tp.valor,
                    tp.opcao,
                    pt.codtpmanutencao,
                    pt.qtd
                FROM opcoes_status tp
                LEFT JOIN ordens_servico pt
                ON tp.valor = pt.statusordemservico)
    pivot(SUM(qtd) AS o
        FOR codtpmanutencao IN(1 AS corretiva, 2 AS preventiva, 3 AS programada, 4 AS melhorias))),
    dados_agrupados AS
    (SELECT valor,
            coalesce(opcao, 'TOTAL GERAL') AS opcao,
            SUM(coalesce(corretiva_o, 0)) AS corretiva,
            SUM(coalesce(preventiva_o, 0)) AS preventiva,
            SUM(coalesce(programada_o, 0)) AS programada,
            SUM(coalesce(melhorias_o, 0)) AS melhorias,
            SUM(coalesce(corretiva_o, 0) + coalesce(preventiva_o, 0) + coalesce(programada_o, 0) + coalesce(melhorias_o, 0)) AS total
        FROM dados_pivot
    GROUP BY ROLLUP((valor, opcao)))
    SELECT valor,
        opcao,
        corretiva,
        preventiva,
        programada,
        melhorias,
        total
    FROM dados_agrupados
    
    ORDER BY valor

</snk:query>

<snk:query var = "desperdiciosQuery">

    WITH base_dados AS
    (SELECT nvl(ite.ad_origem_defeito, 0) AS origem_defeito,
            option_label('TGFITE', 'AD_ORIGEM_DEFEITO', ite.ad_origem_defeito) AS origem,
            cab.dtneg,
            cab.nunota,
            cab.codtipoper,
            gru.codgrupoprod,
            CASE
                WHEN substr(gru.codgrupoprod, 1, 1) = 4
                    AND ite.atualestoque = 1 THEN
                0
                ELSE
                ite.atualestoque
            END AS atualestoque,
            (SELECT g.descrgrupoprod
                FROM tgfgru g
            WHERE substr(g.codgrupoprod, 1, 3) = substr(gru.codgrupoprod, 1, 3)
                AND g.grau = 2) AS descgrupoprod,
            ite.codprod,
            pro.descrprod || pro.compldesc AS descprod,
            pro.codvol,
            (ite.qtdneg * CASE
                WHEN substr(gru.codgrupoprod, 1, 1) = 4
                    AND ite.atualestoque = 1 THEN
                0
                ELSE
                ite.atualestoque
            END) AS qtdneg,
            (SELECT cussemicm
                FROM (SELECT rank() over (PARTITION BY cus.codprod ORDER BY cus.dtatual DESC) AS i,
                            cus.codprod,
                            cus.cussemicm
                        FROM tgfcus cus
                    WHERE cus.codprod = ite.codprod
                        AND cus.dtatual <= cab.dtneg)
            WHERE i = 1) AS vlrcus
        FROM tgfcab cab
    INNER JOIN tgfite ite
        ON cab.nunota = ite.nunota
    INNER JOIN tgfpro pro
        ON ite.codprod = pro.codprod
    INNER JOIN tgfgru gru
        ON pro.codgrupoprod = gru.codgrupoprod
    WHERE cab.codtipoper IN (502, 503)
        AND cab.nunota NOT IN (63316)
        AND to_char(ite.ad_origem_defeito, 'FM00') = :XSETOR
        AND to_char(cab.dtneg, 'YYYYMM') = to_char(TRUNC(:P_XDT), 'YYYYMM')),
    movimentos AS
    (SELECT origem_defeito,
            codprod,
            descprod,
            codvol,
            vlrcus,
            CASE
                WHEN atualestoque < 0 THEN
                qtdneg
                ELSE
                0
            END AS saiqtdneg,
            CASE
                WHEN atualestoque < 0 THEN
                (qtdneg * vlrcus)
                ELSE
                0
            END AS saicustotal,
            CASE
                WHEN atualestoque > 0 THEN
                qtdneg
                ELSE
                0
            END AS entqtdneg,
            CASE
                WHEN atualestoque > 0 THEN
                (qtdneg * vlrcus)
                ELSE
                0
            END AS entcustotal
        FROM base_dados),
    custos AS
    (SELECT origem_defeito,
            codprod,
            descprod,
            codvol,
            CASE
                WHEN SUM(saiqtdneg + entqtdneg) <> 0 THEN
                SUM(saicustotal + entcustotal) / SUM(saiqtdneg + entqtdneg)
                ELSE
                0
            END AS custo,
            SUM(saiqtdneg + entqtdneg) AS qtd,
            SUM(saicustotal + entcustotal) AS total
        FROM movimentos
    GROUP BY origem_defeito,
                codprod,
                descprod,
                codvol),
    resumo AS
    (SELECT origem_defeito,
            codprod,
            descprod,
            codvol,
            custo,
            SUM(qtd) AS qtd,
            SUM(total) AS total
        FROM custos
    WHERE qtd <> 0
    GROUP BY ROLLUP(origem_defeito, (codprod, descprod, codvol, custo)))
    SELECT origem_defeito,
        codprod,
        descprod,
        codvol,
        lpad(to_char(CASE
                        WHEN custo IS NULL THEN
                            CASE
                            WHEN qtd <> 0 THEN
                                total / qtd
                            ELSE
                                0
                            END
                        ELSE
                            custo
                        END, 'FM9G990D00'), 8, ' ') AS custo,
        lpad(to_char(qtd, 'FM9G990'), 5, ' ') AS qtd,
        lpad(to_char(total, 'FM9G999G990D00'), 11, ' ') AS total
    FROM resumo
    WHERE origem_defeito IS NOT NULL
    ORDER BY codprod

</snk:query>

<snk:query var="planoAcaoQuery">

    WITH tot AS
    (SELECT (coalesce(adm_x, 0) + coalesce(com_x, 0) + coalesce(ind_x, 0)) AS total_vencida,
            coalesce(adm_x, 0) AS administrativo,
            coalesce(com_x, 0) AS comercial,
            coalesce(ind_x, 0) AS industria
        FROM (SELECT y.cod,
                    coalesce(COUNT(*), 0) i
                FROM ad_gsetor y
                LEFT JOIN ad_ggestao x
                ON y.cod = x.cod
            WHERE trunc(x.dtprazo) < trunc(SYSDATE)
                AND x.status NOT IN (4, 5)
            GROUP BY y.cod)
    pivot(SUM(i) AS x
        FOR cod IN(4 AS adm, 5 AS com, 6 AS ind))),
    qtd AS
    (SELECT x.cod,
            MAX(trunc(SYSDATE) - x.dtprazo) maior,
            COUNT(*) qtd_em_atrazo_area
        FROM ad_ggestao x
    WHERE trunc(x.dtprazo) < trunc(SYSDATE)
        AND x.status <> 5
    GROUP BY x.cod)
    SELECT to_char(dtprazo, 'DD/MM/YYYY') AS dtprazo,
        acao,
        responsavel,
        setor,
        status
    FROM (SELECT t.total_vencida,
                t.administrativo,
                t.comercial,
                t.industria,
                q.qtd_em_atrazo_area,
                q.maior,
                gse.descricao area,
                gge.cod,
                gge.sequencial,
                upper(gge.acao) acao,
                option_label('AD_GGESTAO', 'CLASSIFICACAO', gge.classificacao) classificacao,
                upper(gge.responsavel) responsavel,
                upper(gar.descricao) setor,
                dbms_lob.substr(upper(gge.porque), 4000, 1) porque,
                gge.dtprazo,
                trunc(SYSDATE) - gge.dtprazo dias,
                CASE
                    WHEN (trunc(SYSDATE) - gge.dtprazo) > 0 THEN
                    'VENCIDA A ' || to_char(trunc(SYSDATE) - gge.dtprazo, 'FM990') || ' DIA(S)'
                    WHEN (trunc(SYSDATE) - gge.dtprazo) < 0 THEN
                    'NO PRAZO'
                    WHEN (trunc(SYSDATE) - gge.dtprazo) = 0 THEN
                    'VENCENDO'
                END AS status,
                dbms_lob.substr(upper(gge.observacao1), 4000, 1) observacao,
                dbms_lob.substr(upper(gge.obsevacao2), 4000, 1) novaobservacao
            FROM ad_ggestao gge
            INNER JOIN ad_gsetor gse
                ON gge.cod = gse.cod
            INNER JOIN ad_garea gar
                ON gge.cod = gar.cod
            AND gge.seq = gar.seq
            INNER JOIN qtd q
                ON gge.cod = q.cod
            CROSS JOIN tot t
            WHERE gge.status NOT IN (4, 5)
            AND gge.cod = 6)
    ORDER BY dias DESC

</snk:query>

<snk:query var = "tempoQuery">

WITH dias_mes AS
 (SELECT trunc(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL) AS data_dia,
         to_char(last_day(add_months(trunc(:P_XDT), -1)) + LEVEL, 'DD') AS dia
    FROM dual
  CONNECT BY LEVEL <= to_number(to_char(last_day(trunc(:P_XDT)), 'DD'))),
mtp AS
 (SELECT codmtp,
         CASE
            WHEN codmtp = 14 THEN
             1
            ELSE
             2
         END tipo,
         initcap(REPLACE(REPLACE(REPLACE(descricao, ' DE MÁQUINA / FERRAMENTA / GABARITO', ''), ' NO ', ' '), ' DE ', ' ')) descricao
    FROM tprmtp
   WHERE ativo = 'S'),
tempo_cnc AS
 (SELECT trunc(apo.dhapo) data_dia,
         nvl(cnc.codmtp, 100) codmtp,
         SUM((cnc.dtfinal - cnc.dtinicio) * 24 * 60) tempo
    FROM ad_cnc cnc
    LEFT JOIN tpriatv atv
      ON atv.idiproc = cnc.idiproc
    LEFT JOIN tpripa ipa
      ON ipa.idiproc = cnc.idiproc
    LEFT JOIN tgfpro pro
      ON pro.codprod = ipa.codprodpa
    LEFT JOIN tprapo apo
      ON apo.idiatv = atv.idiatv
   WHERE trunc(apo.dhapo) BETWEEN trunc(:P_XDT, 'MM') AND last_day(:P_XDT)
     AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
   GROUP BY trunc(apo.dhapo),
            nvl(cnc.codmtp, 100)),
tempo_diario AS
 (SELECT d.dia,
         nvl(SUM(CASE
                    WHEN m.tipo = 1 THEN
                     c.tempo
                 END), 0) manutencao,
         nvl(SUM(CASE
                    WHEN m.tipo = 2 THEN
                     c.tempo
                 END), 0) cnc
    FROM dias_mes d
    LEFT JOIN tempo_cnc c
      ON c.data_dia = d.data_dia
    LEFT JOIN mtp m
      ON m.codmtp = c.codmtp
   GROUP BY d.dia)
SELECT dia AS d,
       coalesce(manutencao, 0) AS manu,
       coalesce(cnc, 0) AS cnc,
       greatest(0, 528 - coalesce(manutencao, 0) - coalesce(cnc, 0)) AS prd
  FROM tempo_diario
 ORDER BY dia

</snk:query>

<div class="header">

    <c:forEach items="${cabecalho.rows}" var="row">
        <h1>
            <span>
                <c:out value="${row.DESCRICAO}"/><br>
            </span>
        </h1>
    </c:forEach>

</div>

<div class="dashboard">

<!-- EFICIÊNCIA -->

<div class="card eficiencia">

<div class="card-title">

QUANTIDADE PRODUÇÃO (MENSAL)

</div>

<div class="card-body">

<canvas id="efficiencyChart"></canvas>

</div>

</div>

<!-- SEMANA -->

<div class="card semana">

<div class="card-title">

QTD PRODUZIDA - SEMANA MÉDIA

</div>

<div class="card-body">

<canvas id="productionChart"></canvas>

</div>

</div>

<!-- DIÁRIA -->

<div class="card diaria">

<div class="card-title">

QTD DIÁRIA

</div>

<div class="card-body">

<canvas id="productionChartDia"></canvas>

</div>

</div>

<!-- TEMPO -->

<div class="card tempo">

<div class="card-title">

ALOCAÇÃO DE TEMPO X DISPONIBILIDADE

</div>

<div class="card-body">

<canvas id="graficoTempo"></canvas>

</div>

</div>

<!-- OCORRÊNCIAS -->

<div class="card ocorrencia">

<div class="card-title">
    OCORRÊNCIAS NA OP
</div>

<div class="card-body">

    <div class="ocorrencia-tabela-scroll">

        <table id="tabelaOcorrenciaMinutos">

            <thead>

                <!-- Título -->
                <tr>

                    <th colspan="2" class="titulo-minutos">
                    </th>

                    <th id="tituloDias"
                        class="titulo-minutos">
                        QTE MINUTOS
                    </th>

                    <th class="col-total fixo-total titulo-minutos">
                    </th>

                </tr>

                <!-- Cabeçalho das colunas -->
                <tr id="cabecalhoOcorrencia">

                    <th class="col-cod fixo-cod">
                        COD
                    </th>

                    <th class="col-descricao fixo-descricao">
                        DESCRIÇÃO
                    </th>

                    <th class="col-total fixo-total">
                        TOTAL
                    </th>

                </tr>

            </thead>

            <tbody id="corpoOcorrenciaMinutos">
            </tbody>

        </table>

    </div>

    <!--
         Dados vindos do Oracle.

         A query agora retorna UMA LINHA POR CLASSIFICAÇÃO,
         contendo d01 ... d31 e total.

         O JavaScript utiliza esses campos diretamente para
         montar a matriz responsiva.
    -->
    <div id="dadosOcorrenciaMinutos"
         class="dados-ocorrencia">

        <c:forEach items="${ocorrenciaOPQuery.rows}" var="row">

            <span
                class="ocorrencia-dado"

                data-cod="<c:out value='${row.codmtp}' />"
                data-descricao="<c:out value='${row.descricao}' />"

                data-d01="<c:out value='${row.d01}' />"
                data-d02="<c:out value='${row.d02}' />"
                data-d03="<c:out value='${row.d03}' />"
                data-d04="<c:out value='${row.d04}' />"
                data-d05="<c:out value='${row.d05}' />"
                data-d06="<c:out value='${row.d06}' />"
                data-d07="<c:out value='${row.d07}' />"
                data-d08="<c:out value='${row.d08}' />"
                data-d09="<c:out value='${row.d09}' />"
                data-d10="<c:out value='${row.d10}' />"
                data-d11="<c:out value='${row.d11}' />"
                data-d12="<c:out value='${row.d12}' />"
                data-d13="<c:out value='${row.d13}' />"
                data-d14="<c:out value='${row.d14}' />"
                data-d15="<c:out value='${row.d15}' />"
                data-d16="<c:out value='${row.d16}' />"
                data-d17="<c:out value='${row.d17}' />"
                data-d18="<c:out value='${row.d18}' />"
                data-d19="<c:out value='${row.d19}' />"
                data-d20="<c:out value='${row.d20}' />"
                data-d21="<c:out value='${row.d21}' />"
                data-d22="<c:out value='${row.d22}' />"
                data-d23="<c:out value='${row.d23}' />"
                data-d24="<c:out value='${row.d24}' />"
                data-d25="<c:out value='${row.d25}' />"
                data-d26="<c:out value='${row.d26}' />"
                data-d27="<c:out value='${row.d27}' />"
                data-d28="<c:out value='${row.d28}' />"
                data-d29="<c:out value='${row.d29}' />"
                data-d30="<c:out value='${row.d30}' />"
                data-d31="<c:out value='${row.d31}' />"

                data-total="<c:out value='${row.total}' />">
            </span>

        </c:forEach>

    </div>

</div>

</div>

<!-- PLANO -->

<div class="card plano">

<div class="card-title">

PLANO DE AÇÃO

</div>

<div class="card-body">

<table>

<thead>

<tr>

<th style="width:10%;">Prazo</th>
<th style="width:30%;">Ação</th>
<th style="width:20%;">Responsavel</th>
<th style="width:20%;">Setor</th>
<th style="width:20%;">Status</th>

</tr>

</thead>

<tbody>
    <c:forEach items="${planoAcaoQuery.rows}" var="row">
        <tr>
            <td><c:out value="${row.dtprazo}" /></td>
            <td><c:out value="${row.acao}" /></td>
            <td><c:out value="${row.responsavel}" /></td>
            <td><c:out value="${row.setor}" /></td>
            <td><c:out value="${row.status}" /></td>
        </tr>
    </c:forEach>
</tbody>


</table>

</div>

</div>

<!-- QUALIDADE -->

<div class="card qualidade">

<div class="card-title">

QUALIDADE

</div>

<div class="card-body">

<canvas id="qualityChart"></canvas>

</div>

</div>

<!-- DESPERDÍCIOS -->

<div class="card perdas">

<div class="card-title">

DESPERDÍCIOS / PERDAS

</div>

<div class="card-body">

<table>

<thead>

<tr>

<th style="width:12%;">Codpro</th>
<th style="width:42%;">Descrição</th>
<th style="width:8%;">UN</th>
<th style="width:12%;">Custo</th>
<th style="width:12%;">Qtd</th>
<th style="width:12%;">Total</th>

</tr>

</thead>

<tbody>

    <c:forEach items="${desperdiciosQuery.rows}" var="row">

        <tr>
            <td><c:out value="${row.codprod}" /></td>
            <td><c:out value="${row.descprod}" /></td>
            <td style="text-align:center;"><c:out value="${row.codvol}" /></td>
            <td style="text-align:right;"><c:out value="${row.custo}" /></td>
            <td style="text-align:right;"><c:out value="${row.qtd}" /></td>
            <td style="text-align:right;"><c:out value="${row.total}" /></td>
        </tr>

    </c:forEach>

</tbody>

</table>

</div>

</div>

<!-- RANKING -->

<div class="card ranking">

<div class="card-title">

RANKING DE O.S.

</div>

<div class="card-body">

<table>

<thead>
<tr>
    <th style="width:70%;">Descrição</th>
    <th style="width:15%;">OS Mês</th>
    <th style="width:15%;">OS Ano</th>
</tr>

</thead>

<tbody>

    <c:forEach items="${rankingOSQuery.rows}" var="row">
    
        <tr>
            <td><c:out value="${row.descritem}" /></td>
            <td style="text-align:center;"><c:out value="${row.mes}" /></td>
            <td style="text-align:center;"><c:out value="${row.ano}" /></td>
        </tr>

    </c:forEach>

</tbody>

</table>

</div>

</div>

<!-- MANUTENÇÃO -->

<div class="card manutencao">

<div class="card-title">

MANUTENÇÃO (ORDENS DE SERVIÇO)

</div>

<div class="card-body">

<table>

<thead>

<tr>

<th style="width:30%;">Status</th>
<th style="width:14%;">Corretiva</th>
<th style="width:14%;">Melhoria</th>
<th style="width:14%;">Preventiva</th>
<th style="width:14%;">Programada</th>
<th style="width:14%;">Total</th>

</tr>

</thead>

<tbody>
    <c:forEach items="${manutencaoOSQuery.rows}" var="row">
        <tr>
            <td><c:out value="${row.opcao}" /></td>
            <td style="text-align:center;"><c:out value="${row.corretiva}" /></td>
            <td style="text-align:center;"><c:out value="${row.preventiva}" /></td>
            <td style="text-align:center;"><c:out value="${row.programada}" /></td>
            <td style="text-align:center;"><c:out value="${row.melhorias}" /></td>
            <td style="text-align:center;"><c:out value="${row.total}" /></td>
        </tr>
    </c:forEach>
</tbody>

</table>

</div>

</div>

<!-- ROTINAS -->

<div class="card rotinas">

<div class="card-title">

ROTINAS NO SETOR

</div>

<div class="rotinas-grid">

<div class="rotina">Orientação Time</div>
<div class="rotina">Abastecimento D-1</div>
<div class="rotina">Controle Hora a Hora</div>
<div class="rotina">Segregação Diária</div>
<div class="rotina">Plano de Produção</div>
<div class="rotina">DDS / DDQ</div>
<div class="rotina">Inspeção Pontos Críticos</div>
<div class="rotina">Premiação</div>
<div class="rotina">Pontos de Manutenção</div>
<div class="rotina">Prioridades Produção</div>
<div class="rotina">Treinamento</div>
<div class="rotina">Feedback Individual</div>
<div class="rotina">Auditoria 5S</div>
<div class="rotina">Reunião Operacional</div>
<div class="rotina">Kaizen</div>

</div>

</div>

</div>
<script>
/*************************************************************
 * DASHBOARD PRODUÇÃO
 * Parte 2 - Gráficos
 * Biblioteca: Chart.js
 *************************************************************/

/**
 * Configuração padrão dos gráficos
 */
Chart.defaults.font.family = "Segoe UI";
Chart.defaults.font.size = 12;
Chart.defaults.plugins.legend.display = true;
Chart.defaults.plugins.tooltip.enabled = true;
Chart.defaults.animation.duration = 1200;

/**
 * Cria um gráfico de barras
 */
function criarGrafico(idCanvas, labels, dados, cor) {

    const ctx = document.getElementById(idCanvas);

    new Chart(ctx, {
        type: 'bar',

        data: {
            labels: labels,
            datasets: [{
                data: dados,
                backgroundColor: cor,
                borderRadius: 6,
                borderSkipped: false
            }]
        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            scales: {

                x: {
                    grid: {
                        display: false
                    }
                },

                y: {

                    beginAtZero: true,

                    ticks: {
                        precision: 0
                    }
                }

            }

        }

    });

}

/******************************************************
 * EFICIÊNCIA
 ******************************************************/

const efilabels = [
<c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
'${row.mesano}'<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const efimetas = [
<c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
${row.meta}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const efiqtd = [
<c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
${row.qtd}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const efiperc = [
<c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
${row.perc}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

new Chart(document.getElementById('efficiencyChart'), {

    type: 'bar',

    data: {
        labels: efilabels,

        datasets: [

            //=========================
            // LINHA - METAS
            //=========================
            {
                label: 'Metas',
                type: 'line',
                data: efimetas,

                borderColor: '#4f81bd',
                backgroundColor: '#4f81bd',

                borderWidth: 3,
                fill: false,
                tension: 0.30,

                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#4f81bd',

                order: 1,

                datalabels: {

                    display: true,
                    color: '#4f81bd',
                    anchor: 'end',
                    align: 'top',
                    offset: 10,
                    rotation: 0,
                    formatter: function(value){
                        return value;
                    },

                    font: {
                        family: 'Arial',
                        size: 12,
                        weight: 'bold'
                    }
                }
            },

            //=========================
            // BARRAS - EFICIÊNCIA
            //=========================
            {
                label: 'Qtds',
                data: efiqtd,
                backgroundColor: '#9bbb59',
                order: 2,
                datalabels: {

                    display: function(context){

                        const meta = context.chart.data.datasets[0].data[context.dataIndex];
                        const qtd  = context.dataset.data[context.dataIndex];

                        return Math.abs(meta - qtd) >= 10;
                    },

                    color: 'black',

                    anchor: 'center',

                    align: 'center',
                    rotation: -90,
                    offset: 0,

                    formatter: function(value){
                        return value;
                    },

                    font: {
                        family: 'Arial',
                        size: 12,
                        weight: 'bold'
                    }
                }
            }
        ]
    },

    options: {

        responsive: true,
        maintainAspectRatio: false,

        plugins: {

            legend: {
                display: true
            },

            tooltip: {
                enabled: true
            }

        },

        scales: {

            y: {

                beginAtZero: true,

                ticks: {
                    font: {
                        size: 12
                    }
                }

            },

            x: {

                ticks: {
                    font: {
                        size: 12
                    }
                }

            }

        }

    },

    plugins: [ChartDataLabels]

});


/******************************************************
 * PRODUÇÃO SEMANA MÉDIA
 ******************************************************/

const medsemlabels = [
    <c:forEach items="${mediaSemanaQuery.rows}" var="row" varStatus="loop">
        '${row.semana_label}'<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const mediasemana = [
    <c:forEach items="${mediaSemanaQuery.rows}" var="row" varStatus="loop">
        ${row.qtd_media}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const metasemana = [
    <c:forEach items="${mediaSemanaQuery.rows}" var="row" varStatus="loop">
        ${row.met_media}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

new Chart(document.getElementById('productionChart'), {
    type: 'bar',
    data: {
        labels: medsemlabels,
        datasets: [
            {
                label: 'Media Semanal',
                data: mediasemana,
                backgroundColor: '#9bbb59',

                datalabels: {
                    color: 'black',
                    anchor: 'center',
                    align: 'center',
                    rotation: -90,   // barras continuam na vertical
                    font: {
                        size: 12,
                        weight: 'bold'
                    }
                }
            },
            {
                label: 'Metas',
                type: 'line',
                data: metasemana,
                borderColor: '#4f81bd',
                backgroundColor: '#4f81bd',
                borderWidth: 3,
                fill: false,
                tension: 0.3,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#4f81bd',
                order: 1,

                datalabels: {
                    color: '#4f81bd',
                    anchor: 'end',
                    align: 'top',
                    rotation: 0,          // Horizontal
                    offset: 5,
                    font: {
                        size: 12,
                        weight: 'bold'
                    }
                }
            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                formatter: function(value) {
                    return value;
                }
            }
        }
    }
});


/******************************************************
 * PRODUÇÃO DIÁRIA
 ******************************************************/

const proddialabels = [
    <c:forEach items="${producaoDiariaQuery.rows}" var="row" varStatus="loop">
        '${row.d}'<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const qtddia = [
    <c:forEach items="${producaoDiariaQuery.rows}" var="row" varStatus="loop">
        ${row.qtd}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const metdia = [
    <c:forEach items="${producaoDiariaQuery.rows}" var="row" varStatus="loop">
        ${row.met}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

new Chart(
    document.getElementById('productionChartDia'),
    {
        type: 'bar',
        data: {
            labels: proddialabels,
            datasets: [
                {
                    label: 'Produção Diaria',
                    data: qtddia,
                    backgroundColor: '#9bbb59',

                    datalabels: {
                        color: 'black',
                        anchor: 'center',
                        align: 'center',
                        rotation: -90,   // Valores das barras na vertical
                        font: {
                            size: 12,
                            weight: 'bold',
                            family: 'Arial'
                        }
                    }
                },
                {
                    label: 'Metas',
                    type: 'line',
                    data: metdia,
                    borderColor: '#4f81bd',
                    backgroundColor: '#4f81bd',
                    borderWidth: 3,
                    fill: false,
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    pointBackgroundColor: '#4f81bd',
                    order: 1,

                    datalabels: {
                        color: '#4f81bd',
                        anchor: 'end',
                        align: 'top',
                        rotation: 0,     // Horizontal
                        offset: 5,
                        font: {
                            size: 12,
                            weight: 'bold',
                            family: 'Arial'
                        }
                    }
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                datalabels: {
                    formatter: function(value) {
                        return value;
                    }
                }
            }
        }
    }
);

/******************************************************
 * ALOCAÇÃO DE TEMPO
 ******************************************************/

const dias = [
    <c:forEach items="${tempoQuery.rows}" var="row" varStatus="loop">
        '${row.d}'<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const producao = [
<c:forEach items="${tempoQuery.rows}" var="row" varStatus="loop">
    ${row.prd}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const cnc = [
<c:forEach items="${tempoQuery.rows}" var="row" varStatus="loop">
    ${row.cnc}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const manutencao = [
<c:forEach items="${tempoQuery.rows}" var="row" varStatus="loop">
    ${row.manu}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const ctx = document.getElementById('graficoTempo').getContext('2d');
console.table({
    dias,
    producao,
    cnc,
    manutencao
});
console.log(producao.reduce((a,b)=>a+b,0));
console.log(cnc.reduce((a,b)=>a+b,0));
console.log(manutencao.reduce((a,b)=>a+b,0));
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: dias,
        datasets: [
            {
                label: 'Produção',
                data: producao,
                backgroundColor: '#FFD700',
                borderColor: '#E6B800',
                stack: 'total',
                borderWidth: 1
            },
            {
                label: 'CNC',
                data: cnc,
                backgroundColor: '#B0B0B0',
                borderColor: '#909090',
                stack: 'total',
                borderWidth: 1
            },
            {
                label: 'Manutenção',
                data: manutencao,
                backgroundColor: '#FF8C00',
                borderColor: '#CC7000',
                stack: 'total',
                borderWidth: 1
            }
        ]
    },
    options: {
        responsive: true,
        plugins: {
            title: {
                display: true,
                font: { size: 12 }
            },
            legend: {
                position: 'bottom'
            },
            datalabels: {
                color: '#000',
                anchor: 'end',
                align: 'start',
                rotation: -90,
                font: {
                    weight: 'bold'
                },
                formatter: function(value) {
                    return value;
                }
            }
        },
        scales: {
            x: {
                stacked: true, // empilha no eixo X
                title: {
                    display: true,
                    text: 'Dias'
                }
            },
            y: {
                stacked: true, // empilha no eixo Y
                title: {
                    display: true,
                    text: 'Quantidade'
                },
                beginAtZero: true,
                max: 600
            }
        }
    }
});


/******************************************************
 * QUALIDADE
 ******************************************************/

const labels = [
    <c:forEach items="${qualityQuery.rows}" var="row" varStatus="loop">
        '${row.TIPO}'<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const metas = [
    <c:forEach items="${qualityQuery.rows}" var="row" varStatus="loop">
        ${row.VLR}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

new Chart(
    document.getElementById('qualityChart'),
    {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                data: metas,
                backgroundColor: [
                    '#ef4444',
                    '#f59e0b',
                    '#3b82f6'
                ]
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,

            plugins: {
                legend: {
                    display: false
                },

                datalabels: {
                    color: '#fff',          // branco para aparecer na barra
                    anchor: 'center',
                    align: 'center',

                    font: {
                        size: 16,
                        weight: 'bold'
                    },

                    formatter: function(value) {
                        return value;
                    }
                }
            }
        }
    }
);

</script>
<script>
/**************************************************************
 * DASHBOARD PRODUÇÃO
 * Parte 3 - Preenchimento das Tabelas
 **************************************************************/

/* ============================================================
 * Dados de exemplo
 * ============================================================*/

const ocorrencias = [
    { op: "OP1001", descricao: "Falta de Material", status: "Aberta" },
    { op: "OP1002", descricao: "Troca de Ferramenta", status: "Em Andamento" },
    { op: "OP1003", descricao: "Aguardando Qualidade", status: "Concluída" },
    { op: "OP1004", descricao: "Parada Programada", status: "Concluída" },
    { op: "OP1005", descricao: "Setup Máquina", status: "Aberta" }
];

const planoAcao = [
    { acao: "Treinar Operador", responsavel: "Carlos", prazo: "10/07" },
    { acao: "Revisar Setup", responsavel: "Marcos", prazo: "12/07" },
    { acao: "Comprar Ferramenta", responsavel: "Compras", prazo: "15/07" },
    { acao: "Padronizar Processo", responsavel: "Engenharia", prazo: "18/07" }
];

const perdas = [
    { tipo: "Refugo", qtd: 12, custo: "R$ 820,00" },
    { tipo: "Retrabalho", qtd: 8, custo: "R$ 310,00" },
    { tipo: "Material", qtd: 5, custo: "R$ 540,00" },
    { tipo: "Quebra", qtd: 2, custo: "R$ 1.250,00" }
];

const rankingOS = [
    { os: "OS1001", equipamento: "Prensa 01", status: "Finalizada" },
    { os: "OS1002", equipamento: "Torno CNC", status: "Execução" },
    { os: "OS1003", equipamento: "Laser", status: "Pendente" },
    { os: "OS1004", equipamento: "Ponte Rolante", status: "Finalizada" },
    { os: "OS1005", equipamento: "Compressor", status: "Execução" }
];

const manutencoes = [
    { os: "OS2051", equipamento: "Prensa 03", responsavel: "José", status: "Execução" },
    { os: "OS2052", equipamento: "Centro Usinagem", responsavel: "Pedro", status: "Pendente" },
    { os: "OS2053", equipamento: "Empilhadeira", responsavel: "Lucas", status: "Concluída" },
    { os: "OS2054", equipamento: "Compressor", responsavel: "Rafael", status: "Execução" }
];

/* ============================================================
 * Retorna o HTML do status
 * ============================================================*/
function statusBadge(status) {

    let cor = "#999";

    switch (status.toUpperCase()) {

        case "CONCLUÍDA":
        case "CONCLUIDA":
        case "FINALIZADA":
            cor = "#28a745";
            break;

        case "EXECUÇÃO":
        case "EXECUCAO":
        case "EM ANDAMENTO":
            cor = "#f39c12";
            break;

        case "ABERTA":
        case "PENDENTE":
            cor = "#dc3545";
            break;
    }

    return `
        <span style="
            background:${cor};
            color:#fff;
            padding:3px 8px;
            border-radius:12px;
            font-size:11px;
            font-weight:bold;">
            ${status}
        </span>`;
}

/* ============================================================
 * Preenche uma tabela
 * ============================================================*/
function preencherTabela(idTabela, dados, colunas) {

    const tbody = document.getElementById(idTabela);

    /* Algumas tabelas antigas podem não existir nesta versão. */
    if (!tbody) {
        return;
    }

    tbody.innerHTML = "";

    dados.forEach(item => {

        const tr = document.createElement("tr");

        colunas.forEach(col => {

            const td = document.createElement("td");

            if (col === "status")
                td.innerHTML = statusBadge(item[col]);
            else
                td.textContent = item[col];

            tr.appendChild(td);

        });

        tbody.appendChild(tr);

    });

}

/* ============================================================
 * Carrega todas as tabelas
 * ============================================================*/

preencherTabela(
    "tbOcorrencias",
    ocorrencias,
    ["Classificação","Freq.","Tempo","%"]
);

preencherTabela(
    "tbPlano",
    planoAcao,
    ["acao","responsavel","prazo"]
);

preencherTabela(
    "tbPerdas",
    perdas,
    ["tipo","qtd","custo"]
);

preencherTabela(
    "tbRanking",
    rankingOS,
    ["os","equipamento","status"]
);

preencherTabela(
    "tbManutencao",
    manutencoes,
    ["os","equipamento","responsavel","status"]
);

</script>
<script>
/**************************************************************
 * OCORRÊNCIAS NA OP
 *
 * A query retorna uma linha por classificação:
 *
 * COD | DESCRIÇÃO | D01 | D02 | ... | D31 | TOTAL
 *
 * O JavaScript somente transforma esse resultado em uma
 * tabela responsiva.
 **************************************************************/

(function montarTabelaOcorrenciaMinutos() {

    const origem = document.querySelectorAll(
        "#dadosOcorrenciaMinutos .ocorrencia-dado"
    );

    const cabecalho = document.getElementById(
        "cabecalhoOcorrencia"
    );

    const corpo = document.getElementById(
        "corpoOcorrenciaMinutos"
    );

    const tituloDias = document.getElementById(
        "tituloDias"
    );

    if (!origem.length || !cabecalho || !corpo) {
        console.warn(
            "OCORRÊNCIAS NA OP: nenhum registro retornado pela query."
        );
        return;
    }


    /* ==========================================================
       Converte número retornado pelo Oracle/JSTL para JavaScript.
       Aceita:
         123
         123.45
         123,45
         vazio / null
       ========================================================== */

    function numero(valor) {

        if (
            valor === null ||
            valor === undefined ||
            valor === ""
        ) {
            return 0;
        }

        const texto = String(valor)
            .trim()
            .replace(",", ".");

        const resultado = Number(texto);

        return Number.isFinite(resultado)
            ? resultado
            : 0;
    }


    /* ==========================================================
       Campos de dias retornados pela query
       ========================================================== */

    const camposDias = [];

    for (let dia = 1; dia <= 31; dia++) {

        camposDias.push(
            "d" +
            String(dia).padStart(2, "0")
        );

    }


    /* ==========================================================
       Transforma cada linha do Oracle em objeto JS
       ========================================================== */

    const dados = Array.from(origem).map(item => {

        const registro = {

            cod:
                item.dataset.cod === ""
                    ? null
                    : numero(item.dataset.cod),

            descricao:
                item.dataset.descricao || "",

            total:
                numero(item.dataset.total),

            dias: {}

        };


        camposDias.forEach(campo => {

            registro.dias[campo] =
                numero(item.dataset[campo]);

        });


        return registro;

    });


    console.log(
        "OCORRÊNCIAS NA OP - registros:",
        dados.length,
        dados
    );


    /* ==========================================================
       O ROLLUP retorna COD/descrição nulos na linha TOTAL.
       Essa linha será apresentada como XX / TOTAL.
       ========================================================== */

    dados.forEach(registro => {

        if (registro.cod === null) {

            registro.cod = 999999;
            registro.descricao = "TOTAL";

        }

    });


    /* ==========================================================
       Ordenação:
       classificações primeiro;
       TOTAL sempre por último.
       ========================================================== */

    dados.sort((a, b) => {

        if (a.cod === 999999) return 1;

        if (b.cod === 999999) return -1;

        return a.cod - b.cod;

    });


    /* ==========================================================
       Limpa linhas antigas criadas pelo JavaScript
       ========================================================== */

    while (
        cabecalho.querySelector(".col-dia")
    ) {

        cabecalho
            .querySelector(".col-dia")
            .remove();

    }


    corpo.innerHTML = "";


    /* ==========================================================
       Cria as 31 colunas dos dias.
       A query já possui d01 até d31.
       ========================================================== */

    for (let dia = 1; dia <= 31; dia++) {

        const th =
            document.createElement("th");

        th.className =
            "col-dia";

        th.textContent =
            dia;

        cabecalho.insertBefore(
            th,
            cabecalho.querySelector(".col-total")
        );

    }


    if (tituloDias) {

        tituloDias.colSpan = 31;

        tituloDias.textContent =
            "QTE MINUTOS";

    }


    /* ==========================================================
       Formatação dos minutos
       ========================================================== */

    function formatarMinutos(valor) {

        valor = numero(valor);

        if (Math.abs(valor) < 0.005) {

            return "";

        }

        return valor.toLocaleString(
            "pt-BR",
            {
                minimumFractionDigits: 0,
                maximumFractionDigits: 2
            }
        );

    }


    /* ==========================================================
       Cria célula
       ========================================================== */

    function criarCelula(
        valor,
        classe
    ) {

        const td =
            document.createElement("td");

        td.className =
            classe || "";

        td.textContent =
            formatarMinutos(valor);

        return td;

    }


    /* ==========================================================
       Cria cada linha
       ========================================================== */

    dados.forEach(registro => {

        const tr =
            document.createElement("tr");


        /* ------------------------------------------------------
           Código
           ------------------------------------------------------ */

        const tdCodigo =
            document.createElement("td");

        tdCodigo.className =
            "col-cod fixo-cod";

        tdCodigo.textContent =
            registro.cod === 999999
                ? "XX"
                : registro.cod;

        tr.appendChild(tdCodigo);


        /* ------------------------------------------------------
           Descrição
           ------------------------------------------------------ */

        const tdDescricao =
            document.createElement("td");

        tdDescricao.className =
            "col-descricao fixo-descricao";

        tdDescricao.textContent =
            registro.cod === 999999
                ? "TOTAL"
                : registro.descricao;

        tr.appendChild(tdDescricao);


        /* ------------------------------------------------------
           Dias 1 até 31
           ------------------------------------------------------ */

        for (let dia = 1; dia <= 31; dia++) {

            const campo =
                "d" +
                String(dia).padStart(2, "0");

            tr.appendChild(
                criarCelula(
                    registro.dias[campo],
                    "col-dia"
                )
            );

        }


        /* ------------------------------------------------------
           Total
           ------------------------------------------------------ */

        tr.appendChild(
            criarCelula(
                registro.total,
                "col-total fixo-total"
            )
        );


        /* ------------------------------------------------------
           Linha TOTAL
           ------------------------------------------------------ */

        if (registro.cod === 999999) {

            tr.classList.add(
                "linha-total"
            );

        }


        corpo.appendChild(tr);

    });


    console.log(
        "OCORRÊNCIAS NA OP - tabela montada com sucesso."
    );

})();
</script>
