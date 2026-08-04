<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simulação de Custos - Nível 2</title>

    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

    <snk:load/>


<style>
    :root {
        --primary-color: #1e293b;
        --secondary-color: #f1f5f9;
        --border-color: #cbd5e1;
        --header-bg: #e2e8f0;
        --hover-bg: #f8fafc;
        --text-color: #0f172a;
        --card-bg: #ffffff;
        --shadow: 0 4px 6px -1px rgba(0,0,0,.10);
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    html, body {
        width: 100%;
        height: 100%;
        background: var(--secondary-color);
        color: var(--text-color);
        overflow: hidden;
    }

    .app-container {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: 100%;
        padding: 8px;
    }

    .table-card {
        background: var(--card-bg);
        border: 1px solid var(--border-color);
        border-radius: 6px;
        box-shadow: var(--shadow);
        display: flex;
        flex-direction: column;
        width: 100%;
        height: 100%;
        min-height: 0;
    }

    .card-header {
        background: var(--primary-color);
        color: #fff;
        padding: 8px 12px;
        font-weight: 600;
        font-size: .85rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid var(--border-color);
        flex-shrink: 0;
    }

    .item-count {
        background: rgba(255,255,255,.20);
        padding: 2px 6px;
        border-radius: 10px;
        font-size: .75rem;
    }

    .table-wrapper {
        flex: 1;
        min-width: 0;
        min-height: 0;
        overflow-y: auto;
        overflow-x: hidden;
    }

    .table-wrapper::-webkit-scrollbar {
        width: 7px;
    }

    .table-wrapper::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .table-wrapper::-webkit-scrollbar-thumb {
        background: #cbd5e1;
        border-radius: 4px;
    }

    table {
        width: 100%;
        max-width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
        font-size: .76rem;
        text-align: left;
    }

    th {
        position: sticky;
        top: 0;
        background: var(--header-bg);
        color: var(--primary-color);
        font-weight: 600;
        padding: 6px 5px;
        border-bottom: 1px solid var(--border-color);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        z-index: 10;
    }

    td {
        padding: 5px;
        border-bottom: 1px solid #f1f5f9;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* Código menor e descrição maior */
    th:nth-child(1), td:nth-child(1) { width: 12%; }
    th:nth-child(2), td:nth-child(2) { width: 52%; }

    /* Quantidade e custo */
    th:nth-child(3), td:nth-child(3) { width: 17%; }
    th:nth-child(4), td:nth-child(4) { width: 19%; }

    /* Permite quebra de linha na descrição */
    td:nth-child(2) {
        white-space: normal;
        overflow-wrap: anywhere;
        word-break: break-word;
        line-height: 1.2;
        vertical-align: top;
    }

    .num-col {
        text-align: right;
    }

    .linha-produto {
        cursor: pointer;
        transition: background-color .15s ease;
    }

    .linha-produto:hover {
        background: #eaf2ff;
    }

    .linha-produto.selecionada {
        background: #dbeafe;
        font-weight: 600;
    }

    .table-footer {
        background: #f8fafc;
        padding: 8px 12px;
        border-top: 1px solid var(--border-color);
        font-weight: bold;
        font-size: .82rem;
        display: flex;
        justify-content: space-between;
        color: var(--primary-color);
        flex-shrink: 0;
    }

    @media (max-width: 768px) {
        .app-container {
            padding: 5px;
        }

        table {
            font-size: .72rem;
        }

        th, td {
            padding: 5px 4px;
        }
    }
</style>

</head>
<body>

<snk:query var="ultQtdN2">
WITH ult_estrutura AS
 (SELECT codprodpa,
         MAX(idefx) idefx
    FROM tprlmp
	WHERE codprodpa = :P_CODPROD_MP
   GROUP BY codprodpa)
SELECT count(l.codprodmp) as qtd
  FROM tprlmp l
 INNER JOIN ult_estrutura ue
    ON l.idefx = ue.idefx
	AND l.codprodpa = ue.codprodpa
</snk:query>

<snk:query var="custoN2">

WITH parametros AS
 (SELECT trunc(:P_XDT) dt_referencia,
         :P_TP tp_custo
    FROM dual),
ultimo_custo AS
 (SELECT c.codprod,
         MAX(c.dtatual) dtatual
    FROM tgfcus c
   CROSS JOIN parametros p
   WHERE c.dtatual <= p.dt_referencia
   GROUP BY c.codprod),
custo_produto AS
 (SELECT c.codprod,
         CASE p.tp_custo
            WHEN '0' THEN
             c.cusmedicm
            WHEN '1' THEN
             c.cussemicm
            WHEN '2' THEN
             c.cusrep
            WHEN '3' THEN
             c.cusvariavel
            WHEN '4' THEN
             c.cusger
            WHEN '5' THEN
             c.cusmed
            WHEN '6' THEN
             pr.ad_custo_objetivo
            ELSE
             0
         END vl_custo
    FROM tgfcus c
   INNER JOIN ultimo_custo u
      ON u.codprod = c.codprod
     AND u.dtatual = c.dtatual
   INNER JOIN tgfpro pr
      ON pr.codprod = c.codprod
   CROSS JOIN parametros p),
ultima_estrutura AS
 (SELECT codprodpa,
         MAX(idefx) idefx
    FROM tprlmp
   GROUP BY codprodpa),
qtde_estrutura AS
 (SELECT l.codprodpa,
         COUNT(*) AS qt_componentes,
         COUNT(DISTINCT l.codprodmp) AS qt_itens
    FROM tprlmp l
   INNER JOIN ultima_estrutura u
      ON u.codprodpa = l.codprodpa
     AND u.idefx = l.idefx
   GROUP BY l.codprodpa),
estrutura_base AS
 (SELECT gp.codgrupoprod,
         gp.descrgrupoprod,
         pa.codprod,
         pa.referencia,
         pa.descrprod || pa.compldesc AS descrprod,
         pa.pesobruto,
         qe.qt_componentes,
         qe.qt_itens,
         mp.codprod AS codprod_mp,
         mp.descrprod || mp.compldesc AS descrprod_mp,
         mp.codgrupoprod AS codgrupo_mp,
         mp.usoprod,
         lmp.codvol,
         voa.quantidade,
         voa.dividemultiplica,
         SUM(lmp.qtdmistura) AS qtdmistura,
         CASE
            WHEN voa.dividemultiplica = 'M' THEN
             SUM(lmp.qtdmistura * nvl(voa.quantidade, 1))
            ELSE
             SUM(lmp.qtdmistura / nvl(voa.quantidade, 1))
         END AS qtd,
         cp.vl_custo
    FROM tgfpro pa
   INNER JOIN tgfgru gp
      ON gp.codgrupoprod = pa.codgrupoprod
    LEFT JOIN ultima_estrutura ue
      ON ue.codprodpa = pa.codprod
    LEFT JOIN tprlmp lmp
      ON lmp.codprodpa = ue.codprodpa
     AND lmp.idefx = ue.idefx
    LEFT JOIN tgfpro mp
      ON mp.codprod = lmp.codprodmp
    LEFT JOIN tgfvoa voa
      ON voa.codprod = lmp.codprodmp
     AND voa.codvol = lmp.codvol
    LEFT JOIN custo_produto cp
      ON cp.codprod = mp.codprod
    LEFT JOIN qtde_estrutura qe
      ON qe.codprodpa = pa.codprod
   WHERE pa.codprod IN (:P_CODPROD_MP)
   GROUP BY gp.codgrupoprod,
            gp.descrgrupoprod,
            pa.codprod,
            pa.referencia,
            pa.descrprod,
            pa.compldesc,
            pa.pesobruto,
            qe.qt_componentes,
            qe.qt_itens,
            mp.codprod,
            mp.descrprod,
            mp.compldesc,
            mp.codgrupoprod,
            mp.usoprod,
            lmp.codvol,
            voa.quantidade,
            voa.dividemultiplica,
            cp.vl_custo),
nivel_1 AS
 (SELECT e.codgrupoprod,
         e.descrgrupoprod,
         e.codprod,
         e.referencia,
         e.descrprod,
         e.pesobruto,
         e.codprod_mp,
         e.descrprod_mp,
			e.qt_componentes,
         e.qtd            AS qtd0,
         e.vl_custo       AS custo0
    FROM estrutura_base e),
nivel_2 AS
 (SELECT n1.*,
         e.codprod_mp   AS codcomposicao1,
         e.descrprod_mp AS descricaoprod1,
         e.qtd          AS qtd1,
         e.vl_custo     AS custo1
    FROM nivel_1 n1
    LEFT JOIN estrutura_base e
      ON e.codprod = n1.codprod_mp),
nivel_3 AS
 (SELECT n2.*,
         e.codprod_mp   AS codcomposicao2,
         e.descrprod_mp AS descricaoprod2,
         e.qtd          AS qtd2,
         e.vl_custo     AS custo2
    FROM nivel_2 n2
    LEFT JOIN estrutura_base e
      ON e.codprod = n2.codcomposicao1),
nivel_4 AS
 (SELECT n3.*,
         e.codprod_mp   AS codcomposicao3,
         e.descrprod_mp AS descricaoprod3,
         e.qtd          AS qtd3,
         e.vl_custo     AS custo3
    FROM nivel_3 n3
    LEFT JOIN estrutura_base e
      ON e.codprod = n3.codcomposicao2),
nivel_5 AS
 (SELECT n4.*,
         e.codprod_mp   AS codcomposicao4,
         e.descrprod_mp AS descricaoprod4,
         e.qtd          AS qtd4,
         e.vl_custo     AS custo4
    FROM nivel_4 n4
    LEFT JOIN estrutura_base e
      ON e.codprod = n4.codcomposicao3),
custos_calculados AS
 (SELECT n5.codgrupoprod,
         n5.descrgrupoprod,
         n5.codprod,
         n5.referencia,
         n5.descrprod,
         n5.pesobruto,
         n5.codprod_mp,
         n5.descrprod_mp,
         ----------------------------------------------------------------------------
         -- Quantidade do componente principal
         ----------------------------------------------------------------------------
         n5.qtd0,
         ----------------------------------------------------------------------------
         -- Nível 1
         ----------------------------------------------------------------------------
         n5.codcomposicao1,
         n5.descricaoprod1,
         n5.qtd1,
         ----------------------------------------------------------------------------
         -- Nível 2
         ----------------------------------------------------------------------------
         n5.codcomposicao2,
         n5.descricaoprod2,
         n5.qtd2,
         ----------------------------------------------------------------------------
         -- Nível 3
         ----------------------------------------------------------------------------
         n5.codcomposicao3,
         n5.descricaoprod3,
         n5.qtd3,
         ----------------------------------------------------------------------------
         -- Nível 4
         ----------------------------------------------------------------------------
         n5.codcomposicao4,
         n5.descricaoprod4,
         n5.qtd4,
         ----------------------------------------------------------------------------
         -- Custos efetivos
         ----------------------------------------------------------------------------
         coalesce(n5.custo4, n5.custo3) custo4_real,
         coalesce(n5.custo3, n5.custo4, n5.custo2) custo3_real,
         coalesce(n5.custo2, n5.custo3, n5.custo4, n5.custo1) custo2_real,
         coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0) custo1_real,
         ----------------------------------------------------------------------------
         -- Regra especial do grupo 403
         ----------------------------------------------------------------------------
         CASE
            WHEN substr(n5.codgrupoprod, 1, 3) = '403' THEN
             n5.custo0
            ELSE
             coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0)
         END custo0_real,
         ----------------------------------------------------------------------------
         -- Custos Totais
         ----------------------------------------------------------------------------
         n5.qtd3 * coalesce(n5.custo4, n5.custo3) AS tcusto3,
         n5.qtd2 * coalesce(n5.custo3, n5.custo4, n5.custo2) AS tcusto2,
         n5.qtd1 * coalesce(n5.custo2, n5.custo3, n5.custo4, n5.custo1) AS tcusto1,
         n5.qtd0 * CASE
            WHEN substr(n5.codgrupoprod, 1, 3) = '403' THEN
             n5.custo0
            ELSE
             coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0)
         END AS tcusto0
    FROM nivel_5 n5),
resultado AS
 (SELECT codgrupoprod,
         descrgrupoprod,
         codprod,
         referencia,
         descrprod,
         pesobruto,
         codprod_mp,
         descrprod_mp,
         qtd0,
         custo0_real,
         tcusto0
    FROM custos_calculados)
SELECT r.codgrupoprod,
       r.descrgrupoprod,
       r.codprod,
	   qer.qt_componentes,
       r.referencia,
       r.descrprod,
       r.pesobruto,
       r.codprod_mp,
       r.descrprod_mp,
       LPAD(to_char(SUM(r.qtd0), 'FM9G990D0000'), 8, ' ' ) AS qtd0,
       LPAD(to_char(SUM(r.tcusto0), 'FM99G990D0000'), 10, ' ' ) AS custo
  FROM resultado r
  LEFT JOIN qtde_estrutura qer
    ON r.codprod = qer.codprodpa
 GROUP BY r.codgrupoprod,
          r.descrgrupoprod,
          r.codprod,
		  qer.qt_componentes,
          r.referencia,
          r.descrprod,
          r.pesobruto,
          r.codprod_mp,
          r.descrprod_mp,
          r.qtd0
 ORDER BY r.codprod_mp

</snk:query>

<snk:query var="totalCustoN2">

WITH parametros AS
 (SELECT trunc(:P_XDT) dt_referencia,
         :P_TP tp_custo
    FROM dual),
ultimo_custo AS
 (SELECT c.codprod,
         MAX(c.dtatual) dtatual
    FROM tgfcus c
   CROSS JOIN parametros p
   WHERE c.dtatual <= p.dt_referencia
   GROUP BY c.codprod),
custo_produto AS
 (SELECT c.codprod,
         CASE p.tp_custo
            WHEN '0' THEN
             c.cusmedicm
            WHEN '1' THEN
             c.cussemicm
            WHEN '2' THEN
             c.cusrep
            WHEN '3' THEN
             c.cusvariavel
            WHEN '4' THEN
             c.cusger
            WHEN '5' THEN
             c.cusmed
            WHEN '6' THEN
             pr.ad_custo_objetivo
            ELSE
             0
         END vl_custo
    FROM tgfcus c
   INNER JOIN ultimo_custo u
      ON u.codprod = c.codprod
     AND u.dtatual = c.dtatual
   INNER JOIN tgfpro pr
      ON pr.codprod = c.codprod
   CROSS JOIN parametros p),
ultima_estrutura AS
 (SELECT codprodpa,
         MAX(idefx) idefx
    FROM tprlmp
   GROUP BY codprodpa),
qtde_estrutura AS
 (SELECT l.codprodpa,
         COUNT(*) AS qt_componentes,
         COUNT(DISTINCT l.codprodmp) AS qt_itens
    FROM tprlmp l
   INNER JOIN ultima_estrutura u
      ON u.codprodpa = l.codprodpa
     AND u.idefx = l.idefx
   GROUP BY l.codprodpa),
estrutura_base AS
 (SELECT gp.codgrupoprod,
         gp.descrgrupoprod,
         pa.codprod,
         pa.referencia,
         pa.descrprod || pa.compldesc AS descrprod,
         pa.pesobruto,
         qe.qt_componentes,
         qe.qt_itens,
         mp.codprod AS codprod_mp,
         mp.descrprod || mp.compldesc AS descrprod_mp,
         mp.codgrupoprod AS codgrupo_mp,
         mp.usoprod,
         lmp.codvol,
         voa.quantidade,
         voa.dividemultiplica,
         SUM(lmp.qtdmistura) AS qtdmistura,
         CASE
            WHEN voa.dividemultiplica = 'M' THEN
             SUM(lmp.qtdmistura * nvl(voa.quantidade, 1))
            ELSE
             SUM(lmp.qtdmistura / nvl(voa.quantidade, 1))
         END AS qtd,
         cp.vl_custo
    FROM tgfpro pa
   INNER JOIN tgfgru gp
      ON gp.codgrupoprod = pa.codgrupoprod
    LEFT JOIN ultima_estrutura ue
      ON ue.codprodpa = pa.codprod
    LEFT JOIN tprlmp lmp
      ON lmp.codprodpa = ue.codprodpa
     AND lmp.idefx = ue.idefx
    LEFT JOIN tgfpro mp
      ON mp.codprod = lmp.codprodmp
    LEFT JOIN tgfvoa voa
      ON voa.codprod = lmp.codprodmp
     AND voa.codvol = lmp.codvol
    LEFT JOIN custo_produto cp
      ON cp.codprod = mp.codprod
    LEFT JOIN qtde_estrutura qe
      ON qe.codprodpa = pa.codprod
   WHERE pa.codprod IN (:P_CODPROD_MP)
   GROUP BY gp.codgrupoprod,
            gp.descrgrupoprod,
            pa.codprod,
            pa.referencia,
            pa.descrprod,
            pa.compldesc,
            pa.pesobruto,
            qe.qt_componentes,
            qe.qt_itens,
            mp.codprod,
            mp.descrprod,
            mp.compldesc,
            mp.codgrupoprod,
            mp.usoprod,
            lmp.codvol,
            voa.quantidade,
            voa.dividemultiplica,
            cp.vl_custo),
nivel_1 AS
 (SELECT e.codgrupoprod,
         e.descrgrupoprod,
         e.codprod,
         e.referencia,
         e.descrprod,
         e.pesobruto,
         e.codprod_mp,
         e.descrprod_mp,
			e.qt_componentes,
         e.qtd            AS qtd0,
         e.vl_custo       AS custo0
    FROM estrutura_base e),
nivel_2 AS
 (SELECT n1.*,
         e.codprod_mp   AS codcomposicao1,
         e.descrprod_mp AS descricaoprod1,
         e.qtd          AS qtd1,
         e.vl_custo     AS custo1
    FROM nivel_1 n1
    LEFT JOIN estrutura_base e
      ON e.codprod = n1.codprod_mp),
nivel_3 AS
 (SELECT n2.*,
         e.codprod_mp   AS codcomposicao2,
         e.descrprod_mp AS descricaoprod2,
         e.qtd          AS qtd2,
         e.vl_custo     AS custo2
    FROM nivel_2 n2
    LEFT JOIN estrutura_base e
      ON e.codprod = n2.codcomposicao1),
nivel_4 AS
 (SELECT n3.*,
         e.codprod_mp   AS codcomposicao3,
         e.descrprod_mp AS descricaoprod3,
         e.qtd          AS qtd3,
         e.vl_custo     AS custo3
    FROM nivel_3 n3
    LEFT JOIN estrutura_base e
      ON e.codprod = n3.codcomposicao2),
nivel_5 AS
 (SELECT n4.*,
         e.codprod_mp   AS codcomposicao4,
         e.descrprod_mp AS descricaoprod4,
         e.qtd          AS qtd4,
         e.vl_custo     AS custo4
    FROM nivel_4 n4
    LEFT JOIN estrutura_base e
      ON e.codprod = n4.codcomposicao3),
custos_calculados AS
 (SELECT n5.codgrupoprod,
         n5.descrgrupoprod,
         n5.codprod,
         n5.referencia,
         n5.descrprod,
         n5.pesobruto,
         n5.codprod_mp,
         n5.descrprod_mp,
         ----------------------------------------------------------------------------
         -- Quantidade do componente principal
         ----------------------------------------------------------------------------
         n5.qtd0,
         ----------------------------------------------------------------------------
         -- Nível 1
         ----------------------------------------------------------------------------
         n5.codcomposicao1,
         n5.descricaoprod1,
         n5.qtd1,
         ----------------------------------------------------------------------------
         -- Nível 2
         ----------------------------------------------------------------------------
         n5.codcomposicao2,
         n5.descricaoprod2,
         n5.qtd2,
         ----------------------------------------------------------------------------
         -- Nível 3
         ----------------------------------------------------------------------------
         n5.codcomposicao3,
         n5.descricaoprod3,
         n5.qtd3,
         ----------------------------------------------------------------------------
         -- Nível 4
         ----------------------------------------------------------------------------
         n5.codcomposicao4,
         n5.descricaoprod4,
         n5.qtd4,
         ----------------------------------------------------------------------------
         -- Custos efetivos
         ----------------------------------------------------------------------------
         coalesce(n5.custo4, n5.custo3) custo4_real,
         coalesce(n5.custo3, n5.custo4, n5.custo2) custo3_real,
         coalesce(n5.custo2, n5.custo3, n5.custo4, n5.custo1) custo2_real,
         coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0) custo1_real,
         ----------------------------------------------------------------------------
         -- Regra especial do grupo 403
         ----------------------------------------------------------------------------
         CASE
            WHEN substr(n5.codgrupoprod, 1, 3) = '403' THEN
             n5.custo0
            ELSE
             coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0)
         END custo0_real,
         ----------------------------------------------------------------------------
         -- Custos Totais
         ----------------------------------------------------------------------------
         n5.qtd3 * coalesce(n5.custo4, n5.custo3) AS tcusto3,
         n5.qtd2 * coalesce(n5.custo3, n5.custo4, n5.custo2) AS tcusto2,
         n5.qtd1 * coalesce(n5.custo2, n5.custo3, n5.custo4, n5.custo1) AS tcusto1,
         n5.qtd0 * CASE
            WHEN substr(n5.codgrupoprod, 1, 3) = '403' THEN
             n5.custo0
            ELSE
             coalesce(n5.custo1, n5.custo2, n5.custo3, n5.custo4, n5.custo0)
         END AS tcusto0
    FROM nivel_5 n5),
resultado AS
 (SELECT codgrupoprod,
         descrgrupoprod,
         codprod,
         referencia,
         descrprod,
         pesobruto,
         codprod_mp,
         descrprod_mp,
         qtd0,
         custo0_real,
         tcusto0
    FROM custos_calculados)	 
SELECT LPAD(to_char(SUM(r.tcusto0), 'FM99G990D0000'), 10, ' ' ) AS custo
  FROM resultado r
  LEFT JOIN qtde_estrutura qer
    ON r.codprod = qer.codprodpa

</snk:query>

<div class="app-container">
    
        <div class="table-card">
            <div class="card-header">
                <span>Nível 2</span>
                <span class="item-count">
                    <c:forEach items="${ultQtdN2.rows}" var="row">
                        <c:out value="${row.qtd}" /> itens
                    </c:forEach>
                </span>
            </div>

            <div class="table-wrapper">
                <table id="tabelaN2">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Descrição</th>
                            <th class="num-col">Qtd</th>
                            <th class="num-col">Custo</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${custoN2.rows}" var="row">
                            <tr class="linha-produto"
                                data-nivel="2"
                                data-codprod="${row.codprod_mp}">

                                <td>
                                    <c:out value="${row.codprod_mp}" />
                                </td>

                                <td>
                                    <c:out value="${row.descrprod_mp}" />
                                </td>

                                <td class="num-col">
                                    <c:out value="${row.qtd0}" />
                                </td>

                                <td class="num-col">
                                    <c:out value="${row.custo}" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="table-footer">
                <span>Total:</span>
                <span>
                    <c:forEach items="${totalCustoN2.rows}" var="row">
                        R$ <c:out value="${row.custo}" />
                    </c:forEach>
                </span>
            </div>
        </div>

</div>

<script>

document.addEventListener('DOMContentLoaded', function () {

    document.querySelectorAll('#tabelaN2 tbody tr.linha-produto')
        .forEach(function (linha) {

            linha.addEventListener('click', function () {

                const codigo = this.dataset.codprod;

                document.querySelectorAll('#tabelaN2 tbody tr.linha-produto')
                    .forEach(function (item) {
                        item.classList.remove('selecionada');
                    });

                this.classList.add('selecionada');

                console.log('Nível 2 - Código selecionado:', codigo);

                refreshDetails('NIVEL3', {
                    P_CODPROD_MP: codigo
                });
            });
        });
});

</script>
</body>
</html>
