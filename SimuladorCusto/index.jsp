

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simulação de Custos de Produtos - Dashboard</title>
    <style>
        :root {
            --primary-color: #1e293b;
            --secondary-color: #f1f5f9;
            --accent-color: #16a34a;
            --border-color: #cbd5e1;
            --header-bg: #e2e8f0;
            --hover-bg: #f8fafc;
            --text-color: #0f172a;
            --card-bg: #ffffff;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        html, body {
            height: 100vh;
            background-color: var(--secondary-color);
            color: var(--text-color);
            overflow: hidden; /* Evita rolagem na página inteira, mantendo focado no painel */
        }

        /* Container Principal Occupando 100% da tela */
        .app-container {
            display: flex;
            flex-direction: column;
            height: 100vh;
            padding: 12px;
            gap: 12px;
        }

        /* Título e Header Compacto */
        .page-title {
            font-size: 1.1rem;
            color: var(--primary-color);
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Seção de Detalhes do Produto */
        .product-header {
            background-color: var(--card-bg);
            padding: 10px 15px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 8px 15px;
            font-size: 0.82rem;
        }

        .header-item strong {
            color: var(--primary-color);
        }

        .badge {
            display: inline-block;
            padding: 1px 6px;
            font-size: 0.75rem;
            font-weight: bold;
            color: #fff;
            background-color: var(--accent-color);
            border-radius: 3px;
        }

        /* Grid Principal com 4 colunas que ocupam a altura restante */
        .table-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            flex: 1; /* Preenche todo o espaço vertical disponível */
            min-height: 0; /* Permite que o flexbox encolha e ative o scroll */
        }

        /* Card da Tabela */
        .table-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            height: 100%;
            min-height: 0; /* Necessário para scroll interno funcionar */
        }

        /* Cabeçalho de cada Tabela */
        .card-header {
            background-color: var(--primary-color);
            color: #fff;
            padding: 8px 12px;
            font-weight: 600;
            font-size: 0.85rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
        }

        .item-count {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 2px 6px;
            border-radius: 10px;
            font-size: 0.75rem;
        }

        /* Área com Rolagem (Scrollbar) da Tabela */
        .table-wrapper {
            flex: 1;
            overflow-y: auto; /* Barra de rolagem vertical ativada */
            overflow-x: auto; /* Barra de rolagem horizontal se a tela for estreita */
        }

        /* Estilização da Barra de Rolagem */
        .table-wrapper::-webkit-scrollbar {
            width: 7px;
            height: 7px;
        }

        .table-wrapper::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .table-wrapper::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .table-wrapper::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* Tabela */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.8rem;
            text-align: left;
        }

        th {
            position: sticky; /* Mantém o cabeçalho visível durante o scroll */
            top: 0;
            background-color: var(--header-bg);
            color: var(--primary-color);
            font-weight: 600;
            padding: 8px;
            border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
            z-index: 10;
        }

        td {
            padding: 6px 8px;
            border-bottom: 1px solid #f1f5f9;
            white-space: nowrap;
        }

        tbody tr:hover {
            background-color: var(--hover-bg);
        }

        .num-col {
            text-align: right;
        }

        /* Rodapé Fixo da Tabela com Total */
        .table-footer {
            background-color: #f8fafc;
            padding: 8px 12px;
            border-top: 1px solid var(--border-color);
            font-weight: bold;
            font-size: 0.82rem;
            display: flex;
            justify-content: space-between;
            color: var(--primary-color);
        }

        /* Responsividade para Telas Menores */
        @media (max-width: 1200px) {
            html, body {
                overflow: auto; /* Reativa scroll geral apenas em telas menores */
                height: auto;
            }
            .app-container {
                height: auto;
            }
            .table-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .table-card {
                height: 400px; /* Altura fixa quando empilhado em tablets */
            }
        }

        @media (max-width: 768px) {
            .table-grid {
                grid-template-columns: 1fr;
            }
            .table-card {
                height: 350px; /* Altura fixa para smartphones */
            }
        }
    </style>

    <script type='text/javascript'>
		function abrirDetalhes(codprod_mp){
			var params = {'P_CODPRODN2' : P_CODPRODN2};
		}	
	</script>


</head>
<body>

<snk:query var="cabecalho">
SELECT pro.codprod AS codprod,
       pro.referencia AS codvendas,
       (pro.descrprod || pro.compldesc) AS descricao_produto,
       TO_CHAR(TRUNC(:P_XDT), 'DD/MM/YYYY') AS data_base,
       pro.pesobruto,
       upper(option_label('TGFPRO', 'AD_TP_ESTOQUE', pro.ad_tp_estoque)) AS tipo_estoque,
       CASE pro.ativo           WHEN 'S' THEN 'SIM' ELSE 'NÃO' END AS ativo,
       CASE pro.ad_palm         WHEN 'S' THEN 'SIM' ELSE 'NÃO' END AS utiliza_ladix,
       CASE pro.ad_permitevenda WHEN 'S' THEN 'SIM' ELSE 'NÃO' END AS permite_venda,
       upper(CASE :P_TP         WHEN '0' THEN 'Custo Com ICMS'
                                WHEN '1' THEN 'Custo Sem ICMS'
                                WHEN '2' THEN 'Custo Reposição'
                                WHEN '3' THEN 'Custo Variável'
                                WHEN '4' THEN 'Custo Gerencial'
                                WHEN '5' THEN 'Custo Médio'
                                WHEN '6' THEN 'Valor Objetivo'
                                ELSE 'Tipo de Custo Inválido'
             END) AS tipo_custo
  FROM tgfpro pro
 WHERE pro.codprod = :P_CODPROD

</snk:query>

<snk:query var="ultQtdN1">
WITH ult_estrutura AS
 (SELECT codprodpa,
         MAX(idefx) idefx
    FROM tprlmp
	WHERE codprodpa = :P_CODPROD
   GROUP BY codprodpa)
SELECT count(l.codprodmp) as qtd
  FROM tprlmp l
 INNER JOIN ult_estrutura ue
    ON l.idefx = ue.idefx
	AND l.codprodpa = ue.codprodpa
</snk:query>

<snk:query var="custoN1">

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
   WHERE pa.codprod IN (:P_CODPROD)
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

<snk:query var="totalCustoN1">

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
   WHERE pa.codprod IN (:P_CODPROD)
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

<snk:query var="ultQtdN2">
WITH ult_estrutura AS
 (SELECT codprodpa,
         MAX(idefx) idefx
    FROM tprlmp
	WHERE codprodpa = :P_CODPRODN2
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
   WHERE pa.codprod IN (:P_CODPRODN2)
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
   WHERE pa.codprod IN (:P_CODPRODN2)
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
        <!-- Detalhes do Produto -->
        <div class="product-header">
            <c:forEach items="${cabecalho.rows}" var="row">
                <div class="header-item"><strong>Cód. Indústria: </strong><c:out value="${row.codprod}" /></div>
                <div class="header-item"><strong>Cód. Venda: </strong><c:out value="${row.codvendas}" /></div>
                <div class="header-item"><strong>Peso Bruto: </strong><c:out value="${row.pesobruto}" /> kg</div>
                <div class="header-item"><strong>Tipo de Custo: </strong><c:out value="${row.tipo_custo}" /></div>
                <div class="header-item"><strong>Data Base: </strong><c:out value="${row.data_base}" /></div>
                <div class="header-item" style="grid-column: span 2;">
                    <strong>Descrição: </strong> <c:out value="${row.descricao_produto}" />
                </div>
                <div class="header-item">
                    <strong>Ativo: </strong> <span class="badge"><c:out value="${row.ativo}" /></span>
                </div>
            </c:forEach>
        </div>

        <!-- Grid das 4 Tabelas Lado a Lado -->
        <div class="table-grid">

            <!-- Tabela Nível 1 -->
            <div class="table-card">
                <div class="card-header">
                    <c:forEach items="${ultQtdN1.rows}" var="row">
                        <span>Nível 1</span>
                        <span class="item-count"><c:out value="${row.qtd}" /> itens</span>
                    </c:forEach>
                </div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Descrição</th>
                                <th class="num-col">Qtd</th>
                                <th class="num-col">Custo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${custoN1.rows}" var="row">
                                <tr><td><c:out value="${row.codprod_mp}" /></td>
                                    <td><c:out value="${row.descrprod_mp}" /></td>
                                    <td class="num-col"><c:out value="${row.qtd0}" /></td>
                                    <td class="num-col"><c:out value="${row.custo}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="table-footer">
                    <c:forEach items="${totalCustoN1.rows}" var="row">
                        <span>Total:</span>
                        <span>R$ <c:out value="${row.custo}" /></span>
                    </c:forEach>
                </div>
            </div>

            <!-- Tabela Nível 2 -->
            <div class="table-card">
                <div class="card-header">
                    <c:forEach items="${ultQtdN2.rows}" var="row">
                        <span>Nível 2</span>
                        <span class="item-count"><c:out value="${row.qtd}" /> itens</span>
                    </c:forEach>
                </div>
                <div class="table-wrapper">
                    <table>
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
                                <tr><td><c:out value="${row.codprod_mp}" /></td>
                                    <td><c:out value="${row.descrprod_mp}" /></td>
                                    <td class="num-col"><c:out value="${row.qtd0}" /></td>
                                    <td class="num-col"><c:out value="${row.custo}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="table-footer">
                    <c:forEach items="${totalCustoN2.rows}" var="row">
                        <span>Total:</span>
                        <span>R$ <c:out value="${row.custo}" /></span>
                    </c:forEach>
                </div>
            </div>

            <!-- Tabela Nível 3 -->
            <div class="table-card">
                <div class="card-header">
                    <span>Nível 3</span>
                    <span class="item-count">16 itens</span>
                </div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Descrição</th>
                                <th class="num-col">Qtd</th>
                                <th class="num-col">Custo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>464</td><td>DOBRADICA CARREGACAO 3 "</td><td class="num-col">3,0000</td><td class="num-col">1,9200</td></tr>
                            <tr><td>500</td><td>CONTRA TESTA</td><td class="num-col">1,0000</td><td class="num-col">0,3800</td></tr>
                            <tr><td>598</td><td>PORTAL DOB 2150X200 #26 ( P.S.REQ12 )</td><td class="num-col">1,0000</td><td class="num-col">8,1700</td></tr>
                            <tr><td>599</td><td>PORTAL DIR 2150X200 #26 ( P.S.REQ12 )</td><td class="num-col">1,0000</td><td class="num-col">8,1700</td></tr>
                            <tr><td>622</td><td>PORTAL TRAV 810X200 #26 ( P.S.REQ12 )</td><td class="num-col">1,0000</td><td class="num-col">3,0780</td></tr>
                            <tr><td>647</td><td>CAD EST 2085X229 #26</td><td class="num-col">1,0000</td><td class="num-col">9,0725</td></tr>
                            <tr><td>648</td><td>CAD DOB 2085X229 #26</td><td class="num-col">1,0000</td><td class="num-col">9,0725</td></tr>
                            <tr><td>671</td><td>CAD TRAV FECHADA 790X229 #26</td><td class="num-col">2,0000</td><td class="num-col">6,8400</td></tr>
                            <tr><td>725</td><td>PERFIL U TRAVAMENTO 780X35 #24</td><td class="num-col">1,0000</td><td class="num-col">0,5975</td></tr>
                            <tr><td>726</td><td>PERFIL U TRAVAMENTO 810X35 #24</td><td class="num-col">1,0000</td><td class="num-col">0,6205</td></tr>
                            <tr><td>799</td><td>COXINHO 193X56 #26</td><td class="num-col">1,0000</td><td class="num-col">0,2304</td></tr>
                            <tr><td>804</td><td>CHAPA TRAVAMENTO 118X38 #24</td><td class="num-col">1,0000</td><td class="num-col">0,0920</td></tr>
                            <tr><td>836</td><td>SUPORTE PORTA 110X130 #24</td><td class="num-col">1,0000</td><td class="num-col">0,3156</td></tr>
                            <tr><td>913</td><td>PALHETA CANELADA 2275X670 #26</td><td class="num-col">1,0000</td><td class="num-col">29,4657</td></tr>
                            <tr><td>1590</td><td>PERFIL U TRAVAMENTO 118X35 #24</td><td class="num-col">5,0000</td><td class="num-col">0,4347</td></tr>
                            <tr><td>2641</td><td>PERFIL ZEE DA ALÇA 117X47 #24</td><td class="num-col">3,0000</td><td class="num-col">0,3629</td></tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-footer">
                    <span>Total:</span>
                    <span>R$ 78,8224</span>
                </div>
            </div>

            <!-- Tabela Nível 4 -->
            <div class="table-card">
                <div class="card-header">
                    <span>Nível 4</span>
                    <span class="item-count">1 item</span>
                </div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Descrição</th>
                                <th class="num-col">Qtd</th>
                                <th class="num-col">Custo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>1438</td><td>CHAPA ELETROGAL 0,60X35 ( #24 )</td><td class="num-col">0,1349</td><td class="num-col">0,6205</td></tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-footer">
                    <span>Total:</span>
                    <span>R$ 0,6205</span>
                </div>
            </div>

        </div>
    </div>

</body>
</html>