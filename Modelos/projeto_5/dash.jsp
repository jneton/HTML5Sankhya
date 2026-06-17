<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
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
    max-width:1500px;
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
    font-size:48px;
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

.diff-warning{
    color:#f59e0b;
    font-weight:700;
}

.diff-danger{
    color:#ef4444;
    font-weight:700;
}

/* RESPONSIVO */

@media(max-width:1024px){

    .table{
        min-width:1000px;
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
        font-size:34px;
    }

    .panel{
        padding:22px;
    }

}

</style>

    <snk:query var="queryPorVendedor">
			SELECT CODVEND, APELIDO, TOTAL,META, META - TOTAL AS DIFERENCA, (CASE WHEN META = 0 THEN 0 ELSE (TOTAL / META) * 100 END) AS PERCENTUAL
                FROM (
                    SELECT TRUNC(CAB.DTFATUR, 'month') as referencia, CAB.CODVEND, VEN.APELIDO, 
                    SUM(CAB.VLRNOTA) AS TOTAL,
                    NVL((SELECT SUM(VALOR) FROM AD_SPMETASV WHERE REFERENCIA =TRUNC(CAB.DTFATUR, 'month') AND CODVEND = CAB.CODVEND   ), 0) AS META
                    FROM TGFCAB CAB
                    INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
                    WHERE CAB.STATUSNOTA = 'L'
                    AND CAB.TIPMOV = 'V'
                    AND TRUNC(CAB.DTFATUR, 'month') = '01/03/2026'
                    GROUP BY TRUNC(CAB.DTFATUR, 'month') , CAB.CODVEND, VEN.APELIDO
                ) A
    </snk:query>

     <snk:query var="queryResumo">
			SELECT 0 AS METAXFATURAMENTO, 0 AS META, 'DANIEL' AS VENDEDOR, 0 AS CLIENTES 
            FROM DUAL
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

        <select class="select">
            <option>Março / 2026</option>
            <option>Fevereiro / 2026</option>
            <option>Janeiro / 2026</option>
        </select>

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
                    <c:out value="${row.METASXFATURAMENTO}" />%
                </div>

                <div class="card-footer">

                    <span class="positive">
                        +8%
                    </span>

                    acima da meta prevista

                </div>

            </div>

            <!-- CARD 2 -->
            <div class="card">

                <div class="card-top">

                    <div class="card-title">
                        Faturamento 12 Meses
                    </div>

                    <div class="icon green">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>

                </div>

                <div class="card-value">
                    R$ <c:out value="${row.META}" />
                </div>

                <div class="card-footer">
                    Crescimento acumulado anual
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

                <div class="card-value" style="font-size:34px;">
                    <c:out value="${row.VENDEDOR}" />
                </div>

                <div class="card-footer">
                    Melhor performance comercial
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
                    <c:out value="${row.CLIENTES}" />
                </div>

                <div class="card-footer">
                    Base ativa de clientes
                </div>

            </div>
        </c:forEach>


    </div>

    <!-- GRÁFICO -->
    <div class="panel">

        <div class="panel-header">

            <div class="panel-title">
                <i class="fa-solid fa-bullseye"></i>
                Metas x Faturamento
            </div>

            <div class="panel-subtitle">
                Comparativo mensal entre meta comercial e faturamento realizado
            </div>

        </div>

        <div class="chart-area">
            <canvas id="salesChart"></canvas>
        </div>

    </div>

    <!-- TABELA -->
    <div class="panel">

        <div class="panel-header">

            <div class="panel-title">
                <i class="fa-solid fa-ranking-star"></i>
                Ranking de Vendedores
            </div>

            <div class="panel-subtitle">
                Performance individual da equipe comercial
            </div>

        </div>

        <table class="table">

            <thead>

                <tr>
                    <th>Vendedor</th>
                    <th>Faturamento</th>
                    <th>Meta</th>
                    <th>Diferença</th>
                    <th>%</th>
                </tr>

            </thead>

            <tbody>

                <c:forEach items="${queryPorVendedor.rows}" var="row">
                    <tr>

                        <td>

                            <div class="user">

                                <div class="avatar">
                                    <c:out value="${row.CODVEND}" />
                                </div>

                                <div class="user-info">
                                    <strong><c:out value="${row.APELIDO}" /></strong>
                                    <!-- <span>Comercial SP</span> -->
                                </div>

                            </div>

                        </td>

                        <td><c:out value="${row.TOTAL}" /></td>

                        <td><c:out value="${row.META}" /></td>

                        <td class="diff-positive">
                            R$ <c:out value="${row.DIFERENCA}" />
                        </td>

                        <td>
                            <span class="badge success">
                                <c:out value="${row.PERCENTUAL}" />
                            </span>
                        </td>

                    </tr>
                </c:forEach>

                

            </tbody>

        </table>

    </div>

</div>

<script>

const ctx = document.getElementById('salesChart');

new Chart(ctx, {

    type:'line',

    data:{

        labels:[
            'Jan',
            'Fev',
            'Mar',
            'Abr',
            'Mai',
            'Jun',
            'Jul',
            'Ago',
            'Set',
            'Out',
            'Nov',
            'Dez'
        ],

        datasets:[

            {
                label:'Meta',

                data:[
                    120,
                    140,
                    150,
                    160,
                    170,
                    180,
                    190,
                    200,
                    210,
                    220,
                    230,
                    250
                ],

                borderColor:'#d1d5db',
                backgroundColor:'rgba(209,213,219,0.15)',
                borderWidth:3,
                tension:0.4,
                pointRadius:0,
                fill:true
            },

            {
                label:'Faturamento',

                data:[
                    132,
                    150,
                    164,
                    172,
                    190,
                    188,
                    210,
                    224,
                    235,
                    240,
                    252,
                    278
                ],

                borderColor:'#2563eb',
                backgroundColor:'rgba(37,99,235,0.12)',
                borderWidth:4,
                tension:0.4,
                pointBackgroundColor:'#2563eb',
                pointRadius:4,
                fill:true
            }

        ]

    },

    options:{

        responsive:true,
        maintainAspectRatio:false,

        plugins:{

            legend:{

                position:'top',

                labels:{
                    color:'#374151',
                    font:{
                        family:'Inter',
                        size:13
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
                    color:'#6b7280'
                }

            },

            y:{

                grid:{
                    color:'#eef2f7'
                },

                ticks:{
                    color:'#6b7280'
                }

            }

        }

    }

});

</script>

</body>
</html>