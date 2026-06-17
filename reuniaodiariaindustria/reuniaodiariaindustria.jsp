<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<title>Painel Reunião Diária</title>
	<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/">
</head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<snk:load/>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#f1f3f6;
    color:#333;
}

.header{
    background:#fff;
    padding:15px;
    text-align:center;
    border-bottom:2px solid #d9d9d9;
}

.header h1{
    font-size:38px;
    font-weight:bold;
    color:#3f3f3f;
}

.periodo, .setor {
    display: inline-block;
    margin-right: 10px;
}

.container{
    padding:15px;
}

.dashboard{
    display:grid;
    gap:15px;
}

.top{
    display:grid;
    grid-template-columns:40% 60%;
    gap:15px;
}

.middle{
    display:grid;
    grid-template-columns:20% 20% 30% 30%;
    gap:15px;
}

.bottom{
    display:grid;
    grid-template-columns:40% 60%;
    gap:15px;
}

.card{
    background:#fff;
    border:1px solid #dcdcdc;
    border-radius:4px;
    overflow:hidden;
}

.card-title{
    background:#f4f4f4;
    padding:10px;
    font-weight:bold;
    border-bottom:1px solid #ddd;
}

.card-body{
    padding:10px;
}

.chart-box{
    height:260px;
}

.small-chart{
    height:180px;
}

table{
    width:100%;
    border-collapse:collapse;
    font-size:12px;
}

th{
    background:#f5f5f5;
    padding:6px;
    border:1px solid #ddd;
}

td{
    padding:6px;
    border:1px solid #ddd;
}

.routines{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
}

.routines ul{
    list-style:none;
}

.routines li{
    padding:4px 0;
}

.kpis{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:10px;
    margin-bottom:15px;
}

.kpi{
    background:#fff;
    border:1px solid #ddd;
    border-radius:4px;
    text-align:center;
    padding:15px;
}

.kpi-value{
    font-size:28px;
    font-weight:bold;
    color:#2f5597;
}

.kpi-label{
    margin-top:5px;
    font-size:13px;
}

@media(max-width:1200px){

    .top,
    .middle,
    .bottom{
        grid-template-columns:1fr;
    }

}

@media(max-width:768px){

    .kpis{
        grid-template-columns:1fr 1fr;
    }

    .routines{
        grid-template-columns:1fr;
    }

}

</style>
</head>
<body>

<snk:query var="cabecalho">
        SELECT b.MES || b.ANO AS MESANO,
            a.descset AS DESCRICAO
        FROM (
            SELECT TO_CHAR(w.valor, 'FM00') AS codset,
                w.opcao AS descset
            FROM tddopc w
            WHERE w.nucampo = 9999990191
            AND TO_CHAR(w.valor, 'FM00') = :XSETOR
            ORDER BY TO_CHAR(w.valor, 'FM00')
        ) a
        CROSS JOIN (
            SELECT :XDT AS xdt,
                UPPER(TO_CHAR(:XDT, 'MON')) AS MES,
                UPPER(TO_CHAR(:XDT, 'YYYY')) AS ANO
            FROM dual
        ) b
</snk:query>

<snk:query var="eficiencia">
        WITH base_producao AS
        (SELECT trunc(apo.dhapo) AS dhapo,
                SUM(apf.qtd) AS qtd,
                SUM(apf.qtd * pso.qtdmistura01) AS kg,
                SUM(apf.qtd * pro.ad_golpes) AS golpe,
                coalesce((SELECT mpc.meta
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
            LEFT JOIN (SELECT d.idefx,
                            a.codprod,
                            d.codvol,
                            d.qtdmistura AS qtdmistura01
                        FROM tgfpro a
                    INNER JOIN tgfgru b
                        ON a.codgrupoprod = b.codgrupoprod
                        LEFT JOIN (SELECT d1.codprodpa,
                                        MAX(d1.idefx) idefx
                                    FROM tprlmp d1
                                GROUP BY d1.codprodpa) c
                        ON a.codprod = c.codprodpa
                        LEFT JOIN tprlmp d
                        ON c.codprodpa = d.codprodpa
                        AND c.idefx = d.idefx
                        LEFT JOIN tgfpro e
                        ON d.codprodmp = e.codprod
                        LEFT JOIN tgfvoa f
                        ON d.codprodmp = f.codprod
                        AND d.codvol = f.codvol) pso
            ON ipa.codprodpa = pso.codprod
        WHERE to_char(apo.dhapo, 'YYYY') = to_char(:XDT, 'YYYY')
            AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
        GROUP BY trunc(apo.dhapo)),
        producao_anual AS
        (SELECT to_char(dhapo, 'YYYY') AS anomes,
                SUM(meta) AS meta,
                SUM(qtd) AS qtd
            FROM base_producao
        GROUP BY to_char(dhapo, 'YYYY')),
        producao_mensal AS
        (SELECT to_char(dhapo, 'YYYYMM') AS anomes,
                SUM(meta) AS meta,
                SUM(qtd) AS qtd
            FROM base_producao
        GROUP BY to_char(dhapo, 'YYYYMM')),
        meses AS
        (SELECT to_char(:XDT, 'YYYY') || to_char(LEVEL, 'FM00') AS anomes,
                to_char(to_date(LEVEL, 'MM'), 'MON') AS mesano
            FROM dual
        CONNECT BY LEVEL <= 12),
        resultado AS
        (SELECT 1 AS ordem,
                pa.anomes,
                'ANO' AS mesano,
                pa.meta,
                pa.qtd,
                CASE
                    WHEN pa.meta = 0 THEN
                    0
                    ELSE
                    (pa.qtd / pa.meta)
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
        UNION ALL
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
                    (coalesce(pm.qtd, 0) / coalesce(pm.meta, 0))
                END AS perc
            FROM meses m
            LEFT JOIN producao_mensal pm
            ON m.anomes = pm.anomes)
        -- ========================= RESULTADO FINAL =========================
        SELECT mesano,
            meta,
            qtd,
            perc
        FROM resultado
        ORDER BY ordem,
                anomes
</snk:query>

<div class="header">
    <h1>
                <c:forEach items="${cabecalho.rows}" var="row">
                    <tr>
                        <td>Período: <c:out value="${row.MESANO}" /></td>
                        <td>Setor: <c:out value="${row.DESCRICAO}" /></td>
                    </tr>
                </c:forEach>
    </h1>
</div>

<div class="container">

    <div class="dashboard">

        <!-- TOPO -->

        <div class="top">

            <div class="card">
                <div class="card-title">% EFICIÊNCIA (MENSAL)</div>

                <div class="card-body">
                    <div class="chart-box">
                        <canvas id="efficiencyChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-title">
                    QTD PRODUZIDA (1º TURNO)
                </div>

                <div class="card-body">
                    <div class="chart-box">
                        <canvas id="productionChart"></canvas>
                    </div>
                </div>
            </div>

        </div>

        <!-- MEIO -->

        <div class="middle">

            <div class="card">

                <div class="card-title">
                    QUALIDADE
                </div>

                <div class="card-body">
                    <div class="small-chart">
                        <canvas id="qualityChart"></canvas>
                    </div>
                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    OCORRÊNCIAS NA OP
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Classificação</th>
                            <th>Freq.</th>
                            <th>%</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr><td>Manutenção</td><td>15</td><td>7,5%</td></tr>
                        <tr><td>Retrabalho</td><td>16</td><td>12,5%</td></tr>
                        <tr><td>Falha Abastecimento</td><td>17</td><td>17,5%</td></tr>
                        <tr><td>Setup</td><td>18</td><td>22,5%</td></tr>
                        <tr><td>Ajustes</td><td>19</td><td>27,5%</td></tr>
                        <tr><td>Falta Funcionário</td><td>20</td><td>12,5%</td></tr>
                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    RANKING DE O.S.
                </div>

                <div class="card-body">

                    <table>
                        <thead>
                        <tr>
                            <th>Equipamento</th>
                            <th>Qtd</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr><td>Equipamento Manutenção</td><td>12</td></tr>
                        <tr><td>Máquina Arquear</td><td>6</td></tr>
                        <tr><td>Bomba Centrífuga</td><td>3</td></tr>
                        <tr><td>Queimador</td><td>3</td></tr>
                        <tr><td>Outros</td><td>8</td></tr>
                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    PLANO DE AÇÃO
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Data</th>
                            <th>Ação</th>
                            <th>OS</th>
                            <th>Resp.</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <td>17/03</td>
                            <td>Troca do Manômetro</td>
                            <td>5265</td>
                            <td>Paulo</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

            </div>

        </div>

        <!-- BAIXO -->

        <div class="bottom">

            <div class="card">

                <div class="card-title">
                    MANUTENÇÃO (ORDENS DE SERVIÇO)
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Status</th>
                            <th>Corretiva</th>
                            <th>Melhoria</th>
                            <th>Preventiva</th>
                            <th>Programada</th>
                            <th>Total</th>
                        </tr>
                        </thead>

                        <tbody>

                        <tr>
                            <td>Aguard. Atendimento</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td>1</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>Em Atendimento</td>
                            <td>0</td>
                            <td>1</td>
                            <td>0</td>
                            <td>0</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>Finalizado</td>
                            <td>7</td>
                            <td>0</td>
                            <td>10</td>
                            <td>0</td>
                            <td>17</td>
                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    DESPERDÍCIOS / PERDA
                </div>

                <div class="card-body">

                    <div class="chart-box">
                        <canvas id="lossChart"></canvas>
                    </div>

                </div>

            </div>

        </div>

        <div class="card">

            <div class="card-title">
                ROTINAS NO SETOR
            </div>

            <div class="card-body">

                <div class="routines">

                    <ul>
                        <li>➜ Orientação Time</li>
                        <li>➜ Abastecimento D-1</li>
                        <li>➜ Controle Hora a Hora</li>
                        <li>➜ Segregação Diária</li>
                        <li>➜ Plano Produção</li>
                    </ul>

                    <ul>
                        <li>➜ DDS e DDQ</li>
                        <li>➜ Inspeção Pontos Críticos</li>
                        <li>➜ Premiação</li>
                        <li>➜ Pontos Manutenção</li>
                        <li>➜ Prioridades Produção</li>
                    </ul>

                    <ul>
                        <li>➜ Treinamento</li>
                        <li>➜ Feedback Individual</li>
                    </ul>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

/* EFICIÊNCIA */

/* EFICIÊNCIA */

const labelsEficiencia = [
<c:forEach items="${eficiencia.rows}" var="row" varStatus="status">
    '${row.MESANO}'<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const dadosEficiencia = [
<c:forEach items="${eficiencia.rows}" var="row" varStatus="status">
    ${row.PERC}<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const coresEficiencia = [
<c:forEach items="${eficiencia.rows}" var="row" varStatus="status">
    <c:choose>
        <c:when test="${row.PERC >= 90}">
            '#4f81bd'
        </c:when>
        <c:otherwise>
            '#e67e22'
        </c:otherwise>
    </c:choose>
    <c:if test="${!status.last}">,</c:if>
</c:forEach>
];

new Chart(
    document.getElementById('efficiencyChart'),
    {
        data: {
            labels: labelsEficiencia,
            datasets: [
                {
                    type: 'bar',
                    label: 'Eficiência (%)',
                    data: dadosEficiencia,
                    backgroundColor: coresEficiencia
                },
                {
                    type: 'line',
                    label: 'Meta',
                    data: labelsEficiencia.map(() => 90),
                    borderColor: 'red',
                    borderDash: [8, 5],
                    pointRadius: 0,
                    borderWidth: 2,
                    fill: false
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
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ': ' +
                                   Number(context.raw).toFixed(2) + '%';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 120,
                    ticks: {
                        callback: function(value) {
                            return value + '%';
                        }
                    }
                }
            }
        }
    }
);

/* PRODUÇÃO */

new Chart(
document.getElementById('productionChart'),
{
    type:'bar',
    data:{
        labels:[
            '1S','2S','3S','4S',
            '1','2','5','6',
            '8','9','12','13',
            '14','15','16','19','20'
        ],
        datasets:[{
            data:[
                178,120,134,136,
                180,175,140,122,
                74,144,126,127,
                130,156,131,136,135
            ],
            backgroundColor:'#9bbb59'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false,
        plugins:{
            legend:{
                display:false
            }
        }
    }
});

/* QUALIDADE */

new Chart(
document.getElementById('qualityChart'),
{
    type:'bar',
    data:{
        labels:[
            'Reprovado',
            'Retido',
            'Notificado'
        ],
        datasets:[{
            data:[1,2,5],
            backgroundColor:'#4f81bd'
        }]
    },
    options:{
        indexAxis:'y',
        responsive:true,
        maintainAspectRatio:false,
        plugins:{
            legend:{
                display:false
            }
        }
    }
});

/* DESPERDÍCIOS */

new Chart(
document.getElementById('lossChart'),
{
    type:'bar',
    data:{
        labels:[
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4',
            'Item 5',
            'Item 6'
        ],
        datasets:[{
            label:'R$',
            data:[
                3137,
                3136,
                3135,
                3134,
                3133,
                3132
            ],
            backgroundColor:'#c0504d'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false
    }
});

</script>

</body>
</html>