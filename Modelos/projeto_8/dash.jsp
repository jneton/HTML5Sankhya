<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>

<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<title>Painel Comercial</title>

<snk:load/>

<!-- CHART -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- FONT AWESOME -->
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<!-- FONT -->
<link rel="preconnect" href="https://fonts.googleapis.com">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

:root{

    --bg:#f5f7fb;
    --card:#ffffff;
    --border:#e8edf5;

    --text:#111827;
    --muted:#6b7280;

    --primary:#2563eb;
    --success:#10b981;
    --warning:#f59e0b;
    --danger:#ef4444;

    --shadow:0 10px 30px rgba(15,23,42,0.05);

}

body{
    font-family:'Inter',sans-serif;
    background:var(--bg);
    color:var(--text);
}

.container{
    max-width:1600px;
    margin:auto;
    padding:30px;
}

/* HEADER */

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:28px;
    gap:20px;
    flex-wrap:wrap;
}

.header h1{
    font-size:42px;
    font-weight:800;
    letter-spacing:-2px;
}

.header p{
    margin-top:8px;
    color:var(--muted);
    font-size:15px;
}

.select{
    height:48px;
    padding:0 18px;
    border-radius:16px;
    border:1px solid var(--border);
    background:white;
    font-weight:600;
    outline:none;
    color:var(--text);
    font-size:14px;
}

/* CARDS */

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:22px;
    margin-bottom:24px;
}

.card{
    background:white;
    border:1px solid var(--border);
    border-radius:28px;
    padding:28px;
    box-shadow:var(--shadow);
    transition:0.25s ease;
}

.card:hover{
    transform:translateY(-3px);
}

.card-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

.card-title{
    font-size:15px;
    font-weight:600;
    color:var(--muted);
}

.icon{
    width:54px;
    height:54px;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.icon i{
    font-size:20px;
}

.blue{
    background:rgba(37,99,235,0.10);
    color:#2563eb;
}

.green{
    background:rgba(16,185,129,0.10);
    color:#10b981;
}

.orange{
    background:rgba(245,158,11,0.10);
    color:#f59e0b;
}

.purple{
    background:rgba(139,92,246,0.10);
    color:#8b5cf6;
}

.card-value{
    font-size:38px;
    font-weight:800;
    letter-spacing:-2px;
}

.card-footer{
    margin-top:10px;
    color:var(--muted);
    font-size:14px;
}

.positive{
    color:var(--success);
    font-weight:700;
}

/* PANEL */

.panel{
    background:white;
    border:1px solid var(--border);
    border-radius:32px;
    padding:32px;
    box-shadow:var(--shadow);
    margin-bottom:24px;
}

.panel-header{
    margin-bottom:28px;
}

.panel-title{
    font-size:28px;
    font-weight:800;
    display:flex;
    align-items:center;
    gap:12px;
}

.panel-title i{
    color:var(--primary);
}

.panel-subtitle{
    margin-top:8px;
    font-size:14px;
    color:var(--muted);
}

.chart-area{
    height:420px;
}

/* TABLE */

.table{
    width:100%;
    border-collapse:collapse;
}

.table thead th{
    text-align:left;
    padding-bottom:18px;
    font-size:13px;
    color:var(--muted);
    font-weight:700;
    border-bottom:1px solid var(--border);
}

.table tbody td{
    padding:22px 0;
    border-bottom:1px solid #f1f5f9;
    font-size:14px;
}

.user{
    display:flex;
    align-items:center;
    gap:14px;
}

.avatar{
    width:46px;
    height:46px;
    border-radius:16px;
    background:#eff6ff;
    color:#2563eb;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:700;
}

.user-info{
    display:flex;
    flex-direction:column;
}

.user-info strong{
    font-size:14px;
}

.user-info span{
    font-size:12px;
    color:var(--muted);
    margin-top:2px;
}

.badge{
    padding:8px 14px;
    border-radius:999px;
    font-size:12px;
    font-weight:700;
    display:inline-flex;
    align-items:center;
    justify-content:center;
}

.success{
    background:#ecfdf5;
    color:#059669;
}

.warning{
    background:#fffbeb;
    color:#d97706;
}

.danger{
    background:#fef2f2;
    color:#dc2626;
}

.diff-positive{
    color:#10b981;
    font-weight:700;
}

.diff-danger{
    color:#ef4444;
    font-weight:700;
}

.text-right{
    text-align:right !important;
}

.text-center{
    text-align:center !important;
}

.strong{
    font-weight:700;
}

.ranking-pos{
    font-size:22px;
    font-weight:700;
}

.total-row{
    background:#f8fafc;
}

.total-row td{
    padding-top:28px !important;
    padding-bottom:28px !important;
    font-weight:800;
    border-bottom:none !important;
}

/* RESPONSIVO */

@media(max-width:1200px){

    .table{
        min-width:1200px;
    }

    .panel{
        overflow:auto;
    }

}

@media(max-width:768px){

    .container{
        padding:18px;
    }

    .header h1{
        font-size:32px;
    }

    .card-value{
        font-size:28px;
    }

    .panel{
        padding:22px;
    }

}

</style>

<!-- QUERY RESUMO -->
<snk:query var="queryResumo">

WITH VENDAS AS (

    SELECT

        CAB.CODVEND,
         (CASE WHEN CAB.CODVEND = 0 THEN 'SEM NOME'  ELSE VEN.APELIDO END) AS APELIDO,

        SUM(CAB.VLRNOTA) AS TOTAL,

        NVL((
            SELECT SUM(META.VALOR)
            FROM AD_SPMETASV META
            WHERE META.CODVEND = CAB.CODVEND
            AND META.REFERENCIA = TRUNC(CAB.DTFATUR,'MONTH')
        ),0) AS META,

        COUNT(DISTINCT CAB.CODPARC) AS CLIENTES

    FROM TGFCAB CAB

    INNER JOIN TGFVEN VEN
        ON VEN.CODVEND = CAB.CODVEND

    WHERE CAB.STATUSNOTA = 'L'
    AND CAB.TIPMOV = 'V'
    AND TRUNC(CAB.DTFATUR,'MONTH') BETWEEN :P_PERIODO.INI AND :P_PERIODO.FIN

    GROUP BY
        CAB.CODVEND,
        VEN.APELIDO,
        TRUNC(CAB.DTFATUR,'MONTH')

),

RESUMO AS (

    SELECT

        ROUND(
            CASE
                WHEN SUM(META) = 0 THEN 0
                ELSE (SUM(TOTAL) / SUM(META)) * 100
            END
        ,2) AS METAXFATURAMENTO,

        ROUND(SUM(TOTAL),2) AS FATURAMENTO,

        SUM(CLIENTES) AS CLIENTES

    FROM VENDAS

),

TOPVENDEDOR AS (

    SELECT APELIDO

    FROM (

        SELECT
            APELIDO,
            TOTAL

        FROM VENDAS

        ORDER BY TOTAL DESC

    )

    WHERE ROWNUM = 1

)

SELECT

    R.METAXFATURAMENTO,
    R.FATURAMENTO,
    T.APELIDO AS VENDEDOR,
    R.CLIENTES

FROM RESUMO R
CROSS JOIN TOPVENDEDOR T

</snk:query>

<!-- QUERY RANKING -->
<snk:query var="queryPorVendedor">

WITH VENDAS AS (

    SELECT

        TRUNC(CAB.DTFATUR,'MONTH') AS REFERENCIA,

        CAB.CODVEND,
        (CASE WHEN CAB.CODVEND = 0 THEN 'SEM NOME'  ELSE VEN.APELIDO END) AS APELIDO,

        SUM(CAB.VLRNOTA) AS FATURAMENTO,

        NVL((
            SELECT SUM(META.VALOR)
            FROM AD_SPMETASV META
            WHERE META.CODVEND = CAB.CODVEND
            AND META.REFERENCIA = TRUNC(CAB.DTFATUR,'MONTH')
        ),0) AS META,

        COUNT(DISTINCT CAB.CODPARC) AS CLIENTES

    FROM TGFCAB CAB

    INNER JOIN TGFVEN VEN
        ON VEN.CODVEND = CAB.CODVEND

    WHERE CAB.STATUSNOTA = 'L'
    AND CAB.TIPMOV = 'V'
    AND TRUNC(CAB.DTFATUR,'MONTH')  BETWEEN :P_PERIODO.INI AND :P_PERIODO.FIN

    GROUP BY
        TRUNC(CAB.DTFATUR,'MONTH'),
        CAB.CODVEND,
        VEN.APELIDO

)

SELECT

    ROW_NUMBER() OVER (
        ORDER BY FATURAMENTO DESC
    ) AS POSICAO,

    CODVEND,
    APELIDO,

    ROUND(FATURAMENTO,2) AS FATURAMENTO,

    ROUND(META,2) AS META,

    ROUND(FATURAMENTO - META,2) AS DIFERENCA,

    ROUND(
        CASE
            WHEN META = 0 THEN 0
            ELSE (FATURAMENTO / META) * 100
        END
    ,2) AS PERCENTUAL,

    CLIENTES

FROM VENDAS

ORDER BY FATURAMENTO DESC

</snk:query>

<!-- QUERY GRÁFICO -->
<snk:query var="queryGrafico">

WITH MESES AS (

    SELECT
        LEVEL AS MES,
        ADD_MONTHS(TRUNC(SYSDATE,'YEAR'), LEVEL - 1) AS DATAREF
    FROM DUAL
    CONNECT BY LEVEL <= 12

),

FATURAMENTO AS (

    SELECT

        TRUNC(CAB.DTFATUR,'MONTH') AS REFERENCIA,

        SUM(CAB.VLRNOTA) AS FATURAMENTO

    FROM TGFCAB CAB

    WHERE CAB.STATUSNOTA = 'L'
    AND CAB.TIPMOV = 'V'
     AND TRUNC(CAB.DTFATUR,'MONTH')  BETWEEN :P_PERIODO.INI AND :P_PERIODO.FIN

    GROUP BY
        TRUNC(CAB.DTFATUR,'MONTH')

),

METAS AS (

    SELECT

        REFERENCIA,

        SUM(VALOR) AS META

    FROM AD_SPMETASV

    GROUP BY REFERENCIA

)

SELECT

    TO_CHAR(M.DATAREF,'MON') AS MES,

    NVL(F.FATURAMENTO,0) AS FATURAMENTO,

    NVL(MT.META,0) AS META

FROM MESES M

LEFT JOIN FATURAMENTO F
    ON F.REFERENCIA = M.DATAREF

LEFT JOIN METAS MT
    ON MT.REFERENCIA = M.DATAREF

ORDER BY M.DATAREF

</snk:query>

</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="header">

        <div>

            <h1>Painel Comercial</h1>

            <p>
                Dashboard executivo de performance comercial
            </p>

        </div>

    </div>

    <!-- CARDS -->
    <div class="cards">

        <c:forEach items="${queryResumo.rows}" var="row">

            <!-- CARD 1 -->
            <div class="card">

                <div class="card-top">

                    <div class="card-title">
                        Metas x Faturamento
                    </div>

                    <div class="icon blue">
                        <i class="fa-solid fa-bullseye"></i>
                    </div>

                </div>

                <div class="card-value">

                    <fmt:formatNumber
                        value="${row.METAXFATURAMENTO}"
                        type="number"
                        minFractionDigits="1"
                    />%

                </div>

                <div class="card-footer">
                    Performance Comercial
                </div>

            </div>

            <!-- CARD 2 -->
            <div class="card">

                <div class="card-top">

                    <div class="card-title">
                        Faturamento do Mês
                    </div>

                    <div class="icon green">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>

                </div>

                <div class="card-value" style="font-size:32px;">

                    R$

                    <fmt:formatNumber
                        value="${row.FATURAMENTO}"
                        type="number"
                        minFractionDigits="2"
                    />

                </div>

                <div class="card-footer">
                    Total faturado no período
                </div>

            </div>

            <!-- CARD 3 -->
            <div class="card">

                <div class="card-top">

                    <div class="card-title">
                        Melhor Vendedor
                    </div>

                    <div class="icon orange">
                        <i class="fa-solid fa-trophy"></i>
                    </div>

                </div>

                <div class="card-value" style="font-size:28px;">
                    ${row.VENDEDOR}
                </div>

                <div class="card-footer">
                    Maior faturamento do mês
                </div>

            </div>

            <!-- CARD 4 -->
            <div class="card">

                <div class="card-top">

                    <div class="card-title">
                        Clientes Ativos
                    </div>

                    <div class="icon purple">
                        <i class="fa-solid fa-users"></i>
                    </div>

                </div>

                <div class="card-value">
                    ${row.CLIENTES}
                </div>

                <div class="card-footer">
                    Clientes distintos faturados
                </div>

            </div>

        </c:forEach>

    </div>

    <!-- GRÁFICO -->
    <div class="panel">

        <div class="panel-header">

            <div class="panel-title">
                <i class="fa-solid fa-chart-column"></i>
                Metas x Faturamento
            </div>

            <div class="panel-subtitle">
                Evolução comercial mensal
            </div>

        </div>

        <div class="chart-area">
            <canvas id="salesChart"></canvas>
        </div>

    </div>

    <!-- RANKING -->
    <div class="panel">

        <div class="panel-header">

            <div class="panel-title">
                <i class="fa-solid fa-ranking-star"></i>
                Ranking de Vendedores
            </div>

            <div class="panel-subtitle">
                Performance comercial consolidada
            </div>

        </div>

        <table class="table">

            <thead>

                <tr>

                    <th>#</th>
                    <th>Vendedor</th>

                    <th class="text-right">
                        Faturamento
                    </th>

                    <th class="text-right">
                        Meta
                    </th>

                    <th class="text-right">
                        Diferença
                    </th>

                    <th class="text-center">
                        %
                    </th>

                    <th class="text-center">
                        Clientes
                    </th>

                </tr>

            </thead>

            <tbody>

            <c:set var="totalFat" value="${0}" />
            <c:set var="totalMeta" value="${0}" />
            <c:set var="totalCli" value="${0}" />

            <c:forEach items="${queryPorVendedor.rows}" var="row">

                <c:set var="totalFat" value="${totalFat + row.FATURAMENTO}" />
                <c:set var="totalMeta" value="${totalMeta + row.META}" />
                <c:set var="totalCli" value="${totalCli + row.CLIENTES}" />

                <tr>

                    <!-- POSIÇÃO -->
                    <td>

                        <div class="ranking-pos">

                            <c:choose>

                                <c:when test="${row.POSICAO == 1}">
                                    🥇
                                </c:when>

                                <c:when test="${row.POSICAO == 2}">
                                    🥈
                                </c:when>

                                <c:when test="${row.POSICAO == 3}">
                                    🥉
                                </c:when>

                                <c:otherwise>
                                    ${row.POSICAO}
                                </c:otherwise>

                            </c:choose>

                        </div>

                    </td>

                    <!-- VENDEDOR -->
                    <td>

                        <div class="user">

                            <div class="avatar">
                                ${row.CODVEND}
                            </div>

                            <div class="user-info">

                                <strong>
                                    ${row.APELIDO}
                                </strong>

                                <span>
                                    Código ${row.CODVEND}
                                </span>

                            </div>

                        </div>

                    </td>

                    <!-- FATURAMENTO -->
                    <td class="text-right strong">

                        R$

                        <fmt:formatNumber
                            value="${row.FATURAMENTO}"
                            type="number"
                            minFractionDigits="2"
                        />

                    </td>

                    <!-- META -->
                    <td class="text-right">

                        R$

                        <fmt:formatNumber
                            value="${row.META}"
                            type="number"
                            minFractionDigits="2"
                        />

                    </td>

                    <!-- DIFERENÇA -->
                    <td class="text-right">

                        <span class="${row.DIFERENCA >= 0 ? 'diff-positive' : 'diff-danger'}">

                            <fmt:formatNumber
                                value="${row.DIFERENCA}"
                                type="number"
                                minFractionDigits="2"
                            />

                        </span>

                    </td>

                    <!-- % -->
                    <td class="text-center">

                        <span class="
                            badge
                            ${row.PERCENTUAL >= 100 ? 'success' : 'warning'}
                        ">

                            <fmt:formatNumber
                                value="${row.PERCENTUAL}"
                                type="number"
                                minFractionDigits="1"
                            />%

                        </span>

                    </td>

                    <!-- CLIENTES -->
                    <td class="text-center">
                        ${row.CLIENTES}
                    </td>

                </tr>

            </c:forEach>

            <!-- TOTAL -->

            <tr class="total-row">

                <td colspan="2">
                    TOTAL GERAL
                </td>

                <td class="text-right">

                    R$

                    <fmt:formatNumber
                        value="${totalFat}"
                        type="number"
                        minFractionDigits="2"
                    />

                </td>

                <td class="text-right">

                    R$

                    <fmt:formatNumber
                        value="${totalMeta}"
                        type="number"
                        minFractionDigits="2"
                    />

                </td>

                <td class="text-right">

                    R$

                    <fmt:formatNumber
                        value="${totalFat - totalMeta}"
                        type="number"
                        minFractionDigits="2"
                    />

                </td>

                <td class="text-center">

                    <span class="badge success">

                        <fmt:formatNumber
                            value="${(totalFat / totalMeta) * 100}"
                            type="number"
                            minFractionDigits="1"
                        />%

                    </span>

                </td>

                <td class="text-center">
                    ${totalCli}
                </td>

            </tr>

            </tbody>

        </table>

    </div>

</div>

<script>

const labels = [
<c:forEach items="${queryGrafico.rows}" var="row" varStatus="loop">
    '${row.MES}'<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const metas = [
<c:forEach items="${queryGrafico.rows}" var="row" varStatus="loop">
    ${row.META}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const faturamento = [
<c:forEach items="${queryGrafico.rows}" var="row" varStatus="loop">
    ${row.FATURAMENTO}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

const ctx = document.getElementById('salesChart');

new Chart(ctx, {

    type:'bar',

    data:{

        labels: labels,

        datasets:[

            {
                label:'Meta',

                data: metas,

                backgroundColor:'rgba(209,213,219,0.55)',
                borderRadius:10,
                borderSkipped:false
            },

            {
                label:'Faturamento',

                data: faturamento,

                backgroundColor:'rgba(37,99,235,0.85)',
                borderRadius:10,
                borderSkipped:false
            }

        ]

    },

    options:{

        responsive:true,
        maintainAspectRatio:false,

        interaction:{
            intersect:false,
            mode:'index'
        },

        plugins:{

            legend:{

                position:'top',

                labels:{
                    color:'#374151',
                    usePointStyle:true,
                    pointStyle:'circle',
                    padding:20,

                    font:{
                        family:'Inter',
                        size:13,
                        weight:'600'
                    }
                }

            },

            tooltip:{

                backgroundColor:'#111827',
                padding:14,
                cornerRadius:12,

                callbacks:{

                    label:function(context){

                        return context.dataset.label + ': R$ ' +

                        Number(context.raw).toLocaleString('pt-BR', {
                            minimumFractionDigits:2
                        });

                    }

                }

            }

        },

        scales:{

            x:{

                grid:{
                    display:false
                },

                ticks:{
                    color:'#6b7280',

                    font:{
                        weight:'600'
                    }
                }

            },

            y:{

                beginAtZero:true,

                grid:{
                    color:'#eef2f7'
                },

                ticks:{

                    color:'#6b7280',

                    callback:function(value){
                        return 'R$ ' + value.toLocaleString('pt-BR');
                    }

                }

            }

        }

    }

});

</script>

</body>
</html>