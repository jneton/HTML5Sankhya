<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>PAINEL DE REUNIÃO DIARIA</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<snk:load/>

<style>

:root{
    --bg:#edf1f5;
    --card:#ffffff;
    --header:#d9e1ea;
    --border:#d7dce2;
    --text:#1f2937;
    --shadow:0 2px 10px rgba(0,0,0,.08);
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Segoe UI,Tahoma,sans-serif;
    background:var(--bg);
    color:var(--text);
}

.header{
    background:var(--header);
    padding:20px;
    text-align:center;
    border-bottom:3px solid #94a3b8;
}

.header h1{
    font-size:2rem;
    font-weight:700;
}

.dashboard{
    padding:15px;

    display:grid;
    grid-template-columns:repeat(12,1fr);
    gap:15px;
}

.card{
    background:var(--card);
    border:1px solid var(--border);
    border-radius:10px;
    overflow:hidden;
    box-shadow:var(--shadow);
}

.card-header{
    padding:10px 15px;
    background:#f8fafc;
    border-bottom:1px solid var(--border);
}

.card-header h3{
    font-size:14px;
    text-transform:uppercase;
}

.card-body{
    padding:15px;
}

.span-5{
    grid-column:span 5;
}

.span-7{
    grid-column:span 7;
}

.span-3{
    grid-column:span 3;
}

.span-4{
    grid-column:span 4;
}

.span-6{
    grid-column:span 6;
}

.span-12{
    grid-column:span 12;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th{
    background:#f1f5f9;
}

table th,
table td{
    border:1px solid #e5e7eb;
    padding:8px;
    font-size:12px;
}

table tbody tr:hover{
    background:#f8fafc;
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
    margin-bottom:8px;
}

.routines li::before{
    content:"➜ ";
    color:#2563eb;
}

.table-scroll{
    max-height:260px;
    overflow:auto;
}

canvas{
    width:100% !important;
    height:280px !important;
}

@media(max-width:1200px){

    .dashboard{
        grid-template-columns:repeat(6,1fr);
    }

    .span-5,
    .span-7{
        grid-column:span 6;
    }

    .span-3{
        grid-column:span 3;
    }

    .span-4{
        grid-column:span 6;
    }

    .span-6{
        grid-column:span 6;
    }
}

@media(max-width:768px){

    .dashboard{
        grid-template-columns:1fr;
    }

    .span-3,
    .span-4,
    .span-5,
    .span-6,
    .span-7,
    .span-12{
        grid-column:span 1;
    }

    .routines{
        grid-template-columns:1fr;
    }

    canvas{
        height:250px !important;
    }

    .header h1{
        font-size:1.4rem;
    }
}

</style>

    <snk:query var="cabecalho">
        SELECT upper(to_char(:XDT, 'MON/YYYY')) AS ANOMES,
               w.opcao AS DESCRICAO
          FROM tddopc w
         WHERE w.nucampo = 9999990191
           AND to_char(w.valor, 'FM00') = :XSETOR
         ORDER BY to_char(w.valor, 'FM00')
    </snk:query>


</head>

<body>

<header class="header">

    <c:forEach items="${cabecalho.rows}" var="row">
        <h1>
            <td>
                <c:out value="${row.DESCRICAO}" />
            </td>
        </h1>
    </c:forEach>

</header>

<div class="dashboard">

    <!-- EFICIÊNCIA -->

    <section class="card span-5">
        <div class="card-header">
            <h3>% Eficiência (Mensal)</h3>
        </div>

        <div class="card-body">
            <canvas id="efficiencyChart"></canvas>
        </div>
    </section>

    <!-- PRODUÇÃO -->

    <section class="card span-7">
        <div class="card-header">
            <h3>Qte Produzida (1º Turno)</h3>
        </div>

        <div class="card-body">
            <canvas id="productionChart"></canvas>
        </div>
    </section>

    <!-- QUALIDADE -->

    <section class="card span-3">
        <div class="card-header">
            <h3>Qualidade</h3>
        </div>

        <div class="card-body">
            <canvas id="qualityChart"></canvas>
        </div>
    </section>

    <!-- OCORRÊNCIAS -->

    <section class="card span-3">
        <div class="card-header">
            <h3>Ocorrências na OP</h3>
        </div>

        <div class="card-body">

            <table>
                <thead>
                <tr>
                    <th>Classificação</th>
                    <th>Freq.</th>
                    <th>Tempo</th>
                    <th>%</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td>Manutenção</td>
                    <td>15</td>
                    <td>01:30</td>
                    <td>7,5%</td>
                </tr>

                <tr>
                    <td>Retrabalho</td>
                    <td>16</td>
                    <td>02:30</td>
                    <td>12,5%</td>
                </tr>

                <tr>
                    <td>Setup</td>
                    <td>18</td>
                    <td>04:30</td>
                    <td>22,5%</td>
                </tr>

                <tr>
                    <td>Ajustes</td>
                    <td>19</td>
                    <td>05:30</td>
                    <td>27,5%</td>
                </tr>
                </tbody>
            </table>

        </div>
    </section>

    <!-- RANKING -->

    <section class="card span-3">
        <div class="card-header">
            <h3>Ranking de O.S.</h3>
        </div>

        <div class="card-body">

            <table>
                <thead>
                <tr>
                    <th>Descrição</th>
                    <th>Qtd</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td>Equipamento Manutenção</td>
                    <td>12</td>
                </tr>

                <tr>
                    <td>Máquina de Arquear</td>
                    <td>6</td>
                </tr>

                <tr>
                    <td>Bomba Centrífuga</td>
                    <td>4</td>
                </tr>

                <tr>
                    <td>Outros</td>
                    <td>8</td>
                </tr>
                </tbody>
            </table>

        </div>
    </section>

    <!-- PLANO DE AÇÃO -->

    <section class="card span-3">
        <div class="card-header">
            <h3>Plano de Ação</h3>
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
                    <td>17/Mar</td>
                    <td>Troca do Manômetro</td>
                    <td>5265</td>
                    <td>Paulo</td>
                </tr>
                </tbody>
            </table>

        </div>
    </section>

    <!-- MANUTENÇÃO -->

    <section class="card span-6">
        <div class="card-header">
            <h3>Manutenção (Ordens de Serviço)</h3>
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
                    <td>Finalizado</td>
                    <td>7</td>
                    <td>1</td>
                    <td>10</td>
                    <td>1</td>
                    <td>19</td>
                </tr>
                </tbody>
            </table>

        </div>
    </section>

    <!-- DESPERDÍCIOS -->

    <section class="card span-6">
        <div class="card-header">
            <h3>Desperdícios / Perdas</h3>
        </div>

        <div class="card-body table-scroll">

            <table>
                <thead>
                <tr>
                    <th>Descrição</th>
                    <th>Qtd</th>
                    <th>Custo</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td>Produto Rejeitado</td>
                    <td>617</td>
                    <td>R$ 3.137,70</td>
                </tr>

                <tr>
                    <td>Produto Branco</td>
                    <td>131</td>
                    <td>R$ 3.135,70</td>
                </tr>

                <tr>
                    <td>Produto Extra</td>
                    <td>114</td>
                    <td>R$ 3.131,70</td>
                </tr>

                <tr>
                    <td>Produto Pronto</td>
                    <td>115</td>
                    <td>R$ 3.130,70</td>
                </tr>
                </tbody>

            </table>

        </div>
    </section>

    <!-- ROTINAS -->

    <section class="card span-12">
        <div class="card-header">
            <h3>Rotinas no Setor</h3>
        </div>

        <div class="card-body routines">

            <ul>
                <li>Orientação Time</li>
                <li>Abastecimento D-1</li>
                <li>Controle Hora a Hora</li>
                <li>Segregação Diária</li>
                <li>Plano de Produção</li>
            </ul>

            <ul>
                <li>DDS e DDQ</li>
                <li>Inspeção Pontos Críticos</li>
                <li>Premiação</li>
                <li>Pontos de Manutenção</li>
                <li>Prioridades Produção</li>
            </ul>

            <ul>
                <li>Treinamento</li>
                <li>Feedback Individual</li>
                <li>Auditoria 5S</li>
                <li>Reunião Operacional</li>
                <li>Kaizen</li>
            </ul>

        </div>
    </section>

</div>

<script>

// EFICIÊNCIA

new Chart(
document.getElementById('efficiencyChart'),
{
    type:'bar',
    data:{
        labels:['YTD','Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set'],
        datasets:[{
            label:'Eficiência (%)',
            data:[85.4,88.1,89.7,73.7,73.3,96.7,88.4,90.8,88.0,81.1],
            backgroundColor:'#4f81bd'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false
    }
});


// PRODUÇÃO

new Chart(
document.getElementById('productionChart'),
{
    type:'bar',
    data:{
        labels:[
            '1ª Sem',
            '2ª Sem',
            '3ª Sem',
            '4ª Sem',
            '1ª Semana Mês'
        ],
        datasets:[{
            label:'Produção',
            data:[178,120,134,136,180],
            backgroundColor:'#9bbb59'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false
    }
});


// QUALIDADE

new Chart(
document.getElementById('qualityChart'),
{
    type:'bar',
    data:{
        labels:['Reprovado','Retido','Notificado'],
        datasets:[{
            data:[1,2,5],
            backgroundColor:[
                '#ef4444',
                '#f59e0b',
                '#3b82f6'
            ]
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

</script>

</body>
</html>